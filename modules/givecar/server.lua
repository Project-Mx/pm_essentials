local ESX = exports['es_extended']:getSharedObject()
local Vehicles = {}

if config.givecar == true then
    ESX.RegisterCommand('givecar', 'admin', function(xPlayer, args, showError)
        local targetPlayerId = args.playerId
        local model = args.model

        if targetPlayerId and model and model ~= '' then
            local targetPlayer = ESX.GetPlayerFromId(targetPlayerId)
            
            if targetPlayer then
                local plate = GeneratePlate()
                local p = {
                    model = model,
                    plate = plate
                }
                CreateVehicleDB(plate, p, targetPlayer)
                TriggerClientEvent('pm_givecar:car', targetPlayerId, model, nil, plate)
                targetPlayer.showNotification(string.format("You have been given a free vehicle: %s with plate %s", model, plate))
                xPlayer.showNotification(string.format("You have given a vehicle: %s with plate %s to player ID %d", model, plate, targetPlayerId))
            else
                xPlayer.showNotification("Invalid player ID.")
            end
        else
            xPlayer.showNotification("Invalid usage. Correct syntax: /givecar [playerId] [model]")
        end
    end, true, {help = 'Give a player a free vehicle', validate = true, arguments = {
        {name = 'playerId', help = 'Player ID', type = 'number'},
        {name = 'model', help = 'Vehicle model name', type = 'string'}
    }})
end

CreateVehicleDB = function(plate, p, xPlayer)
    p.plate = plate
    MySQL.Sync.execute("INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)", {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = tostring(plate),
        ['@vehicle'] = json.encode(p)
    })
end

GeneratePlate = function()
    local firstLetter = string.char(math.random(65, 90)) 
    local secondLetter = string.char(math.random(65, 90)) 
    local numbers = math.random(100, 999) 
    local plate = firstLetter .. secondLetter .. numbers
    return plate
end

ESX.RegisterCommand('delplate', 'admin', function(xPlayer, args, showError)
    local plate = args.plate

    if plate and plate ~= '' then
        plate = string.upper(plate)
        local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        })

        if result == 1 then
            xPlayer.showNotification(string.format('You deleted a vehicle with plate %s', plate))
            local bool = false 
        else
            xPlayer.showNotification(string.format('Cannot find vehicle with plate %s', plate))
        end
    else
        xPlayer.showNotification('Invalid usage. Correct syntax: /delplate [plate]')
    end
end, true, {help = 'Delete a vehicle by its plate', validate = true, arguments = {
    {name = 'plate', help = 'License plate', type = 'string'}
}})
