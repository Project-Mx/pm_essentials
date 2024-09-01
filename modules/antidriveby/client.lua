
if config.antidriveby then
	local passengerDriveby = true
	local SetPlayerCanDoDriveBy = SetPlayerCanDoDriveBy

	lib.onCache('seat', function(seat)
		if seat ~= -1 and passengerDriveby then
			SetPlayerCanDoDriveBy(cache.playerId, true)
		else
			SetPlayerCanDoDriveBy(cache.playerId, false)
			TriggerEvent('ox_inventory:disarm', true)
		end
	end)
end