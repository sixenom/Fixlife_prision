------------------------------------------------------
--Put Discord WebHook Here!
local webhookid = 'Insert_Discord_Webhook'

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
local adminRoles = { 
    'admin',
    'superadmin',
    'owner'
}

--All configs for admin controls with menu
local adminAbilities = {
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
local solJail = {}
Items = {}
local good = false

local infoPedLocie = 1

local lockCount = 0
local lockDown = false
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

RegisterServerEvent('HD_Jail:ReJail')
AddEventHandler('HD_Jail:ReJail', function(id, values)
    local xPlayer = Qbox.GetPlayer(id)
    local ident = xPlayer.identifier
    local theS = {}
    local cellies = {}
    local lowest = {val = 0, amtie = 30}
    theS = values
    local tots = 0
    if theS.cell == 0 then
        theS.cell = 1
    end
    for i = 1, #inJail[theS.cell], 1 do
        tots = tots + 1
    end

    if tots >= Config.MaxPerCell then
        for i = 1, #inJail, 1 do
            if inJail[i].Players ~= nil then
                local total = 0
                for p = 1, #inJail[i].Players, 1 do
                    total = total + 1
                end
                table.insert(cellies, {value = i, amt = total})
            else
                table.insert(cellies, {value = i, amt = 0})
            end
        end
        for i = 1, #cellies, 1 do
            if cellies[i].amt < lowest.amtie then
                lowest.val = cellies[i].value
                lowest.amtie = cellies[i].amt
            end
        end
        
        table.insert(inJail[lowest.val].Players, {Player = ident, Timie = theS.jailtime, ID = id, Sol = theS.soli, Dead = false, Breako = 0})
        if Log.ReJail then
            if Config.SimpleTime then
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(id),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Remaining:**",
                        ["value"] = theS.jailtime..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Solitary Time:**",
                        ["value"] = theS.soli..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Cell Number:**",
                        ["value"] = lowest.val,
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 16562691, "Re-Jailing Player")
            else
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(id),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Remaining:**",
                        ["value"] = GetGoodTime(theS.jailtime),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Solitary Time:**",
                        ["value"] = GetGoodTime(theS.soli),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Cell Number:**",
                        ["value"] = lowest.val,
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 16562691, "Re-Jailing Player")
            end
        end
        TriggerEvent('HD_Jail:UpdateCell', lowest.val, id)
        if theS.clothes[1] ~= nil then
            TriggerClientEvent('HD_Jail:GoToJail', id, theS.jailtime, theS.job, false)
            Wait(4000)
            TriggerClientEvent('HD_Jail:UpBreaks', id, theS.breaks, false)
        else
            TriggerClientEvent('HD_Jail:GoToJail', id, theS.jailtime, theS.job, true)
            Wait(4000)
            TriggerClientEvent('HD_Jail:UpBreaks', id, theS.breaks, false)
        end
    else
        table.insert(inJail[theS.cell].Players, {Player = ident, Timie = theS.jailtime, ID = id, Sol = theS.soli, Dead = false, Breako = 0})
        if Log.ReJail then
            if not Config.SimpleTime then
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(id),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Remaining:**",
                        ["value"] = GetGoodTime(theS.jailtime),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Solitary Time:**",
                        ["value"] = GetGoodTime(theS.soli),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Cell Number:**",
                        ["value"] = theS.cell,
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 16562691, "Re-Jailing Player")
            else
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(id),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Remaining:**",
                        ["value"] = theS.jailtime..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Solitary Time:**",
                        ["value"] = theS.soli..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Cell Number:**",
                        ["value"] = theS.cell,
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 16562691, "Re-Jailing Player")
            end
        end
        if theS.clothes[1] ~= nil then
            TriggerClientEvent('HD_Jail:GoToJail', id, theS.jailtime, theS.job, false)
            Wait(4000)
            TriggerClientEvent('HD_Jail:UpBreaks', id, theS.breaks, false)
        else
            TriggerClientEvent('HD_Jail:GoToJail', id, theS.jailtime, theS.job, true)
            Wait(4000)
            TriggerClientEvent('HD_Jail:UpBreaks', id, theS.breaks, false)
        end
    end
end)

Citizen.CreateThread(function()
    for i = 1, #Config.Cells, 1 do
        table.insert(inJail, {Value = i, Players = {}})
    end
    for i = 1, #Config.SolCells, 1 do
        table.insert(solJail, {Value = i, Players = {}})
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for i = 1, #inJail, 1 do
            for k = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[k].Player ~= nil then
                    if not inJail[i].Players[k].Dead then
                        if inJail[i].Players[k].Breako > 0 then
                            inJail[i].Players[k].Breako = inJail[i].Players[k].Breako - 1
                            if inJail[i].Players[k].Breako <= 0 then
                                TriggerEvent('HD_Jail:UnBreak', inJail[i].Players[k].ID)
                            end
                        else
                            if inJail[i].Players[k].Sol > 0 then
                                inJail[i].Players[k].Sol = inJail[i].Players[k].Sol - 1
                                if inJail[i].Players[k].Sol <= 0 then
                                    TriggerEvent('HD_Jail:UnSol', inJail[i].Players[k].ID)
                                end
                            else
                                inJail[i].Players[k].Timie = inJail[i].Players[k].Timie - 1
                                if inJail[i].Players[k].Timie <= 0 then
                                    TriggerEvent('HD_Jail:UnJailPlayer', inJail[i].Players[k].ID, true)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler('playerDropped', function(reason) 
    local src = source
    local xPlayer = Qbox.GetPlayer(src)
    if xPlayer then
        local cert = nil
        cert = xPlayer.identifier
    
        local found1 = 0
        local found2 = 0
    
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == cert then
                        found1 = i
                        found2 = j
                     end
                end
            end
        end
    
        if found1 ~= 0 then
            if Log.LeaveInJail then
                if Config.SimpleTime then
                    local this = {
                        {
                            ["name"] = "**Player Name:**",
                            ["value"] = GetPlayerName(inJail[found1].Players[found2].ID),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player ID:**",
                            ["value"] = inJail[found1].Players[found2].ID,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player Identifier:**",
                            ["value"] = cert,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Time Remaining:**",
                            ["value"] = inJail[found1].Players[found2].Timie..' (seconds)',
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Solitary Time Remaining:**",
                            ["value"] = inJail[found1].Players[found2].Sol..' (seconds)',
                            ["inline"] = true
                        }
                    }
                    sendToDiscord(this, 13172480, "Player Leaving In Jail")
                else
                    local this = {
                        {
                            ["name"] = "**Player Name:**",
                            ["value"] = GetPlayerName(inJail[found1].Players[found2].ID),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player ID:**",
                            ["value"] = inJail[found1].Players[found2].ID,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player Identifier:**",
                            ["value"] = cert,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Time Remaining:**",
                            ["value"] = GetGoodTime(inJail[found1].Players[found2].Timie),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Solitary Time Remaining:**",
                            ["value"] = GetGoodTime(inJail[found1].Players[found2].Sol),
                            ["inline"] = true
                        }
                    }
                    sendToDiscord(this, 13172480, "Player Leaving In Jail")
                end
            end
    
    
            local player = inJail[found1].Players[found2]
            local jailtime = player.Timie
            local solitary = player.Sol
            table.remove(inJail[found1].Players, found2)
            JailStorage.Get(cert, function(newData)
                newData.jailtime = jailtime
                newData.soli = solitary
                JailStorage.Save(cert, newData)
            end)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.SyncInterval* 60000)

        for i = 1, #inJail, 1 do
            for k = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[k].Player ~= nil then
                    local player = inJail[i].Players[k]
                    JailStorage.Get(player.Player, function(newData)
                        newData.jailtime = player.Timie
                        newData.soli = player.Sol
                        JailStorage.Save(player.Player, newData)
                    end)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.ESXVersion == '1.1' then
        TriggerEvent('es:addGroupCommand', 'jailmenu', 'admin', function(source, args, user)
            local id = source
            TriggerClientEvent('HD_Jail:JailMenu', id)
        end, function(source, args, user)
            TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
        end, {help = 'Jail Menu For Admins & Police', params = {{}}})
    else
        Qbox.RegisterCommand('jailmenu', 'admin', function(xPlayer, args, showError)
            TriggerClientEvent('HD_Jail:JailMenu',xPlayer.source)
        end, true, {help = 'Jail Menu For Admins & Police', validate = true, arguments = {
        }})
    end
end)


RegisterServerEvent('HD_Jail:sendToJail')
AddEventHandler('HD_Jail:sendToJail', function(id, time, reason)
    time = math.floor(tonumber(time) or 0)
    if time <= 0 or time > Config.MaxJail * 60 then return end
    reason = tostring(reason or '')
    if CheckUser(source, 'jail') then
        local xPlayer = Qbox.GetPlayer(id)
        if not xPlayer then return end
        local ident = xPlayer.identifier 
        local bad = false
        local cell = 0
        
        if xPlayer then
            for i = 1, #inJail, 1 do
                if inJail[i].Players[1] ~= nil then
                    for j = 1, #inJail[i].Players, 1 do
                        if inJail[i].Players[j].Player == ident then
                            bad = true
                        end
                    end
                end
            end
            if not bad then
                JailStorage.Get(xPlayer.identifier, function(newData)
                    newData.jailtime = time
                    newData.jobo = xPlayer.job.name
                    newData.grade = xPlayer.job.grade
                    if false then
                        print(('[Fixlife_prision] No se encontrÃƒÆ’Ã‚Â³ hdjail_data para citizenid %s (source %s)'):format(tostring(xPlayer.identifier), tostring(id)))
                    end
                    xPlayer.setJob('prisoner', 0)
                    local itemz = xPlayer.inventory
                    local inventory = nil
                    local keep = {}
                    inventory = {itemz = itemz}
                    for i=1, #inventory.itemz, 1 do
                        local item = inventory.itemz[i]
            
                        if item.count > 0 then
                            local item = inventory.itemz[i]
                            local bad2 = false
                            for j=1, #Config.DontGiveBackItems, 1 do
                                if item.name == Config.DontGiveBackItems[j] then
                                    bad2 = true
                                end
                            end

                            if not bad2 then
                                table.insert(keep, {item = item.name, Amt = item.count})
                            end
                        end
                    end
                    for i=1, #inventory.itemz, 1 do
                        local item = inventory.itemz[i]
            
                        if item.count > 0 then
                            local item = inventory.itemz[i]

                            local keepo = false
                            for j=1, #Config.DontTakeItemsUponEntry, 1 do
                                if item.name == Config.DontTakeItemsUponEntry[j] then
                                    keepo = true
                                end
                            end
                            if not keepo then
                                xPlayer.removeInventoryItem(item.name, item.count)
                            end
                        end
                    end
                    newData.items = keep
                    JailStorage.Save(xPlayer.identifier, newData, function(rowsChanged)
                        TriggerClientEvent('esx_policejob:unrestrain', id)
                        TriggerClientEvent('HD_Jail:JailStart', id, time)
                        local fullname = nil
                        if Config.ESXVersion ~= '1.1' then
                            fullname = xPlayer.get("firstName") .. " " .. xPlayer.get("lastName")
                        else
                            fullname = GetPlayerName(xPlayer.source)
                        end
                        if Config.SimpleTime then
                            -- TriggerClientEvent('chat:addMessage', -1, {args = {Config.ServerName..' '..Config.Sayings[7], fullname..Config.Sayings[8]..ESX.Math.Round(time / 60)..Config.Sayings[21]..reason}, color = {147, 196, 109}})
                            TriggerClientEvent('chat:addMessage', -1, {
                                template = '<div class="chat-message pm"><i class="scale-balanced"></i> <b><span style="color: #916db0">['..Config.ServerName..' '..Config.Sayings[7], fullname..Config.Sayings[8]..ESX.Math.Round(time / 60)..Config.Sayings[21]..reason..'] {0}</span>&nbsp;<span class="time">{2}</span></b><div class="message">{1}</div></div>',
                                args = { fullname, reason, os.date('%H:%M') }
                            })
                        else
                            local bruhTime = {Hours = 0, Mins = 0, Seconds = 0}

                            local duration = time
                            local extraSeconds = duration%60
                            local minutes = (duration-extraSeconds)/60
                            local currentTime = os.date('%H:%M')
                            if duration >= 60 then
                                if minutes >= 60 then
                                    local extraMinutes = minutes%60
                                    local hours = (minutes-extraMinutes)/60
                                    bruhTime.Hours = math.floor(hours)
                                    bruhTime.Mins = math.ceil(extraMinutes)
                                    bruhTime.Seconds = extraSeconds
                                else
                                    bruhTime.Hours = 0
                                    bruhTime.Mins = math.floor(minutes)
                                    bruhTime.Seconds = extraSeconds
                                end
                            else
                                bruhTime.Hours = 0
                                bruhTime.Mins = 0
                                bruhTime.Seconds = duration
                            end

                            -- TriggerClientEvent('chat:addMessage', -1, {args = {Config.ServerName..' '..Config.Sayings[7], fullname..Config.Sayings[8]..bruhTime.Hours..'^1H^0 '..bruhTime.Mins..'^1M^0 '..bruhTime.Seconds..'^1S^0'..Config.Sayings[21]..reason}, color = {147, 196, 109}})
                            -- TriggerClientEvent('chat:addMessage', -1, {
                            --     template = '<div class="chat-message server-msg"><i class="fa-solid fa-scale-balanced" style="vertical-align: middle;"></i> <span style="vertical-align: middle;"><b><span style="color: #00D3FC;">[SISTEMA JUDICIAL DE '..Config.ServerName..']</span>&nbsp;<span class="time">{1}</span></b></span><div class="message">{0}</div></div>',
                            --     args = { Config.Sayings[7].. fullname..Config.Sayings[8]..bruhTime.Hours..'^1H^0 '..bruhTime.Mins..'^1M^0 '..bruhTime.Seconds..'^1S^0'..Config.Sayings[21]..reason, time }
                            -- })
                            TriggerClientEvent('chat:addMessage', -1, {
                                template = '<div class="chat-message server-msg"><i class="fas fa-gavel" style="vertical-align: middle;"></i> <span style="vertical-align: middle;"><b><span style="color: #FAEA17;">[SISTEMA JUDICIAL]</span>&nbsp;<span class="time">{1}</span></b></span><div class="message">{0}</div></div>',
                                args = { 'El ciudadano(a) ^3'.. fullname..'^0'..Config.Sayings[8]..'^3'..bruhTime.Hours..' aÃƒÆ’Ã‚Â±o(s) ^0 con ^3'..bruhTime.Mins..' mes(es) ^0 y ^3'..bruhTime.Seconds..' semana(s)^0, por un juez de la republica, en la '..Config.Sayings[1].. ', por el delito de ^3'..reason, currentTime }
                            })
                        end
                        local cellies = {}
                        local lowest = {val = 0, amtie = 30}
                        for i = 1, #inJail, 1 do
                            if inJail[i].Players ~= nil then
                                local total = 0
                                for p = 1, #inJail[i].Players, 1 do
                                    total = total + 1
                                end
                                table.insert(cellies, {value = i, amt = total})
                            else
                                table.insert(cellies, {value = i, amt = 0})
                            end
                        end
                        for i = 1, #cellies, 1 do
                            if cellies[i].amt < lowest.amtie then
                                lowest.val = cellies[i].value
                                lowest.amtie = cellies[i].amt
                            end
                        end
                        table.insert(inJail[lowest.val].Players, {Player = ident, Timie = time, ID = id, Sol = 0, Dead = false, Breako = 0})
                        if Log.Jail then
                            if Config.SimpleTime then
                                local this = {
                                    {
                                        ["name"] = "**Player Name:**",
                                        ["value"] = GetPlayerName(id),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Player ID:**",
                                        ["value"] = id,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Player Identifier:**",
                                        ["value"] = ident,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Time:**",
                                        ["value"] = time..' (seconds)',
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Cell Number:**",
                                        ["value"] = lowest.val,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Reason:**",
                                        ["value"] = reason,
                                        ["inline"] = true
                                    }
                                }
                                sendToDiscord(this, 16542467, "Jailing Player")
                            else
                                local this = {
                                    {
                                        ["name"] = "**Player Name:**",
                                        ["value"] = GetPlayerName(id),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Player ID:**",
                                        ["value"] = id,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Player Identifier:**",
                                        ["value"] = ident,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Time:**",
                                        ["value"] = GetGoodTime(time),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Cell Number:**",
                                        ["value"] = lowest.val,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "**Reason:**",
                                        ["value"] = reason,
                                        ["inline"] = true
                                    }
                                }
                                sendToDiscord(this, 16542467, "Jailing Player")
                            end
                        end
                    end)
                end)
            end
        end
    else
        local _source = source
        TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
    end
end)

Qbox.RegisterCallback('HD_Jail:GetCell', function(source, cb)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then cb(0); return end
    local ident = xPlayer.identifier
    local found = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found = i
                end
            end
        end
    end

    cb(found)
end)

Qbox.RegisterCallback('HD_Jail:CheckID', function(source, cb, id)
    local xPlayer = Qbox.GetPlayer(id)
    if xPlayer ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

Qbox.RegisterCallback('HD_Jail:GetPlayerInCell', function(source, cb, cell)
    local goodShit = {}
    if not inJail[cell] then cb(goodShit); return end
    for j = 1, #inJail[cell].Players, 1 do
        local xPlayer = Qbox.GetPlayer(inJail[cell].Players[j].ID)
        if xPlayer then
            local fullname = nil
            if Config.ESXVersion ~= '1.1' then
                fullname = xPlayer.get("firstName") .. " " .. xPlayer.get("lastName")
            else
                fullname = GetPlayerName(xPlayer.source)
            end
            table.insert(goodShit, {name = fullname, id = inJail[cell].Players[j].ID})
        end
    end
    cb(goodShit)
end)


RegisterServerEvent('HD_Jail:UnJailPlayer')
AddEventHandler('HD_Jail:UnJailPlayer', function(id, flip)
    local xTarget = Qbox.GetPlayer(source)
    if xTarget == nil then
        local xPlayer = Qbox.GetPlayer(id)
        if not xPlayer then return end
        local ident = xPlayer.identifier
        local found = 0
        local found2 = 0
    
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == ident then
                        found = i
                        found2 = j
                    end
                end
            end
        end
    
        if found ~= 0 then
            table.remove(inJail[found].Players, found2)
    
            if flip then
                JailStorage.Get(xPlayer.identifier, function(newData)
                    local itemzz = nil
                    local clothie = nil
                    local data = nil
                    newData.cell = 0
                    newData.chest = {}
                    newData.job = 0
                    xPlayer.setJob(newData.jobo, newData.grade)
                    newData.jobo = 'nil'
                    newData.grade = 0
                    newData.job = 0
                    newData.jailtime = 0
                    newData.soli = 0
                    newData.breaks = 0
                    clothie = newData.clothes
                    newData.clothes = {}
                    itemzz = newData.items
                    newData.items = {}
                    data = json.encode(newData)
                    TriggerClientEvent('HD_Jail:UnnJail', id, itemzz, clothie)
    
                    if Log.UnJail then
                        local this = {
                            {
                                ["name"] = "**Player Name:**",
                                ["value"] = GetPlayerName(id),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player ID:**",
                                ["value"] = id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player Identifier:**",
                                ["value"] = ident,
                                ["inline"] = true
                            }
                        }
                        sendToDiscord(this, 16515843, "Un-Jailing Player")
                    end
    
                    JailStorage.Save(xPlayer.identifier, newData)
                end)
            else
                JailStorage.Get(xPlayer.identifier, function(newData)
                    newData.cell = 0
                    newData.chest = {}
                    newData.job = 0
                    xPlayer.setJob(newData.jobo, newData.grade)
                    newData.jobo = 'nil'
                    newData.grade = 0
                    newData.soli = 0
                    newData.jailtime = 0
                    newData.breaks = 0
                    newData.clothes = {}
                    newData.items = {}
                    JailStorage.Save(xPlayer.identifier, newData)
                end)
            end
        end
    else
        if CheckUser(source, 'unjail') then
            local xPlayer = Qbox.GetPlayer(id)
            if not xPlayer then return end
            local ident = xPlayer.identifier
            local found = 0
            local found2 = 0
        
            for i = 1, #inJail, 1 do
                if inJail[i].Players[1] ~= nil then
                    for j = 1, #inJail[i].Players, 1 do
                        if inJail[i].Players[j].Player == ident then
                            found = i
                            found2 = j
                        end
                    end
                end
            end
        
            if found ~= 0 then
                table.remove(inJail[found].Players, found2)
        
                if flip then
                    JailStorage.Get(xPlayer.identifier, function(newData)
                        local itemzz = nil
                        local clothie = nil
                        local data = nil
                        newData.cell = 0
                        newData.chest = {}
                        newData.job = 0
                        xPlayer.setJob(newData.jobo, newData.grade)
                        newData.jobo = 'nil'
                        newData.grade = 0
                        newData.job = 0
                        newData.jailtime = 0
                        newData.soli = 0
                        newData.breaks = 0
                        clothie = newData.clothes
                        newData.clothes = {}
                        itemzz = newData.items
                        newData.items = {}
                        data = json.encode(newData)
                        TriggerClientEvent('HD_Jail:UnnJail', id, itemzz, clothie)
        
                        if Log.UnJail then
                            local this = {
                                {
                                    ["name"] = "**Player Name:**",
                                    ["value"] = GetPlayerName(id),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Player ID:**",
                                    ["value"] = id,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Player Identifier:**",
                                    ["value"] = ident,
                                    ["inline"] = true
                                }
                            }
                            sendToDiscord(this, 16515843, "Un-Jailing Player")
                        end
        
                        JailStorage.Save(xPlayer.identifier, newData)
                    end)
                else
                    JailStorage.Get(xPlayer.identifier, function(newData)
                        local data = nil
                        newData.cell = 0
                        newData.chest = {}
                        newData.job = 0
                        xPlayer.setJob(newData.jobo, newData.grade)
                        newData.jobo = 'nil'
                        newData.grade = 0
                        newData.soli = 0
                        newData.jailtime = 0
                        newData.breaks = 0
                        newData.clothes = {}
                        newData.items = {}
                    JailStorage.Save(xPlayer.identifier, newData)
                    end)
                end
            end
        else
            TriggerClientEvent('HD_Jail:SendNotif', xTarget.source, Config.Sayings[159])
        end
    end
end)

RegisterServerEvent('HD_Jail:UpdateCell')
AddEventHandler('HD_Jail:UpdateCell', function(cnum, player)
    local xPlayer = nil
    cnum = math.floor(tonumber(cnum) or 0)
    if not inJail[cnum] then return end

    if Qbox.GetPlayer(source) == nil then
        xPlayer = Qbox.GetPlayer(player)
    else
        xPlayer = Qbox.GetPlayer(source)
    end
    if not xPlayer then return end
    JailStorage.Get(xPlayer.identifier, function(newData)
        newData.cell = cnum
        JailStorage.Save(xPlayer.identifier, newData)
	end)
end)

RegisterServerEvent('HD_Jail:AddSomeTime')
AddEventHandler('HD_Jail:AddSomeTime', function(id, timzu, reason)
    timzu = math.floor(tonumber(timzu) or 0)
    if timzu <= 0 then return end
    if CheckUser(source, 'add') then
        local xPlayer = Qbox.GetPlayer(id)
        if not xPlayer then return end
        local ident = xPlayer.identifier
        local found = 0
        local found2 = 0
    
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == ident then
                        found = i
                        found2 = j
                    end
                end
            end
        end
    
        if found ~= 0 then
    
            if Log.AddTime then
                if Config.SimpleTime then
                    local this = {
                        {
                            ["name"] = "**Player Name:**",
                            ["value"] = GetPlayerName(id),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player ID:**",
                            ["value"] = id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player Identifier:**",
                            ["value"] = ident,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Current Time:**",
                            ["value"] = inJail[found].Players[found2].Timie..' (seconds)',
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Amount Being Added:**",
                            ["value"] = timzu..' (seconds)',
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Total New Time:**",
                            ["value"] = inJail[found].Players[found2].Timie + timzu,
                            ["inline"] = true
                        }
                    }
                    sendToDiscord(this, 65301, "Adding Time To Player")
                else
                    local this = {
                        {
                            ["name"] = "**Player Name:**",
                            ["value"] = GetPlayerName(id),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player ID:**",
                            ["value"] = id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player Identifier:**",
                            ["value"] = ident,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Current Time:**",
                            ["value"] = GetGoodTime(inJail[found].Players[found2].Timie),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Amount Being Added:**",
                            ["value"] = GetGoodTime(timzu),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Total New Time:**",
                            ["value"] = GetGoodTime(inJail[found].Players[found2].Timie + timzu),
                            ["inline"] = true
                        }
                    }
                    sendToDiscord(this, 65301, "Adding Time To Player")
                end
            end
    
            JailStorage.Get(xPlayer.identifier, function(newData)
                inJail[found].Players[found2].Timie = inJail[found].Players[found2].Timie + timzu
                newData.jailtime = inJail[found].Players[found2].Timie
                TriggerClientEvent('HD_Jail:AddItUp', id, timzu)
                JailStorage.Save(xPlayer.identifier, newData)
            end)
        end
    else
        local _source = source
        TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
    end
end)

RegisterServerEvent('HD_Jail:RemoveSomeTime')
AddEventHandler('HD_Jail:RemoveSomeTime', function(id, timzu, reason)
    timzu = math.floor(tonumber(timzu) or 0)
    if timzu <= 0 then return end
    if CheckUser(source, 'remove') then
        local xPlayer = Qbox.GetPlayer(id)
        if not xPlayer then return end
        local ident = xPlayer.identifier
        local _source = source
        local found = 0
        local found2 = 0
    
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == ident then
                        found = i
                        found2 = j
                    end
                end
            end
        end
    
        if found ~= 0 then
            if inJail[found].Players[found2].Timie > timzu then
    
                if Log.RemoveTime then
                    if Config.SimpleTime then
                        local this = {
                            {
                                ["name"] = "**Player Name:**",
                                ["value"] = GetPlayerName(id),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player ID:**",
                                ["value"] = id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player Identifier:**",
                                ["value"] = ident,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Current Time:**",
                                ["value"] = inJail[found].Players[found2].Timie..' (seconds)',
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Amount Being Removed:**",
                                ["value"] = timzu..' (seconds)',
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Total New Time:**",
                                ["value"] = inJail[found].Players[found2].Timie - timzu,
                                ["inline"] = true
                            }
                        }
                        sendToDiscord(this, 65301, "Removing Time From Player")
                    else
                        local this = {
                            {
                                ["name"] = "**Player Name:**",
                                ["value"] = GetPlayerName(id),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player ID:**",
                                ["value"] = id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player Identifier:**",
                                ["value"] = ident,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Current Time:**",
                                ["value"] = GetGoodTime(inJail[found].Players[found2].Timie),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Amount Being Removed:**",
                                ["value"] = GetGoodTime(timzu),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Total New Time:**",
                                ["value"] = GetGoodTime(inJail[found].Players[found2].Timie - timzu),
                                ["inline"] = true
                            }
                        }
                        sendToDiscord(this, 65301, "Removing Time From Player")
                    end
                end
    
                JailStorage.Get(xPlayer.identifier, function(newData)
                    inJail[found].Players[found2].Timie = inJail[found].Players[found2].Timie - timzu
                    newData.jailtime = inJail[found].Players[found2].Timie
                    TriggerClientEvent('HD_Jail:Removeit', id, timzu)
                    JailStorage.Save(xPlayer.identifier, newData)
                end)
            else
                TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[141])
            end
        end
    else
        local _source = source
        TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
    end
end)

RegisterServerEvent('HD_Jail:UpdateClothes')
AddEventHandler('HD_Jail:UpdateClothes', function(numie)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or type(numie) ~= 'table' then return end

    JailStorage.Get(xPlayer.identifier, function(newData)
        newData.clothes = numie
        JailStorage.Save(xPlayer.identifier, newData)
	end)
end)

RegisterServerEvent('HD_Jail:Ate')
AddEventHandler('HD_Jail:Ate', function()
    local currentHunger = exports.qbx_core:GetMetadata(source, 'hunger') or 0
    local currentThirst = exports.qbx_core:GetMetadata(source, 'thirst') or 0
    exports.qbx_core:SetMetadata(source, 'hunger', math.min(100, currentHunger + math.floor(Config.FoodAmt / 10000)))
    exports.qbx_core:SetMetadata(source, 'thirst', math.min(100, currentThirst + math.floor(Config.DrinkAmt / 10000)))
end)

RegisterServerEvent('HD_Jail:UnBreak')
AddEventHandler('HD_Jail:UnBreak', function(id)
    local eventSource = tonumber(source) or 0
    if eventSource > 0 and eventSource ~= 65535 and tonumber(id) ~= eventSource then return end
    local xPlayer = Qbox.GetPlayer(id)
    if not xPlayer then return end
    local ident = xPlayer.identifier
    local found1 = 0
    local found2 = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found1 = i
                    found2 = j
                end
            end
        end
    end

    if found1 ~= 0 then
        inJail[found1].Players[found2].Breako = 0
        TriggerClientEvent('HD_Jail:UnBreak2', id)
    end
end)

RegisterServerEvent('HD_Jail:RetrieveItems')
AddEventHandler('HD_Jail:RetrieveItems', function(itoms)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end

    JailStorage.Get(xPlayer.identifier, function(newData)
        if (tonumber(newData.jailtime) or 0) > 0 then return end

        local remaining = {}
        for _, item in ipairs(newData.items or {}) do
            local amount = math.floor(tonumber(item.Amt) or 0)
            if type(item.item) == 'string' and amount > 0 then
                if xPlayer.canCarryItem(item.item, amount) then
                    xPlayer.addInventoryItem(item.item, amount)
                else
                    remaining[#remaining + 1] = item
                end
            end
        end
        newData.items = remaining
        JailStorage.Save(xPlayer.identifier, newData)
    end)
end)

RegisterServerEvent('HD_Jail:SetJob')
AddEventHandler('HD_Jail:SetJob', function(jobii, flip)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or (jobii ~= 0 and not Config.JobOptions[jobii]) then return end
    local ident = xPlayer.identifier
    local found1 = 0
    local found2 = 0
    local id = nil

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    id = inJail[i].Players[j].ID
                end
            end
        end
    end

    JailStorage.Get(xPlayer.identifier, function(newData)

        if Log.Job and flip then
            local jobzo = nil
            local jobbo = nil
            if newData.job ~= 0 then
                jobzo = Config.JobOptions[newData.job].Name
            else
                jobzo = Config.Sayings[16]
            end
            if jobii ~= 0 then
                jobbo = Config.JobOptions[jobii].Name
            else
                jobbo = Config.Sayings[16]
            end
            local this = {
                {
                    ["name"] = "**Player Name:**",
                    ["value"] = GetPlayerName(id),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player ID:**",
                    ["value"] = id,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player Identifier:**",
                    ["value"] = ident,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Old Job:**",
                    ["value"] = jobzo,
                    ["inline"] = true
                },
                {
                    ["name"] = "**New Job:**",
                    ["value"] = jobbo,
                    ["inline"] = true
                }
            }
            sendToDiscord(this, 65412, "Player Job Change")
        end

        newData.job = jobii
        JailStorage.Save(xPlayer.identifier, newData)
	end)
end)

RegisterServerEvent('HD_Jail:TaskComplete')
AddEventHandler('HD_Jail:TaskComplete', function(taskJob)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or not Config.JobOptions[taskJob] then return end
    local ident = xPlayer.identifier
    local found1 = 0
    local found2 = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found1 = i
                    found2 = j
                end
            end
        end
    end

    if found1 ~= 0 then

        if Log.Job then
            local yur = inJail[found1].Players[found2].Timie - Config.JobOptions[taskJob].TimeRemove

            if Config.SimpleTime then
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(xPlayer.source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = xPlayer.source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Job:**",
                        ["value"] = Config.JobOptions[taskJob].Name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Current Time:**",
                        ["value"] = inJail[found1].Players[found2].Timie..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Being Removed:**",
                        ["value"] = Config.JobOptions[taskJob].TimeRemove..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**New Time:**",
                        ["value"] = yur..' (seconds)',
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 65480, "Job Task Complete")
            else
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(xPlayer.source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = xPlayer.source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Job:**",
                        ["value"] = Config.JobOptions[taskJob].Name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Current Time:**",
                        ["value"] = GetGoodTime(inJail[found1].Players[found2].Timie),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Being Removed:**",
                        ["value"] = GetGoodTime(Config.JobOptions[taskJob].TimeRemove),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**New Time:**",
                        ["value"] = GetGoodTime(yur),
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 65480, "Job Task Complete")
            end
        end

        inJail[found1].Players[found2].Timie = inJail[found1].Players[found2].Timie - Config.JobOptions[taskJob].TimeRemove
        JailStorage.Get(ident, function(newData)
            newData.jailtime = inJail[found1].Players[found2].Timie
            JailStorage.Save(ident, newData)
        end)
    end
end)


RegisterServerEvent('HD_Jail:PlayerDie')
AddEventHandler('HD_Jail:PlayerDie', function(trip)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.identifier
    local found1 = 0
    local found2 = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found1 = i
                    found2 = j
                end
            end
        end
    end

    if found1 ~= 0 then
        inJail[found1].Players[found2].Dead = trip
        if inJail[found1].Players[found2].Breako > 0 then
            TriggerEvent('HD_Jail:UnBreak', inJail[found1].Players[found2].ID)
        end
    end
end)

RegisterServerEvent('HD_Jail:KilledBy')
AddEventHandler('HD_Jail:KilledBy', function(id)
    local xPlayer = Qbox.GetPlayer(id)
    if xPlayer then
        local ident = xPlayer.identifier
        local found1 = 0
        local found2 = 0
    
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == ident then
                        found1 = i
                        found2 = j
                    end
                end
            end
        end
    
        if found1 ~= 0 and Config.Sol4Kill then
            TriggerEvent('HD_Jail:SendToSol', id, Config.SolKillTime, Config.Sayings[110])
        end
    end
end)


RegisterServerEvent('HD_Jail:UpdateBreak')
AddEventHandler('HD_Jail:UpdateBreak', function()
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.identifier
    local found1 = 0
    local found2 = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found1 = i
                    found2 = j
                end
            end
        end
    end

    if found1 ~= 0 then
        inJail[found1].Players[found2].Breako = Config.BreakoutTime

        JailStorage.Get(xPlayer.identifier, function(newData)
            newData.breaks = 0
            JailStorage.Save(xPlayer.identifier, newData)
        end) 
    end
end)

RegisterServerEvent('HD_Jail:UpdateBreaking')
AddEventHandler('HD_Jail:UpdateBreaking', function()
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.identifier
    local found1 = 0
    local found2 = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found1 = i
                    found2 = j
                end
            end
        end
    end

    if found1 ~= 0 then
        inJail[found1].Players[found2].Breako = 0
    end
end)

RegisterServerEvent('HD_Jail:TaskComplete1')
AddEventHandler('HD_Jail:TaskComplete1', function(taskJob)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or not Config.JobOptions[taskJob] then return end
    local ident = xPlayer.identifier

    local ran = math.random(1,10)
    local ranq = 0
    ranq = ran
    if ranq <= Config.JobOptions[taskJob].StealChance then
        local totNims = {}
        local totnums = 0
        for i = 1, #Config.JobOptions[taskJob].StealItems, 1 do
            for x = 1, Config.JobOptions[taskJob].StealItems[i].Chance, 1 do
                table.insert(totNims, {value = i})
            end
        end
        for i = 1, #totNims, 1 do
            totnums = totnums + 1
        end
        if totnums == 0 then return end
        local rannym = math.random(1, totnums)
        local finish = 0 
        finish = rannym

        xPlayer.addInventoryItem(Config.JobOptions[taskJob].StealItems[totNims[finish].value].Item, 1)
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'inform',
            description = Config.Sayings[86]..Config.JobOptions[taskJob].StealItems[totNims[finish].value].Name
        })
    end
end)

RegisterServerEvent('HD_Jail:LoadedIn')
AddEventHandler('HD_Jail:LoadedIn', function()
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local _source = source
    JailStorage.Get(xPlayer.identifier, function(newData)
        if newData.jailtime > 0 then
            TriggerEvent('HD_Jail:ReJail', _source, newData)
        end
    end)
end)

RegisterServerEvent('HD_Jail:CheckSol')
AddEventHandler('HD_Jail:CheckSol', function(id)
    local xPlayer = Qbox.GetPlayer(id)
    if not xPlayer then return end
    local ident = xPlayer.identifier
    local cellies = {}
    local lowest = {val = 0, amtie = 30}
    local found1 = 0
    local found2 = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found1 = i
                    found2 = j
                end
            end
        end
    end

    if found1 ~= 0 then
        if inJail[found1].Players[found2].Sol > 0 then
            for i = 1, #solJail, 1 do
                if solJail[i].Players ~= nil then
                    local total = 0
                    for p = 1, #solJail[i].Players, 1 do
                        total = total + 1
                    end
                    table.insert(cellies, {value = i, amt = total})
                else
                    table.insert(cellies, {value = i, amt = 0})
                end
            end
            for i = 1, #cellies, 1 do
                if cellies[i].amt < lowest.amtie then
                    lowest.val = cellies[i].value
                    lowest.amtie = cellies[i].amt
                end
            end
            table.insert(solJail[lowest.val].Players, {Player = ident})
            TriggerClientEvent('HD_Jail:SendSol', id, inJail[found1].Players[found2].Sol, lowest.val)
        else
            TriggerClientEvent('HD_Jail:NotSol', id)
        end
    end
end)

RegisterServerEvent('HD_Jail:SendToSol')
AddEventHandler('HD_Jail:SendToSol', function(id, tima, reasons)
    tima = math.floor(tonumber(tima) or 0)
    if tima <= 0 then return end
    local xTarget = Qbox.GetPlayer(source)
    if xTarget == nil then
        local xPlayer = Qbox.GetPlayer(id)
        if not xPlayer then return end
        local ident = xPlayer.identifier
        local timaz = tima *60
        local found = 0
        local found2 = 0
    
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == ident then
                        found = i
                        found2 = j
                    end
                end
            end
        end
    
        if found ~= 0 then
            JailStorage.Get(xPlayer.identifier, function(newData)
                newData.soli = timaz
    
                local cellies = {}
                local lowest = {val = 0, amtie = 30}
                for i = 1, #solJail, 1 do
                    if solJail[i].Players ~= nil then
                        local total = 0
                        for p = 1, #solJail[i].Players, 1 do
                            total = total + 1
                        end
                        table.insert(cellies, {value = i, amt = total})
                    else
                        table.insert(cellies, {value = i, amt = 0})
                    end
                end
                for i = 1, #cellies, 1 do
                    if cellies[i].amt < lowest.amtie then
                        lowest.val = cellies[i].value
                        lowest.amtie = cellies[i].amt
                    end
                end
                table.insert(solJail[lowest.val].Players, {Player = ident})
                inJail[found].Players[found2].Sol = timaz
    
                if Log.SendingSol then
                    if Config.SimpleTime then
                        local this = {
                            {
                                ["name"] = "**Player Name:**",
                                ["value"] = GetPlayerName(id),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player ID:**",
                                ["value"] = id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player Identifier:**",
                                ["value"] = ident,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Solitary Time:**",
                                ["value"] = timaz..' (seconds)',
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Reason For Solitary:**",
                                ["value"] = reasons,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Solitary Cell:**",
                                ["value"] = lowest.val,
                                ["inline"] = true
                            }
                        }
                        sendToDiscord(this, 54783, "Player Going To Solitary")
                    else
                        local this = {
                            {
                                ["name"] = "**Player Name:**",
                                ["value"] = GetPlayerName(id),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player ID:**",
                                ["value"] = id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Player Identifier:**",
                                ["value"] = ident,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Solitary Time:**",
                                ["value"] = GetGoodTime(timaz),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Reason For Solitary:**",
                                ["value"] = reasons,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "**Solitary Cell:**",
                                ["value"] = lowest.val,
                                ["inline"] = true
                            }
                        }
                        sendToDiscord(this, 54783, "Player Going To Solitary")
                    end
                end
    
                TriggerClientEvent('HD_Jail:SendSol', id, timaz, lowest.val)
                JailStorage.Save(xPlayer.identifier, newData)
            end)
        end
    else
        if CheckUser(source, 'solitary') then
            local xPlayer = Qbox.GetPlayer(id)
            local ident = xPlayer.identifier
            local timaz = tima *60
            local found = 0
            local found2 = 0
        
            for i = 1, #inJail, 1 do
                if inJail[i].Players[1] ~= nil then
                    for j = 1, #inJail[i].Players, 1 do
                        if inJail[i].Players[j].Player == ident then
                            found = i
                            found2 = j
                        end
                    end
                end
            end
        
            if found ~= 0 then
                JailStorage.Get(xPlayer.identifier, function(newData)
                    newData.soli = timaz
        
                    local cellies = {}
                    local lowest = {val = 0, amtie = 30}
                    for i = 1, #solJail, 1 do
                        if solJail[i].Players ~= nil then
                            local total = 0
                            for p = 1, #solJail[i].Players, 1 do
                                total = total + 1
                            end
                            table.insert(cellies, {value = i, amt = total})
                        else
                            table.insert(cellies, {value = i, amt = 0})
                        end
                    end
                    for i = 1, #cellies, 1 do
                        if cellies[i].amt < lowest.amtie then
                            lowest.val = cellies[i].value
                            lowest.amtie = cellies[i].amt
                        end
                    end
                    table.insert(solJail[lowest.val].Players, {Player = ident})
                    inJail[found].Players[found2].Sol = timaz
        
                    if Log.SendingSol then
                        if Config.SimpleTime then
                            local this = {
                                {
                                    ["name"] = "**Player Name:**",
                                    ["value"] = GetPlayerName(id),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Player ID:**",
                                    ["value"] = id,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Player Identifier:**",
                                    ["value"] = ident,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Solitary Time:**",
                                    ["value"] = timaz..' (seconds)',
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Reason For Solitary:**",
                                    ["value"] = reasons,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Solitary Cell:**",
                                    ["value"] = lowest.val,
                                    ["inline"] = true
                                }
                            }
                            sendToDiscord(this, 54783, "Player Going To Solitary")
                        else
                            local this = {
                                {
                                    ["name"] = "**Player Name:**",
                                    ["value"] = GetPlayerName(id),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Player ID:**",
                                    ["value"] = id,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Player Identifier:**",
                                    ["value"] = ident,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Solitary Time:**",
                                    ["value"] = GetGoodTime(timaz),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Reason For Solitary:**",
                                    ["value"] = reasons,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "**Solitary Cell:**",
                                    ["value"] = lowest.val,
                                    ["inline"] = true
                                }
                            }
                            sendToDiscord(this, 54783, "Player Going To Solitary")
                        end
                    end
        
                    TriggerClientEvent('HD_Jail:SendSol', id, timaz, lowest.val)
                    JailStorage.Save(xPlayer.identifier, newData)
                end)
            end
        else
            local _source = source
            TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
        end
    end
end)

RegisterServerEvent('HD_Jail:UnSol')
AddEventHandler('HD_Jail:UnSol', function(id)
    local xTarget = Qbox.GetPlayer(source)
    if xTarget == nil then
        local xPlayer = Qbox.GetPlayer(id)
        if not xPlayer then return end
        local ident = xPlayer.identifier
        local found = 0
        local found2 = 0
        local found3 = 0
        local found4 = 0
    
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == ident then
                        found = i
                        found2 = j
                    end
                end
            end
        end
    
        for i = 1, #solJail, 1 do
            if solJail[i].Players[1] ~= nil then
                for j = 1, #solJail[i].Players, 1 do
                    if solJail[i].Players[j].Player == ident then
                        found3 = i
                        found4 = j
                    end
                end
            end
        end
    
        if found3 ~= 0 then
            table.remove(solJail[found3].Players, found4)
        end
        if found ~= 0 then
    
            if Log.SendingSol then
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(id),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 2303, "Player Being Removed From Solitary")
            end
    
            JailStorage.Get(xPlayer.identifier, function(newData)
                newData.soli = 0
                TriggerClientEvent('HD_Jail:UnnSol', id)
                JailStorage.Save(xPlayer.identifier, newData)
            end)
        end
    else
        if CheckUser(source, 'unsolitary') then
            local xPlayer = Qbox.GetPlayer(source)
            local ident = xPlayer.identifier
            local found = 0
            local found2 = 0
            local found3 = 0
            local found4 = 0
        
            for i = 1, #inJail, 1 do
                if inJail[i].Players[1] ~= nil then
                    for j = 1, #inJail[i].Players, 1 do
                        if inJail[i].Players[j].Player == ident then
                            found = i
                            found2 = j
                        end
                    end
                end
            end
        
            for i = 1, #solJail, 1 do
                if solJail[i].Players[1] ~= nil then
                    for j = 1, #solJail[i].Players, 1 do
                        if solJail[i].Players[j].Player == ident then
                            found3 = i
                            found4 = j
                        end
                    end
                end
            end
        
            if found3 ~= 0 then
                table.remove(solJail[found3].Players, found4)
            end
            if found ~= 0 then
        
                if Log.SendingSol then
                    local this = {
                        {
                            ["name"] = "**Player Name:**",
                            ["value"] = GetPlayerName(id),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player ID:**",
                            ["value"] = id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "**Player Identifier:**",
                            ["value"] = ident,
                            ["inline"] = true
                        }
                    }
                    sendToDiscord(this, 2303, "Player Being Removed From Solitary")
                end
        
                JailStorage.Get(xPlayer.identifier, function(newData)
                    newData.soli = 0
                    TriggerClientEvent('HD_Jail:UnnSol', id)
                    JailStorage.Save(xPlayer.identifier, newData)
                end)
            end
        else
            local _source = source
            TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
        end
    end
end)

Qbox.RegisterCallback('HD_Jail:CheckItemMake', function(source, cb, num)
	local xPlayer    = Qbox.GetPlayer(source)
    if not xPlayer or not Config.Crafts[num] then cb(1); return end
    local totnum = 0
    for i = 1, #Config.Crafts[num].Needed, 1 do
        totnum = totnum + 1
        if xPlayer.getInventoryItem(Config.Crafts[num].Needed[i].Item).count >= Config.Crafts[num].Needed[i].Amount then
            totnum = totnum - 1
        end
    end

    if totnum <= 0 then
        if Config.OLDESX then
            local sourceItem = xPlayer.getInventoryItem(Config.Crafts[num].MakeItem)
            if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
                cb(2)
            else
                cb(3)
            end
        else
            if xPlayer.canCarryItem(Config.Crafts[num].MakeItem, 1) then
                cb(3)
            else
                cb(2)
            end
        end
    else
        cb(1)
    end
end)

Qbox.RegisterCallback('HD_Jail:CheckItemB', function(source, cb, num)
	local xPlayer    = Qbox.GetPlayer(source)
    if not xPlayer or not Config.RoomTools[num] then cb(false); return end

    if xPlayer.getInventoryItem(Config.RoomTools[num].Item).count >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

Qbox.RegisterCallback('HD_Jail:CheckLockdown', function(source, cb)
	local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then cb({}); return end

    local elo = {}

    if CheckUser(xPlayer.source, 'jail') then
        table.insert(elo, {label = Config.Sayings[128], value = 'jailplayer'})
    end
    if CheckUser(xPlayer.source, 'unjail') then
        table.insert(elo, {label = Config.Sayings[129], value = 'unjail'})
    end
    if CheckUser(xPlayer.source, 'add') then
        table.insert(elo, {label = Config.Sayings[130], value = 'add'})
    end
    if CheckUser(xPlayer.source, 'remove') then
        table.insert(elo, {label = Config.Sayings[131], value = 'remove'})
    end
    if CheckUser(xPlayer.source, 'solitary') then
        table.insert(elo, {label = Config.Sayings[132], value = 'solitary'})
    end
    if CheckUser(xPlayer.source, 'unsolitary') then
        table.insert(elo, {label = Config.Sayings[144], value = 'unsolitary'})
    end
    if CheckUser(xPlayer.source, 'lockdown') then
        if lockDown then
            table.insert(elo, {label = Config.Sayings[145]..' <span style="color:green;">'..Config.Sayings[146], value = 'lockdown'})
        else
            table.insert(elo, {label = Config.Sayings[145]..' <span style="color:red;">'..Config.Sayings[147], value = 'lockdown'})
        end
    end
    if CheckUser(xPlayer.source, 'message') then
        table.insert(elo, {label = Config.Sayings[165], value = 'mssg'})
    end
    cb(elo)
end)

RegisterServerEvent('HD_Jail:SwitchLock')
AddEventHandler('HD_Jail:SwitchLock', function()
    local xPlayer = Qbox.GetPlayer(source)
    local _source = source

    if CheckUser(_source, 'lockdown') then
        if lockCount > 0 then
            TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[148])
        else
            if lockDown then
                TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[151])
                lockDown = false
                TriggerClientEvent('HD_Jail:TurnOffLock', -1)
            else
                TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[153]..Config.StartLockCount..Config.Sayings[154])
                StartLockDown()
            end
        end
    else
        TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
    end
end)

function StartLockDown()
    lockCount = Config.StartLockCount
    TriggerClientEvent('HD_Jail:CountWarn', -1, Config.StartLockCount)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if lockCount > 0 then
                lockCount = lockCount - 1
                for i = 1, #Config.WarnLockNums, 1 do
                    if lockCount == Config.WarnLockNums[i] then
                        TriggerClientEvent('HD_Jail:CountWarn', -1, Config.WarnLockNums[i])
                    end
                end
            else
                lockDown = true
                TriggerClientEvent('HD_Jail:CountFinish', -1)
                break
            end
        end
    end)
end

Qbox.RegisterCallback('HD_Jail:CheckItemB2', function(source, cb, item)
	local xPlayer    = Qbox.GetPlayer(source)

    if xPlayer.getInventoryItem(item).count >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('HD_Jail:TakeItems4')
AddEventHandler('HD_Jail:TakeItems4', function(itnuma)
    local xPlayer = Qbox.GetPlayer(source)
    local tool = Config.RoomTools[itnuma]
    if not xPlayer or not tool or xPlayer.getInventoryItem(tool.Item).count < 1 then return end

    xPlayer.removeInventoryItem(tool.Item, 1)
end)

RegisterServerEvent('HD_Jail:TakeItems2')
AddEventHandler('HD_Jail:TakeItems2', function(item)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or type(item) ~= 'string' or xPlayer.getInventoryItem(item).count < 1 then return end

    xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('HD_Jail:SuccessFul')
AddEventHandler('HD_Jail:SuccessFul', function(id, time)
    if tonumber(id) ~= source then return end
    local xPlayer = Qbox.GetPlayer(id)
    if not xPlayer then return end
    local ident = xPlayer.identifier

    JailStorage.Get(xPlayer.identifier, function(newData)

        if Log.Breaking then
            local this = {
                {
                    ["name"] = "**Player Name:**",
                    ["value"] = GetPlayerName(id),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player ID:**",
                    ["value"] = id,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player Identifier:**",
                    ["value"] = ident,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Current Amount Of Breaks:**",
                    ["value"] = newData.breaks,
                    ["inline"] = true
                },
                {
                    ["name"] = "**New Amount Of Breaks:**",
                    ["value"] = newData.breaks + 1,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Needed Breaks To Breakout:**",
                    ["value"] = Config.BreakHole,
                    ["inline"] = true
                }
            }
            sendToDiscord(this, 30719, "Player Successfully Digging In Wall")
        end

        newData.breaks = newData.breaks + 1
        TriggerClientEvent('HD_Jail:UpBreaks', id, newData.breaks, true, time)
        JailStorage.Save(xPlayer.identifier, newData)
    end)
end)

RegisterServerEvent('HD_Jail:TakeItems')
AddEventHandler('HD_Jail:TakeItems', function(itnuma)
    local xPlayer = Qbox.GetPlayer(source)
    local craft = Config.Crafts[itnuma]
    if not xPlayer or not craft then return end
    for _, needed in ipairs(craft.Needed) do
        if xPlayer.getInventoryItem(needed.Item).count < needed.Amount then return end
    end
    if not xPlayer.canCarryItem(craft.MakeItem, 1) then return end
    local ident = xPlayer.identifier
    local id = xPlayer.source
    if Log.Craft then
        local this = {
            {
                ["name"] = "**Player Name:**",
                ["value"] = GetPlayerName(id),
                ["inline"] = true
            },
            {
                ["name"] = "**Player ID:**",
                ["value"] = id,
                ["inline"] = true
            },
            {
                ["name"] = "**Player Identifier:**",
                ["value"] = ident,
                ["inline"] = true
            },
            {
                ["name"] = "**Item Being Crafted:**",
                    ["value"] = craft.Name,
                ["inline"] = true
            }
        }
        sendToDiscord(this, 7799039, "Player Crafting Item")
    end

    for i = 1, #craft.Needed, 1 do
        xPlayer.removeInventoryItem(craft.Needed[i].Item, craft.Needed[i].Amount)
    end
    xPlayer.addInventoryItem(craft.MakeItem, 1)
end)


--Discord
function sendToDiscord(field, colour, titles, ur)
    local urls = nil
    if ur ~= nil then
        urls = ur
    else
        urls = "https://imgur.com/WFyOaoY.png"
    end
    local embed = {
          {
              ["fields"] = field,
              ["color"] = colour,
              ["title"] = titles,
              ["description"] = titles,
              ["footer"] = {
                  ["text"] = "Timestamp: "..os.date("%x %X %p"),
              },
              ["thumbnail"] = {
                  ["url"] = urls,
              },
          }
    }
PerformHttpRequest(webhookid, function(err, text, headers) end, 'POST', json.encode({username = "Bolingbroke Penitentiary", embeds = embed, avatar_url = "https://imgur.com/WFyOaoY.png"}), { ['Content-Type'] = 'application/json' })
end

function GetGoodTime(timo)
    local dope = {Hours = 0, Mins = 0, Seconds = 0}

    local msg = nil

    local duration = timo
    local extraSeconds = duration%60
    local minutes = (duration-extraSeconds)/60
    if duration >= 60 then
        if minutes >= 60 then
            local extraMinutes = minutes%60
            local hours = (minutes-extraMinutes)/60
            dope.Hours = math.floor(hours)
            dope.Mins = math.ceil(extraMinutes)
            dope.Seconds = extraSeconds
        else
            dope.Hours = 0
            dope.Mins = math.floor(minutes)
            dope.Seconds = extraSeconds
        end
    else
        dope.Hours = 0
        dope.Mins = 0
        dope.Seconds = timo
    end
    msg = dope.Hours..'H '..dope.Mins..'M '..dope.Seconds..'S '
    return msg
end

function CheckUser(yupiue, checkfor)
    local xPlayer = Qbox.GetPlayer(yupiue)
    local wegood = false

    if not xPlayer or not xPlayer.job then return false end

    for i = 1, #Config.PoliceRoles, 1 do
        if xPlayer.job.name == Config.PoliceRoles[i] then
            if checkfor == 'jail' then
                for j = 1, #Config.PoliceRanks.Jailing, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.Jailing[j].Job and xPlayer.job.grade >= Config.PoliceRanks.Jailing[j].Grade then
                        wegood = true
                    end
                end
            elseif checkfor == 'unjail' then
                for j = 1, #Config.PoliceRanks.UnJail, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.UnJail[j].Job and xPlayer.job.grade >= Config.PoliceRanks.UnJail[j].Grade then
                        wegood = true
                    end
                end
            elseif checkfor == 'add' then
                for j = 1, #Config.PoliceRanks.AddTime, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.AddTime[j].Job and xPlayer.job.grade >= Config.PoliceRanks.AddTime[j].Grade then
                        wegood = true
                    end
                end
            elseif checkfor == 'remove' then
                for j = 1, #Config.PoliceRanks.RemoveTime, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.RemoveTime[j].Job and xPlayer.job.grade >= Config.PoliceRanks.RemoveTime[j].Grade then
                        wegood = true
                    end
                end
            elseif checkfor == 'solitary' then
                for j = 1, #Config.PoliceRanks.Send2Solitary, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.Send2Solitary[j].Job and xPlayer.job.grade >= Config.PoliceRanks.Send2Solitary[j].Grade then
                        wegood = true
                    end
                end
            elseif checkfor == 'unsolitary' then
                for j = 1, #Config.PoliceRanks.RemoveFromSolitary, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.RemoveFromSolitary[j].Job and xPlayer.job.grade >= Config.PoliceRanks.RemoveFromSolitary[j].Grade then
                        wegood = true
                    end
                end
            elseif checkfor == 'lockdown' then
                for j = 1, #Config.PoliceRanks.Lockdown, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.Lockdown[j].Job and xPlayer.job.grade >= Config.PoliceRanks.Lockdown[j].Grade then
                        wegood = true
                    end
                end
            elseif checkfor == 'message' then
                for j = 1, #Config.PoliceRanks.Message, 1 do
                    if xPlayer.job.name == Config.PoliceRanks.Message[j].Job and xPlayer.job.grade >= Config.PoliceRanks.Message[j].Grade then
                        wegood = true
                    end
                end
            end 
        end
    end

    for i = 1, #adminRoles, 1 do
        if xPlayer.group == adminRoles[i] then
            if checkfor == 'jail' then
                for j = 1, #adminAbilities.Jailing, 1 do
                    if xPlayer.group == adminAbilities.Jailing[j] then
                        wegood = true
                    end
                end
            elseif checkfor == 'unjail' then
                for j = 1, #adminAbilities.UnJail, 1 do
                    if xPlayer.group == adminAbilities.UnJail[j] then
                        wegood = true
                    end
                end
            elseif checkfor == 'add' then
                for j = 1, #adminAbilities.AddTime, 1 do
                    if xPlayer.group == adminAbilities.AddTime[j] then
                        wegood = true
                    end
                end
            elseif checkfor == 'remove' then
                for j = 1, #adminAbilities.RemoveTime, 1 do
                    if xPlayer.group == adminAbilities.RemoveTime[j] then
                        wegood = true
                    end
                end
            elseif checkfor == 'solitary' then
                for j = 1, #adminAbilities.Send2Solitary, 1 do
                    if xPlayer.group == adminAbilities.Send2Solitary[j] then
                        wegood = true
                    end
                end
            elseif checkfor == 'unsolitary' then
                for j = 1, #adminAbilities.RemoveFromSolitary, 1 do
                    if xPlayer.group == adminAbilities.RemoveFromSolitary[j] then
                        wegood = true
                    end
                end
            elseif checkfor == 'lockdown' then
                for j = 1, #adminAbilities.Lockdown, 1 do
                    if xPlayer.group == adminAbilities.Lockdown[j] then
                        wegood = true
                    end
                end
            elseif checkfor == 'message' then
                for j = 1, #adminAbilities.Message, 1 do
                    if xPlayer.group == adminAbilities.Message[j] then
                        wegood = true
                    end
                end
            end
        end
    end

    if wegood then
        return true
    else
        return false
    end
end
