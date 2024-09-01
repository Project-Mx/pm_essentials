local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('ls_essentials:addMileage')
AddEventHandler('ls_essentials:addMileage', function(vehPlate, km)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
	local plate = vehPlate
	local newKM = km

    MySQL.Async.execute('UPDATE veh_km SET km = @kms WHERE carplate = @plate', {['@plate'] = plate, ['@kms'] = newKM})
end)

ESX.RegisterServerCallback('ls_essentials:getMileage', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)
	local vehPlate = plate

	MySQL.Async.fetchAll(
		'SELECT * FROM veh_km WHERE carplate = @plate',
		{
			['@plate'] = vehPlate
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = result[i].carplate

				if vehicleProps == vehPlate then
					KMSend = result[i].km
					found = true
					break
				end

			end

			if found then
				cb(KMSend)
			else
				cb(0)
				MySQL.Async.execute('INSERT INTO veh_km (carplate) VALUES (@carplate)',{['@carplate'] = plate})
				Wait(2000)
			end

		end
	)

end)