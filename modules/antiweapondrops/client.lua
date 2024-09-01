if config.antiweapondrops then
	AddEventHandler('populationPedCreating', function(x, y, z)
		Wait(500)	
		local handle = GetClosestPed(vec3(x, y, z)) 
		SetPedDropsWeaponsWhenDead(handle, false)
	end)

	CreateThread(function()
		local sleep
		while true do
			sleep = 1000
			if IsPedBeingStunned(cache.ped, 0) then
				sleep = 0
				SetPedMinGroundTimeForStungun(cache.ped, math.random(4000, 7000))
			end
			Wait(sleep)
		end
	end)
end