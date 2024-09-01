local ESX = exports['es_extended']:getSharedObject()
local PlayerData = {}


AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if IsPedInAnyVehicle(PlayerPedId()) then
            SetUserRadioControlEnabled(false)
            if GetPlayerRadioStationName() ~= nil then
                SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()), "OFF")
            end
        end
        
        if not IsAudioSceneActive("CHARACTER_CHANGE_IN_SKY_SCENE") then
            StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        end
    end
end)
