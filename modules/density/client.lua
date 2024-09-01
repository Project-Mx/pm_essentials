if config.density then
    -------------------------------------------------------------------------------
    -- Dispatch Configuration
    -------------------------------------------------------------------------------
    CreateThread(function()
        SetAudioFlag("DisableFlightMusic", true)
        SetAudioFlag("PoliceScannerDisabled", true)

        SetRandomBoats(false)
        SetRandomTrains(false)
        SetGarbageTrucks(false)
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
        SetDispatchCopsForPlayer(cache.ped, false)
        DistantCopCarSirens(false)

        -- Generators
        RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 46.51 + 300.0)
        RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0)
        RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0)
        RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0)
        RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0) 
        RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0)
        RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0)
        RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0)

        while true do
            Wait(5000)
            local playerCoords = GetEntityCoords(cache.ped)
            ClearAreaOfCops(playerCoords.x, playerCoords.y, playerCoords.z, 400.0, 0)
        end
    end)

    -------------------------------------------------------------------------------
    -- Density Configuration
    -------------------------------------------------------------------------------
    local function DecorSet(Type, Value)
        if Type == 'parked' then
            config_density.Density['parked'] = Value
        elseif Type == 'vehicle' then
            config_density.Density['vehicle'] = Value
        elseif Type == 'multiplier' then
            config_density.Density['multiplier'] = Value
        elseif Type == 'peds' then
            config_density.Density['peds'] = Value
        elseif Type == 'scenario' then
            config_density.Density['scenario'] = Value
        end
    end

    exports('DecorSet', DecorSet)

    CreateThread(function()
        while true do
            -- Density
            SetParkedVehicleDensityMultiplierThisFrame(config_density.Density['parked'])
            SetVehicleDensityMultiplierThisFrame(config_density.Density['vehicle'])
            SetRandomVehicleDensityMultiplierThisFrame(config_density.Density['multiplier'])
            SetPedDensityMultiplierThisFrame(config_density.Density['peds'])
            SetScenarioPedDensityMultiplierThisFrame(config_density.Density['scenario'], config_density.Density['scenario'])

            -- Suppress Models
            SetVehicleModelIsSuppressed(`rubble`, true)
            SetVehicleModelIsSuppressed(`dump`, true)
            SetVehicleModelIsSuppressed(`biff`, true)
            SetVehicleModelIsSuppressed(`blimp`, true)
            SetVehicleModelIsSuppressed(`mule`, true)
            Wait(0)
        end
    end)
end