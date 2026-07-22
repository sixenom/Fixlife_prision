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
                        print(('[Fixlife_prision] No se encontrÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â³ hdjail_data para citizenid %s (source %s)'):format(tostring(xPlayer.identifier), tostring(id)))
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
                                args = { 'El ciudadano(a) ^3'.. fullname..'^0'..Config.Sayings[8]..'^3'..bruhTime.Hours..' aÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â±o(s) ^0 con ^3'..bruhTime.Mins..' mes(es) ^0 y ^3'..bruhTime.Seconds..' semana(s)^0, por un juez de la republica, en la '..Config.Sayings[1].. ', por el delito de ^3'..reason, currentTime }
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

