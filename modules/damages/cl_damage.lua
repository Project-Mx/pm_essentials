local oldBodyDamage = 0.0
local currentBodyDamage = 0.0
local vehicle
local vehicleClass
local diff = 0.0
local currentHealth = 0.0

function get_class()
    vehicleClass = GetVehicleClass(vehicle)
end

Citizen.CreateThread(function()
    time = 1000
    while true do
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            get_class()
            time = 100
            vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            currentHealth = GetVehicleEngineHealth(vehicle)
            if DoesEntityExist(vehicle) then
                oldBodyDamage = currentBodyDamage
                currentBodyDamage = GetVehicleBodyHealth(vehicle)
                diff = (oldBodyDamage - currentBodyDamage) * config.molt_systemEng * config.demageEng[vehicleClass]
                currentVehicle = GetVehiclePedIsIn(PlayerPedId(-1), false)
                if currentBodyDamage ~= oldBodyDamage and oldBodyDamage ~= 0 and currentBodyDamage ~= 0 and (oldBodyDamage - currentBodyDamage) > 10 then
                    if config.debug_client then
                        print('-----------------------------------------')                        
                        print('Event crash - Send to server')                        
                        print('Damage reducing factor: '..config.demageEng[vehicleClass])  
                        print('Send extent of the collision: '..diff)
                        print('Send Eng. Old: '..oldBodyDamage)
                        print('Send Eng. Current: '..currentBodyDamage)
                        print('Send Current Vehicle: '..vehicle)
                        print('Send Current Vehicle Class: '..vehicleClass)
                        print('-----------------------------------------')                          
                    end
                    TriggerServerEvent('ls_essentials:invia', vehicle, currentHealth, diff)
                end
            end
        else
            time = 1000
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    time = 1000
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            time = 500
            vehicle = GetVehiclePedIsIn(PlayerPedId(-1), false)
        else
            time = 1000
        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent('ls_essentials:ricevi')
AddEventHandler('ls_essentials:ricevi', function(_car, _damage)
    currentHealth = GetVehicleEngineHealth(_car)
    if config.debug_client then  
        print('-----------------------------------------')                        
        print('Event crash - Receives from the server')   
        print('Receives Vehicle: '.._car)
        print('Receives Damage: '.._damage)
        print('-----------------------------------------')           
    end
    SetVehicleEngineHealth(_car, _damage)
    SetVehicleDamage(_car, 1.0, 0.0, 0.0, 7.0  * config.demageBody, 2000.0, true)
    SetVehicleDamage(_car, 0.0, 0.5, 0.0, 7.0 * config.demageBody, 3000.0, true)
    SetVehicleDamage(_car, 0.0, -0.5, 0.0, 7.0 * config.demageBody, 3000.0, true)
    SetVehicleDamage(_car, -1.0, 0.0, 0.0, 7.0 * config.demageBody, 2000.0, true)
    SetVehicleDamage(_car, 0.0, 0.0, 1.0, 7.0 * config.demageBody, 2000.0, true)
end)

RegisterNetEvent('ls_essentials:stop')
AddEventHandler('ls_essentials:stop', function(_car)
    SetVehicleUndriveable(_car, true)
    if config.debug_client then 
        print('-----------------------------------------')         
        print('STOP VEHICLE')
        print('-----------------------------------------')          
    end
end)


RegisterCommand('vstats', function()
ExecuteCommand('miles')
TriggerEvent('chatMessage', 'Dashboard Display: ' )

    local player = PlayerPedId()
    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local currentHealth = GetVehicleEngineHealth(vehicle)
        local healthPercentage = (currentHealth / 1000) * 100 
        TriggerEvent('chatMessage', '', {255, 0, 0}, '^3Engine Health:^1 ' .. math.floor(healthPercentage) .. '% ')
        if healthPercentage < 50 then
            TriggerEvent('chatMessage', '', {255, 0, 0}, 'Warning: Engine health is below 50%! Take your vehicle to a mechanic.')
        end
    else
        TriggerEvent('chatMessage', '', {255, 0, 0}, 'You are not in a vehicle.')
    end
end, false)


local vehicleEntered = {} 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local vehicleClass = GetVehicleClass(vehicle)
            if vehicleClass ~= 13 and vehicleClass ~= 14 and vehicleClass ~= 15 and vehicleClass ~= 16 then
                 local vehicleId = VehToNet(vehicle)
                local speed = GetEntitySpeed(vehicle) * 2.236936 
                if speed > 5 and not vehicleEntered[vehicleId] then
                    TriggerEvent('chat:addMessage', {
                        color = {255, 0, 0},
                        multiline = true,
                        args = {"[!]", "/vstats to view dashboard."}
                    })
                    vehicleEntered[vehicleId] = true
                end
            end
        else
            vehicleEntered = {} 
        end
    end
end)


function ToggleVehicleEngine()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local engineState = GetIsVehicleEngineRunning(vehicle)
        if engineState then
            SetVehicleEngineOn(vehicle, false, false, true)
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                multiline = true,
                args = {"[!]", "Vehicle engine turned off."}
            })
        else
            SetVehicleEngineOn(vehicle, true, false, true)
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                multiline = true,
                args = {"[!]", "Vehicle engine turned on."}
            })
        end
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"[!]", "You are not in a vehicle."}
        })
    end
end

RegisterCommand("engine", function()
    ToggleVehicleEngine()
end, false)


