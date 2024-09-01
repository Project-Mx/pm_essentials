if config.antistealthkill then
    local stealthKill = {
        "ACT_stealth_kill_a",
        "ACT_stealth_kill_weapon",
        "ACT_stealth_kill_b",
        "ACT_stealth_kill_c",
        "ACT_stealth_kill_d",
        "ACT_stealth_kill_a_gardener"
    }

    CreateThread(function()
        for _, killName in ipairs(stealthKill) do
            local hash = GetHashKey(killName)
            RemoveStealthKill(hash, false)
        end
    end)

    CreateThread(function()
        local sleep = true
        local IsPedArmed = IsPedArmed
        local IsPlayerFreeAiming = IsPlayerFreeAiming
        local DisableControlAction = DisableControlAction

        while true do
            if IsPedArmed(cache.ped, 6) or IsPlayerFreeAiming(cache.playerId) then
                sleep = false
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
                DisableControlAction(1, 263, true)
                DisableControlAction(1, 264, true)
            end

            Wait(sleep and 1500 or 0)
        end
    end)
end