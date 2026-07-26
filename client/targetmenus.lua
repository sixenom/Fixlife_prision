for i, breakLoc in ipairs(Config.BreakLocs) do
    exports.ox_target:addSphereZone({
        coords = breakLoc.StartLoc.Loc,
        radius = 0.5,
        options = {{
            name = 'fixlife_prision_cavar_' .. i,
            label = Config.Sayings[93],
            icon = 'fa-solid fa-person-digging',
            distance = 3.0,
            canInteract = function()
                return injail and not using and not isDead and closestBreak == i and breakout2 and breakout > 0
            end,
            onSelect = function()
                inMenu.coords, inMenu.is = breakLoc.StartLoc.Loc, true
                OpenBreakingMenu()
            end
        }}
    })
end

for cell, data in ipairs(Config.Cells) do
    exports.ox_target:addSphereZone({
        coords = data.BreakLoc.Loc,
        radius = 0.5,
        options = {{
            name = 'fixlife_prision_cavar_celda_' .. cell,
            label = Config.Sayings[93],
            icon = 'fa-solid fa-person-digging',
            distance = 3.0,
            canInteract = function()
                return injail and jailCell == cell and not using and not isDead and not breakout2
            end,
            onSelect = function()
                if breakout3 then
                    BreakOutStart()
                else
                    inMenu.coords, inMenu.is = data.BreakLoc.Loc, true
                    OpenWallMenu()
                end
            end
        }}
    })
end
