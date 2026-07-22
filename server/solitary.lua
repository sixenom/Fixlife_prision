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

