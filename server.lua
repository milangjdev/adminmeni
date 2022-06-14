local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("esx:proveriRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    if player.proveriDuznost() == true then

        if player ~= nil then
            local playerGroup = player.getGroup()

            if playerGroup ~= nil then 
                cb(playerGroup)
            else
                cb("user")
            end
        else
            cb("user")
        end
    else
        cb("user")
    end
end)


-- DISCORD
RegisterServerEvent('logovi')
AddEventHandler('logovi', function(bot, msg)
    logovi(bot, msg, 0)
end)

function logovi(name, message, color)
	local vreme = os.date('*t')
	local DiscordWebHook = Config.Webhook
	local DISCORD_NAME = Config.Ime
	local DISCORD_IMAGE = Config.Slika
  	local embeds = {
	  	{
		  ["title"] = message,
		  ["type"] = "rich",
		  ["color"] = "8663711",
		  ["footer"] = {
			["text"] = "Vreme: " .. vreme.hour .. ':' .. vreme.min .. ':' .. vreme.sec,
		},
	}
}
  
	if message == nil or message == '' then return FALSE end
		PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = DISCORD_NAME, embeds = embeds, avatar_url = DISCORD_IMAGE }), { ['Content-Type'] = 'application/json' })
	end