local targetZones = {}

function CreatePrisonTargets(cell)
    local data = Config.Cells[cell]
    if not data then return end

    targetZones[#targetZones + 1] = exports.ox_target:addSphereZone({
        coords = data.BreakLoc.Loc,
        radius = 0.5,
        options = {{
            name = 'fixlife_prision_cavar_celda_' .. cell,
            label = 'Forzar inodoro',
            icon = 'fa-solid fa-toilet',
            distance = 3.0,
            canInteract = function()
                return injail and jailCell == cell and not using and not isDead and not breakout2
            end,
            onSelect = function()
                StartToiletEscape()
            end
        }}
    })
end

function RemovePrisonTargets()
    for i = #targetZones, 1, -1 do
        exports.ox_target:removeZone(targetZones[i])
        targetZones[i] = nil
    end
end
