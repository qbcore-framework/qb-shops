local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-shops:server:UpdateShopItems', function(shop, itemData, amount)
    if not shop or not itemData or not amount then return end

    Config.Locations[shop]["products"][itemData.slot].amount -= amount
    if Config.Locations[shop]["products"][itemData.slot].amount < 0 then
        Config.Locations[shop]["products"][itemData.slot].amount = 0
    end

    TriggerClientEvent('qb-shops:client:SetShopItems', -1, shop, Config.Locations[shop]["products"])
end)

RegisterNetEvent('qb-shops:server:RestockShopItems', function(shop)
    if not shop or not Config.Locations[shop]?["products"] then return end

    local randAmount = math.random(10, 50)
    for k in pairs(Config.Locations[shop]["products"]) do
        Config.Locations[shop]["products"][k].amount += randAmount
    end

    TriggerClientEvent('qb-shops:client:RestockShopItems', -1, shop, randAmount)
end)

local ItemList = {
    ["casinochips"] = 1,
}

RegisterNetEvent('qb-shops:server:sellChips', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casinochips")
    if xItem then
        for k in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] then
                if ItemList[Player.PlayerData.items[k].name] then
                    local price = ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney("cash", price, "sold-casino-chips")

                    QBCore.Functions.Notify(src, "You sold your chips for $" .. price)
                    TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "blue", "**" .. GetPlayerName(src) .. "** got $" .. price .. " for selling the Chips")
                end
            end
        end
    else
        QBCore.Functions.Notify(src, "You have no chips..")
    end
end)
