function DrawText3Ds(x, y, z, text)
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

Citizen.CreateThread(function()
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
                        DrawText3Ds(loc["x"], loc["y"], loc["z"] + 0.15, '~g~E~w~ - Shop')
                        if IsControlJustPressed(0, 38) then -- E
                            local ShopItems = {}
                            ShopItems.items = {}
                            QBCore.Functions.TriggerCallback('qb-shops:server:getLicenseStatus', function(result)
                                ShopItems.label = Config.Locations[shop]["label"]
                                if Config.Locations[shop].type == "weapon" then
                                    if result then
                                        ShopItems.items = SetupItems(shop)
                                    else
                                        for i = 1, #products do
                                            if not products[i].requiredJob then
                                                if not products[i].requiresLicense then
                                                    table.insert(ShopItems.items, products[i])
                                                end
                                            else
                                                for i2 = 1, #products[i].requiredJob do
                                                    if QBCore.Functions.GetPlayerData().job.name == products[i].requiredJob[i2] and not products[i].requiresLicense then
                                                        table.insert(ShopItems.items, products[i])
                                                    end
                                                end
                                            end
                                        end
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
            Citizen.Wait(5000)
        end
        Citizen.Wait(5)
    end
end)

function SetupItems(shop)
    local products = Config.Locations[shop].products
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}

    for i = 1, #products do
        if not products[i].requiredJob then
            table.insert(items, products[i])
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    table.insert(items, products[i])
                end
            end
        end
    end

    return items
end

RegisterNetEvent('qb-shops:client:UpdateShop')
AddEventHandler('qb-shops:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('qb-shops:server:UpdateShopItems', shop, itemData, amount)
end)

RegisterNetEvent('qb-shops:client:SetShopItems')
AddEventHandler('qb-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent('qb-shops:client:RestockShopItems')
AddEventHandler('qb-shops:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then 
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end)

Citizen.CreateThread(function()
    for store,_ in pairs(Config.Locations) do
	if Config.Locations[store]["showblip"] then
	    StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"][1]["x"], Config.Locations[store]["coords"][1]["y"], Config.Locations[store]["coords"][1]["z"])
	    SetBlipColour(StoreBlip, 0)

	    if Config.Locations[store]["products"] == Config.Products["normal"] then
	        SetBlipSprite(StoreBlip, 52)
	        SetBlipScale(StoreBlip, 0.6)
	    elseif Config.Locations[store]["products"] == Config.Products["coffeeplace"] then
	        SetBlipSprite(StoreBlip, 52)
	        SetBlipScale(StoreBlip, 0.6)
	    elseif Config.Locations[store]["products"] == Config.Products["gearshop"] then
	        SetBlipSprite(StoreBlip, 52)
	        SetBlipScale(StoreBlip, 0.6)
	    elseif Config.Locations[store]["products"] == Config.Products["hardware"] then
	        SetBlipSprite(StoreBlip, 402)
	        SetBlipScale(StoreBlip, 0.8)
	    elseif Config.Locations[store]["products"] == Config.Products["weapons"] then
	        SetBlipSprite(StoreBlip, 110)
	        SetBlipScale(StoreBlip, 0.85)
	    elseif Config.Locations[store]["products"] == Config.Products["leisureshop"] then
	        SetBlipSprite(StoreBlip, 52)
	        SetBlipScale(StoreBlip, 0.6)
	        SetBlipColour(StoreBlip, 3)           
	    elseif Config.Locations[store]["products"] == Config.Products["mustapha"] then
	        SetBlipSprite(StoreBlip, 225)
	        SetBlipScale(StoreBlip, 0.6)
	        SetBlipColour(StoreBlip, 3)              
	    elseif Config.Locations[store]["products"] == Config.Products["coffeeshop"] then
	        SetBlipSprite(StoreBlip, 140)
	        SetBlipScale(StoreBlip, 0.55)
	    elseif Config.Locations[store]["products"] == Config.Products["casino"] then
	        SetBlipSprite(StoreBlip, 617)
	        SetBlipScale(StoreBlip, 0.70)
	    end

	    SetBlipDisplay(StoreBlip, 4)
	    SetBlipAsShortRange(StoreBlip, true)


	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
	    EndTextCommandSetBlipName(StoreBlip)
	end
    end
end)
