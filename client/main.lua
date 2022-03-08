local QBCore = exports["qb-core"]:GetCoreObject()

-- Functions
local function SetupItems(shop)
    local products = Config.Locations[shop].products
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items + 1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items + 1] = products[i]
                end
            end
        end
    end
    return items
end

-- Events
RegisterNetEvent("qb-shops:client:UpdateShop", function(shop, itemData, amount)
    TriggerServerEvent("qb-shops:server:UpdateShopItems", shop, itemData, amount)
end)

RegisterNetEvent("qb-shops:client:SetShopItems", function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent("qb-shops:client:RestockShopItems", function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then
        for k, v in pairs(Config.Locations[shop]["products"]) do
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end)

RegisterNetEvent("qb-shops:client:openShop", function()
    local PlayerPed = PlayerPedId()
    local PlayerPos = GetEntityCoords(PlayerPed)
    for shop, _ in pairs(Config.Locations) do
        local position = Config.Locations[shop]["coords"]
        local products = Config.Locations[shop].products
        for _, loc in pairs(position) do
            local dist = #(PlayerPos - vector3(loc["x"], loc["y"], loc["z"]))
            if dist < 3 then
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
                                        ShopItems.items[#ShopItems.items + 1] = products[i]
                                    end
                                else
                                    for i2 = 1, #products[i].requiredJob do
                                        if QBCore.Functions.GetPlayerData().job.name == products[i].requiredJob[i2] and not products[i].requiresLicense then
                                            ShopItems.items[#ShopItems.items + 1] = products[i]
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
                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_" .. shop, ShopItems)
                end)
            end
        end
    end
end)

-- Threads
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

if not Config.UseTarget then
    local inShop = false
    CreateThread(function()
        for shop, _ in pairs(Config.Locations) do
            for i = 1, #Config.Locations[shop]["coords"] do
                local shopZone = CircleZone:Create(Config.Locations[shop]["coords"][i], Config.Locations[shop]["radius"], {useZ = true})
                shopZone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside)
                    if isPointInside then
                        inShop = true
                        exports["qb-core"]:DrawText(Lang:t("info.interact"))
                    else
                        inShop = false
                        exports["qb-core"]:HideText()
                    end
                end, 100)
            end
        end
    end)
    CreateThread(function()
        while true do
            if IsControlJustPressed(0, 38) then -- E
                if inShop then
                    exports["qb-core"]:KeyPressed()
                    TriggerEvent("qb-shops:client:openShop")
                end
            end
            Wait(5)
        end
    end)
end

if Config.UseTarget then
    CreateThread(function()
        for store, _ in pairs(Config.Locations) do
            for i = 1, #Config.Locations[store]["coords"] do
                coords = Config.Locations[store]["coords"][i]
                radius = Config.Locations[store]["radius"]
                exports["qb-target"]:AddCircleZone(coords, coords, radius, {useZ = true}, {
                    options = {
                        {
                            type = "client",
                            event = "qb-shops:client:openShop",
                            icon = "fas fa-shopping-basket",
                            label = "Open Shop",
                        }
                    },
                    distance = 3.0
                })
            end
        end
    end)
end
