ESX = nil
local deliveryVehicle
local globalDeliveryBlip
local targetBlip
local playerIsInVehicle = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('ille_drugdelivery:startDrugDelivery')
AddEventHandler('ille_drugdelivery:startDrugDelivery', function(spawnCoords, deliveryPoint)
    ESX.Game.SpawnVehicle(Config.VehicleModel, spawnCoords, spawnCoords.h, function(vehicle)
        deliveryVehicle = vehicle
        SetEntityAsMissionEntity(deliveryVehicle, true, true)

        globalDeliveryBlip = AddBlipForEntity(deliveryVehicle)
        SetBlipSprite(globalDeliveryBlip, 616)
        SetBlipColour(globalDeliveryBlip, 1)
        SetBlipScale(globalDeliveryBlip, 0.8)
        SetBlipAsShortRange(globalDeliveryBlip, false)
        SetBlipHighDetail(globalDeliveryBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("~r~Drug Delivery Van")
        EndTextCommandSetBlipName(globalDeliveryBlip)
		
		ESX.ShowAdvancedNotification(Config.AdvancedNotification2.title, Config.AdvancedNotification2.subject, Config.AdvancedNotification2.msg, Config.AdvancedNotification2.icon, Config.AdvancedNotification2.iconType)
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if vehicle == deliveryVehicle then
                if not playerIsInVehicle then
                    playerIsInVehicle = true
                    SetVehicleDoorsLocked(deliveryVehicle, 1)
                    TriggerServerEvent('ille_drugdelivery:enteredVehicle')

                    SetNewWaypoint(deliveryPoint.x, deliveryPoint.y)

                                        targetBlip = AddBlipForCoord(deliveryPoint.x, deliveryPoint.y, deliveryPoint.z)
                    SetBlipSprite(targetBlip, 616)
                    SetBlipColour(targetBlip, 5)
                    SetBlipScale(targetBlip, 0.8)
                    SetBlipAsShortRange(targetBlip, true)
                    SetBlipHighDetail(targetBlip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentSubstringPlayerName("~y~Delivery Point")
                    EndTextCommandSetBlipName(targetBlip)

                    ESX.ShowAdvancedNotification(Config.AdvancedNotification.title, Config.AdvancedNotification.subject, Config.AdvancedNotification.msg, Config.AdvancedNotification.icon, Config.AdvancedNotification.iconType)
                end

                local coords = GetEntityCoords(playerPed)
                local distance = GetDistanceBetweenCoords(coords, deliveryPoint.x, deliveryPoint.y, deliveryPoint.z, true)

                if distance < 15.0 then
                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to deliver drugs.")
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent('ille_drugdelivery:deliveredDrugs')
						TriggerServerEvent('ille_drugdelivery:FinishedNotifyALL')
                        ESX.Game.DeleteVehicle(deliveryVehicle)
                        deliveryVehicle = nil
                        playerIsInVehicle = false

                        if globalDeliveryBlip ~= nil then
                            RemoveBlip(globalDeliveryBlip)
                            globalDeliveryBlip = nil
                        end

                        if targetBlip ~= nil then
                            RemoveBlip(targetBlip)
                            targetBlip = nil
                        end
                    end
                end
            elseif playerIsInVehicle then
                playerIsInVehicle = false
                if targetBlip ~= nil then
                    RemoveBlip(targetBlip)
                    targetBlip = nil
                end
            end
        end
    end)
end)

-- Add a timer to start the delivery event
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Timer * 1000)
        TriggerServerEvent('ille_drugdelivery:timerEvent')
    end
end)

