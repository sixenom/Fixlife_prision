AddEventHandler('HD_Jail:PlayerDie', function(trip)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.identifier
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
    local xPlayer = Qbox.GetPlayer(id)
    if xPlayer then
        local ident = xPlayer.identifier
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
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.identifier
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

        JailStorage.Get(xPlayer.identifier, function(newData)
            newData.breaks = 0
            JailStorage.Save(xPlayer.identifier, newData)
        end) 
    end
end)

RegisterServerEvent('HD_Jail:UpdateBreaking')
AddEventHandler('HD_Jail:UpdateBreaking', function()
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local ident = xPlayer.identifier
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

RegisterServerEvent('HD_Jail:TaskComplete1')
AddEventHandler('HD_Jail:TaskComplete1', function(taskJob)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or not Config.JobOptions[taskJob] then return end
    local ident = xPlayer.identifier

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

        xPlayer.addInventoryItem(Config.JobOptions[taskJob].StealItems[totNims[finish].value].Item, 1)
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'inform',
            description = Config.Sayings[86]..Config.JobOptions[taskJob].StealItems[totNims[finish].value].Name
        })
    end
end)

RegisterServerEvent('HD_Jail:LoadedIn')
AddEventHandler('HD_Jail:LoadedIn', function()
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then return end
    local _source = source
    JailStorage.Get(xPlayer.identifier, function(newData)
        if newData.jailtime > 0 then
            TriggerEvent('HD_Jail:ReJail', _source, newData)
        end
    end)
end)

