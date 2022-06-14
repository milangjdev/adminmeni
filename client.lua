ESX = nil

Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)

RegisterKeyMapping('adminmeni', 'Admin Meni', 'keyboard', 'HOME')
RegisterCommand('adminmeni', function()
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
		if playerRank == "admin" or playerRank == "superadmin" or playerRank == "helper" or playerRank == "vodjalidera" or playerRank == "headadmin" or playerRank == "menadzer" or playerRank == "developer" or playerRank == "suvlasnik" or playerRank == "owner" then
            TriggerEvent('milan:adminmeni')
        else
            if Config.okokNotify then
             exports['okokNotify']:Alert("ADMIN", "Nemas Dozvolu.", 5000, 'info')
            elseif Config.MythicNotify then
              exports['mythic_notify']:DoHudText('error', 'Nemas Dozvolu.')
            elseif Config.DefaultNotify then
                ESX.ShowNotification('Nemas Dozvolu') 
            end
        end
    end)
end, false)

RegisterNetEvent('milan:adminmeni', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Admin Meni",
            txt = ""
        },
        {
            id = 2,
            header = "Nevidljivost 🌟",
            txt = "Ukljuci Nevidljivost",
            params = {
                event = "nevidljivost",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 
        {
            id = 3,
            header = "Teleport na Marker ✈",
            txt = "Teleportaj se na marker oznacen na mapi",
            params = {
                event = "teleport:marker",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Stvori Vozilo 🚗",
            txt = "Stvori vozilo po zjeli",
            params = {
                event = "vozilo",
                args = {
                    number = 3,
                    id = 4
                }
            }
        }, 
        {
            id = 5,
            header = "Obrisi Vozilo 🚗",
            txt = "Obrisi vozilo u koje se nalazis",
            params = {
                event = "obrisi:vozilo",
                args = {
                    number = 4,
                    id = 5
                }
            }
        },          
        {
            id = 6,
            header = "Popravi 🔧",
            txt = "Popravi vozilo u koje se nalazis",
            params = {
                event = "popravi:vozilo",
                args = {
                    number = 5,
                    id = 6
                }
            }
        },     
        {
            id = 7,
            header = "Ocisti 🧽",
            txt = "Ocisti vozilo u koje se nalazis",
            params = {
                event = "ocisti:vozilo",
                args = {
                    number = 6,
                    id = 7
                }
            }
        },  
        {
            id = 8,
            header = "Ozivi se 👨‍⚕️",
            txt = "Ozivi se",
            params = {
                event = "esx_ambulancejob:revive",
                args = {
                    number = 7,
                    id = 8
                }
            }
        },  
        {
            id = 9,
            header = "Heal se ❤",
            txt = "Nahilaj se",
            params = {
                event = "esx_basicneeds:healPlayer",
                args = {
                    number = 8,
                    id = 9
                }
            }
        },   
        {
            id = 10,
            header = "NoClip 🛸",
            txt = "Ukljuci NoClip",
            params = {
                event = "esx:noclip",
                args = {
                    number = 9,
                    id = 10
                }
            }
        }, 
        {
            id = 11,
            header = "ID 🆔",
            txt = "Ukljuci ID-eve",
            params = {
                event = "ideve",
                args = {
                    number = 10,
                    id = 11
                }
            }
        }, 
        {
            id = 12,
            header = "Posmatraj 🔭",
            txt = "Posmatraj nekoga",
            params = {
                event = "esx_spectate:spectate",
                args = {
                    number = 11,
                    id = 12
                }
            }
        },
    })
end)

local nevidljivost = false
RegisterNetEvent('nevidljivost')
AddEventHandler('nevidljivost', function()
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
    if nevidljivost == false then
        if Config.MythicNotify then
            exports['mythic_notify']:DoHudText('inform', 'Ukljucio si Nevidljivost.')
        elseif Config.okokNotify then
            exports['okokNotify']:Alert("ADMIN", "Ukljucio si Nevidljivost.", 5000, 'info')
        elseif Config.DefaultNotify then
            ESX.ShowNotification('Ukljucio si Nevidljivost.')
        end
        SetEntityVisible(PlayerPedId(), false)
        nevidljivost = true
        local igrac = PlayerId()
        local ime = GetPlayerName(igrac)
        local msg = ''..ime..  ' je ukljucio nevidljivost. \nGrupa: ' ..playerRank.. '' 
        local bot = "Admin"
        TriggerServerEvent('logovi', bot, msg) 
      else
        if Config.MythicNotify then
            exports['mythic_notify']:DoHudText('inform', 'Iskljucio si Nevidljivost.')
        elseif Config.okokNotify then
            exports['okokNotify']:Alert("ADMIN", "Iskljucio si Nevidljivost.", 5000, 'info')
        elseif Config.DefaultNotify then
            ESX.ShowNotification('Iskljucio si Nevidljivost.')
        end
        SetEntityVisible(PlayerPedId(), true)
        nevidljivost = false
        local igrac = PlayerId()
        local ime = GetPlayerName(igrac)
        local msg = ''..ime..  ' je iskljucio nevidljivost. \nGrupa: ' ..playerRank.. '' 
        local bot = "Admin"
        TriggerServerEvent('logovi', bot, msg) 
      end
    end)
end)

RegisterNetEvent('teleport:marker')
AddEventHandler('teleport:marker', function()
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
    local WaypointHandle = GetFirstBlipInfoId(8)

    if DoesBlipExist(WaypointHandle) then
      local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

      for height = 1, 1000 do
        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

        local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

        if foundGround then
          SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
          break
        end
        Citizen.Wait(0)
      end
      local igrac = PlayerId()
      local ime = GetPlayerName(igrac)
      local msg = ''..ime..  ' se teleportovao na marker. \nGrupa: ' ..playerRank.. '' 
      local bot = "Admin"
      TriggerServerEvent('logovi', bot, msg) 
      if Config.MythicNotify then
        exports['mythic_notify']:DoHudText('inform', 'Teleportovani ste do trazenje lokacije.')
    elseif Config.okokNotify then
        exports['okokNotify']:Alert("ADMIN", "Teleportovani ste do trazenje lokacije.", 5000, 'info')
    elseif Config.DefaultNotify then
        ESX.ShowNotification('Teleportovani ste do trazenje lokacije.')
    end
    else        
        if Config.MythicNotify then
        exports['mythic_notify']:DoHudText('error', 'Morate oznaciti lokaciju na mapi!')
    elseif Config.okokNotify then
        exports['okokNotify']:Alert("ADMIN", "Morate oznaciti lokaciju na mapi!", 5000, 'error')
    elseif Config.DefaultNotify then
        ESX.ShowNotification('Morate oznaciti lokaciju na mapi!')
    end
end
end)
end)

RegisterNetEvent('popravi:vozilo')
AddEventHandler('popravi:vozilo', function()
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      SetVehicleEngineHealth(vehicle, 1000)
      SetVehicleEngineOn( vehicle, true, true )
      SetVehicleFixed(vehicle)
      if Config.MythicNotify then
        exports['mythic_notify']:DoHudText('inform', 'Vozilo je popraveno.')
    elseif Config.okokNotify then
        exports['okokNotify']:Alert("ADMIN", "Vozilo je popraveno.", 5000, 'info')
    elseif Config.DefaultNotify then
        ESX.ShowNotification('Vozilo je popraveno!')
    end
    local igrac = PlayerId()
    local ime = GetPlayerName(igrac)
    local msg = ''..ime..  ' je popravio vozilo. \nGrupa: ' ..playerRank.. '' 
    local bot = "Admin"
    TriggerServerEvent('logovi', bot, msg) 
    else
        if Config.MythicNotify then
            exports['mythic_notify']:DoHudText('error', 'Niste u vozilu!')
        elseif Config.okokNotify then
            exports['okokNotify']:Alert("ADMIN", "Niste u vozilu!", 5000, 'error')
        elseif Config.DefaultNotify then
            ESX.ShowNotification('Niste u vozilu!')
        end
    end
end)
end)


RegisterNetEvent('ocisti:vozilo')
AddEventHandler('ocisti:vozilo', function()
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      SetVehicleDirtLevel(vehicle, 0)
      local igrac = PlayerId()
      local ime = GetPlayerName(igrac)
      local msg = ''..ime..  ' je ocistio vozilo. \nGrupa: ' ..playerRank.. '' 
      local bot = "Admin"
      TriggerServerEvent('logovi', bot, msg) 
      if Config.MythicNotify then
        exports['mythic_notify']:DoHudText('inform', 'Vozilo je ocisteno.')
    elseif Config.okokNotify then
        exports['okokNotify']:Alert("ADMIN", "Vozilo je ocisteno.", 5000, 'info')
    elseif Config.DefaultNotify then
        ESX.ShowNotification('Vozilo je ocisteno!')
    end
    else
        if Config.MythicNotify then
            exports['mythic_notify']:DoHudText('error', 'Niste u vozilu!')
        elseif Config.okokNotify then
            exports['okokNotify']:Alert("ADMIN", "Niste u vozilu!", 5000, 'error')
        elseif Config.DefaultNotify then
            ESX.ShowNotification('Niste u vozilu!')
        end
    end
end)
end)


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end


local open = false
local PlayerData = {}
local disPlayerNames = 20
local idovi = false
RegisterNetEvent('ideve')
AddEventHandler('ideve', function()
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
    if not idovi then
            local igrac = PlayerId()
            local ime = GetPlayerName(igrac)
            local msg = ''..ime..  ' je ukljucio id-eve. \nGrupa: ' ..playerRank.. '' 
            local bot = "Admin"
            TriggerServerEvent('logovi', bot, msg) 
    if Config.okokNotify then
        exports['okokNotify']:Alert("ADMIN", "Ukljucili ste ID-ove.", 5000, 'info')
    elseif Config.MythicNotify then
        exports['mythic_notify']:DoHudText('inform', 'Ukljucili ste ID-ove.')
    elseif Config.DefaultNotify then
        ESX.ShowNotification('Ukljucili ste ID-ove.') 
    end
    idovi = true
    else
    idovi = false
    local igrac = PlayerId()
    local ime = GetPlayerName(igrac)
    local msg = ''..ime..  ' je iskljucio id-eve. \nGrupa: ' ..playerRank.. '' 
    local bot = "Admin"
    TriggerServerEvent('logovi', bot, msg)
    if Config.okokNotify then
        exports['okokNotify']:Alert("ADMIN", "Iskljucili ste ID-ove.", 5000, 'info')
       elseif Config.MythicNotify then
        exports['mythic_notify']:DoHudText('inform', 'Iskljucili ste ID-ove.')
       elseif Config.DefaultNotify then
        ESX.ShowNotification('Iskljucili ste ID-ove.')
       end 
      end
    end)
end)

playerDistances = {}

Citizen.CreateThread(function()
    Wait(1000)
    while true do
    Citizen.Wait(5)
      if not idovi then
        Citizen.Wait(2000)
      else
        for _, player in ipairs(GetActivePlayers()) do
          local ped = GetPlayerPed(player)
          if GetPlayerPed(player) ~= PlayerPedId() then
            if playerDistances[player] ~= nil and playerDistances[player] < disPlayerNames then
              x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
              if not NetworkIsPlayerTalking(player) then
                TINKY3D(vec(x2, y2, z2+0.94), '~b~' .. GetPlayerServerId(player) .. ' ~c~| ~b~[~w~' .. GetPlayerName(player)..'~b~]~w~')
              else
                TINKY3D(vec(x2, y2, z2+0.94), '🎤' .. GetPlayerServerId(player) .. ' ~c~| ~b~[~w~' .. GetPlayerName(player)..'~b~]~w~')
              end
            end
          end
        end
      end
    end
end)


Citizen.CreateThread(function()
    while true do
        for _, player in ipairs(GetActivePlayers()) do
            if GetPlayerPed(player) ~= PlayerPedId() then
                x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                playerDistances[player] = distance
            end
        end
        Citizen.Wait(1500)
    end
end)

function TINKY3D(coords, text, size)
  local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  if onScreen then
      SetTextScale(0.35, 0.38)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextDropshadow(255, 255, 255, 255, 255)
      SetTextEdge(1, 0, 0, 0, 150)
      SetTextDropshadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
  end
end

RegisterNetEvent('vozilo')
AddEventHandler('vozilo', function()
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
    local vozilo = KeyboardInput("Vozilo:", "", 20)
    TriggerEvent('esx:spawnVehicle', vozilo)
    local igrac = PlayerId()
    local ime = GetPlayerName(igrac)
    local msg = ''..ime..  ' je stvorio vozilo ``' .. vozilo ..  '``\nGrupa: ' ..playerRank.. '' 
    local bot = "Admin"
    TriggerServerEvent('logovi', bot, msg)
    end)
end)

RegisterNetEvent('obrisi:vozilo')
AddEventHandler('obrisi:vozilo', function(source)
    ESX.TriggerServerCallback("esx:proveriRank", function(playerRank)
        local igrac = PlayerId()
        local ime = GetPlayerName(igrac)
        local msg = ''..ime..  ' je obriso vozilo.\nGrupa: ' ..playerRank.. '' 
        local bot = "Admin"
        TriggerServerEvent('logovi', bot, msg)
    TriggerEvent('esx:deleteVehicle', source)
    end)
end)