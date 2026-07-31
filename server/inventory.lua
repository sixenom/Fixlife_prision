RegisterNetEvent('HD_Jail:OpenBedInventory')
AddEventHandler('HD_Jail:OpenBedInventory', function()
    local src = source
    local xPlayer = exports.qbx_core:GetPlayer(src)
    if not xPlayer then return end
    local _, cell = GetJailedPlayer(src, xPlayer)
    if not cell or not IsNearPoint(src, Config.Cells[cell].InvLoc.Loc, 3.0) then return end

    JailStorage.Get(xPlayer.PlayerData.citizenid, function(data)
        if (tonumber(data.jailtime) or 0) <= 0 then return end

        local stashId = ('fixlife_bed_%s'):format(xPlayer.PlayerData.citizenid)
        exports.ox_inventory:RegisterStash(stashId, 'Cama de prisión', 30, 100000, xPlayer.PlayerData.citizenid)
        TriggerClientEvent('HD_Jail:OpenBedInventory', src, stashId, xPlayer.PlayerData.citizenid)
    end)
end)

RegisterNetEvent('HD_Jail:OpenPoliceBedInventory')
AddEventHandler('HD_Jail:OpenPoliceBedInventory', function(targetId)
    local src = source
    if not CheckUser(src, 'jail') then return end
    local target = exports.qbx_core:GetPlayer(tonumber(targetId))
    if not target then return end
    local _, cell = GetJailedPlayer(target.PlayerData.source, target)
    if not cell or not IsNearPoint(src, Config.Cells[cell].InvLoc.Loc, 3.0) then return end

    local data = awaitStorage(target.PlayerData.citizenid)
    if (tonumber(data.jailtime) or 0) <= 0 then return end
    local stashId = ('fixlife_bed_%s'):format(target.PlayerData.citizenid)
    exports.ox_inventory:RegisterStash(stashId, 'Cama de prision', 30, 100000, target.PlayerData.citizenid)
    exports.ox_inventory:forceOpenInventory(src, 'stash', stashId)
    TriggerClientEvent('HD_Jail:TrackBedInventory', src)
end)

lib.callback.register('HD_Jail:GetChest', function(source)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer then return {} end

    local newData = awaitStorage(xPlayer.PlayerData.citizenid)
    local tablie = {}
    for i=1, #newData.chest, 1 do
        for j=1, #Items, 1 do
            if Items[j].name == newData.chest[i].item then
                table.insert(tablie, {itemName = Items[j].label, amt = newData.chest[i].amt, ite = newData.chest[i].item})
            end
        end
    end
    return tablie
end)

lib.callback.register('HD_Jail:GetChest2', function(source, id)
    if not CheckUser(source, 'jail') then return {} end
    local xPlayer = exports.qbx_core:GetPlayer(id)
    if not xPlayer then return {} end
    local _, cell = GetJailedPlayer(xPlayer.PlayerData.source, xPlayer)
    if not cell or not IsNearPoint(source, Config.Cells[cell].InvLoc.Loc, 3.0) then return {} end

    local newData = awaitStorage(xPlayer.PlayerData.citizenid)
    local tablie = {}
    for i=1, #newData.chest, 1 do
        for j=1, #Items, 1 do
            if Items[j].name == newData.chest[i].item then
                table.insert(tablie, {itemName = Items[j].label, amt = newData.chest[i].amt, ite = newData.chest[i].item})
            end
        end
    end
    return tablie
end)

lib.callback.register('HD_Jail:GrabInfoLoc', function()
	return infoPedLocie
end)

lib.callback.register('HD_Jail:CheckID2', function(source, id)
    local xPlayer = exports.qbx_core:GetPlayer(id)
    local cert = nil
    if xPlayer ~= nil then
        cert = xPlayer.PlayerData.citizenid
    end
    local found1 = 0
    local found2 = 0

    if cert ~= nil then
        for i = 1, #inJail, 1 do
            if inJail[i].Players[1] ~= nil then
                for j = 1, #inJail[i].Players, 1 do
                    if inJail[i].Players[j].Player == cert then
                        found1 = i
                        found2 = j
                    end
                end
            end
        end
    end

    if found1 ~= 0 then
        return true
    else
        return false
    end
end)

lib.callback.register('HD_Jail:GetInventory', function(source)
	local xPlayer    = exports.qbx_core:GetPlayer(source)
	if not xPlayer then return {items = {}} end
	local items      = exports.ox_inventory:GetInventoryItems(source) or {}

	return {items = items}
end)

RegisterServerEvent('HD_Jail:RemoveItem')
AddEventHandler('HD_Jail:RemoveItem', function(items, amti, namo, idie)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    amti = math.floor(tonumber(amti) or 0)
    local _, cell = xPlayer and GetJailedPlayer(source, xPlayer)
    if not xPlayer or not cell or not IsNearPoint(source, Config.Cells[cell].InvLoc.Loc, 3.0) or type(items) ~= 'string' or amti <= 0 or not exports.ox_inventory:CanCarryItem(xPlayer.PlayerData.source, items, amti) then return end

    JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
        local removie = {}
        local removed = false
        for i=1, #newData.chest, 1 do
            if newData.chest[i].item == items then
                if newData.chest[i].amt < amti then return end
                newData.chest[i].amt = newData.chest[i].amt - amti
                removed = true
                if newData.chest[i].amt == 0 then table.insert(removie, i) end
            end
        end
        if not removed then return end

        if Log.Bed then
            local sugg = nil
            for i=1, #newData.chest, 1 do
                if newData.chest[i].item == items then
                    sugg = newData.chest[i].amt
                end
            end
            local this = {
                {
                    ["name"] = "**Player Name:**",
                    ["value"] = GetPlayerName(idie),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player ID:**",
                    ["value"] = idie,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player Identifier:**",
                    ["value"] = xPlayer.PlayerData.citizenid,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Item Being Removed:**",
                    ["value"] = amti..'x '..namo,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Amount Of That Item Left Under Bed:**",
                    ["value"] = sugg,
                    ["inline"] = true
                }
            }
            sendToDiscord(this, 15597823, "Player Removing Item From Under Bed")
        end

        exports.ox_inventory:AddItem(xPlayer.PlayerData.source, items, amti)
        if removie[1] ~= nil then
            for i=1, #removie, 1 do
                table.remove(newData.chest, removie[i])
            end
        end
        removie = {}
        JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
    end)
end)

RegisterServerEvent('HD_Jail:RemoveItem2')
AddEventHandler('HD_Jail:RemoveItem2', function(items, amti, namo, idie)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    local xTarget = exports.qbx_core:GetPlayer(idie)
    amti = math.floor(tonumber(amti) or 0)
    local _, cell = xTarget and GetJailedPlayer(xTarget.PlayerData.source, xTarget)
    if not Config.PoliceCanSearchInv or not CheckUser(source, 'jail') or not xPlayer or not xTarget or not cell or not IsNearPoint(source, Config.Cells[cell].InvLoc.Loc, 3.0) or type(items) ~= 'string' or amti <= 0 or not exports.ox_inventory:CanCarryItem(xPlayer.PlayerData.source, items, amti) then return end

    JailStorage.Get(xTarget.PlayerData.citizenid, function(newData)
        local removie = {}
        local removed = false
        for i=1, #newData.chest, 1 do
            if newData.chest[i].item == items then
                if newData.chest[i].amt < amti then return end
                newData.chest[i].amt = newData.chest[i].amt - amti
                removed = true
                if newData.chest[i].amt == 0 then table.insert(removie, i) end
            end
        end
        if not removed then return end

        exports.ox_inventory:AddItem(xPlayer.PlayerData.source, items, amti)
        if removie[1] ~= nil then
            for i=1, #removie, 1 do
                table.remove(newData.chest, removie[i])
            end
        end
        removie = {}
        JailStorage.Save(xTarget.PlayerData.citizenid, newData)
    end)
end)

RegisterServerEvent('HD_Jail:AddItem')
AddEventHandler('HD_Jail:AddItem', function(items, amti, namo, idie)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    local found = 0

    amti = math.floor(tonumber(amti) or 0)
    local _, cell = xPlayer and GetJailedPlayer(source, xPlayer)
    local owned = xPlayer and (exports.ox_inventory:GetItem(xPlayer.PlayerData.source, items, nil, true) or 0) or 0
    if not xPlayer or not cell or not IsNearPoint(source, Config.Cells[cell].InvLoc.Loc, 3.0) or type(items) ~= 'string' or amti <= 0 or amti > owned then return end

    JailStorage.Get(xPlayer.PlayerData.citizenid, function(newData)
        for i=1, #newData.chest, 1 do
            if newData.chest[i].item == items then
                found = i
            end
        end
        if found == 0 then
            table.insert(newData.chest, {item = items, amt = amti})
        else
            newData.chest[found].amt = newData.chest[found].amt + amti
        end
        exports.ox_inventory:RemoveItem(xPlayer.PlayerData.source, items, amti)
        if Log.Bed then
            local sugg = nil
            for i=1, #newData.chest, 1 do
                if newData.chest[i].item == items then
                    sugg = newData.chest[i].amt
                end
            end
            local shitie = {
                {
                    ["name"] = "**Player Name:**",
                    ["value"] = GetPlayerName(idie),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player ID:**",
                    ["value"] = idie,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Player Identifier:**",
                    ["value"] = xPlayer.PlayerData.citizenid,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Item Being Added:**",
                    ["value"] = amti..'x '..namo,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Amount Of That Item Under Bed:**",
                    ["value"] = sugg,
                    ["inline"] = true
                }
            }
            sendToDiscord(shitie, 16515951, "Player Putting Item Under Bed")
        end
        JailStorage.Save(xPlayer.PlayerData.citizenid, newData)
    end)
end)

local function awaitStorage(citizenid)
    local promise = promise.new()
    JailStorage.Get(citizenid, function(data) promise:resolve(data) end)
    return Citizen.Await(promise)
end
