if IsDuplicityVersion() then
    local qbx = exports.qbx_core
    local inventory = exports.ox_inventory
    ESX = {}
    ESX.Math = { Round = function(value) return math.floor(value + 0.5) end }
    Qbox = {}

    local fetchAll = MySQL.Async.fetchAll
    local asyncExecute = MySQL.Async.execute
    local syncExecute = MySQL.Sync.execute
    local function qboxQuery(query)
        return query:gsub('users', 'players'):gsub('identifier', 'citizenid')
    end
    MySQL.Async.fetchAll = function(query, params, callback)
        return fetchAll(qboxQuery(query), params, callback)
    end
    MySQL.Async.execute = function(query, params, callback)
        return asyncExecute(qboxQuery(query), params, callback)
    end
    MySQL.Sync.execute = function(query, params)
        return syncExecute(qboxQuery(query), params)
    end

    JailStorage = {}
    JailStorage.Default = {
        cell = 0, chest = {}, jailtime = 0, items = {}, clothes = {},
        job = 0, breaks = 0, soli = 0, jobo = 'nil', grade = 0
    }

    function JailStorage.Get(citizenid, callback)
        MySQL.Async.fetchAll('SELECT hdjail_data FROM players WHERE citizenid = @citizenid', {
            ['@citizenid'] = citizenid
        }, function(result)
            local row = result and result[1]
            local data = row and row.hdjail_data and json.decode(row.hdjail_data)
            callback(data or json.decode(json.encode(JailStorage.Default)))
        end)
    end

    function JailStorage.Save(citizenid, data, callback)
        MySQL.Async.execute('UPDATE players SET hdjail_data = @hdjail_data WHERE citizenid = @citizenid', {
            ['@citizenid'] = citizenid,
            ['@hdjail_data'] = json.encode(data)
        }, callback)
    end

    CreateThread(function()
        if not qbx:GetJob('prisoner') then
            qbx:CreateJob('prisoner', {
                label = 'Prisoner',
                type = 'none',
                defaultDuty = true,
                offDutyPay = false,
                grades = { [0] = { name = 'Inmate', payment = 0 } }
            })
        end
    end)

    function ESX.GetPlayers()
        local players = {}
        for source in pairs(qbx:GetQBPlayers()) do
            players[#players + 1] = source
        end
        return players
    end

    Qbox.GetPlayers = ESX.GetPlayers

    function ESX.GetPlayerFromId(source)
        local player = qbx:GetPlayer(source)
        if not player then return nil end

        local data = player.PlayerData
        local job = {}
        for key, value in pairs(data.job) do job[key] = value end
        job.grade = data.job.grade.level or data.job.grade
        local permissions = qbx:GetPermission(source) or {}
        local group
        for permission, enabled in pairs(permissions) do
            if enabled then group = permission break end
        end
        return {
            source = source,
            identifier = data.citizenid,
            job = job,
            group = group,
            inventory = inventory:GetInventoryItems(source) or {},
            get = function(key)
                if key == 'firstName' then return data.charinfo.firstname end
                if key == 'lastName' then return data.charinfo.lastname end
                return data[key]
            end,
            setJob = function(job, grade)
                local jobName = tostring(job or '')
                if not qbx:GetJob(jobName) then jobName = 'unemployed' end
                qbx:SetJob(data.citizenid, jobName, tonumber(grade) or 0)
            end,
            addInventoryItem = function(item, amount)
                return inventory:AddItem(source, item, amount)
            end,
            removeInventoryItem = function(item, amount)
                return inventory:RemoveItem(source, item, amount)
            end,
            getInventoryItem = function(item)
                return { count = inventory:GetItem(source, item, nil, true) or 0 }
            end,
            canCarryItem = function(item, amount)
                return inventory:CanCarryItem(source, item, amount)
            end
        }
    end

    Qbox.GetPlayer = ESX.GetPlayerFromId

    function ESX.RegisterServerCallback(name, handler)
        lib.callback.register(name, function(source, ...)
            local result
            local done = false
            handler(source, function(value)
                result = value
                done = true
            end, ...)
            while not done do Wait(0) end
            return result
        end)
    end

    function ESX.RegisterUsableItem(item, handler)
        qbx:CreateUseableItem(item, function(source)
            handler(source)
        end)
    end

    function ESX.RegisterCommand(_, _, handler)
        lib.addCommand('jailmenu', { help = 'Abrir menú de prisión', restricted = 'group.admin' }, function(source)
            handler(ESX.GetPlayerFromId(source), {}, function() end)
        end)
    end
else
    ESX = { PlayerData = {}, UI = { Menu = {} }, Game = {} }

    function ESX.Game.GetPeds(ignore)
        local ignored = {}
        for _, ped in ipairs(ignore or {}) do ignored[ped] = true end
        local peds = {}
        for _, ped in ipairs(GetGamePool('CPed')) do
            if not ignored[ped] then peds[#peds + 1] = ped end
        end
        return peds
    end

    function ESX.Game.GetClosestPlayer()
        local closest, distance = -1, -1
        local coords = GetEntityCoords(PlayerPedId())
        for _, player in ipairs(GetActivePlayers()) do
            if player ~= PlayerId() then
                local dist = #(coords - GetEntityCoords(GetPlayerPed(player)))
                if distance == -1 or dist < distance then
                    closest, distance = player, dist
                end
            end
        end
        return closest, distance
    end

    function ESX.GetPlayerData()
        return QBX and QBX.PlayerData or ESX.PlayerData
    end

    function ESX.TriggerServerCallback(name, callback, ...)
        lib.callback(name, false, callback, ...)
    end

    local menus = {}

    function ESX.UI.Menu.CloseAll()
        menus = {}
        lib.hideContext()
    end

    function ESX.UI.Menu.Open(menuType, _, name, data, submit, cancel)
        if menuType == 'dialog' then
            local result = lib.inputDialog(data.title or 'Entrada', {{ type = 'input', label = data.title or 'Valor' }})
            if result then submit({ value = result[1] }, { close = function() end }) else cancel({}, { close = function() end }) end
            return
        end

        local menu = { close = function() menus[name] = nil; lib.hideContext() end }
        menus[name] = menu
        local options = {}
        for _, element in ipairs(data.elements or {}) do
            options[#options + 1] = {
                title = element.label,
                onSelect = function() submit({ current = element }, menu) end
            }
        end
        lib.registerContext({ id = 'fixlife_prision_' .. name, title = data.title or name, options = options })
        lib.showContext('fixlife_prision_' .. name)
    end

    CreateThread(function()
        while not QBX or not QBX.PlayerData or not QBX.PlayerData.job do Wait(100) end
        ESX.PlayerData = QBX.PlayerData
        ESX.Player = ESX.PlayerData
    end)

    RegisterNetEvent('qbx_core:client:onJobUpdate', function(job)
        ESX.PlayerData.job = job
        ESX.Player = ESX.PlayerData
        TriggerEvent('esx:setJob', job)
    end)
end
