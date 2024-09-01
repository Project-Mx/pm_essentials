if config.autowalk then
    local autoWalkEnabled = false

    function StartAutoWalk()
        if autoWalkEnabled then

            if PlayerPedId() and DoesEntityExist(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true) then
                local oneortwo = false
                local actualcoords = GetEntityCoords(PlayerPedId())

                Citizen.CreateThread(function()
                    Wait(2000)
                    while autoWalkEnabled do
                        Wait(500)
                        if #(actualcoords - GetEntityCoords(PlayerPedId())) < 0.5 then
                            autoWalkEnabled = false
                            ClearPedTasksImmediately(PlayerPedId())
                        end
                        actualcoords = GetEntityCoords(PlayerPedId())
                    end
                end)
                while autoWalkEnabled do
                    local autoWalkSpeed = config_autowalk.AutoWalkSpeedNormal
                    if IsControlJustPressed(0,config_autowalk.DisableWalkControl) or config_autowalk.UseDisabledCommands and IsDisabledControlPressed(0,config_autowalk.DisableWalkControl) or IsPedInAnyVehicle(PlayerPedId(), true) then 
                        autoWalkEnabled = false
                        ClearPedTasks(PlayerPedId())
                        ClearPedSecondaryTask(PlayerPedId())
                        break
                    end
                    local leftright = 0.0
                    if IsControlPressed(0,config_autowalk.GoLeftControl) or config_autowalk.UseDisabledCommands and IsDisabledControlPressed(0,config_autowalk.GoLeftControl) then
                        leftright = leftright - config_autowalk.GoLeftSpeed
                    end
                    if IsControlPressed(0,config_autowalk.GoRightControl) or config_autowalk.UseDisabledCommands and IsDisabledControlPressed(0,config_autowalk.GoRightControl) then
                        leftright = leftright + config_autowalk.GoRightSpeed
                    end

                    if IsControlPressed(0,config_autowalk.RunButton) or config_autowalk.UseDisabledCommands and IsDisabledControlPressed(0,config_autowalk.RunButton) then
                        oneortwo = not oneortwo
                        if oneortwo then
                            leftright = leftright + 0.01
                        else
                            leftright = leftright - 0.01
                        end
                        autoWalkSpeed = config_autowalk.AutoWalkSpeedRunning
                    end

                    local coordstogo = GetOffsetFromEntityInWorldCoords(PlayerPedId(), leftright, autoWalkSpeed, 0.0)
                    TaskGoStraightToCoord(PlayerPedId(), coordstogo, autoWalkSpeed, -1, GetEntityHeading(PlayerPedId()), 0.0)

                    Wait(0)
                end
                
            end
        else
            ClearPedTasks(PlayerPedId())
            ClearPedSecondaryTask(PlayerPedId())
        end
    end

    RegisterCommand(config_autowalk.AutoWalkCommand, function(source, args, rawCommand)
        autoWalkEnabled = not autoWalkEnabled
        StartAutoWalk()
    end)
end