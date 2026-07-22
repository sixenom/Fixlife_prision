------------------------------------------------------
--Put Discord WebHook Here!
webhookid = 'Insert_Discord_Webhook'

--Discord Log Configs
Log = {
    ReJail = true, --If it logs when someone gets jailed upon script restart or player load in
    Jail = true, --If it logs when someone gets jailed 
    UnJail = true, --If it logs when someone gets unjailed
    AddTime = true, --If it logs when someone gets time added
    RemoveTime = true, --If it logs when someone gets time removed
    LeaveInJail = true, --If it logs when someone logs out while in jail
    SendingSol = true, --IF it logs when someone is sent/taken to solitary
    Breaking = true, --If it logs when someone successfully breaks a part of the wall
    Escape = true, --If it logs when someone escapes
    Craft = true, --If it logs when someone crafts an item
    Bed = true, --If it logs when someone adds/removes something from bed
    Job = true --If it logs everything with the jobs
}

--Admin User Ranks That Can Use Menu
adminRoles = { 
    'admin',
    'superadmin',
    'owner'
}

--All configs for admin controls with menu
adminAbilities = {
    Jailing = {'admin', 'superadmin', 'owner'},
    UnJail = {'superadmin', 'owner'},
    AddTime = {'admin', 'superadmin', 'owner'},
    RemoveTime = {'superadmin', 'owner'},
    Send2Solitary = {'admin', 'superadmin', 'owner'},
    RemoveFromSolitary = {'superadmin', 'owner'},
    Lockdown = {'admin', 'superadmin', 'owner'},
    Message = {'admin', 'superadmin', 'owner'}
}

------------------------------------------------------

inJail = {}
solJail = {}
Items = {}
local good = false

local infoPedLocie = 1

lockCount = 0
lockDown = false
local DEFAULT_JAIL_DATA = json.encode(JailStorage.Default)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then

        local this = {
            {
                ["name"] = "**Script:**",
                ["value"] = "HD Advanced Jail",
                ["inline"] = true
            },
            {
                ["name"] = "**Script Maker:**",
                ["value"] = "Hobo's Development",
                ["inline"] = true
            },
            {
                ["name"] = "**Current Version:**",
                ["value"] = Config.CurrentV,
                ["inline"] = true
            }
        }
        sendToDiscord(this, 16777215, "Discord Webhook Online", "https://imgur.com/Iric4Kr.gif")

        Citizen.CreateThread(function()
            Citizen.Wait(3000)
            local xPlayers = Qbox.GetPlayers()
            if xPlayers[1] ~= nil then
                good = true
                for name, item in pairs(exports.ox_inventory:Items()) do
                    table.insert(Items, {name = name, label = item.label or name})
                end
                for i=1, #xPlayers, 1 do
                    local xPlayer = Qbox.GetPlayer(xPlayers[i])
                    JailStorage.Get(xPlayer.identifier, function(newData)
                        if newData.jailtime > 0 then
                            TriggerEvent('HD_Jail:ReJail', xPlayer.source, newData)
                        elseif xPlayer.job.name == 'prisoner' then
                            xPlayer.setJob(Config.DefaultSetJob.Name, Config.DefaultSetJob.Grade)
                        end
                    end)
                end
            end
        end)
    end
end)

Citizen.CreateThread(function()
    if Config.RanMessage then
        while true do
            Citizen.Wait(Config.RanMessageTime* 60000)
    
            local xPlayers = Qbox.GetPlayers()
            if xPlayers[1] ~= nil then
                for i=1, #xPlayers, 1 do
                    local xPlayer = Qbox.GetPlayer(xPlayers[i])
                    local total = 0
                    local ranMessage = nil
            
                    for j=1, #Config.RanMessages, 1 do
                        total = total + 1
                    end
                    ranMessage = math.random(1, total)
                    TriggerClientEvent('HD_Jail:SendNotif2', xPlayer.source, Config.RanMessages[ranMessage])
                end
            end
        end
    end
end)

RegisterServerEvent('HD_Jail:Send2Prisoners')
AddEventHandler('HD_Jail:Send2Prisoners', function(messago)
    local xTarget = Qbox.GetPlayer(source)

    if CheckUser(source, 'message') then
        TriggerClientEvent('HD_Jail:SendNotif', -1, Config.Sayings[168]..messago, true)
    end
end)

RegisterServerEvent('HD_Jail:PoliceNotify')
AddEventHandler('HD_Jail:PoliceNotify', function()
    local xPlayer = Qbox.GetPlayer(source)

    local fullname = nil
    if Config.ESXVersion ~= '1.1' then
        fullname = xPlayer.get("firstName") .. " " .. xPlayer.get("lastName")
    else
        fullname = GetPlayerName(xPlayer.source)
    end
    TriggerClientEvent('HD_Jail:PoliceWarning', -1, fullname)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.InfoPedChangeTime* 60000)
        local total = 0

        for j=1, #Config.InfoPedLoc, 1 do
            total = total + 1
        end
        infoPedLocie = math.random(1, total)
        TriggerClientEvent('HD_Jail:ChangeLoc', -1, infoPedLocie)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        local this = {
            {
                ["name"] = "**Script:**",
                ["value"] = "HD Advanced Jail",
                ["inline"] = true
            },
            {
                ["name"] = "**Script Maker:**",
                ["value"] = "Hobo's Development",
                ["inline"] = true
            },
            {
                ["name"] = "**Current Version:**",
                ["value"] = Config.CurrentV,
                ["inline"] = true
            }
        }
        sendToDiscord(this, 0, "Discord Webhook Offline", "https://imgur.com/Iric4Kr.gif")


        for i = 1, #inJail, 1 do
            for k = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[k].Player ~= nil then
                    local player = inJail[i].Players[k]
                    JailStorage.Get(player.Player, function(newData)
                        newData.jailtime = player.Timie
                        JailStorage.Save(player.Player, newData)
                    end)
                end
            end
        end
    end
end)

