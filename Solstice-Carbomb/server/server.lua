local QBCore = exports['qb-core']:GetCoreObject()
local armedVehicles = {}

RegisterServerEvent('Solstice-Carbomb:Server:ArmVehicle')
AddEventHandler('Solstice-Carbomb:Server:ArmVehicle', function(netId, speed)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if player.Functions.GetItemByName(Config.ArmItem) then
        armedVehicles[netId] = speed
        TriggerClientEvent('Solstice-Carbomb:Client:UpdateArmedVehicles', -1, armedVehicles)
        player.Functions.RemoveItem(Config.ArmItem, 1)
    else
        QBCore.Functions.Notify(Config.Notifications.ItemRequirementArm, 'error', src)
    end
end)

QBCore.Functions.CreateUseableItem(Config.ArmItem, function(source, item)
    TriggerClientEvent('Solstice-Carbomb:Client:UseArmItem', source, item)
end)

QBCore.Functions.CreateUseableItem(Config.DisarmItem, function(source, item)
    TriggerClientEvent('Solstice-Carbomb:Client:UseDisarmItem', source, item)
end)

RegisterServerEvent('Solstice-Carbomb:Server:DisarmVehicle')
AddEventHandler('Solstice-Carbomb:Server:DisarmVehicle', function(veh)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player.Functions.GetItemByName(Config.DisarmItem) then
        if armedVehicles[veh] then
            armedVehicles[veh] = nil
            TriggerClientEvent('Solstice-Carbomb:Client:UpdateArmedVehicles', -1, armedVehicles)

            player.Functions.RemoveItem(Config.DisarmItem, 1)
            
            TriggerClientEvent('qb-carbomb:StopTimer', -1, veh)

            QBCore.Functions.Notify(Config.Notifications.DisarmSuccess, 'success', src)
        else
            QBCore.Functions.Notify(Config.Notifications.NoArmedVehicle, 'error', src)
        end
    else
        QBCore.Functions.Notify(Config.Notifications.ItemRequirementDisarm, 'error', src)
    end
end)

RegisterServerEvent('Solstice-Carbomb:Server:NotifyDriver')
AddEventHandler('Solstice-Carbomb:Server:NotifyDriver', function(driverNetId, message, messageType)
    local driverEntity = NetworkGetEntityFromNetworkId(driverNetId)
    local driverSource = NetworkGetEntityOwner(driverEntity)

    if driverSource then
        TriggerClientEvent('Solstice-Carbomb:Client:NotifyDriver', driverSource, message, messageType)
    else
        print("Could not find the driver source for netId: " .. tostring(driverNetId))
    end
end)