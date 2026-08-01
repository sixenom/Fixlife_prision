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
            good = true
            for name, item in pairs(exports.ox_inventory:Items()) do
                table.insert(Items, {name = name, label = item.label or name})
            end
            for playerId in pairs(exports.qbx_core:GetQBPlayers()) do
                local xPlayer = exports.qbx_core:GetPlayer(playerId)
                if xPlayer then
                    local data = xPlayer.PlayerData
                    JailStorage.Get(data.citizenid, function(newData)
                        if (tonumber(newData.jailtime) or 0) <= 0 and data.job.name == 'prisoner' then
                            exports.qbx_core:SetJob(data.citizenid, Config.DefaultSetJob.Name, Config.DefaultSetJob.Grade)
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
    
            local xPlayers = exports.qbx_core:GetQBPlayers()
            if next(xPlayers) then
                for playerId in pairs(xPlayers) do
                    local xPlayer = exports.qbx_core:GetPlayer(playerId)
                    local total = 0
                    local ranMessage = nil
            
                    for j=1, #Config.RanMessages, 1 do
                        total = total + 1
                    end
                    ranMessage = math.random(1, total)
                    TriggerClientEvent('HD_Jail:SendNotif2', xPlayer.PlayerData.source, Config.RanMessages[ranMessage])
                end
            end
        end
    end
end)

RegisterServerEvent('HD_Jail:Send2Prisoners')
AddEventHandler('HD_Jail:Send2Prisoners', function(messago)
    if CheckUser(source, 'message') then
        TriggerClientEvent('HD_Jail:SendNotif', -1, Config.Sayings[168]..messago, true)
    end
end)

RegisterServerEvent('HD_Jail:PoliceNotify')
AddEventHandler('HD_Jail:PoliceNotify', function()
    local xPlayer = exports.qbx_core:GetPlayer(source)

    if not xPlayer or not IsPrisoner(source, xPlayer) or not CheckCooldown(source, 'police_notify', 5000) then return end
    local fullname = nil
    fullname = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
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
                    local solcell = 0
                    for cell = 1, #solJail do
                        for index = 1, #solJail[cell].Players do
                            if solJail[cell].Players[index].Player == player.Player then solcell = cell break end
                        end
                        if solcell ~= 0 then break end
                    end
                    JailStorage.Get(player.Player, function(newData)
                        newData.cell = i
                        newData.jailtime = player.Timie
                        newData.soli = player.Sol
                        newData.solcell = solcell ~= 0 and solcell or newData.solcell or 0
                        JailStorage.Save(player.Player, newData)
                    end)
                end
            end
        end
    end
end)

