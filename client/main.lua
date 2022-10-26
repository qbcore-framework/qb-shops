local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local inChips = false
local currentShop, currentData
local pedSpawned = false
local listen = false
local ShopPed = {}
local NewZones = {}

-- Functions

local function SetupItems(shop, checkLicense)
    local products = Config.Locations[shop].products
    local curJob
    local curGang
    local items = {}
    for i = 1, #products do
        curJob = products[i].requiredJob
        curGang = products[i].requiredGang

        if curJob then goto jobCheck end
        if curGang then goto gangCheck end
        if checkLicense then goto licenseCheck end

        items[#items + 1] = products[i]

        goto nextIteration

        :: jobCheck ::
        for i2 = 1, #curJob do
            if PlayerData.job.name == curJob[i2] then
                items[#items + 1] = products[i]
            end
        end

        goto nextIteration

        :: gangCheck ::
        for i2 = 1, #curGang do
            if PlayerData.gang.name == curGang[i2] then
                items[#items + 1] = products[i]
            end
        end

        goto nextIteration

        :: licenseCheck ::
        if not products[i].requiresLicense then
            items[#items + 1] = products[i]
        end

        :: nextIteration ::
    end
    return items
end

local function createBlips()
    if pedSpawned then return end

    for store in pairs(Config.Locations) do
        if Config.Locations[store]["showblip"] then
            local StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"]["x"], Config.Locations[store]["coords"]["y"], Config.Locations[store]["coords"]["z"])
            SetBlipSprite(StoreBlip, Config.Locations[store]["blipsprite"])
            SetBlipScale(StoreBlip, Config.Locations[store]["blipscale"])
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.Locations[store]["blipcolor"])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function openShop(shop, data)
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = data["label"]

    if data.type == "weapon" and Config.FirearmsLicenseCheck then

        if PlayerData.metadata["licences"] and PlayerData.metadata["licences"].weapon and QBCore.Functions.HasItem("weaponlicense") then

            ShopItems.items = SetupItems(shop)
            QBCore.Functions.Notify(Lang:t("success.dealer_verify"), "success")
            Wait(500)
        else
            ShopItems.items = SetupItems(shop, true)
            QBCore.Functions.Notify(Lang:t("error.dealer_decline"), "error")
            Wait(500)
            QBCore.Functions.Notify(Lang:t("error.talk_cop"), "error")
            Wait(1000)
        end
    else
        ShopItems.items = SetupItems(shop)
    end

    for k in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end

    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_" .. shop, ShopItems)
end

local function listenForControl()
    if listen then return end

    CreateThread(function()
        listen = true
        while listen do
            if IsControlJustPressed(0, 38) then -- E
                if inChips then
                    exports["qb-core"]:KeyPressed()
                    TriggerServerEvent("qb-shops:server:sellChips")
                else
                    exports["qb-core"]:KeyPressed()
                    openShop(currentShop, currentData)
                end
                listen = false
                break
            end
            Wait(0)
        end
    end)
end

local function createPeds()
    if pedSpawned then return end

    for k, v in pairs(Config.Locations) do
        local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end

        ShopPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        TaskStartScenarioInPlace(ShopPed[k], v["scenario"], 0, true)
        FreezeEntityPosition(ShopPed[k], true)
        SetEntityInvincible(ShopPed[k], true)
        SetBlockingOfNonTemporaryEvents(ShopPed[k], true)

        if Config.UseTarget then
            exports['qb-target']:AddTargetEntity(ShopPed[k], {
                options = {
                    {
                        label = v["targetLabel"],
                        icon = v["targetIcon"],
                        item = v["item"],
                        action = function()
                            openShop(k, Config.Locations[k])
                        end,
                        job = v.requiredJob,
                        gang = v.requiredGang
                    }
                },
                distance = 2.0
            })
        end
    end

    local current = type(Config.SellCasinoChips.ped) == 'number' and Config.SellCasinoChips.ped or joaat(Config.SellCasinoChips.ped)

    RequestModel(current)
    while not HasModelLoaded(current) do
        Wait(0)
    end

    ShopPed["casino"] = CreatePed(0, current, Config.SellCasinoChips.coords.x, Config.SellCasinoChips.coords.y, Config.SellCasinoChips.coords.z-1, Config.SellCasinoChips.coords.w, false, false)
    FreezeEntityPosition(ShopPed["casino"], true)
    SetEntityInvincible(ShopPed["casino"], true)
    SetBlockingOfNonTemporaryEvents(ShopPed["casino"], true)

    if Config.UseTarget then
        exports['qb-target']:AddTargetEntity(ShopPed["casino"], {
            options = {
                {
                    label = 'Sell Chips',
                    icon = 'fa-solid fa-coins',
                    action = function()
                        TriggerServerEvent("qb-shops:server:sellChips")
                    end
                }
            },
            distance = 2.0
        })
    end

    pedSpawned = true
end

local function deletePeds()
    if not pedSpawned then return end

    for _, v in pairs(ShopPed) do
        DeletePed(v)
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
    if not Config.Locations[shop]["products"] then return end

    for k in pairs(Config.Locations[shop]["products"]) do
        Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    createBlips()
    createPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
    table.wipe(PlayerData)
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    createBlips()
    createPeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    deletePeds()
end)

-- Threads

if not Config.UseTarget then
    CreateThread(function()
        for shop in pairs(Config.Locations) do
            NewZones[#NewZones+1] = CircleZone:Create(vector3(Config.Locations[shop]["coords"]["x"], Config.Locations[shop]["coords"]["y"], Config.Locations[shop]["coords"]["z"]), Config.Locations[shop]["radius"], {
                useZ = true,
                debugPoly = false,
                name = shop,
            })
        end

        local combo = ComboZone:Create(NewZones, {name = "RandomZOneName", debugPoly = false})
        combo:onPlayerInOut(function(isPointInside, _, zone)
            if isPointInside then
                currentShop = zone.name
                currentData = Config.Locations[zone.name]
                exports["qb-core"]:DrawText(Lang:t("info.open_shop"))
                listenForControl()
            else
                exports["qb-core"]:HideText()
                listen = false
            end
        end)

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
    end)
end

CreateThread(function()
    for k1, v in pairs(Config.Locations) do
        if v.requiredJob and type(v.requiredJob) == "table" and table.type(v.requiredJob) == "array" then
            for k in pairs(v.requiredJob) do
                Config.Locations[k1].requiredJob[k] = 0
            end
        end

        if v.requiredGang and type(v.requiredGang) == "table" and table.type(v.requiredGang) == "array" then
            for k in pairs(v.requiredGang) do
                Config.Locations[k1].requiredGang[k] = 0
            end
        end
    end
end)
