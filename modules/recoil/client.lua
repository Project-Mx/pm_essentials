if config.recoil then
	CreateThread(function()
		local IsPedShooting = IsPedShooting;
		local IsPedDoingDriveby = IsPedDoingDriveby;
		local GetCurrentPedWeapon = GetCurrentPedWeapon;
		local GetFollowPedCamViewMode = GetFollowPedCamViewMode;
		local GetGameplayCamRelativePitch = GetGameplayCamRelativePitch;
		local SetGameplayCamRelativePitch = SetGameplayCamRelativePitch;

		while true do
			if IsPedShooting(cache.ped) and not IsPedDoingDriveby(cache.ped) then
				local _, weapon = GetCurrentPedWeapon(cache.ped)

				if config_recoil.weapons[weapon] and config_recoil.weapons[weapon] ~= 0 then
					local tv = 0

					if GetFollowPedCamViewMode() ~= 4 then
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							SetGameplayCamRelativePitch(p+0.1, 0.2)
							tv += 0.1
						until tv >= config_recoil.weapons[weapon]
					else
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							if config_recoil.weapons[weapon] > 0.1 then
								SetGameplayCamRelativePitch( p + 0.6, 1.2)
								tv += 0.6
							else
								SetGameplayCamRelativePitch(p + 0.016, 0.333)
								tv += 0.1
							end
						until tv >= config_recoil.weapons[weapon]
					end
				end
			end
			Wait(0)
		end
	end)
end