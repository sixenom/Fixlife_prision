local qbx = exports.qbx_core

JailStorage = { Default = { cell = 0, solcell = 0, chest = {}, jailtime = 0, items = {}, clothes = {}, job = 0, breaks = 0, soli = 0, jobo = 'nil', grade = 0 }, Cache = {}, LastSaved = {}, Gets = {}, Saves = {} }

local function copyStorage(data)
    return json.decode(json.encode(data))
end

local function mergeStorage(base, localData, remote)
    local merged, keys = {}, {}
    for key in pairs(base or {}) do keys[key] = true end
    for key in pairs(localData or {}) do keys[key] = true end
    for key in pairs(remote or {}) do keys[key] = true end

    for key in pairs(keys) do
        local baseValue, localValue, remoteValue = base and base[key], localData and localData[key], remote and remote[key]
        local localIsBase = json.encode(localValue) == json.encode(baseValue)
        local remoteIsBase = json.encode(remoteValue) == json.encode(baseValue)
        merged[key] = localIsBase and remoteValue or remoteIsBase and localValue or localValue
    end
    return merged
end

function JailStorage.Get(citizenid, callback)
    local cached = JailStorage.Cache[citizenid]
    if cached then callback(copyStorage(cached)); return end

    if JailStorage.Gets[citizenid] then
        JailStorage.Gets[citizenid][#JailStorage.Gets[citizenid] + 1] = callback
        return
    end
    JailStorage.Gets[citizenid] = {callback}

    MySQL.Async.fetchAll('SELECT hdjail_data FROM players WHERE citizenid = @citizenid', { ['@citizenid'] = citizenid }, function(result)
        local row = result and result[1]
        local data = row and row.hdjail_data and json.decode(row.hdjail_data) or copyStorage(JailStorage.Default)
        JailStorage.Cache[citizenid] = JailStorage.Cache[citizenid] or data
        if not JailStorage.Saves[citizenid] then
            JailStorage.LastSaved[citizenid] = json.encode(JailStorage.Cache[citizenid])
        end
        local callbacks = JailStorage.Gets[citizenid]
        JailStorage.Gets[citizenid] = nil
        for i = 1, #callbacks do callbacks[i](copyStorage(JailStorage.Cache[citizenid])) end
    end)
end

local function saveNext(citizenid)
    local state = JailStorage.Saves[citizenid]
    if not state or state.active then return end

    local entry = table.remove(state.queue, 1)
    if not entry then JailStorage.Saves[citizenid] = nil; return end
    state.active = true

    local query = 'UPDATE players SET hdjail_data = @hdjail_data WHERE citizenid = @citizenid'
    local params = { ['@citizenid'] = citizenid, ['@hdjail_data'] = entry.encoded }
    if entry.previous then
        query = query .. ' AND hdjail_data = @previous_data'
        params['@previous_data'] = entry.previous
    end

    MySQL.Async.execute(query, params, function(affectedRows)
        if entry.previous and affectedRows ~= 1 then
            local pending = state.queue
            local last = pending[#pending]
            local localEncoded = last and last.encoded or entry.encoded
            local callbacks = entry.callbacks
            for i = 1, #pending do
                for j = 1, #pending[i].callbacks do callbacks[#callbacks + 1] = pending[i].callbacks[j] end
            end
            state.queue = {}
            if (entry.retries or 0) >= 3 then
                print(('[Fixlife_prision] Conflicto de persistencia repetido para %s; se canceló el reintento.'):format(citizenid))
                JailStorage.Cache[citizenid] = nil
                JailStorage.LastSaved[citizenid] = nil
                state.active = false
                JailStorage.Saves[citizenid] = nil
                for i = 1, #callbacks do callbacks[i](0) end
                return
            end

            MySQL.Async.fetchAll('SELECT hdjail_data FROM players WHERE citizenid = @citizenid', { ['@citizenid'] = citizenid }, function(result)
                local row = result and result[1]
                local remoteEncoded = row and row.hdjail_data
                local remote = remoteEncoded and json.decode(remoteEncoded)
                if not remote then
                    print(('[Fixlife_prision] No se pudo fusionar el estado externo de %s.'):format(citizenid))
                    state.active = false
                    JailStorage.Saves[citizenid] = nil
                    for i = 1, #callbacks do callbacks[i](0) end
                    return
                end

                local base = json.decode(entry.previous) or JailStorage.Default
                local localData = json.decode(localEncoded) or JailStorage.Default
                local merged = mergeStorage(base, localData, remote)
                local mergedEncoded = json.encode(merged)
                JailStorage.Cache[citizenid] = copyStorage(merged)
                JailStorage.LastSaved[citizenid] = remoteEncoded
                state.queue[1] = {encoded = mergedEncoded, previous = remoteEncoded, retries = (entry.retries or 0) + 1, callbacks = callbacks}
                state.tail = mergedEncoded
                state.active = false
                saveNext(citizenid)
            end)
            return
        end
        JailStorage.LastSaved[citizenid] = entry.encoded
        state.active = false
        for i = 1, #entry.callbacks do entry.callbacks[i](affectedRows) end
        saveNext(citizenid)
    end)
end

function JailStorage.Save(citizenid, data, callback)
    local encoded = json.encode(data)
    JailStorage.Cache[citizenid] = json.decode(encoded)
    if JailStorage.LastSaved[citizenid] == encoded then
        if callback then callback(0) end
        return
    end

    local state = JailStorage.Saves[citizenid]
    if not state then
        state = {active = false, queue = {}, tail = JailStorage.LastSaved[citizenid]}
        JailStorage.Saves[citizenid] = state
    end
    local last = state.queue[#state.queue]
    if last and last.encoded == encoded then
        if callback then last.callbacks[#last.callbacks + 1] = callback end
        return
    end
    local previous = state.tail or JailStorage.LastSaved[citizenid]
    state.queue[#state.queue + 1] = {encoded = encoded, previous = previous, retries = 0, callbacks = callback and {callback} or {}}
    state.tail = encoded
    saveNext(citizenid)
end

CreateThread(function()
    if not qbx:GetJob('prisoner') then qbx:CreateJob('prisoner', { label = 'Prisoner', type = 'none', defaultDuty = true, offDutyPay = false, grades = { [0] = { name = 'Inmate', payment = 0 } } }) end
end)

function GetRandomCell(cells, maxPlayers)
    local available = {}
    for i, cell in ipairs(cells) do
        if #cell.Players < maxPlayers then available[#available + 1] = i end
    end
    if #available == 0 then
        for i = 1, #cells do available[i] = i end
    end
    return available[math.random(#available)]
end

function RemovePlayerFromCells(cells, identifier)
    for i = #cells, 1, -1 do
        for j = #cells[i].Players, 1, -1 do
            if cells[i].Players[j].Player == identifier then
                table.remove(cells[i].Players, j)
            end
        end
    end
end
