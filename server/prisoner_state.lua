RegisterServerEvent('HD_Jail:UpdateClothes')
AddEventHandler('HD_Jail:UpdateClothes', function(numie)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or not IsPrisoner(source, xPlayer) or type(numie) ~= 'table' or #json.encode(numie) > 10000 then return end

    JailStorage.Get(xPlayer.identifier, function(newData)
        newData.clothes = numie
        JailStorage.Save(xPlayer.identifier, newData)
	end)
end)

RegisterServerEvent('HD_Jail:Ate')
AddEventHandler('HD_Jail:Ate', function()
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or not IsPrisoner(source, xPlayer) or not IsNearPoint(source, Config.GetFoodLoc.Loc, 2.0) or not CheckCooldown(source, 'eat', 3000) then return end
    local currentHunger = exports.qbx_core:GetMetadata(source, 'hunger') or 0
    local currentThirst = exports.qbx_core:GetMetadata(source, 'thirst') or 0
    exports.qbx_core:SetMetadata(source, 'hunger', math.min(100, currentHunger + math.floor(Config.FoodAmt / 10000)))
    exports.qbx_core:SetMetadata(source, 'thirst', math.min(100, currentThirst + math.floor(Config.DrinkAmt / 10000)))
end)

RegisterServerEvent('HD_Jail:UnBreak')
AddEventHandler('HD_Jail:UnBreak', function(id)
    local eventSource = tonumber(source) or 0
    if eventSource > 0 and eventSource ~= 65535 and tonumber(id) ~= eventSource then return end
    local xPlayer = Qbox.GetPlayer(id)
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
        if Config.FailBreakToSol and Config.Solitary then
            TriggerEvent('HD_Jail:SendToSol', id, Config.SolBreakTime, Config.Sayings[108])
        else
            TriggerClientEvent('HD_Jail:UnBreak2', id)
        end
    end
end)

RegisterServerEvent('HD_Jail:RetrieveItems')
AddEventHandler('HD_Jail:RetrieveItems', function(itoms)
    local src = source
    local xPlayer = Qbox.GetPlayer(src)
    if not xPlayer then return end

    JailStorage.Get(xPlayer.identifier, function(newData)
        if (tonumber(newData.jailtime) or 0) > 0 then return end

        local remaining = {}
        for _, item in ipairs(newData.items or {}) do
            local amount = math.floor(tonumber(item.Amt or item.amount or item.amt or item.count) or 0)
            if type(item.item) == 'string' and amount > 0 then
                local success, response = exports.ox_inventory:AddItem(src, item.item, amount, item.metadata)
                if not success then
                    remaining[#remaining + 1] = item
                    print(('[Fixlife_prision] No se pudo devolver %sx %s al jugador %s: %s'):format(amount, item.item, src, response or 'sin respuesta'))
                end
            end
        end
        newData.items = remaining
        JailStorage.Save(xPlayer.identifier, newData)
    end)
end)

RegisterServerEvent('HD_Jail:SetJob')
AddEventHandler('HD_Jail:SetJob', function(jobii, flip)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer or not IsPrisoner(source, xPlayer) or (jobii ~= 0 and not Config.JobOptions[jobii]) then return end
    local ident = xPlayer.identifier
    local found1 = 0
    local found2 = 0
    local id = nil

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    id = inJail[i].Players[j].ID
                end
            end
        end
    end

    JailStorage.Get(xPlayer.identifier, function(newData)

        if Log.Job and flip then
            local jobzo = nil
            local jobbo = nil
            if newData.job ~= 0 then
                jobzo = Config.JobOptions[newData.job].Name
            else
                jobzo = Config.Sayings[16]
            end
            if jobii ~= 0 then
                jobbo = Config.JobOptions[jobii].Name
            else
                jobbo = Config.Sayings[16]
            end
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
                    ["name"] = "**Old Job:**",
                    ["value"] = jobzo,
                    ["inline"] = true
                },
                {
                    ["name"] = "**New Job:**",
                    ["value"] = jobbo,
                    ["inline"] = true
                }
            }
            sendToDiscord(this, 65412, "Player Job Change")
        end

        newData.job = jobii
        JailStorage.Save(xPlayer.identifier, newData)
	end)
end)

RegisterServerEvent('HD_Jail:TaskComplete')
AddEventHandler('HD_Jail:TaskComplete', function(taskJob, taskIndex)
    local xPlayer = Qbox.GetPlayer(source)
    taskJob = tonumber(taskJob)
    taskIndex = tonumber(taskIndex)
    local jobData = Config.JobOptions[taskJob]
    local taskData = jobData and jobData.Tasks[taskIndex]
    local ped = GetPlayerPed(source)
    if not xPlayer or not IsPrisoner(source, xPlayer) or xPlayer.job.name ~= 'prisoner' or not HasPrisonJob(source, taskJob, xPlayer) or not CheckCooldown(source, 'task', 1500) or not taskData or ped <= 0 then return end

    local taskCoords = taskData.TaskLoc and taskData.TaskLoc.Loc
    if not taskCoords or #(GetEntityCoords(ped) - taskCoords) > 6.0 then return end
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

        if Log.Job then
            local yur = inJail[found1].Players[found2].Timie - Config.JobOptions[taskJob].TimeRemove

            if Config.SimpleTime then
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(xPlayer.source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = xPlayer.source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Job:**",
                        ["value"] = Config.JobOptions[taskJob].Name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Current Time:**",
                        ["value"] = inJail[found1].Players[found2].Timie..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Being Removed:**",
                        ["value"] = Config.JobOptions[taskJob].TimeRemove..' (seconds)',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**New Time:**",
                        ["value"] = yur..' (seconds)',
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 65480, "Job Task Complete")
            else
                local this = {
                    {
                        ["name"] = "**Player Name:**",
                        ["value"] = GetPlayerName(xPlayer.source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player ID:**",
                        ["value"] = xPlayer.source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player Identifier:**",
                        ["value"] = ident,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Job:**",
                        ["value"] = Config.JobOptions[taskJob].Name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Current Time:**",
                        ["value"] = GetGoodTime(inJail[found1].Players[found2].Timie),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Time Being Removed:**",
                        ["value"] = GetGoodTime(Config.JobOptions[taskJob].TimeRemove),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**New Time:**",
                        ["value"] = GetGoodTime(yur),
                        ["inline"] = true
                    }
                }
                sendToDiscord(this, 65480, "Job Task Complete")
            end
        end

        inJail[found1].Players[found2].Timie = inJail[found1].Players[found2].Timie - Config.JobOptions[taskJob].TimeRemove
        JailStorage.Get(ident, function(newData)
            newData.jailtime = inJail[found1].Players[found2].Timie
            JailStorage.Save(ident, newData)
        end)
    end
end)


RegisterServerEvent('HD_Jail:PlayerDie')
