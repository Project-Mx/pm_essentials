RegisterNetEvent('pm_givecar:showDeleteVehicleMenu')
AddEventHandler('pm_givecar:showDeleteVehicleMenu', function(vehicles, targetPlayerId)
    local vehicleOptions = {}

    for _, vehicle in ipairs(vehicles) do
        table.insert(vehicleOptions, {
            title = string.format("%s (%s)", vehicle.model, vehicle.plate),
            description = "Select this vehicle to delete",
            event = 'pm_givecar:selectVehicleToDelete',
            args = { plate = vehicle.plate, targetPlayerId = targetPlayerId }
        })
    end

    -- Register and show the context menu using ox_lib
    lib.registerContext({
        id = 'delete_vehicle_menu',
        title = 'Select Vehicle to Delete',
        options = vehicleOptions
    })

    lib.showContext('delete_vehicle_menu')
end)

RegisterNetEvent('pm_givecar:selectVehicleToDelete')
AddEventHandler('pm_givecar:selectVehicleToDelete', function(data)
    local plate = data.plate
    local targetPlayerId = data.targetPlayerId
    local adminId = source
    local targetPlayerId = GetPlayerServerId(PlayerId())
    -- Trigger server event to delete the vehicle
    TriggerServerEvent('pm_givecar:deleteSelectedVehicle', adminId, plate, targetPlayerId)
end)
