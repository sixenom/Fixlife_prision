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
    local xPlayer = Qbox.GetPlayer(id)
    if xPlayer ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

Qbox.RegisterCallback('HD_Jail:GetPlayerInCell', function(source, cb, cell)
    local goodShit = {}
    if not inJail[cell] then cb(goodShit); return end
    for j = 1, #inJail[cell].Players, 1 do
        local xPlayer = Qbox.GetPlayer(inJail[cell].Players[j].ID)
        if xPlayer then
            local fullname = nil
            if Config.ESXVersion ~= '1.1' then
                fullname = xPlayer.get("firstName") .. " " .. xPlayer.get("lastName")
            else
                fullname = GetPlayerName(xPlayer.source)
            end
            table.insert(goodShit, {name = fullname, id = inJail[cell].Players[j].ID})
        end
    end
    cb(goodShit)
end)


