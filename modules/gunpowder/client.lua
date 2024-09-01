if config.gunpowder then
    local lastShotTime = 0 
    local shootingCooldown = 15500

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0) 

            if IsPedShooting(GetPlayerPed(-1)) and (GetGameTimer() - lastShotTime) > shootingCooldown then
                lastShotTime = GetGameTimer() 
                lib.notify({ icon = 'fa fa-search-minus', duration = 6000, description = "Smells of gunpowder..." }) 

                TriggerEvent('chat:addMessage', {
                    template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; word-break: break-word;"> [!]:^0 Your adrenaline starts to rush...</div>',
                    args = {}
                })

                TriggerEvent('chat:addMessage', {
                    template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; word-break: break-word;"> [!]:^0 Head to the water to wash rinse off powder...</div>',
                    args = {}
                })
            end
        end
    end)
else
end