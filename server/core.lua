local qbx = exports.qbx_core
local inventory = exports.ox_inventory
Qbox = {}

JailStorage = { Default = { cell = 0, chest = {}, jailtime = 0, items = {}, clothes = {}, job = 0, breaks = 0, soli = 0, jobo = 'nil', grade = 0 } }

function JailStorage.Get(citizenid, callback)
    MySQL.Async.fetchAll('SELECT hdjail_data FROM players WHERE citizenid = @citizenid', { ['@citizenid'] = citizenid }, function(result)
        local row = result and result[1]
        local data = row and row.hdjail_data and json.decode(row.hdjail_data)
        callback(data or json.decode(json.encode(JailStorage.Default)))
    end)
end

function JailStorage.Save(citizenid, data, callback)
    MySQL.Async.execute('UPDATE players SET hdjail_data = @hdjail_data WHERE citizenid = @citizenid', { ['@citizenid'] = citizenid, ['@hdjail_data'] = json.encode(data) }, callback)
end

CreateThread(function()
    if not qbx:GetJob('prisoner') then qbx:CreateJob('prisoner', { label = 'Prisoner', type = 'none', defaultDuty = true, offDutyPay = false, grades = { [0] = { name = 'Inmate', payment = 0 } } }) end
end)

function Qbox.GetPlayers()
    local players = {}
    for source in pairs(qbx:GetQBPlayers()) do players[#players + 1] = source end
    return players
end

function Qbox.GetPlayer(source)
    local player = qbx:GetPlayer(source)
    if not player then return nil end
    local data = player.PlayerData
    local job = {}
    for key, value in pairs(data.job) do job[key] = value end
    job.grade = data.job.grade.level or data.job.grade
    local permissions = qbx:GetPermission(source) or {}
    local group
    for permission, enabled in pairs(permissions) do if enabled then group = permission break end end
    return {
        source = source, identifier = data.citizenid, job = job, group = group,
        inventory = inventory:GetInventoryItems(source) or {},
        get = function(key)
            if key == 'firstName' then return data.charinfo.firstname end
            if key == 'lastName' then return data.charinfo.lastname end
            return data[key]
        end,
        setJob = function(jobName, grade)
            jobName = tostring(jobName or '')
            if not qbx:GetJob(jobName) then jobName = 'unemployed' end
            qbx:SetJob(data.citizenid, jobName, tonumber(grade) or 0)
        end,
        addInventoryItem = function(item, amount) return inventory:AddItem(source, item, amount) end,
        removeInventoryItem = function(item, amount) return inventory:RemoveItem(source, item, amount) end,
        getInventoryItem = function(item) return { count = inventory:GetItem(source, item, nil, true) or 0 } end,
        canCarryItem = function(item, amount) return inventory:CanCarryItem(source, item, amount) end
    }
end

function Qbox.RegisterCallback(name, handler)
    lib.callback.register(name, function(source, ...)
        local result
        local done = false
        handler(source, function(value) result, done = value, true end, ...)
        while not done do Wait(0) end
        return result
    end)
end

function Qbox.RegisterUsableItem(item, handler)
    qbx:CreateUseableItem(item, function(source) handler(source) end)
end

function Qbox.RegisterCommand(_, _, handler)
    lib.addCommand('jailmenu', { help = 'Abrir menu de prision', restricted = 'group.admin' }, function(source)
        handler(Qbox.GetPlayer(source), {}, function() end)
    end)
end
