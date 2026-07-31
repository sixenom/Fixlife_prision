lib.callback.register('HD_Jail:GetCell', function(source)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer then return 0 end
    local ident = xPlayer.PlayerData.citizenid
    local found = 0

    for i = 1, #inJail, 1 do
        if inJail[i].Players[1] ~= nil then
            for j = 1, #inJail[i].Players, 1 do
                if inJail[i].Players[j].Player == ident then
                    found = i
                end
            end
        end
    end

    return found
end)

lib.callback.register('HD_Jail:CheckID', function(source, id)
    if not CheckUser(source, 'jail') then return false end
    local xPlayer = exports.qbx_core:GetPlayer(id)
    return xPlayer ~= nil
end)

lib.callback.register('HD_Jail:GetPlayerInCell', function(source, cell)
    local goodShit = {}
    local seen = {}
    if not CheckUser(source, 'jail') then return goodShit end
    cell = math.floor(tonumber(cell) or 0)
    if not inJail[cell] then return goodShit end
    for j = 1, #inJail[cell].Players, 1 do
        local xPlayer = exports.qbx_core:GetPlayer(inJail[cell].Players[j].ID)
        if xPlayer and not seen[xPlayer.PlayerData.source] then
            seen[xPlayer.PlayerData.source] = true
            local fullname = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
            table.insert(goodShit, {name = fullname, id = inJail[cell].Players[j].ID})
        end
    end
    return goodShit
end)


