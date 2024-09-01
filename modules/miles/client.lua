if config.milescommand then
	local PlayerData = {}
	local inVeh = false
	local distance = 0
	local vehPlate

	local hasKM = 0
	local showKM = 0

	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
		PlayerData = xPlayer
	end)

	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
		PlayerData.job = job
	end)

	function round(num, numDecimalPlaces)
		local mult = 10^(numDecimalPlaces or 0)
		return math.floor(num * mult + 0.5) / mult
	end

	RegisterCommand("miles", function(source, args, rawCommand)
		local playerPed = PlayerPedId()
		local isInVehicle = IsPedInAnyVehicle(playerPed, false)

		if isInVehicle then
			local veh = GetVehiclePedIsIn(playerPed, false)
			local driver = GetPedInVehicleSeat(veh, -1)
			local passenger = GetPedInVehicleSeat(veh, 0)

			if driver == playerPed or passenger == playerPed then
				local vehClass = GetVehicleClass(veh)
				if vehClass ~= 13 and vehClass ~= 14 and vehClass ~= 15 and vehClass ~= 16 and vehClass ~= 17 and vehClass ~= 21 then
					vehPlate = GetVehicleNumberPlateText(veh)
					ESX.TriggerServerCallback('ls_essentials:getMileage', function(hasKM)
						showKM = math.floor(hasKM * 1.33) / 1000
						TriggerEvent('chat:addMessage', {
							color = { 255, 255, 255 },
							multiline = true,
							args = { "Vehicle Miles: " .. round(showKM, 2)}
						})
					end, vehPlate)
				else
					TriggerEvent('chat:addMessage', {
						color = { 255, 0, 0 },
						multiline = true,
						args = { "[!]", "You cannot check mileage for this type of vehicle." }
					})
				end
			else
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0 },
					multiline = true,
					args = { "[!]", "You must be the driver or the passenger to check the mileage." }
				})
			end
		else
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0 },
				multiline = true,
				args = { "[!]", "You are not in a vehicle." }
			})
		end
	end, false)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(250)
			local playerPed = PlayerPedId()
			local isInVehicle = IsPedInAnyVehicle(playerPed, false)

			if isInVehicle then
				local veh = GetVehiclePedIsIn(playerPed, false)
				local driver = GetPedInVehicleSeat(veh, -1)

				if driver == playerPed then
					local vehClass = GetVehicleClass(veh)
					if vehClass ~= 13 and vehClass ~= 14 and vehClass ~= 15 and vehClass ~= 16 and vehClass ~= 17 and vehClass ~= 21 then
						if not inVeh then
							inVeh = true
							vehPlate = GetVehicleNumberPlateText(veh)
							ESX.TriggerServerCallback('ls_essentials:getMileage', function(hasKM)
								showKM = math.floor(hasKM * 1.33) / 1000
								local oldPos = GetEntityCoords(playerPed)
								Citizen.Wait(1000)
								local curPos = GetEntityCoords(playerPed)
								local dist = IsVehicleOnAllWheels(veh) and GetDistanceBetweenCoords(oldPos.x, oldPos.y, oldPos.z, curPos.x, curPos.y, curPos.z, true) or 0
								hasKM = hasKM + dist
								TriggerServerEvent('ls_essentials:addMileage', vehPlate, hasKM)
								inVeh = false
							end, vehPlate)
						end

						if showKM >= 5000 then
							SetVehicleDirtLevel(veh, 15.0)
							SetVehicleEngineHealth(veh, 650)
						end
					end
				end
			else
				inVeh = false
				Citizen.Wait(500)
			end

			Citizen.Wait(0)
		end
	end)
end

