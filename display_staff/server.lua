ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("checkperms:fordisplay", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerPems = player.getGroup()

        if playerPems ~= nil then 
            cb(playerPems)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

RegisterServerEvent('on:logs')
AddEventHandler('on:logs', function()
	local playerName = GetPlayerName(source)
	PerformHttpRequest("YourWebhook", function(err, text, headers) end, 'POST', json.encode({embeds={{title="Staff Logs",description=" \n**Oνομα STAFF**: "..playerName.."\n**WENT ON**\n**TIME: **"..os.date("!%H:%M",  os.time() + 3 * 60 * 60).."",color=0000}}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('off:logs')
AddEventHandler('off:logs', function()
	local playerName = GetPlayerName(source)
	PerformHttpRequest("YourWebhook", function(err, text, headers) end, 'POST', json.encode({embeds={{title="Staff Logs",description=" \n**Oνομα STAFF**: "..playerName.."\n**WENT OFF**\n**TIME: **"..os.date("!%H:%M",  os.time() + 3 * 60 * 60).."",color=0000}}}), { ['Content-Type'] = 'application/json' })
end)