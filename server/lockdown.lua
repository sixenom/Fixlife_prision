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
