local QBCore = exports["qb-core"]:GetCoreObject()
local inShop = false
local inChips = false
local currentShop, currentData

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

local function createBlips()
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

local function openShop(shop, data)
    local products = data.products
    local ShopItems = {}
    ShopItems.items = {}
    QBCore.Functions.TriggerCallback("qb-shops:server:getLicenseStatus", function(hasLicense, hasLicenseItem)
        ShopItems.label = data["label"]
        if data.products == Config.Products["weapons"] then
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

-- Threads
CreateThread(function()
    createBlips()
    for shop, _ in pairs(Config.Locations) do
        for i = 1, #Config.Locations[shop]["coords"] do
            if not Config.UseTarget then
                local shopZone = CircleZone:Create(vector3(Config.Locations[shop]["coords"][i]["x"], Config.Locations[shop]["coords"][i]["y"], Config.Locations[shop]["coords"][i]["z"]), Config.Locations[shop]["radius"], {useZ = true})
                shopZone:onPlayerInOut(function(isPointInside)
                    if isPointInside then
                        inShop = true
                        currentShop = shop
                        currentData = Config.Locations[shop]
                        exports["qb-core"]:DrawText(Lang:t("info.open_shop"))
                    else
                        inShop = false
                        exports["qb-core"]:HideText()
                    end
                end)
            else
                exports["qb-target"]:SpawnPed({
                    model = Config.Locations[shop]["ped"]["model"],
                    coords = Config.Locations[shop]["coords"][i],
                    minusOne = true,
                    freeze = true,
                    invincible = true,
                    blockevents = true,
                    target = {
                        options = {
                            {
                                type = "client",
                                icon = "fas fa-shopping-basket",
                                label = "Open Shop",
                                action = function()
                                    openShop(shop, Config.Locations[shop])
                                end
                            }
                        },
                        distance = Config.Locations[shop]["radius"],
                    }
                })
                exports["qb-target"]:SpawnPed({
                    model = Config.SellCasinoChips.ped,
                    coords = Config.SellCasinoChips.coords - 5,
                    minusOne = true,
                    freeze = true,
                    invincible = true,
                    blockevents = true,
                    target = {
                        options = {
                            {
                                type = "server",
                                icon = "fas fa-coins",
                                label = "Sell Chips",
                                event = "qb-shops:server:sellChips"
                            }
                        },
                        distance = Config.SellCasinoChips.Radius,
                    }
                })
            end
        end
    end
    if not Config.UseTarget then
        local sellChips = CircleZone:Create(vector3(Config.SellCasinoChips.coords["x"], Config.SellCasinoChips.coords["y"], Config.SellCasinoChips.coords["z"]), Config.SellCasinoChips.radius, {useZ = true})
        sellChips:onPlayerInOut(function(isPointInside)
            if isPointInside then
                inChips = true
                exports["qb-core"]:DrawText(Lang:t("info.sell_chips"))
            else
                inChips = false
                exports["qb-core"]:HideText()
            end
        end)
    end
    while true do
        local sleep = 1000
        if inShop then
            sleep = 0
            if IsControlJustPressed(0, 38) then -- E
                sleep = 1000
                exports["qb-core"]:KeyPressed()
                openShop(currentShop, currentData)
            end
        end
        if inChips then
            sleep = 0
            if IsControlJustPressed(0, 38) then -- E
                sleep = 1000
                exports["qb-core"]:KeyPressed()
                TriggerServerEvent("qb-shops:server:sellChips")
            end
        end
        Wait(sleep)
    end
end)
