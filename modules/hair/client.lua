if config.haircommand then
    local isMale = true
    local ishairoff = false
    local currenthair = 0
    local currenthaircolor = 0

    TriggerEvent('chat:addSuggestion', '/hair', 'Toggle your hair.')

    function getSex()
        if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
            isMale = true
        elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
            isMale = false
        end
        return isMale
    end

    RegisterNetEvent('toggle:hair')
    AddEventHandler('toggle:hair', function()
        local ped = PlayerPedId()

        if getSex() and ishairoff then
            SetPedComponentVariation(ped, 2, currenthair, 0, 0)      
            SetPedHairColor(ped, currenthaircolor)
            ishairoff = false
        else
            currenthair = GetPedDrawableVariation(ped, 2)
            currenthaircolor = GetPedHairColor(ped, 2)

            SetPedComponentVariation(ped, 2, 0, 0, 0)
            ishairoff = true
        end
    end)

    RegisterCommand('hair', function(source, args, rawCommand)
        TriggerEvent('toggle:hair')
    end)
end