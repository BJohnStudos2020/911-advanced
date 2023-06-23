--------------------------------------
---- B.John Studios Advanced 911 -----
--------------------------------------
--
--
--
--




TriggerEvent("chat:addSuggestion", "/911", "Call 911 for your emergency!", {
    { name = "Report", help = "Enter your report here!"}
})

TriggerEvent("chat:addSuggestion", "/OnDuty", "Go OnDuty", {
    { name = " Dispatch | LEO ", help = "Enter your department here! [ Dispatch | LEO ]"}
})

local activeLEOs = 0
local nearestPostalText = ""
local format = string.format


local configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

    local data = {
        leo = {
            names = {},
            ids = {}
        },
        dispatchers = {
            names = {},
            ids = {}
        },
        active = 0
    }

-- Event handler for updating the active LEO count on the screen
RegisterNetEvent('updateActiveLEOs')
AddEventHandler('updateActiveLEOs', function(count)
    activeLEOs = count
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
    if activeLEOs > 0 then
        if args[1] == nil then
            -- No message provided
            TriggerEvent("chatMessage", "^1ERROR: Please provide a message for the 911 call.")
        else
            -- Send the 911 call to dispatchers

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
        TriggerEvent("chat:addMessage", Config.prefix911 .. "^2Sorry there is no [LEO/Fire/Medics] online at the momemt")
    end
end, false)


RegisterNetEvent('duty')
AddEventHandler('duty', function(args)
    if args == 'Dispatch' then
        local targetPlayer = GetPlayerFromServerId(PlayerId())
        local playerID = GetPlayerServerId(PlayerId())
        local playerName = GetPlayerName(PlayerId())
        TriggerServerEvent('dispatcher',  playerName, targetPlayer, playerID)
    elseif args == 'LEO' then
        local targetPlayer = GetPlayerFromServerId(PlayerId())
        local playerID = GetPlayerServerId(PlayerId())
        local playerName = GetPlayerName(PlayerId())
        TriggerServerEvent('leo',  playerName, targetPlayer, playerID)
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
        dispatchers = {
            names = {},
            ids = {},
            target = {}
        },
        active = 0
    }

    while true do
        local x = 0.16 -- horizontal position of the text
        local y = 0.87 -- vertical position of the text
        local z = 1.0 -- depth of the text
        SetTextFont(4)
        SetTextScale(0.5, 0.5)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextEntry('STRING')
        SetTextOutline()
        AddTextComponentString('~y~ Active LEOs: ~w~' .. activeLEOs)
        DrawText(x, y)
        Citizen.Wait(0)
    end
end)

local postals = nil
Citizen.CreateThread(function()
    postals = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file', 23))
    postals = json.decode(postals)
    for i, postal in ipairs(postals) do postals[i] = { vec(postal.x, postal.y), code = postal.code } end
end)
