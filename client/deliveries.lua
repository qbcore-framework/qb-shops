local QBCore = exports['qb-core']:GetCoreObject()
local JobsDone = 0
local LocationsDone = {}
local CurrentLocation = nil
local CurrentBlip = nil
local hasBox = false
local boxObject = nil
local isWorking = false
local currentCount = 0
local CurrentPlate = nil
local TruckerBlip = nil
local deliveryPed = nil
local Delivering = false
local showMarker = false
local markerLocation
local zoneCombo = nil
local returningToStation = false

-- Functions

local function ShowMarker(active)
    showMarker = active
end

local function SetDelivering(active)
    Delivering = active
end

local function setupZones(type, number)
    local coords
    local heading
    local boxName
    local size

    if type == 'main' then
        coords = vector3(Config.DeliveryLocations[type].coords.x, Config.DeliveryLocations[type].coords.y, Config.DeliveryLocations[type].coords.z)
        heading = Config.DeliveryLocations[type].coords.w
        boxName = Config.DeliveryLocations[type].label
        size = 3
    elseif type == 'vehicleDeposit' then
        coords = Config.DeliveryLocations[type]
        heading = Config.DeliveryLocations[type].w
        boxName = 'qb-shops:vehicleDeposit'
        size = 10
    elseif type == 'stores' then
        coords = vector3(Config.DeliveryLocations[type][number].coords.x, Config.DeliveryLocations[type][number].coords.y, Config.DeliveryLocations[type][number].coords.z)
        heading = Config.DeliveryLocations[type][number].coords.w
        boxName = Config.DeliveryLocations[type][number].name
        size = 40
    end

    if Config.UseTarget and type == 'main' then
        RequestModel('s_m_m_postal_01')
        while not HasModelLoaded('s_m_m_postal_01') do Wait(0) end
        deliveryPed = CreatePed(0, 's_m_m_postal_01', coords.x, coords.y, coords.z - 1, heading, false, false)
        FreezeEntityPosition(deliveryPed, true)
        SetEntityInvincible(deliveryPed, true)
        SetBlockingOfNonTemporaryEvents(deliveryPed, true)
        exports['qb-target']:AddTargetEntity(deliveryPed, {
            options = {
                {
                    icon = 'fas fa-box',
                    label = 'Start Delivering',
                    action = function()
                        TriggerServerEvent('qb-shops:server:DoBail', true)
                    end
                }
            },
            distance = 2.0
        })
    else
        local zone = BoxZone:Create(
            coords, size, size, {
                minZ = coords.z - 5.0,
                maxZ = coords.z + 5.0,
                name = boxName,
                debugPoly = false,
                heading = heading,
            })

        zoneCombo = ComboZone:Create({ zone }, { name = boxName, debugPoly = false })
        zoneCombo:onPlayerInOut(function(isPointInside)
            if isPointInside then
                if type == 'main' then
                    TriggerServerEvent('qb-shops:server:DoBail', true)
                elseif type == 'vehicleDeposit' then
                    TriggerEvent('qb-shops:client:Vehicle')
                elseif type == 'stores' then
                    markerLocation = coords
                    QBCore.Functions.Notify(Lang:t('mission.store_reached'))
                    ShowMarker(true)
                    SetDelivering(true)
                end
            else
                if type == 'stores' then
                    ShowMarker(false)
                    SetDelivering(false)
                end
            end
        end)
        if type == 'vehicleDeposit' then
            local zonedel = BoxZone:Create(
                coords, 40, 40, {
                    minZ = coords.z - 5.0,
                    maxZ = coords.z + 5.0,
                    name = boxName,
                    debugPoly = false,
                    heading = heading,
                })

            local zoneCombodel = ComboZone:Create({ zonedel }, { name = boxName, debugPoly = false })
            zoneCombodel:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    markerLocation = coords
                    ShowMarker(true)
                else
                    ShowMarker(false)
                end
            end)
        elseif type == 'stores' then
            CurrentLocation.zoneCombo = zoneCombo
        end
    end
end

local function CreateBlip()
    TruckerBlip = AddBlipForCoord(Config.DeliveryLocations['main'].coords.x, Config.DeliveryLocations['main'].coords.y, Config.DeliveryLocations['main'].coords.z)
    SetBlipSprite(TruckerBlip, 408)
    SetBlipDisplay(TruckerBlip, 4)
    SetBlipScale(TruckerBlip, 0.6)
    SetBlipAsShortRange(TruckerBlip, true)
    SetBlipColour(TruckerBlip, 6)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.DeliveryLocations['main'].label)
    EndTextCommandSetBlipName(TruckerBlip)
    setupZones('main')
    setupZones('vehicleDeposit')
end

local function getShopList()
    local shoplist = {}
    local cnt = 0
    for k, v in pairs(Config.Locations) do
        cnt = cnt + 1
        shoplist[cnt] = {}
        shoplist[cnt].name = k
        shoplist[cnt].coords = v.delivery
    end
    Config.DeliveryLocations['stores'] = shoplist
end

local function returnToStation()
    SetBlipRoute(TruckerBlip, true)
    returningToStation = true
end

local function getNextLocation()
    local current = 1
    while true do
        local done = false
        if LocationsDone and table.type(LocationsDone) ~= 'empty' then
            for _, v in pairs(LocationsDone) do
                if v == current then
                    done = true
                    break
                end
            end
        end
        if not done then
            break
        end
        current = math.random(#Config.DeliveryLocations['stores'])
        if #LocationsDone == #Config.DeliveryLocations['stores'] then
            LocationsDone = {}
            break
        end
    end
    return current
end

local function getTruckerVehicle(vehicle)
    for k in pairs(Config.Vehicles) do
        if GetEntityModel(vehicle) == joaat(k) then
            return k
        end
    end
    return false
end

local function isTruckerVehicle(vehicle)
    return getTruckerVehicle(vehicle) ~= false
end

local function RemoveTruckerBlips()
    ClearAllBlipRoutes()
    if TruckerBlip then
        RemoveBlip(TruckerBlip)
        TruckerBlip = nil
    end
    if CurrentBlip then
        RemoveBlip(CurrentBlip)
        CurrentBlip = nil
    end
end

local function getNewLocation()
    local location = getNextLocation()
    if location ~= 0 then
        CurrentLocation = {}
        CurrentLocation.id = location
        CurrentLocation.dropcount = math.random(1, 3)
        CurrentLocation.store = Config.DeliveryLocations['stores'][location].name
        CurrentLocation.x = Config.DeliveryLocations['stores'][location].coords.x
        CurrentLocation.y = Config.DeliveryLocations['stores'][location].coords.y
        CurrentLocation.z = Config.DeliveryLocations['stores'][location].coords.z
        setupZones('stores', location)
        CurrentBlip = AddBlipForCoord(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)
        SetBlipColour(CurrentBlip, 3)
        SetBlipRoute(CurrentBlip, true)
        SetBlipRouteColour(CurrentBlip, 3)
    else
        QBCore.Functions.Notify(Lang:t('success.payslip_time'))
        if CurrentBlip ~= nil then
            RemoveBlip(CurrentBlip)
            ClearAllBlipRoutes()
            CurrentBlip = nil
        end
    end
end

local function TableCount(tbl)
    local cnt = 0
    for _ in pairs(tbl) do cnt = cnt + 1 end
    return cnt
end

local function BackDoorsOpen(vehicle)
    local tv = getTruckerVehicle(vehicle)
    local cnt = TableCount(Config.Vehicles[tv].cargodoors)
    if isTruckerVehicle(vehicle) then
        if cnt == 2 then
            return GetVehicleDoorAngleRatio(vehicle, Config.Vehicles[tv].cargodoors[0]) > 0.0 and GetVehicleDoorAngleRatio(vehicle, Config.Vehicles[tv].cargodoors[1]) > 0.0
        elseif cnt == 1 then
            return GetVehicleDoorAngleRatio(vehicle, Config.Vehicles[tv].cargodoors[0]) > 0.0
        end
    end
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function carryBox()
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
    loadAnimDict('anim@heists@box_carry@')
    TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
    boxObject = CreateObject(`hei_prop_heist_box`, coords.x, coords.y, coords.z, true, true, true)
    SetEntityCollision(boxObject, false, false)
    AttachEntityToEntity(boxObject, ped, GetPedBoneIndex(ped, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, false, false, false, false, 2, true)
end

local function GetInTrunk()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        return QBCore.Functions.Notify(Lang:t('error.get_out_vehicle'), 'error')
    end
    local pos = GetEntityCoords(ped, true)
    local vehicle = GetVehiclePedIsIn(ped, true)
    local tv = getTruckerVehicle(vehicle)
    if not isTruckerVehicle(vehicle) or CurrentPlate ~= QBCore.Functions.GetPlate(vehicle) then
        return QBCore.Functions.Notify(Lang:t('error.vehicle_not_correct'), 'error')
    end
    if not BackDoorsOpen(vehicle) then
        return QBCore.Functions.Notify(Lang:t('error.backdoors_not_open'), 'error')
    end
    local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
    if #(pos - vector3(trunkpos.x, trunkpos.y, trunkpos.z)) > Config.Vehicles[tv].trunkpos then
        return QBCore.Functions.Notify(Lang:t('error.too_far_from_trunk'), 'error')
    end
    if isWorking then return end
    isWorking = true
    QBCore.Functions.Progressbar('work_carrybox', Lang:t('mission.take_box'), 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function()
        isWorking = false
        carryBox()
        hasBox = true
    end, function()
        isWorking = false
    end)
end

local function Deliver()
    isWorking = true
    Wait(500)
    QBCore.Functions.Progressbar('work_dropbox', Lang:t('mission.deliver_box'), 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        isWorking = false
        ClearPedTasks(PlayerPedId())
        if boxObject then
            DeleteEntity(boxObject)
            boxObject = nil
        end
        hasBox = false
        currentCount = currentCount + 1
        if currentCount == CurrentLocation.dropcount then
            LocationsDone[#LocationsDone + 1] = CurrentLocation.id
            TriggerServerEvent('qb-shops:server:RestockShopItems', CurrentLocation.store)
            exports['qb-core']:HideText()
            Delivering = false
            showMarker = false
            if CurrentBlip ~= nil then
                RemoveBlip(CurrentBlip)
                ClearAllBlipRoutes()
                CurrentBlip = nil
            end
            CurrentLocation.zoneCombo:destroy()
            CurrentLocation = nil
            currentCount = 0
            JobsDone = JobsDone + 1
            if JobsDone == Config.MaxDeliveries then
                QBCore.Functions.Notify(Lang:t('mission.return_to_station'))
                returnToStation()
            else
                QBCore.Functions.Notify(Lang:t('mission.goto_next_point'))
                getNewLocation()
            end
        else
            QBCore.Functions.Notify(Lang:t('mission.another_box'))
        end
    end, function()
        isWorking = false
    end)
end

-- Events

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    CurrentLocation = nil
    CurrentBlip = nil
    hasBox = false
    isWorking = false
    JobsDone = 0
    CreateBlip()
    getShopList()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    DeletePed(deliveryPed)
    RemoveBlip(TruckerBlip)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CurrentLocation = nil
    CurrentBlip = nil
    hasBox = false
    isWorking = false
    JobsDone = 0
    CreateBlip()
    getShopList()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    RemoveTruckerBlips()
    CurrentLocation = nil
    CurrentBlip = nil
    hasBox = false
    isWorking = false
    JobsDone = 0
end)

RegisterNetEvent('qb-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]['products'] = shopProducts
end)

RegisterNetEvent('qb-shops:client:SpawnVehicle', function()
    local coords = Config.DeliveryLocations['vehicleWithdraw']
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
        local veh = NetToVeh(netId)
        SetVehicleNumberPlateText(veh, 'TRUK' .. tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        SetVehicleLivery(veh, 1)
        SetVehicleColours(veh, 122, 122)
        exports[Config.Fuel]:SetFuel(veh, 100.0)
        exports['qb-menu']:closeMenu()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true, false)
        CurrentPlate = QBCore.Functions.GetPlate(veh)
        getNewLocation()
    end, 'boxville2', coords, true)
end)

RegisterNetEvent('qb-shops:client:Vehicle', function()
    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped, false)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if inVehicle and isTruckerVehicle(vehicle) then
        if GetPedInVehicleSeat(vehicle, -1) == ped then
            if isTruckerVehicle(vehicle) then
                DeleteVehicle(vehicle)
                TriggerServerEvent('qb-shops:server:DoBail', false)
                if CurrentBlip ~= nil then
                    RemoveBlip(CurrentBlip)
                    ClearAllBlipRoutes()
                    CurrentBlip = nil
                end
                if returningToStation or CurrentLocation then
                    ClearAllBlipRoutes()
                    returningToStation = false
                    QBCore.Functions.Notify(Lang:t('mission.job_completed'), 'success')
                end
            else
                QBCore.Functions.Notify(Lang:t('error.vehicle_not_correct'), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('error.no_driver'))
        end
    end
end)

-- Threads

CreateThread(function()
    local sleep
    while true do
        sleep = 1000
        if showMarker then
            DrawMarker(2, markerLocation.x, markerLocation.y, markerLocation.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
            sleep = 0
        end
        if Delivering then
            if IsControlJustReleased(0, 38) then
                if not hasBox then
                    GetInTrunk()
                else
                    if #(GetEntityCoords(PlayerPedId()) - markerLocation) < 5 then
                        Deliver()
                    else
                        QBCore.Functions.Notify(Lang:t('error.too_far_from_delivery'), 'error')
                    end
                end
            end
            sleep = 0
        end
        Wait(sleep)
    end
end)
