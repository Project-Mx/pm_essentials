if config.damages then
    local DamageHealt = 0

    RegisterServerEvent('ls_essentials:invia')
    AddEventHandler('ls_essentials:invia', function(car, health, diffe)
        DamageHealt = health - diffe
        if DamageHealt > 80 then
            TriggerClientEvent('ls_essentials:ricevi', -1, car, DamageHealt)
        elseif DamageHealt <= 80 then
            TriggerClientEvent('ls_essentials:stop', -1, car)
        end
    end)
end