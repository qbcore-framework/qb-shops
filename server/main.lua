local QBCore = exports['qb-core']:GetCoreObject()
local Bail = {}

-- Functions

local function checkTable(inputValue, requiredValue)
    if type(inputValue) == 'table' and type(requiredValue) == 'table' then
        for _, v in ipairs(requiredValue) do
            if inputValue[v] then return true end
        end
    elseif type(requiredValue) == 'table' then
        for _, v in ipairs(requiredValue) do
            if v == inputValue then return true end
        end
    elseif type(inputValue) == 'string' and type(requiredValue) == 'string' then
        return inputValue == requiredValue
    elseif type(inputValue) == 'table' and type(requiredValue) == 'string' then
        return inputValue[requiredValue] == true
    elseif type(inputValue) == 'string' and type(requiredValue) == 'table' then
        for _, v in ipairs(requiredValue) do
            if v == inputValue then return true end
        end
    end

    return false
end

local function saveShopInv(shop, products)
    local shopinv = {}
    shopinv[shop] = {}
    shopinv[shop].products = products
    SaveResourceFile(GetCurrentResourceName(), Config.ShopsInvJsonFile, json.encode(shopinv), -1)
end

local function deliveryPay(source, shop)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    local deliverCoords = Config.Locations[shop].delivery
    local distance = #(playerCoords - vector3(deliverCoords.x, deliverCoords.y, deliverCoords.z))
    if distance > 10 then return end
    Player.Functions.AddMoney('bank', Config.DeliveryPrice, 'qb-shops:deliveryPay')
    if math.random(100) <= 10 then exports['qb-inventory']:AddItem(source, Config.RewardItem, 1, false, false, 'qb-shops:deliveryPay') end
end

-- Events

-- Deliveries

RegisterNetEvent('qb-shops:server:RestockShopItems', function(shop)
    local src = source
    if not shop then return end
    if not Config.Locations[shop] then return end
    deliveryPay(src, shop)
    if not Config.Locations[shop].useStock then return end
    local randAmount = math.random(10, 50)
    for k in pairs(Config.Locations[shop].products) do Config.Locations[shop].products[k].amount += randAmount end
    saveShopInv(shop, Config.Locations[shop].products)
    TriggerClientEvent('qb-shops:client:SetShopItems', -1, shop, Config.Locations[shop].products)
end)

RegisterNetEvent('qb-shops:server:UpdateShopItems', function(shop, itemData, amount) -- called from inventory
    if not shop or not itemData or not amount then return end
    if not Config.Locations[shop] then return end
    if not Config.Locations[shop].useStock then return end
    Config.Locations[shop].products[itemData.slot].amount -= amount
    if Config.Locations[shop].products[itemData.slot].amount < 0 then
        Config.Locations[shop].products[itemData.slot].amount = 0
    end
    saveShopInv(shop, Config.Locations[shop].products)
    TriggerClientEvent('qb-shops:client:SetShopItems', -1, shop, Config.Locations[shop].products)
end)

RegisterNetEvent('qb-shops:server:DoBail', function(bool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if bool then
        if Player.Functions.RemoveMoney('cash', Config.TruckDeposit, 'tow-received-bail') then
            Bail[Player.PlayerData.citizenid] = Config.TruckDeposit
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.paid_with_cash', { value = Config.TruckDeposit }), 'success')
            TriggerClientEvent('qb-shops:client:SpawnVehicle', src)
        elseif Player.Functions.RemoveMoney('bank', Config.TruckDeposit, 'tow-received-bail') then
            Bail[Player.PlayerData.citizenid] = Config.TruckDeposit
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.paid_with_bank', { value = Config.TruckDeposit }), 'success')
            TriggerClientEvent('qb-shops:client:SpawnVehicle', src)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_deposit', { value = Config.TruckDeposit }), 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] then
            Player.Functions.AddMoney('cash', Bail[Player.PlayerData.citizenid], 'trucker-bail-paid')
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.refund_to_cash', { value = Config.TruckDeposit }), 'success')
        end
    end
end)

RegisterNetEvent('qb-shops:server:PaySlip', function(drops)
    local src = source
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local coords = Config.DeliveryLocations['main'].coords
    local distance = #(playerCoords - vector3(coords.x, coords.y, coords.z))
    if distance > 10 then return end
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local completedDrops = tonumber(drops)
    if not drops then return end
    local payment = Config.DeliveryPrice * completedDrops
    Player.Functions.AddMoney('bank', payment, 'trucker-salary')
    Player.Functions.AddRep('delivery', completedDrops)
    TriggerClientEvent('QBCore:Notify', src, Lang:t('success.you_earned', { value = payment }), 'success')
end)

-- Opening shops

RegisterNetEvent('qb-shops:server:openShop', function(data)
    local src = source
    local shopName = data.shop
    local shopData = Config.Locations[shopName]
    if not shopData then return end
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local playerData = Player.PlayerData
    local products = shopData.products
    local items = {}

    if shopData.useStock then
        local shopInvJson = json.decode(LoadResourceFile(GetCurrentResourceName(), Config.ShopsInvJsonFile))
        if shopInvJson[shopName] then
            for k, v in pairs(shopInvJson[shopName].products) do
                if products[k] then
                    products[k].amount = v.amount
                end
            end
        end
    end

    for i = 1, #products do
        local curProduct = products[i]
        local addProduct = true

        if curProduct.requiredGrade and playerData.job.grade.level < curProduct.requiredGrade then
            addProduct = false
        end

        if addProduct and curProduct.requiredJob and not checkTable(playerData.job.name, curProduct.requiredJob) then
            addProduct = false
        end

        if addProduct and curProduct.requiredGang and not checkTable(playerData.gang.name, curProduct.requiredGang) then
            addProduct = false
        end

        if addProduct and curProduct.requiredLicense and not checkTable(playerData.metadata['licences'], curProduct.requiredLicense) then
            addProduct = false
        end

        if addProduct then
            curProduct.slot = #items + 1
            items[#items + 1] = curProduct
        end
    end

    exports['qb-inventory']:CreateShop({
        name = shopName,
        label = shopData.label,
        slots = shopData.slots,
        coords = shopData.coords,
        items = items,
    })
    exports['qb-inventory']:OpenShop(src, shopName)
end)
