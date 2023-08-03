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

local extract = json.decode(configfile)
data.dispatchers = extract.dispatchers
data.leo = extract.leo
data.ems = extract.ems
data.fire = extract.fire
Totallen = 0
Totalems = 0 
for len in ipairs(data.leo.ids) do
    Totallen = Totallen + 1
end
for len in ipairs(data.dispatchers.ids) do
    Totallen = Totallen + 1
end
data.active = Totallen

for len in ipairs(data.ems.ids) do
    Totalems = Totalems + 1
end
for len in ipairs(data.fire.ids) do
    Totalems = Totalems + 1
end
data.activeems = Totalems

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
        data.ems = extract.ems
        data.fire = extract.fire

        if OnDuty_Check(playerID) == false then

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

            SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now on duty as Dispatch", 10000, 'Green')
            
            --TriggerClientEvent('chatMessage', playerID, Config.prefixduty .. 'You are now on duty as a Dispatcher')
            print('^4', playerName, '^0Is On Duty, as Dispatch')
        else 
            TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are already OnDuty!')
        end
end)

RegisterServerEvent('leo')
AddEventHandler('leo', function(playerName , targetPlayer, playerID)
        configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

        local extract = json.decode(configfile)
        data.dispatchers = extract.dispatchers
        data.leo = extract.leo
        data.ems = extract.ems
        data.fire = extract.fire

        if OnDuty_Check(playerID) == false then

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

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now on duty as LEO", 10000, 'Green')
            
            --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now on duty as LEO')
            print('^4', playerName, '^0Is On Duty, as LEO')
        else 
            TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are already OnDuty!')
        end
end)

RegisterServerEvent('ems')
AddEventHandler('ems', function(playerName , targetPlayer, playerID)
        configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

        local extract = json.decode(configfile)
        data.dispatchers = extract.dispatchers
        data.leo = extract.leo
        data.ems = extract.ems
        data.fire = extract.fire

        if OnDuty_Check(playerID) == false then

            table.insert(data.ems.names, playerName)
            table.insert(data.ems.ids, playerID)
            table.insert(data.ems.target, targetPlayer)
            Totallen = 0
            for len in ipairs(data.ems.ids) do
                Totallen = Totallen + 1
            end
            for len in ipairs(data.fire.ids) do
                Totallen = Totallen + 1
            end
            data.activeems = Totallen
            TriggerClientEvent('updateActiveEMS', -1, data.activeems)

            SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now on duty as EMS", 10000, 'Green')
            
            --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now on duty as EMS')
            print('^4', playerName, '^0Is On Duty, as EMS')
        else 
            TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are already OnDuty!')
        end
end)

RegisterServerEvent('fire')
AddEventHandler('fire', function(playerName , targetPlayer, playerID)
        configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

        local extract = json.decode(configfile)
        data.dispatchers = extract.dispatchers
        data.leo = extract.leo
        data.ems = extract.ems
        data.fire = extract.fire

        if OnDuty_Check(playerID) == false then

            table.insert(data.fire.names, playerName)
            table.insert(data.fire.ids, playerID)
            table.insert(data.fire.target, targetPlayer)
            Totallen = 0
            for len in ipairs(data.ems.ids) do
                Totallen = Totallen + 1
            end
            for len in ipairs(data.fire.ids) do
                Totallen = Totallen + 1
            end
            data.activeems = Totallen
            TriggerClientEvent('updateActiveEMS', -1, data.activeems)

            SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now on duty as FIRE", 10000, 'Green')
            
            --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now on duty as FIRE')
            print('^4', playerName, '^0Is On Duty, as FIRE')
        else 
            TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are already OnDuty!')
        end
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

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as Dispatch", 10000, 'Red')

            --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as Dispatch')
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

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as LEO", 10000, 'Red')

            --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as LEO')
            print('^4', playerName, '^0Is Off Duty')
        end
    end

    for i, officer in ipairs(data.ems.ids) do
        if playerID == officer then
            table.remove(data.ems.ids, i)
            table.remove(data.ems.names, i)
            table.remove(data.ems.target, i)
            Totallen = 0
        for len in ipairs(data.ems.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.fire.ids) do
            Totallen = Totallen + 1
        end
        data.activeems = Totallen
            TriggerClientEvent('updateActiveEMS', -1, data.activeems)

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as EMS", 10000, 'Red')

            --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as EMS')
            print('^4', playerName, '^0Is Off Duty, as EMS')
        end
    end


    for i, officer in ipairs(data.fire.ids) do
        if playerID == officer then
            table.remove(data.fire.ids, i)
            table.remove(data.fire.names, i)
            table.remove(data.fire.target, i)
            Totallen = 0
        for len in ipairs(data.ems.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.fire.ids) do
            Totallen = Totallen + 1
        end
        data.activeems = Totallen
            TriggerClientEvent('updateActiveEMS', -1, data.activeems)

            TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as FIRE", 10000, 'Red')

            --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as FIRE')
            print('^4', playerName, '^0Is Off Duty, as FIRE')
        end
    end

    SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)

end)

AddEventHandler('playerDropped', function (reason)
    configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")

    local playerID = source

    local name = ''

    for i, dispatcher in ipairs(data.dispatchers.ids) do
        if playerID == dispatcher then
            name = data.dispatchers.names[i]
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
        end
    end

    for i, officer in ipairs(data.leo.ids) do
        if playerID == officer then
            name = data.leo.names[i]
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

    for i, officer in ipairs(data.ems.ids) do
        if playerID == officer then
            name = data.ems.names[i]
            table.remove(data.ems.ids, i)
            table.remove(data.ems.names, i)
            table.remove(data.ems.target, i)
            Totallen = 0
        for len in ipairs(data.ems.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.fire.ids) do
            Totallen = Totallen + 1
        end
        data.activeems = Totallen
            TriggerClientEvent('updateActiveEMS', -1, data.activeems)
        end
    end


    for i, officer in ipairs(data.fire.ids) do
        if playerID == officer then
            name = data.fire.names[i]
            table.remove(data.fire.ids, i)
            table.remove(data.fire.names, i)
            table.remove(data.fire.target, i)
            Totallen = 0
        for len in ipairs(data.ems.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.fire.ids) do
            Totallen = Totallen + 1
        end
        data.activeems = Totallen
            TriggerClientEvent('updateActiveEMS', -1, data.activeems)
        end
    end

    if not name == '' then
        print('^4', name, '^0Is Off Duty, as EMS')
    end

    SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)

    Who_OnDuty()

end)







------ EVENTS -------

function Log()
    
    if Config.server_name ~= 'Enter Server Name' then
        local embed = {}
        embed = {
            {
                ["color"] = 16711680,
                ["title"] = "**" .. Config.server_name .. "**",
                ["description"] = " Is Running " .. Config.script_name,
            }
        }

        PerformHttpRequest("https://discord.com/api/webhooks/912979277975285780/Z4hJpQbCffR5eMbqRrflHVK89VSU1hp8lezN-rvSTqeUFWokvcRpihHUJzaheloKMBQs",
            function(err, text, headers) end, 'POST', json.encode({username = 'BJS - Server Logger', embeds = embed}), {['Content-Type'] = 'application/json'})
    else 
        print('^1Error: ^5Please Enter your Server Name! - @BJS-911-Advanced/config.lua ^4')
    end
end


RegisterServerEvent('911')
AddEventHandler('911' , function (playerName, message, playerZone, playerLocation, coords, playerCoords, args)
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
                for i, EMS in ipairs(data.ems.names) do
                    TriggerClientEvent("chat:addMessage", data.ems.ids[i], Config.prefix911 .. "Officer " .. data.ems.names[i] .. ": ^0" .. playerName .. "^1 is calling 911.")
                    TriggerClientEvent("chat:addMessage", data.ems.ids[i], Config.prefix911 .. "Nearest Postal: ^0" .. playerLocation)
                    TriggerClientEvent("chat:addMessage", data.ems.ids[i], Config.prefix911 .. "Call Info: ^5" .. message)
                end
                for i, FIRE in ipairs(data.fire.names) do
                    TriggerClientEvent("chat:addMessage", data.fire.ids[i], Config.prefix911 .. "Officer " .. data.fire.names[i] .. ": ^0" .. playerName .. "^1 is calling 911.")
                    TriggerClientEvent("chat:addMessage", data.fire.ids[i], Config.prefix911 .. "Nearest Postal: ^0" .. playerLocation)
                    TriggerClientEvent("chat:addMessage", data.fire.ids[i], Config.prefix911 .. "Call Info: ^5" .. message)
                end
            end

    end)
    



    RegisterServerEvent('BJS:Connected')
    AddEventHandler('BJS:Connected', function()
        configfile = LoadResourceFile(GetCurrentResourceName(), "./config.json")
        local playerSource = source
    
        Citizen.Wait(5000)
        local extract = json.decode(configfile)
        data.dispatchers = extract.dispatchers
        data.leo = extract.leo
        data.ems = extract.ems
        data.fire = extract.fire
        Totallen = 0
        Totalems = 0 
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen
        
        for len in ipairs(data.ems.ids) do
            Totalems = Totalems + 1
        end
        for len in ipairs(data.fire.ids) do
            Totalems = Totalems + 1
        end
        data.activeems = Totalems
    
        TriggerClientEvent('updateActiveLEOs', -1, data.active)
        TriggerClientEvent('updateActiveEMS', -1, Totalems)

        Who_OnDuty()
    end)


RegisterNetEvent('BJS-Duty-Perms')
AddEventHandler('BJS-Duty-Perms', function ()
    if (IsPlayerAceAllowed(source, "group.bjsleo") or Config.perms == false) then
        TriggerClientEvent('BJS-911-updatePerms', source, true)
        TriggerClientEvent('Notification', source, Config.server_name, Config.script_name .. ': Has Granted You Permissions', 10000, 'Green')
        print(Config.prefixduty .. GetPlayerName(source) .. ' Has Been Granted Duty Perms')
    end    
end)





Citizen.CreateThread(function()
    Log()

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

    print(consolemessage)
    SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)
    TriggerClientEvent('updateActiveLEOs', -1, data.active)
    TriggerClientEvent('updateActiveEMS', -1, data.activeems)

    while true do
        local extract = json.decode(configfile)
        Totallen = 0
        Totalems = 0 
        for len in ipairs(data.leo.ids) do
            Totallen = Totallen + 1
        end
        for len in ipairs(data.dispatchers.ids) do
            Totallen = Totallen + 1
        end
        data.active = Totallen

        for len in ipairs(data.ems.ids) do
            Totalems = Totalems + 1
        end
        for len in ipairs(data.fire.ids) do
            Totalems = Totalems + 1
        end
        data.activeems = Totalems
        data.active = Totallen
        Citizen.Wait(0)
    end
end)


function OnDuty_Check(playerID)
    local onduty_value = false

    for i, officer in ipairs(data.ems.ids) do
        if playerID == officer then
            onduty_value = true
        end
    end

    for i, officer in ipairs(data.leo.ids) do
        if playerID == officer then
            onduty_value = true
        end
    end

    for i, officer in ipairs(data.dispatchers.ids) do
        if playerID == officer then
            onduty_value = true
        end
    end

    for i, officer in ipairs(data.fire.ids) do
        if playerID == officer then
            onduty_value = true
        end
    end

    return onduty_value
end

function Who_OnDuty() 
    if data.active + data.activeems > 0 then
        for i, name in ipairs(data.leo.names) do
            print('^0' .. data.leo.names[i] .. ' Is OnDuty As: LEO')
        end
        for i, name in ipairs(data.dispatchers.names) do
            print('^0' .. data.dispatchers.names[i] .. ' Is OnDuty As: Dispatch')
        end
        for i, name in ipairs(data.ems.names) do
            print('^0' .. data.ems.names[i] .. ' Is OnDuty As: EMS')
        end
        for i, name in ipairs(data.fire.names) do
            print('^0' .. data.fire.names[i] .. ' Is OnDuty As: FIRE')
        end
        print( Config.prefixduty .. data.active + data.activeems .. ' - Number of Active LEO / EMS / Fire')
    else
        print(Config.prefixduty .. '^4NO ACTIVE - LEO / FIRE / EMS ')
    end
end


RegisterServerEvent('toggleduty')
AddEventHandler('toggleduty', function(playerID, args)
    if OnDuty_Check(source) == false then
        TriggerClientEvent('duty', source, args)
    else 
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
    
                TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as Dispatch", 10000, 'Red')
    
                --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as Dispatch')
                print('^4', GetPlayerName(source), '^0Is Off Duty')
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
    
                TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as LEO", 10000, 'Red')
    
                --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as LEO')
                print('^4', GetPlayerName(source), '^0Is Off Duty')
            end
        end
    
        for i, officer in ipairs(data.ems.ids) do
            if playerID == officer then
                table.remove(data.ems.ids, i)
                table.remove(data.ems.names, i)
                table.remove(data.ems.target, i)
                Totallen = 0
            for len in ipairs(data.ems.ids) do
                Totallen = Totallen + 1
            end
            for len in ipairs(data.fire.ids) do
                Totallen = Totallen + 1
            end
            data.activeems = Totallen
                TriggerClientEvent('updateActiveEMS', -1, data.activeems)
    
                TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as EMS", 10000, 'Red')
    
                --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as EMS')
                print('^4', GetPlayerName(source), '^0Is Off Duty, as EMS')
            end
        end
    
    
        for i, officer in ipairs(data.fire.ids) do
            if playerID == officer then
                table.remove(data.fire.ids, i)
                table.remove(data.fire.names, i)
                table.remove(data.fire.target, i)
                Totallen = 0
            for len in ipairs(data.ems.ids) do
                Totallen = Totallen + 1
            end
            for len in ipairs(data.fire.ids) do
                Totallen = Totallen + 1
            end
            data.activeems = Totallen
                TriggerClientEvent('updateActiveEMS', -1, data.activeems)
    
                TriggerClientEvent('Notification', source, 'BJS-Duty', "You are now off duty as FIRE", 10000, 'Red')
    
                --TriggerClientEvent("chat:addMessage", playerID, Config.prefixduty .. 'You are now off duty as FIRE')
                print('^4', GetPlayerName(source), '^0Is Off Duty, as FIRE')
            end
        end
    
        SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(data), -1)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(7500)
    local local_v = local_version()
    local git_v = git_version()

    if local_v == git_v then
        print('^0' .. Config.script_name .. ': Is running the latest version!')     
    else
        if git_v ~= false then
            print(Config.script_name .. ': ^1Is not running the latest version! Please Update Code! ^0')
        end 
    end
end)


function git_version()
    local repoOwner = "BJohnStudos2020"
    local repoName = Config.script_name
    local filePath = "fxmanifest.lua"
    local url = string.format("https://raw.githubusercontent.com/%s/%s/master/%s", repoOwner, repoName, filePath)
    local command = string.format("curl -sS \"%s\"", url)
    local file = io.popen(command)
    local fileContent = file:read("*a")
    file:close()

    if fileContent ~= '404: Not Found'then
        return string.match(fileContent, "\nversion%s+'([^']+)'")
    else
        print('^1ERROR: ^3@' .. Config.script_name .. ' Please Fix file name @fxmanifest - this needs to be the same as the githubs fxmanifest^0')
        return false
    end
end 

function local_version()
    local fileContent = LoadResourceFile(GetCurrentResourceName(), "fxmanifest.lua")
    if fileContent then
        local localVersion = string.match(fileContent, "\nversion%s+'([^']+)'")
        return localVersion
    end
end