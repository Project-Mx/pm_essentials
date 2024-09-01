if config.specialchars then
    function hasSpecialChars(name)
        local pattern = "[%p%c%s]"
        return string.match(name, pattern) ~= nil
    end


    AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
        deferrals.defer()

        Citizen.Wait(0)

        if hasSpecialChars(playerName) then
            setKickReason('Your name contains special characters. Please remove them and try again.')
            deferrals.done('Your name contains special characters. Please remove them and try again.')
        else
            deferrals.done()
        end
    end)
end