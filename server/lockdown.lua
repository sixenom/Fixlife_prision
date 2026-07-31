lib.callback.register('HD_Jail:CheckItemMake', function(source, num)
	local xPlayer    = exports.qbx_core:GetPlayer(source)
    if not xPlayer or not Config.Crafts[num] then return 1 end
    local totnum = 0
    for i = 1, #Config.Crafts[num].Needed, 1 do
        totnum = totnum + 1
        if (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, Config.Crafts[num].Needed[i].Item, nil, true) or 0) >= Config.Crafts[num].Needed[i].Amount then
            totnum = totnum - 1
        end
    end

    if totnum <= 0 then
        if exports.ox_inventory:CanCarryItem(xPlayer.PlayerData.source, Config.Crafts[num].MakeItem, 1) then
            return 3
        else
            return 2
        end
    else
        return 1
    end
end)

local breakAttempts = {}

lib.callback.register('HD_Jail:CheckItemB', function(source, num)
	local xPlayer    = exports.qbx_core:GetPlayer(source)
    local index = tonumber(num)
    local tool = index and Config.RoomTools[index]
    if not tool and type(num) == 'string' then
        for i = 1, #Config.RoomTools do
            if Config.RoomTools[i].Item == num then index, tool = i, Config.RoomTools[i]; break end
        end
    end
    if not xPlayer or not tool then return false end

    if (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, tool.Item, nil, true) or 0) >= 1 then
        breakAttempts[source] = {tool = index, readyAt = GetGameTimer() + tool.Time * 1000}
        return true
    else
        return false
    end
end)

lib.callback.register('HD_Jail:CheckLockdown', function(source)
	local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer then return {} end

    local elo = {}

    if CheckUser(xPlayer.PlayerData.source, 'jail') then
        table.insert(elo, {label = Config.Sayings[128], value = 'jailplayer'})
    end
    if CheckUser(xPlayer.PlayerData.source, 'unjail') then
        table.insert(elo, {label = Config.Sayings[129], value = 'unjail'})
    end
    if CheckUser(xPlayer.PlayerData.source, 'add') then
        table.insert(elo, {label = Config.Sayings[130], value = 'add'})
    end
    if CheckUser(xPlayer.PlayerData.source, 'remove') then
        table.insert(elo, {label = Config.Sayings[131], value = 'remove'})
    end
    if CheckUser(xPlayer.PlayerData.source, 'solitary') then
        table.insert(elo, {label = Config.Sayings[132], value = 'solitary'})
    end
    if CheckUser(xPlayer.PlayerData.source, 'unsolitary') then
        table.insert(elo, {label = Config.Sayings[144], value = 'unsolitary'})
    end
    if CheckUser(xPlayer.PlayerData.source, 'lockdown') then
        if lockDown then
            table.insert(elo, {label = Config.Sayings[145]..' <span style="color:green;">'..Config.Sayings[146], value = 'lockdown'})
        else
            table.insert(elo, {label = Config.Sayings[145]..' <span style="color:red;">'..Config.Sayings[147], value = 'lockdown'})
        end
    end
    if CheckUser(xPlayer.PlayerData.source, 'message') then
        table.insert(elo, {label = Config.Sayings[165], value = 'mssg'})
    end
    return elo
end)

RegisterServerEvent('HD_Jail:SwitchLock')
AddEventHandler('HD_Jail:SwitchLock', function()
    local xPlayer = exports.qbx_core:GetPlayer(source)
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

lib.callback.register('HD_Jail:CheckItemB2', function(source, item)
	local xPlayer    = exports.qbx_core:GetPlayer(source)

    if (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, item, nil, true) or 0) >= 1 then
        return true
    else
        return false
    end
end)

RegisterServerEvent('HD_Jail:TakeItems4')
AddEventHandler('HD_Jail:TakeItems4', function(itnuma)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    local tool = Config.RoomTools[itnuma]
    if not xPlayer or not IsPrisoner(source, xPlayer) or not tool or (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, tool.Item, nil, true) or 0) < 1 then return end

    breakAttempts[source] = nil
    exports.ox_inventory:RemoveItem(xPlayer.PlayerData.source, tool.Item, 1)
end)

RegisterServerEvent('HD_Jail:TakeItems2')
AddEventHandler('HD_Jail:TakeItems2', function(item)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer or not IsPrisoner(source, xPlayer) or type(item) ~= 'string' or (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, item, nil, true) or 0) < 1 then return end

    exports.ox_inventory:RemoveItem(xPlayer.PlayerData.source, item, 1)
end)

RegisterServerEvent('HD_Jail:SuccessFul')
AddEventHandler('HD_Jail:SuccessFul', function(toolIndex)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    local tool = Config.RoomTools[tonumber(toolIndex)]
    local attempt = breakAttempts[source]
    local _, cell = xPlayer and GetJailedPlayer(source, xPlayer)
    local cellData = cell and Config.Cells[cell]
    local ped = GetPlayerPed(source)
    if not xPlayer or not tool or not attempt or attempt.tool ~= tonumber(toolIndex) or GetGameTimer() < attempt.readyAt or not cellData or ped <= 0 or not IsPrisoner(source, xPlayer) or xPlayer.PlayerData.job.name ~= 'prisoner' then return end

    local coords = GetEntityCoords(ped)
    if #(coords - cellData.BreakLoc.Loc) > 4.0 or (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, tool.Item, nil, true) or 0) < 1 then return end
    local ident = xPlayer.PlayerData.citizenid

    JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
        if (tonumber(newData.jailtime) or 0) <= 0 or (tonumber(newData.breaks) or 0) >= Config.BreakHole or not CheckCooldown(source, 'breakout', 1000) then return end
        breakAttempts[source] = nil

        if Log.Breaking then
            local this = {
                {
                    ["name"] = "**Player Name:**",
                    ["value"] = GetPlayerName(source),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player ID:**",
                    ["value"] = source,
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
        TriggerClientEvent('HD_Jail:UpBreaks', source, newData.breaks, true, tool.Time * 1000)
        JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
    end)
end)

RegisterServerEvent('HD_Jail:TakeItems')
AddEventHandler('HD_Jail:TakeItems', function(itnuma)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    local craft = Config.Crafts[itnuma]
    if not xPlayer or not IsPrisoner(source, xPlayer) or not craft then return end
    for _, needed in ipairs(craft.Needed) do
        if (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, needed.Item, nil, true) or 0) < needed.Amount then return end
    end
    if not exports.ox_inventory:CanCarryItem(xPlayer.PlayerData.source, craft.MakeItem, 1) then return end
    local ident = xPlayer.PlayerData.citizenid
    local id = xPlayer.PlayerData.source
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
        exports.ox_inventory:RemoveItem(xPlayer.PlayerData.source, craft.Needed[i].Item, craft.Needed[i].Amount)
    end
    exports.ox_inventory:AddItem(xPlayer.PlayerData.source, craft.MakeItem, 1)
end)


--Discord
