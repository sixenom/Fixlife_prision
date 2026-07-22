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
