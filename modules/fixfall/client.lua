if config.fixfall then
	RegisterCommand('fixfall', function()
		local ped = cache.ped
		local veh = GetVehiclePedIsIn(ped, false)
		if veh ~= 0 then -- get the entity coordinates of the vehicle instead
			_target = veh
		end

		local _coords = GetEntityCoords(ped)
		local _, z = GetGroundZFor_3dCoord(_coords.x, _coords.y, 150.0, 0) -- starting at 150.0 at Z since it works up-down, but not down-up	
		if _coords.z < config_fixfall.z_check then
			if not IsPedFalling(ped) then
				return
			end
			if veh ~= 0 and not IsEntityInAir(veh) then
				return
			end
			ClearPedTasksImmediately(ped)
			SetEntityCoordsNoOffset(ped, _coords.x, _coords.y, z, true, false, false)
			if veh ~= 0 then
				SetPedIntoVehicle(ped, veh, -1)
			end
		end
	end)
end