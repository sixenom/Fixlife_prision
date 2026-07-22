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
