AddEventHandler('HD_Jail:PlayerDie', function(trip)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.PlayerData.citizenid
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
        inJail[found1].Players[found2].Dead = trip
        if inJail[found1].Players[found2].Breako > 0 then
            TriggerEvent('HD_Jail:UnBreak', inJail[found1].Players[found2].ID)
        end
    end
end)

RegisterServerEvent('HD_Jail:KilledBy')
AddEventHandler('HD_Jail:KilledBy', function(id)
    local xPlayer = exports.qbx_core:GetPlayer(id)
    if xPlayer then
        local ident = xPlayer.PlayerData.citizenid
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
    
        if found1 ~= 0 and Config.Sol4Kill then
            TriggerEvent('HD_Jail:SendToSol', id, Config.SolKillTime, Config.Sayings[110])
        end
    end
end)


RegisterServerEvent('HD_Jail:UpdateBreak')
AddEventHandler('HD_Jail:UpdateBreak', function()
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.PlayerData.citizenid
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
        inJail[found1].Players[found2].Breako = Config.BreakoutTime

        JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
            newData.breaks = 0
            JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
        end) 
    end
end)

RegisterServerEvent('HD_Jail:UpdateBreaking')
AddEventHandler('HD_Jail:UpdateBreaking', function()
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.PlayerData.citizenid
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
        inJail[found1].Players[found2].Breako = 0
    end
end)

local function IsOutsidePrison(source)
    local ped = GetPlayerPed(source)
    return ped > 0 and #(GetEntityCoords(ped) - Config.JailLoc) > Config.MaxTpDist
end

local function JailDebug(message)
    if Config.DebugJail then print(('[Fixlife_prision][DEBUG][SERVER] %s'):format(message)) end
end

escapeStarted = escapeStarted or {}

RegisterServerEvent('HD_Jail:EscapeStarted')
AddEventHandler('HD_Jail:EscapeStarted', function()
    local src = source
    local xPlayer = exports.qbx_core:GetPlayer(src)
    if not xPlayer or not IsPrisoner(src, xPlayer) then
        JailDebug(('EscapeStarted RECHAZADO src=%s player=%s prisoner=%s'):format(src, tostring(xPlayer ~= nil), tostring(xPlayer and IsPrisoner(src, xPlayer))))
        return
    end

    for i = 1, #inJail do
        for j = 1, #(inJail[i].Players or {}) do
            local prisoner = inJail[i].Players[j]
            if prisoner and prisoner.Player == xPlayer.PlayerData.citizenid then
                escapeStarted[src] = true
                JailDebug(('EscapeStarted OK src=%s citizenid=%s cell=%s Breako=%s'):format(src, xPlayer.PlayerData.citizenid, i, prisoner.Breako or 0))
                return
            end
        end
    end
    JailDebug(('EscapeStarted RECHAZADO src=%s citizenid=%s: no encontrado o Breako=0'):format(src, xPlayer.PlayerData.citizenid))
end)

RegisterServerEvent('HD_Jail:EscapeComplete')
AddEventHandler('HD_Jail:EscapeComplete', function()
    local src = source
    local xPlayer = exports.qbx_core:GetPlayer(src)
    local outside = IsOutsidePrison(src)
    local prisoner = xPlayer and IsPrisoner(src, xPlayer)
    local cooldown = CheckCooldown(src, 'escape', 5000)
    if Config.DebugJail then
        JailDebug(('EscapeComplete src=%s started=%s player=%s prisoner=%s outside=%s cooldown=%s'):format(src, tostring(escapeStarted[src] == true), tostring(xPlayer ~= nil), tostring(prisoner), tostring(outside), tostring(cooldown)))
    end
    if not escapeStarted[src] or not xPlayer or not prisoner or not outside or not cooldown then return end
    escapeStarted[src] = nil

    for i = 1, #inJail do
        local cell = inJail[i]
        for j = 1, #(cell.Players or {}) do
            local prisoner = cell.Players[j]
            if prisoner and prisoner.Player == xPlayer.PlayerData.citizenid then
                JailDebug(('EscapeComplete OK src=%s citizenid=%s; ejecutando UnJailPlayer(false)'):format(src, xPlayer.PlayerData.citizenid))
                TriggerEvent('HD_Jail:UnJailPlayer', src, false)
                return
            end
        end
    end
    JailDebug(('EscapeComplete RECHAZADO src=%s: no encontrado en inJail'):format(src))
end)

RegisterServerEvent('HD_Jail:TaskComplete1')
AddEventHandler('HD_Jail:TaskComplete1', function(taskJob)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer or not IsPrisoner(source, xPlayer) or not HasPrisonJob(source, taskJob, xPlayer) or not CheckCooldown(source, 'steal', 1500) or not Config.JobOptions[taskJob] then return end
    local ident = xPlayer.PlayerData.citizenid

    local ran = math.random(1,10)
    local ranq = 0
    ranq = ran
    if ranq <= Config.JobOptions[taskJob].StealChance then
        local totNims = {}
        local totnums = 0
        for i = 1, #Config.JobOptions[taskJob].StealItems, 1 do
            for x = 1, Config.JobOptions[taskJob].StealItems[i].Chance, 1 do
                table.insert(totNims, {value = i})
            end
        end
        for i = 1, #totNims, 1 do
            totnums = totnums + 1
        end
        if totnums == 0 then return end
        local rannym = math.random(1, totnums)
        local finish = 0 
        finish = rannym

        exports.ox_inventory:AddItem(xPlayer.PlayerData.source, Config.JobOptions[taskJob].StealItems[totNims[finish].value].Item, 1)
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'inform',
            description = Config.Sayings[86]..Config.JobOptions[taskJob].StealItems[totNims[finish].value].Name
        })
    end
end)

RegisterServerEvent('HD_Jail:LoadedIn')
AddEventHandler('HD_Jail:LoadedIn', function()
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer then return end
    local _source = source
    JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
        if newData.jailtime > 0 then
            TriggerEvent('HD_Jail:ReJail', _source, newData)
        end
    end)
end)

