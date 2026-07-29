Qbox.RegisterCallback('HD_Jail:GetCell', function(source, cb)
    local xPlayer = Qbox.GetPlayer(source)
    if not xPlayer then cb(0); return end
    local ident = xPlayer.identifier
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

    cb(found)
end)

Qbox.RegisterCallback('HD_Jail:CheckID', function(source, cb, id)
    if not CheckUser(source, 'jail') then cb(false); return end
    local xPlayer = Qbox.GetPlayer(id)
    if xPlayer ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

Qbox.RegisterCallback('HD_Jail:GetPlayerInCell', function(source, cb, cell)
    local goodShit = {}
    local seen = {}
    if not CheckUser(source, 'jail') then cb(goodShit); return end
    cell = math.floor(tonumber(cell) or 0)
    if not inJail[cell] then cb(goodShit); return end
    for j = 1, #inJail[cell].Players, 1 do
        local xPlayer = Qbox.GetPlayer(inJail[cell].Players[j].ID)
        if xPlayer and not seen[xPlayer.source] then
            seen[xPlayer.source] = true
            local fullname = xPlayer.get("firstName") .. " " .. xPlayer.get("lastName")
            table.insert(goodShit, {name = fullname, id = inJail[cell].Players[j].ID})
        end
    end
    cb(goodShit)
end)


