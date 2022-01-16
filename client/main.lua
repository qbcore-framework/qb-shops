local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function SetupItems(shop)
    local products = Config.Locations[shop].products
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Events

RegisterNetEvent('qb-shops:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('qb-shops:server:UpdateShopItems', shop, itemData, amount)
end)

RegisterNetEvent('qb-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent('qb-shops:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then
        for k, v in pairs(Config.Locations[shop]["products"]) do
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end)

-- Threads

CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        for shop, _ in pairs(Config.Locations) do
            local position = Config.Locations[shop]["coords"]
            local products = Config.Locations[shop].products
            for _, loc in pairs(position) do
                local dist = #(PlayerPos - vector3(loc["x"], loc["y"], loc["z"]))
                if dist < 10 then
                    InRange = true
                    DrawMarker(2, loc["x"], loc["y"], loc["z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
                    if dist < 1 then
                        DrawText3Ds(loc["x"], loc["y"], loc["z"] + 0.15, Lang:t("info.interact"))
                        if IsControlJustPressed(0, 38) then -- E
                            local ShopItems = {}
                            ShopItems.items = {}
                            QBCore.Functions.TriggerCallback("qb-shops:server:getLicenseStatus", function(hasLicense, hasLicenseItem)
                                ShopItems.label = Config.Locations[shop]["label"]
                                if Config.Locations[shop].products == Config.Products["weapons"] then
                                    if hasLicense and hasLicenseItem then
                                        ShopItems.items = SetupItems(shop)
                                        QBCore.Functions.Notify(Lang:t("success.dealer_verify"), "success")
                                        Wait(500)
                                    else
                                        for i = 1, #products do
                                            if not products[i].requiredJob then
                                                if not products[i].requiresLicense then
                                                    ShopItems.items[#ShopItems.items+1] = products[i]
                                                end
                                            else
                                                for i2 = 1, #products[i].requiredJob do
                                                    if QBCore.Functions.GetPlayerData().job.name == products[i].requiredJob[i2] and not products[i].requiresLicense then
                                                        ShopItems.items[#ShopItems.items+1] = products[i]
                                                    end
                                                end
                                            end
                                        end
                                        QBCore.Functions.Notify(Lang:t("error.dealer_decline"), "error")
                                        Wait(500)
                                        QBCore.Functions.Notify(Lang:t("error.talk_cop"), "error")
                                        Wait(1000)
                                    end
                                else
                                    ShopItems.items = SetupItems(shop)
                                end
                                for k, v in pairs(ShopItems.items) do
                                    ShopItems.items[k].slot = k
                                end
                                ShopItems.slots = 30
                                TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                            end)
                        end
                    end
                end
            end
        end

        if not InRange then
            Wait(5000)
        end
        Wait(5)
    end
end)

CreateThread(function()
    for store, _ in pairs(Config.Locations) do
        if Config.Locations[store]["showblip"] then
            for i = 1, #Config.Locations[store]["coords"] do
                StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"][i]["x"], Config.Locations[store]["coords"][i]["y"], Config.Locations[store]["coords"][i]["z"])
                SetBlipColour(StoreBlip, 0)
                SetBlipSprite(StoreBlip, Config.Locations[store]["blipsprite"])
                SetBlipScale(StoreBlip, 0.6)
                SetBlipDisplay(StoreBlip, 4)
                SetBlipAsShortRange(StoreBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
                EndTextCommandSetBlipName(StoreBlip)
            end
        end
    end
end)