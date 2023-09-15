local QBCore = exports['qb-core']:GetCoreObject()
local armedVeh = nil
local armedSpeed = nil
local lowerBound = nil
local upperBound = nil
local hasReachedSpeed = false
local currentDriver = nil
local armedVehicles = {}

RegisterNetEvent('Solstice-Carbomb:Client:UpdateArmedVehicles')
AddEventHandler('Solstice-Carbomb:Client:UpdateArmedVehicles', function(updatedArmedVehicles)
    armedVehicles = updatedArmedVehicles
end)

RegisterNetEvent('Solstice-Carbomb:Client:UseArmItem')
AddEventHandler('Solstice-Carbomb:Client:UseArmItem', function(item)
    local outcome = exports.mbt_minigames:startHackingSession({
        Time = Config.MinigameTime,
    })
    if outcome then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 70)
        
        if DoesEntityExist(veh) then
            local networkId = NetworkGetNetworkIdFromEntity(veh)    
            local speedInput = exports['qb-input']:ShowInput({
                header = 'Detonation Speed',
                submitText = 'Set',
                inputs = {
                    {
                        type = 'number',
                        isRequired = true,
                        name = 'speed',
                        text = 'Speed (MPH)'
                    }
                }
            })

            if speedInput and speedInput.speed then
                armedSpeed = tonumber(speedInput.speed)
                lowerBound = armedSpeed - 10  -- Set lowerBound here
                armedVeh = veh
                TriggerServerEvent('Solstice-Carbomb:Server:ArmVehicle', networkId, armedSpeed)    
                QBCore.Functions.Notify("You have successfully armed the bomb. The bomb will arm at " .. tostring(armedSpeed) .. " MPH.", "success")
            else
                QBCore.Functions.Notify("You failed to set the speed.", "error")
            end
        else
            QBCore.Functions.Notify("No vehicle nearby to arm.", "error")
        end
    else
        QBCore.Functions.Notify("You failed to arm the bomb.", "error")
    end
end)


RegisterNetEvent('Solstice-Carbomb:Client:NotifyDriver')
AddEventHandler('Solstice-Carbomb:Client:NotifyDriver', function(message, messageType)
    if messageType and message then
        QBCore.Functions.Notify(message, messageType)
    else
        print("Received incorrect message or messageType")
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        
        if armedVeh and DoesEntityExist(armedVeh) then
            local speed = GetEntitySpeed(armedVeh) * 2.236936
            currentDriver = GetPedInVehicleSeat(armedVeh, -1)
            
            if currentDriver and currentDriver ~= 0 then
                if speed >= armedSpeed then
                    if not hasReachedSpeed then
                        TriggerServerEvent('Solstice-Carbomb:Server:NotifyDriver', NetworkGetNetworkIdFromEntity(currentDriver), 'You realize there\'s a bomb in the vehicle. Maintain speed to prevent it from blowing up!', 'error')
                        hasReachedSpeed = true
                    end
                elseif speed < lowerBound and hasReachedSpeed then
                    AddExplosion(GetEntityCoords(armedVeh), 4, 1.0, true, false, 1.0)
                    TriggerServerEvent('Solstice-Carbomb:Server:NotifyDriver', NetworkGetNetworkIdFromEntity(currentDriver), 'The vehicle has exploded!', 'error')
                    
                    armedVeh = nil
                    armedSpeed = nil
                    lowerBound = nil
                    hasReachedSpeed = false
                end
            end
        end
    end
end)

RegisterNetEvent('Solstice-Carbomb:Client:UseDisarmItem')
AddEventHandler('Solstice-Carbomb:Client:UseDisarmItem', function(item)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 70)
    
    if DoesEntityExist(veh) and veh == armedVeh then
        TriggerServerEvent('Solstice-Carbomb:Server:DisarmVehicle', veh)
        armedVeh = nil
        armedSpeed = nil
    else
        TriggerEvent('QBCore:Notify', 'No vehicle nearby to disarm.', 'error')
    end
end)
