RegisterServerEvent('qb-shops:server:UpdateShopItems')
AddEventHandler('qb-shops:server:UpdateShopItems', function(shop, itemData, amount)
    Config.Locations[shop]["products"][itemData.slot].amount =  Config.Locations[shop]["products"][itemData.slot].amount - amount
    if Config.Locations[shop]["products"][itemData.slot].amount <= 0 then 
        Config.Locations[shop]["products"][itemData.slot].amount = 0
    end
    TriggerClientEvent('qb-shops:client:SetShopItems', -1, shop, Config.Locations[shop]["products"])
end)

RegisterServerEvent('qb-shops:server:RestockShopItems')
AddEventHandler('qb-shops:server:RestockShopItems', function(shop)
    if Config.Locations[shop]["products"] ~= nil then 
        local randAmount = math.random(10, 50)
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + randAmount
        end
        TriggerClientEvent('qb-shops:client:RestockShopItems', -1, shop, randAmount)
    end
end)

QBCore.Functions.CreateCallback('qb-shops:server:getLicenseStatus', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local licenseTable = Player.PlayerData.metadata["licences"]
    local licenseItem = Player.Functions.GetItemByName("weaponlicense")

    if licenseTable.weapon then
        if licenseItem then
            TriggerClientEvent('QBCore:Notify', src, "The dealer verifies your weapons license", "success")
            Citizen.Wait(1000)
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', src, "The dealer declines to show you firearms", "error")
            Citizen.Wait(500)
            TriggerClientEvent('QBCore:Notify', src, "Go pickup a copy of your firearms license from City Hall", "error")
            Citizen.Wait(1000)
            cb(false)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "The dealer declines to show you firearms", "error")
        Citizen.Wait(500)
        TriggerClientEvent('QBCore:Notify', src, "Speak with law enforcement to get a firearms license", "error")
        Citizen.Wait(1000)
        cb(false)
    end
end)