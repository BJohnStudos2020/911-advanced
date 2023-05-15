local configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")
local data = {
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

local extract = json.decode(configfile)
data.dispatchers = extract.dispatchers
data.leo = extract.leo
Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen

local consolemessage =
    [[

        ⚠️🚨 | B.John Studios Advanced 911 Script | 🚨⚠️
                  Created by Timmmy#9240
    ]]


--      {"dispatchers":{"target":[],"names":[],"ids":[]},"leo":{"target":[],"names":[],"ids":[]}, "active": 0}



RegisterServerEvent('dispatcher')
AddEventHandler('dispatcher', function(playerName , targetPlayer, playerID)
        configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

        local extract = json.decode(configfile)
        data.dispatchers = extract.dispatchers
        data.leo = extract.leo
        Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
        
        for i, dispatcher in ipairs(data.dispatchers.ids) do
            if targetPlayer == dispatcher then
                TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. playerID, 'You are already OnDuty!')
                return
            end
        end


        table.insert(data.dispatchers.names, playerName)
        table.insert(data.dispatchers.ids, playerID)
        table.insert(data.dispatchers.target, targetPlayer)

        Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen

        TriggerClientEvent('updateActiveLEOs', -1, data.active)

        print(json.encode(data))

        SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)
        
        TriggerClientEvent('chatMessage', playerID, Config.prefixduty .. 'You are now on duty as a Dispatcher')
        print('^4', playerName, '^0Is On Duty')
end)

RegisterServerEvent('leo')
AddEventHandler('leo', function(playerName , targetPlayer, playerID)
        configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

        local extract = json.decode(configfile)
        data.dispatchers = extract.dispatchers
        data.leo = extract.leo

        for i, officer in ipairs(data.leo.ids) do
            if targetPlayer == officer then
                TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are already OnDuty!')
                return
            end
        end

        table.insert(data.leo.names, playerName)
        table.insert(data.leo.ids, playerID)
        table.insert(data.leo.target, targetPlayer)
        Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
        TriggerClientEvent('updateActiveLEOs', -1, data.active)

        SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)
        
        TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now on duty as LEO')
        print('^4', playerName, '^0Is On Duty')
end)

RegisterServerEvent('offduty')
AddEventHandler('offduty', function(playerName , targetPlayer, playerID)
    configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")
    
    for i, dispatcher in ipairs(data.dispatchers.ids) do
        if playerID == dispatcher then
            table.remove(data.dispatchers.target, i)
            table.remove(data.dispatchers.names, i)
            table.remove(data.dispatchers.ids, i)
            Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
            TriggerClientEvent('updateActiveLEOs', -1, data.active)

            TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as Dispatch')
            print('^4', playerName, '^0Is Off Duty')
        end
    end

    for i, officer in ipairs(data.leo.ids) do
        if playerID == officer then
            table.remove(data.leo.ids, i)
            table.remove(data.leo.names, i)
            table.remove(data.leo.target, i)
            Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
            TriggerClientEvent('updateActiveLEOs', -1, data.active)

            TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as LEO')
            print('^4', playerName, '^0Is Off Duty')
        end
    end

    SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)

end)

AddEventHandler('playerDropped', function (reason)
    configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

    local playerID = source
    
    for i, dispatcher in ipairs(data.dispatchers.ids) do
        if playerID == dispatcher then
            print('^4', data.dispatchers.names[i], '^0Is Off Duty')
            table.remove(data.dispatchers.ids, i)
            table.remove(data.dispatchers.names, i)
            table.remove(data.dispatchers.target, i)
            Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
            TriggerClientEvent('updateActiveLEOs', -1, data.active)
        end
    end

    for i, officer in ipairs(data.leo.ids) do
        if playerID == officer then
            print('^4', data.leo.names[i], '^0Is Off Duty')
            table.remove(data.leo.ids, i)
            table.remove(data.leo.names, i)
            table.remove(data.leo.target, i)
            Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
            TriggerClientEvent('updateActiveLEOs', -1, data.active)
        end
    end

    SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)

end)







------ EVENTS -------

function log()
    
    if Config.server_name ~= 'Enter Server Name' then
        
        PerformHttpRequest('http://api.ipify.org/', function(err, text, headers)
          local serverip =  tostring(text)

            local embed = {}
            embed = {
                {
                    ["color"] = 16711680,
                    ["title"] = "**" .. Config.server_name .. "**",
                    ["description"] = " Is Running BJS-911-Advanced",
                    ["footer"] = {
                        ["text"] = serverip,
                    }
                }
            }

            PerformHttpRequest("https://discord.com/api/webhooks/912979277975285780/Z4hJpQbCffR5eMbqRrflHVK89VSU1hp8lezN-rvSTqeUFWokvcRpihHUJzaheloKMBQs",
                function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), {['Content-Type'] = 'application/json'})
         end)
    else 
        print('^1Error: ^5Please Enter your Server Name! - @BJS-911-Advanced/config.lua ^4')
    end
end


RegisterServerEvent('911', function (playerName, message, playerZone, playerLocation, coords, playerCoords, args)
AddEventHandler('911')
    configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")
    local extract = json.decode(configfile)
    data.dispatchers = extract.dispatchers
    data.leo = extract.leo

    TriggerClientEvent('911blip', -1, coords, playerCoords, data.leo.ids)
    
            -- Notify dispatchers and leo if no dispatchers
    
            if #data.dispatchers.names > 0 then
                for i, dispatcher in ipairs(data.dispatchers.names) do
                    TriggerClientEvent("chat:addMessage", data.dispatchers.ids[i], Config.prefix911 .. "Dispatcher " .. data.dispatchers.names[i] .. ": ^0" .. playerName .. "^1 is calling 911.")
                    TriggerClientEvent("chat:addMessage", data.dispatchers.ids[i], Config.prefix911 .. "Nearest Postal: ^0" .. playerLocation)
                    TriggerClientEvent("chat:addMessage", data.dispatchers.ids[i], Config.prefix911 .. "Call Info: " .. message)
                end
            else
                for i, leos in ipairs(data.leo.names) do
                    TriggerClientEvent("chat:addMessage", data.leo.ids[i], Config.prefix911 .. "Officer " .. data.leo.names[i] .. ": ^0" .. playerName .. "^1 is calling 911.")
                    TriggerClientEvent("chat:addMessage", data.leo.ids[i], Config.prefix911 .. "Nearest Postal: ^0" .. playerLocation)
                    TriggerClientEvent("chat:addMessage", data.leo.ids[i], Config.prefix911 .. "Call Info: ^5" .. message)
                end
            end

end)



AddEventHandler('playerConnecting', function()
    configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

    Citizen.Wait(5000)
    local extract = json.decode(configfile)
    data.dispatchers = extract.dispatchers
    data.leo = extract.leo
    Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
    TriggerClientEvent('updateActiveLEOs', -1, data.active)
end)

Citizen.CreateThread(function()
    log()

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

    print(consolemessage)
    SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)
    TriggerClientEvent('updateActiveLEOs', -1, data.active)

    while true do
        local extract = json.decode(configfile)
        Totallen = 0
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
        Citizen.Wait(0)
    end
end)


RegisterCommand('OnDuty', function(source, args)
    if (IsPlayerAceAllowed(source, "group.bjsleo") .. Config.perms == true) then
        if args[1] == nil then
            -- No message provided
            TriggerClientEvent("chatMessage",source, Config.prefixduty .. "^1ERROR: Please Provide a Department")
        else
            TriggerClientEvent('duty', -1, args[1])
        end
    else
        TriggerClientEvent('chatMessage',source, Config.prefixduty .. 'You are not allowed to go on duty')
    end
end)
