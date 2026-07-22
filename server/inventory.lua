Qbox.RegisterCallback('HD_Jail:GetChest', function(source, cb)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then cb({}); return end

    JailStorage.Get(xPlayer.identifier, function(newData)
        local tablie = {}
        for i=1, #newData.chest, 1 do
            for j=1, #Items, 1 do
                if Items[j].name == newData.chest[i].item then
                    table.insert(tablie, {itemName = Items[j].label, amt = newData.chest[i].amt, ite = newData.chest[i].item})
                end
            end
        end
        cb(tablie)
    end)
end)

Qbox.RegisterCallback('HD_Jail:GetChest2', function(source, cb, id)
    if not CheckUser(source, 'jail') then cb({}); return end
    local xPlayer = Qbox.GetPlayer(id)
    if not xPlayer then cb({}); return end

    JailStorage.Get(xPlayer.identifier, function(newData)
        local tablie = {}
        for i=1, #newData.chest, 1 do
            for j=1, #Items, 1 do
                if Items[j].name == newData.chest[i].item then
                    table.insert(tablie, {itemName = Items[j].label, amt = newData.chest[i].amt, ite = newData.chest[i].item})
                end
            end
        end
        cb(tablie)
    end)
end)

Qbox.RegisterCallback('HD_Jail:GrabInfoLoc', function(source, cb)
    local xPlayer = Qbox.GetPlayer(source)

    cb(infoPedLocie)
end)

Qbox.RegisterCallback('HD_Jail:CheckID2', function(source, cb, id)
    local xPlayer = Qbox.GetPlayer(id)
    local cert = nil
    if xPlayer ~= nil then
        cert = xPlayer.identifier
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
        cb(true)
    else
        cb(false)
    end
end)

Qbox.RegisterCallback('HD_Jail:GetInventory', function(source, cb)
	local xPlayer    = Qbox.GetPlayer(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

RegisterServerEvent('HD_Jail:RemoveItem')
AddEventHandler('HD_Jail:RemoveItem', function(items, amti, namo, idie)
    local xPlayer = Qbox.GetPlayer(source)
    amti = math.floor(tonumber(amti) or 0)
    if not xPlayer or amti <= 0 then return end

    JailStorage.Get(xPlayer.identifier, function(newData)
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
                    ["value"] = xPlayer.identifier,
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

        xPlayer.addInventoryItem(items, amti)
        if removie[1] ~= nil then
            for i=1, #removie, 1 do
                table.remove(newData.chest, removie[i])
            end
        end
        removie = {}
        JailStorage.Save(xPlayer.identifier, newData)
    end)
end)

RegisterServerEvent('HD_Jail:RemoveItem2')
AddEventHandler('HD_Jail:RemoveItem2', function(items, amti, namo, idie)
    local xPlayer = Qbox.GetPlayer(source)
    local xTarget = Qbox.GetPlayer(idie)
    amti = math.floor(tonumber(amti) or 0)
    if not Config.PoliceCanSearchInv or not CheckUser(source, 'jail') or not xPlayer or not xTarget or amti <= 0 then return end

    JailStorage.Get(xTarget.identifier, function(newData)
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

        xPlayer.addInventoryItem(items, amti)
        if removie[1] ~= nil then
            for i=1, #removie, 1 do
                table.remove(newData.chest, removie[i])
            end
        end
        removie = {}
        JailStorage.Save(xTarget.identifier, newData)
    end)
end)

RegisterServerEvent('HD_Jail:AddItem')
AddEventHandler('HD_Jail:AddItem', function(items, amti, namo, idie)
    local xPlayer = Qbox.GetPlayer(source)
    local found = 0

    amti = math.floor(tonumber(amti) or 0)
    local owned = xPlayer and xPlayer.getInventoryItem(items).count or 0
    if amti <= 0 or amti > owned then return end

    JailStorage.Get(xPlayer.identifier, function(newData)
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
        xPlayer.removeInventoryItem(items, amti)
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
                    ["value"] = xPlayer.identifier,
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
        JailStorage.Save(xPlayer.identifier, newData)
    end)
end)

