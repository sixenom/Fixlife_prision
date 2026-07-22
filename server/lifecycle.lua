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


