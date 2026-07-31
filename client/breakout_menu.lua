function OpenBreakMenu()
    local elements = {
        {label = Config.Sayings[72], onSelect = function() OpenBreak2Menu('room') end},
        {label = Config.Sayings[73], onSelect = function() OpenBreak2Menu('wall1') end},
        {label = Config.Sayings[74], onSelect = function() OpenBreak2Menu('wall2') end},
    }
    lib.hideContext()
	lib.registerContext({id = 'fixlife_prision_Break_Menu2', title = Config.Sayings[71], options = {
		{title = elements[1].label, onSelect = elements[1].onSelect},
		{title = elements[2].label, onSelect = elements[2].onSelect},
		{title = elements[3].label, onSelect = elements[3].onSelect},
	}, onExit = OpenInfoMenu})
	lib.showContext('fixlife_prision_Break_Menu2')
end

function OpenBreak2Menu(vali)
    local title = vali == 'room' and Config.Sayings[72] or vali == 'wall1' and Config.Sayings[73] or Config.Sayings[74]
    local elements = {
        {label = Config.Sayings[75], onSelect = function()
            Notification(vali == 'room' and Config.Sayings[77] or vali == 'wall1' and Config.Sayings[78] or Config.Sayings[79])
        end},
        {label = Config.Sayings[76], onSelect = function() OpenBreak3Menu(vali) end},
    }
    lib.hideContext()
	lib.registerContext({id = 'fixlife_prision_Break_Menu3', title = title, options = {
		{title = elements[1].label, onSelect = elements[1].onSelect},
		{title = elements[2].label, onSelect = elements[2].onSelect},
	}, onExit = OpenBreakMenu})
	lib.showContext('fixlife_prision_Break_Menu3')
end

function OpenBreak3Menu(vali)
    local source = vali == 'wall1' and Config.FenceTool or Config.RoomTools
    local elements = {}
    for i = 1, #source do
        local index = i
        elements[#elements + 1] = {label = source[index].Name, onSelect = function() OpenBreak4Menu(vali, index) end}
    end
    lib.hideContext()
	lib.registerContext({id = 'fixlife_prision_Break_Men4', title = Config.Sayings[76], options = elements, onExit = function() OpenBreak2Menu(vali) end})
	lib.showContext('fixlife_prision_Break_Men4')
end

function OpenBreak4Menu(vali, numy)
    local tool = (vali == 'wall1' and Config.FenceTool or Config.RoomTools)[numy]
    local elements = {
        {label = Config.Sayings[80] .. tool.Time .. Config.Sayings[81], onSelect = function() end},
        {label = Config.Sayings[82] .. tool.Percent * 10 .. '%', onSelect = function() end},
    }
    lib.hideContext()
	lib.registerContext({id = 'fixlife_prision_Break_Men5', title = tool.Name, options = elements, onExit = function() OpenBreak3Menu(vali) end})
	lib.showContext('fixlife_prision_Break_Men5')
end
