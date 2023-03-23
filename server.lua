ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ille_drugdelivery:timerEvent')
AddEventHandler('ille_drugdelivery:timerEvent', function()
    local spawnCoords = Config.SpawnPoint
    local deliveryPoint = Config.DeliveryPoint
					TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="font-size:17px;font-family: Arial, Helvetica, sans-serif;padding: 0.3vw; margin: 0.5vw;box-shadow:0px 1.5px 5px blue; background:blue; border-radius: 3px;"><b style="color:yellow">[Drug-Delivery]</b> Open your map and find the drug deliver van and go and get it and deliver it to the destination to receive the rewards!</div>'
				})
end)

RegisterNetEvent('ille_drugdelivery:enteredVehicle')
AddEventHandler('ille_drugdelivery:enteredVehicle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx:showNotification', -1, "~g~The drug delivery has started.")
					TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="font-size:17px;font-family: Arial, Helvetica, sans-serif;padding: 0.3vw; margin: 0.5vw;box-shadow:0px 1.5px 5px blue; background:blue; border-radius: 3px;"><b style="color:yellow">[Drug-Delivery]</b> Someone entered the drug delivery van, he is visible on the map, you can go and kill him and get the van!</div>'
				})
end)

RegisterNetEvent('ille_drugdelivery:FinishedNotifyALL')
AddEventHandler('ille_drugdelivery:FinishedNotifyALL', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
					TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="font-size:17px;font-family: Arial, Helvetica, sans-serif;padding: 0.3vw; margin: 0.5vw;box-shadow:0px 1.5px 5px blue; background:blue; border-radius: 3px;"><b style="color:yellow">[Drug-Delivery]</b> The Delivery Van was delivered to its location.</div>'
				})
end)

RegisterNetEvent('ille_drugdelivery:deliveredDrugs')
AddEventHandler('ille_drugdelivery:deliveredDrugs', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(Config.MoneyGiven)
    xPlayer.addInventoryItem(Config.ItemGiven, Config.ItemGivenAmount)
    xPlayer.showNotification("~g~You have successfully delivered the drugs and received your reward!")
end)

RegisterCommand('startdd', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getGroup() == 'superadmin' then
        local spawnCoords = Config.SpawnPoint
        local deliveryPoint = Config.DeliveryPoint
        TriggerClientEvent('ille_drugdelivery:startDrugDelivery', -1, spawnCoords, deliveryPoint)
		TriggerClientEvent('ille_drugdelivery:announcement',-1)
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="font-size:17px;font-family: Arial, Helvetica, sans-serif;padding: 0.3vw; margin: 0.5vw;box-shadow:0px 1.5px 5px blue; background:blue; border-radius: 3px;"><b style="color:yellow">[Drug-Delivery]</b> Open your map and find the drug deliver van and go and get it and deliver it to the destination to receive the rewards!</div>'
				})
    else
        xPlayer.showNotification("~r~You do not have permission to use this command.")
    end
end, false)