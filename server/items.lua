Qbox.RegisterUsableItem('hd_Shank', function(source)
    local xPlayer = Qbox.GetPlayer(source)

    if Config.ShankAllowed then
        if Config.ShankItem then
            TriggerClientEvent('HD_Jail:ShankPull', source)
        else
            TriggerClientEvent('HD_Jail:GiveShankie', source)
            xPlayer.removeInventoryItem('hd_Shank', 1)
        end
    end
end)

Qbox.RegisterUsableItem('hd_booze', function(source)
    local xPlayer = Qbox.GetPlayer(source)

    if Config.BoozeAllowed then
        if Config.BoozeEffect then
            TriggerClientEvent('HD_Jail:TakeBooze', source)
        end
        addNeeds(source, 'thirst', Config.BoozeGive)
        TriggerClientEvent('HD_Jail:SendNotif', source, Config.Sayings[163])
        xPlayer.removeInventoryItem('hd_booze', 1)
    else
        TriggerClientEvent('HD_Jail:SendNotif', source, Config.Sayings[162])
    end
end)

Qbox.RegisterUsableItem('hd_pPunch', function(source)
    local xPlayer = Qbox.GetPlayer(source)

    if Config.PunchAllowed then
        addNeeds(source, 'thirst', Config.PunchGive)
        addNeeds(source, 'hunger', Config.PunchGive)
        TriggerClientEvent('HD_Jail:SendNotif', source, Config.Sayings[164])
        xPlayer.removeInventoryItem('hd_pPunch', 1)
    else
        TriggerClientEvent('HD_Jail:SendNotif', source, Config.Sayings[162])
    end
end)
local function addNeeds(source, need, amount)
    local current = exports.qbx_core:GetMetadata(source, need) or 0
    exports.qbx_core:SetMetadata(source, need, math.min(100, current + math.floor(amount / 10000)))
end
