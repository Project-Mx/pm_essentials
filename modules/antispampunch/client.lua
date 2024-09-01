if config.antispampunch then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 5.0 then
                DisableControlAction(1, 140, true)
                if not IsPlayerTargettingAnything(PlayerId()) then
                    DisableControlAction(1, 141, true)
                    DisableControlAction(1, 142, true)
                end
            else
                Citizen.Wait(250)
            end
        end
    end)
end