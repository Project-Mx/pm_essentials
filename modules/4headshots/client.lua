if config.fourheadshots then
    Citizen.CreateThread(function()
        while true do
            Wait(5)

            SetPedSuffersCriticalHits(PlayerPedId(), false)
        end
    end)
end