RegisterServerEvent('HD_Jail:CheckSol')
AddEventHandler('HD_Jail:CheckSol', function(id)
    if tonumber(id) ~= source then return end
    local xPlayer = exports.qbx_core:GetPlayer(id)
    if not xPlayer then return end
    local ident = xPlayer.PlayerData.citizenid
    local found1, found2 = 0, 0
    for i = 1, #inJail do
        for j = 1, #inJail[i].Players do
            if inJail[i].Players[j].Player == ident then found1, found2 = i, j end
        end
    end
    if found1 == 0 or inJail[found1].Players[found2].Sol <= 0 then
        TriggerClientEvent('HD_Jail:NotSol', id)
        return
    end
    JailStorage.Get(ident, function(data)
        local cell = tonumber(data.solcell)
        if not solJail[cell] then
            cell = GetRandomCell(solJail, 1)
            data.solcell = cell
            JailStorage.Save(ident, data)
        end
        table.insert(solJail[cell].Players, {Player = ident})
        TriggerClientEvent('HD_Jail:SendSol', id, inJail[found1].Players[found2].Sol, cell)
    end)
end)

function SendToSolitary(id, tima, reasons, internal)
    local caller = tonumber(source) or 0
    local target = tonumber(id) or 0
    if Config.DebugJail then print(('[Fixlife_prision][DEBUG][SERVER] SendToSolitary caller=%s target=%s time=%s internal=%s reason=%s'):format(caller, target, tostring(tima), tostring(internal), tostring(reasons))) end
    if not internal and caller ~= 65535 and caller ~= target and not CheckUser(caller, 'solitary') then return end
    tima = math.floor(tonumber(tima) or 0)
    if tima <= 0 then return end
    local xPlayer = exports.qbx_core:GetPlayer(tonumber(id))
    if xPlayer then
        if internal then
            for _, item in pairs(exports.ox_inventory:GetInventoryItems(id) or {}) do
                if item and item.count and item.count > 0 then
                    exports.ox_inventory:RemoveItem(id, item.name, item.count)
                end
            end
        end
        local ident = xPlayer.PlayerData.citizenid
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
            JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
                newData.soli = timaz
    
                local lowest = {val = GetRandomCell(solJail, 1)}
                newData.solcell = lowest.val
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
                JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
            end)
        end
    elseif not internal then
        if CheckUser(source, 'solitary') then
            local xPlayer = exports.qbx_core:GetPlayer(id)
            local ident = xPlayer.PlayerData.citizenid
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
                JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
                    newData.soli = timaz
        
                    local lowest = {val = GetRandomCell(solJail, 1)}
                    newData.solcell = lowest.val
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
                    JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
                end)
            end
        else
            local _source = source
            TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
        end
    end
end

RegisterServerEvent('HD_Jail:SendToSol')
AddEventHandler('HD_Jail:SendToSol', function(id, tima, reasons)
    SendToSolitary(id, tima, reasons, false)
end)

RegisterServerEvent('HD_Jail:UnSol')

AddEventHandler('HD_Jail:UnSol', function(id)
    local xTarget = exports.qbx_core:GetPlayer(source)
    if xTarget == nil then
        local xPlayer = exports.qbx_core:GetPlayer(id)
        if not xPlayer then return end
        local ident = xPlayer.PlayerData.citizenid
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
    
            JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
                newData.soli = 0
                newData.solcell = 0
                TriggerClientEvent('HD_Jail:UnnSol', id)
                JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
            end)
        end
    else
        if CheckUser(source, 'unsolitary') then
            local xPlayer = exports.qbx_core:GetPlayer(source)
            local ident = xPlayer.PlayerData.citizenid
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
        
                JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
                    newData.soli = 0
                    newData.solcell = 0
                    TriggerClientEvent('HD_Jail:UnnSol', id)
                    JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
                end)
            end
        else
            local _source = source
            TriggerClientEvent('HD_Jail:SendNotif', _source, Config.Sayings[159])
        end
    end
end)

