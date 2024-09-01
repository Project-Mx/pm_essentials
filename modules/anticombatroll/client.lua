
if config.anticombatroll then
	CreateThread(function()
		local sleep = true
		local IsPedArmed = IsPedArmed
		local IsControlPressed = IsControlPressed
		local DisableControlAction = DisableControlAction

		while true do
			if IsPedArmed(cache.ped, 4 | 2) and IsControlPressed(0, 25) then
				sleep = false
				DisableControlAction(0, 22, true)
			end

			Wait(sleep and 1500 or 0)
		end
	end)
end