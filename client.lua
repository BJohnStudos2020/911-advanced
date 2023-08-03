--------------------------------------
---- B.John Studios Advanced 911 -----
--------------------------------------
--
--
--
--

local activeLEOs = 0
local activeEMS = 0
local nearestPostalText = ""
local format = string.format
local postals = nil
local perms = false


local configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

    local data = {
        leo = {
            names = {},
            ids = {},
            target = {}
        },
        ems = {
            names = {},
            ids = {},
            target = {}
        },
        fire = {
            names = {},
            ids = {},
            target = {}
        },
        dispatchers = {
            names = {},
            ids = {},
            target = {}
        },
        active = 0,
        activeems = 0
    }

-- Event handler for updating the active LEO count on the screen
RegisterNetEvent('updateActiveLEOs')
AddEventHandler('updateActiveLEOs', function(count)
    activeLEOs = count
end)

RegisterNetEvent('updateActiveEMS')
AddEventHandler('updateActiveEMS', function(count)
    activeEMS = count
end)

local extract = json.decode(configfile)

RegisterNetEvent('911blip')
AddEventHandler('911blip', function(coords, playerCoords, ids)
    for i, id in ipairs(ids) do
        if GetPlayerServerId(PlayerId()) == id then

            local blip911 = AddBlipForRadius(playerCoords.x + math.random(75), playerCoords.y + math.random(75), playerCoords.z + math.random(75), 110.0)
            
            SetBlipAlpha(blip911, 128)
            SetBlipColour(blip911, 0xF4433680)

            Citizen.Wait(Config.blip_remove_time)
            RemoveBlip(blip911)
        end 
    end
end)


-- Commands
RegisterCommand("911", function(source, args)
    if activeLEOs > 0 or activeEMS > 0 then
        if args[1] == nil then
            TriggerEvent("chatMessage", "^1ERROR: Please provide a message for the 911 call.")
        else

            local coords = GetEntityCoords(PlayerPedId())
            coords = vec(coords[1], coords[2])
            local _total = #postals
            local _nearestIndex, _nearestD
            for i = 1, _total do
                local D = #(coords - postals[i][1])
                if not _nearestD or D < _nearestD then
                    _nearestIndex = i
                    _nearestD = D
                end
            end
            local _code = postals[_nearestIndex].code


            local message = table.concat(args, " ")
            local playerName = GetPlayerName(PlayerId())
            local playerCoords = GetEntityCoords(GetPlayerPed(PlayerId()))
            local playerZone = GetLabelText(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))
            local playerLocation = _code
            TriggerEvent("chat:addMessage", Config.prefix911 .. "911 | Whats your Emergancy?")
            TriggerEvent("chat:addMessage", Config.prefix911 .. "Caller Info | ^0" .. playerName .. ": ^1" .. message )
            TriggerEvent("chat:addMessage", Config.prefix911 .. "Caller location | ^1" .. playerZone)
            TriggerEvent("chat:addMessage", Config.prefix911 .. "Nearest Postal | ^1" .. playerLocation)
            TriggerEvent("chat:addMessage", Config.prefix911 .. "^2Dont Worry, Help is on its way!")


            TriggerServerEvent('911', playerName, message, playerZone, playerLocation, _code, playerCoords, args)
        end
    else
        TriggerEvent("chat:addMessage", Config.prefix911 .. "^2Sorry there is no [ LEO / FIRE / EMS ] online at the momemt")
    end
end, false)


RegisterNetEvent('duty')
AddEventHandler('duty', function(content)
    local args = content.lower(content)
    if args == 'dispatch' then
        local targetPlayer = GetPlayerFromServerId(PlayerId())
        local playerID = GetPlayerServerId(PlayerId())
        local playerName = GetPlayerName(PlayerId())
        TriggerServerEvent('dispatcher',  playerName, targetPlayer, playerID)
    elseif args == 'leo' then
        local targetPlayer = GetPlayerFromServerId(PlayerId())
        local playerID = GetPlayerServerId(PlayerId())
        local playerName = GetPlayerName(PlayerId())
        TriggerServerEvent('leo',  playerName, targetPlayer, playerID)
    elseif args == 'ems' then
        local targetPlayer = GetPlayerFromServerId(PlayerId())
        local playerID = GetPlayerServerId(PlayerId())
        local playerName = GetPlayerName(PlayerId())
        TriggerServerEvent('ems',  playerName, targetPlayer, playerID)
    elseif args == 'fire' then
        local targetPlayer = GetPlayerFromServerId(PlayerId())
        local playerID = GetPlayerServerId(PlayerId())
        local playerName = GetPlayerName(PlayerId())
        TriggerServerEvent('fire',  playerName, targetPlayer, playerID)
    end
end)




RegisterCommand('OffDuty', function(source, args)
    local targetPlayer = GetPlayerFromServerId(PlayerId())
    local playerID = GetPlayerServerId(PlayerId())
    local playerName = GetPlayerName(PlayerId())
    TriggerServerEvent('offduty',  playerName, targetPlayer, playerID)
end, false)

-- Draw the active LEO count on the screen
Citizen.CreateThread(function()
    data = {
        leo = {
            names = {},
            ids = {},
            target = {}
        },
        ems = {
            names = {},
            ids = {},
            target = {}
        },
        fire = {
            names = {},
            ids = {},
            target = {}
        },
        dispatchers = {
            names = {},
            ids = {},
            target = {}
        },
        active = 0,
        activeems = 0
    }

    while true do

        function ActiveLEO()
            local color = '~w~'
            local x = 0.158 -- horizontal position of the text
            local y = 0.85 -- vertical position of the text
            local z = 1.0 -- depth of the text
            SetTextFont(4)
            SetTextScale(0.45, 0.45)
            SetTextColour(255, 255, 255, 255)
            SetTextEdge(4, 0, 0, 0, 255)
            SetTextEntry('STRING')
            SetTextOutline()
            if activeLEOs > 0 then color = '~g~' end
            AddTextComponentString('~y~ Active LEOs: ' .. color .. activeLEOs)
            DrawText(x, y) 
        end

        function ActiveEMS()
            local color = '~w~'
            local x = 0.158 -- horizontal position of the text
            local y = 0.8715 -- vertical position of the text
            local z = 1.0 -- depth of the text
            SetTextFont(4)
            SetTextScale(0.45, 0.45)
            SetTextColour(255, 255, 255, 255)
            SetTextEdge(4, 0, 0, 0, 255)
            SetTextEntry('STRING')
            SetTextOutline()
            if activeEMS > 0 then color = '~g~' end
            AddTextComponentString('~y~ Active EMS / FIRE: ' .. color .. activeEMS)
            DrawText(x, y)
        end

        ActiveLEO()
        ActiveEMS()

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    postals = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
    postals = json.decode(postals)
    for i, postal in ipairs(postals) do postals[i] = { vec(postal.x, postal.y), code = postal.code } end
end)





function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(135, 206, 250, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNetEvent('BJS-911-updatePerms')
AddEventHandler('BJS-911-updatePerms', function(value)
    PD_OnDuty()
    EMS_OnDuty()
    Blips()
end)

function Blips()

    for _, coords in pairs(Config.PD_Locations) do
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 606    )
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 24)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('BJS: Duty Toggle') -- set blip's "name"
        EndTextCommandSetBlipName(blip)

    end

    for _, coords in pairs(Config.EMS_Locations) do
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 606    )
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 24)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('BJS: Duty Toggle') -- set blip's "name"
        EndTextCommandSetBlipName(blip)

    end
end


function PD_OnDuty()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed, false)

            for _, coords in pairs(Config.PD_Locations) do
                local distance = GetDistanceBetweenCoords(playerCoords, coords.x, coords.y, coords.z, true)

                if distance <= 25 then
                    DrawMarker(27, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 173, 216, 230, 150, false, true, 2, nil, nil, false)
                end

                if distance <= 3 then
                    Draw3DText(coords.x, coords.y, coords.z, 0.5, 'Press E To Go ON/OFF Duty')
                end
                if distance <= 1.0 and IsControlJustPressed(0, 38) then
                    local playerID = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('toggleduty', playerID, 'leo')
                end
            end
        end
    end)
end

function EMS_OnDuty()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed, false)

            for _, coords in pairs(Config.EMS_Locations) do
                local distance = GetDistanceBetweenCoords(playerCoords, coords.x, coords.y, coords.z, true)

                if distance <= 25 then
                    DrawMarker(27, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 173, 216, 230, 150, false, true, 2, nil, nil, false)
                end

                if distance <= 3 then
                    Draw3DText(coords.x, coords.y, coords.z, 0.5, 'Press E To Go ON/OFF Duty')
                end
                if distance <= 1.0 and IsControlJustPressed(0, 38) then
                    local playerID = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('toggleduty', playerID, 'EMS')
                end
            end
        end
    end)
end

function Alert(title, message, time, types)
	SendNUIMessage({
		action = 'notify',
        type = types,
        title = title,
        message = message,
        time = time
	})
end

RegisterNetEvent('Notification')
AddEventHandler('Notification', function(title, message, time, types)
	Alert(title, message, time, types)
end)

Citizen.CreateThread(function()
	Wait(5000);
	TriggerServerEvent('BJS-Duty-Perms')
    TriggerServerEvent('BJS:Connected')
end)