exports.ox_target:addSphereZone({
        coords = vector3(-2311.2600, 348.1845, 178.5717),
        radius = 0.3,
        debug = false,
        options = {
            {
            name = 'prision',
            distance = 1,
            label = 'Menu De Prisoneros',
            icon = "fa-solid fa-handcuffs",
            onSelect = function()
                TriggerEvent('HD_Jail:JailMenu')
            end
            }
        }
})
