exports.qbx_core:CreateUseableItem('cuchillo_improvisado', function(source)

    if Config.ShankAllowed then
        if Config.ShankItem then
            TriggerClientEvent('HD_Jail:ShankPull', source)
        else
            TriggerClientEvent('HD_Jail:GiveShankie', source)
            exports.ox_inventory:RemoveItem(source, 'cuchillo_improvisado', 1)
        end
    end
end)

lib.callback.register('HD_Jail:ConsumeEscapeTool', function(source, item)
    if item ~= 'destornillador' and item ~= 'cizalla' then return false end
    local xPlayer = exports.qbx_core:GetPlayer(source)
    if not xPlayer or not IsPrisoner(source, xPlayer) then return false end
    return exports.ox_inventory:RemoveItem(source, item, 1) == true
end)
