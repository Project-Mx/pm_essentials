if config.fps then
    local ESX = exports['es_extended']:getSharedObject()
    RegisterCommand('fps', function(source)
      OpenFPSMenu()
  end)
end

function OpenFPSMenu() 

    local elements = {
		  {label = 'FPS Boost',		value = 'fps'},	   
      {label = 'Pack Graphic',		value = 'fps7'},	       
      {label = 'View & Improved lights',		value = 'fps5'},         
		  {label = 'Standard',		value = 'fps2'},									          
        }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'Boost FPS Menu',
        align    = 'top-left',
        elements = elements
        },
  
            function(data2, menu2)
  
              if data2.current.value == 'fps' then
                SetTimecycleModifier('yell_tunnel_nodirect')
             elseif data2.current.value == 'fps2' then
                SetTimecycleModifier()
                ClearTimecycleModifier()
                ClearExtraTimecycleModifier()
              elseif data2.current.value == 'fps5' then
                SetTimecycleModifier('tunnel') 
              elseif data2.current.value == 'fps7' then
                  SetTimecycleModifier('MP_Powerplay_blend')
                  SetExtraTimecycleModifier('reflection_correct_ambient')    
              end
            end,
      function(data2, menu2)
        menu2.close()
      end)
end