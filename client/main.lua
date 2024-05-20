local currentShop, currentData
local pedSpawned = false
local listen = false
local ShopPed = {}
local NewZones = {}

-- Functions

local function createBlips()
    if pedSpawned then return end

    for store in pairs(Config.Locations) do
        if Config.Locations[store]['showblip'] then
            local StoreBlip = AddBlipForCoord(Config.Locations[store]['coords']['x'], Config.Locations[store]['coords']['y'], Config.Locations[store]['coords']['z'])
            SetBlipSprite(StoreBlip, Config.Locations[store]['blipsprite'])
            SetBlipScale(StoreBlip, Config.Locations[store]['blipscale'])
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.Locations[store]['blipcolor'])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.Locations[store]['label'])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function listenForControl()
    if listen then return end
    CreateThread(function()
        listen = true
        while listen do
            if IsControlJustPressed(0, 38) then -- E
                exports['qb-core']:KeyPressed()
                TriggerServerEvent('qb-shops:server:openShop', { shop = currentShop })
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
        if not v.ped then
            exports['qb-target']:AddCircleZone(k, vector3(v.coords.x, v.coords.y, v.coords.z), 0.5, {
                name = k,
                debugPoly = false,
                useZ = true
            }, {
                options = {
                    {
                        label = v.targetLabel,
                        icon = v.targetIcon,
                        item = v.item,
                        type = 'server',
                        event = 'qb-shops:server:openShop',
                        shop = k,
                        job = v.requiredJob,
                        gang = v.requiredGang
                    }
                },
                distance = 2.0
            })
        else
            local current = type(v['ped']) == 'number' and v['ped'] or joaat(v['ped'])
            RequestModel(current)
            while not HasModelLoaded(current) do Wait(0) end
            ShopPed[k] = CreatePed(0, current, v['coords'].x, v['coords'].y, v['coords'].z - 1, v['coords'].w, false, false)
            TaskStartScenarioInPlace(ShopPed[k], v['scenario'], 0, true)
            FreezeEntityPosition(ShopPed[k], true)
            SetEntityInvincible(ShopPed[k], true)
            SetBlockingOfNonTemporaryEvents(ShopPed[k], true)
            if Config.UseTarget then
                exports['qb-target']:AddTargetEntity(ShopPed[k], {
                    options = {
                        {
                            label = v.targetLabel,
                            icon = v.targetIcon,
                            item = v.item,
                            type = 'server',
                            event = 'qb-shops:server:openShop',
                            shop = k,
                            job = v.requiredJob,
                            gang = v.requiredGang
                        }
                    },
                    distance = 2.0
                })
            end
        end
    end
    pedSpawned = true
end

local function deletePeds()
    if not pedSpawned then return end
    for _, v in pairs(ShopPed) do
        DeletePed(v)
    end
    pedSpawned = false
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createBlips()
    createPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
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
            NewZones[#NewZones + 1] = CircleZone:Create(vector3(Config.Locations[shop]['coords']['x'], Config.Locations[shop]['coords']['y'], Config.Locations[shop]['coords']['z']), Config.Locations[shop]['radius'] or 1.5, {
                useZ = true,
                debugPoly = false,
                name = shop,
            })
        end

        local combo = ComboZone:Create(NewZones, { name = 'RandomZOneName', debugPoly = false })
        combo:onPlayerInOut(function(isPointInside, _, zone)
            if isPointInside then
                currentShop = zone.name
                currentData = Config.Locations[zone.name]
                exports['qb-core']:DrawText(Lang:t('info.open_shop'))
                listenForControl()
            else
                exports['qb-core']:HideText()
                listen = false
            end
        end)
    end)
end
