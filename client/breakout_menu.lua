function OpenBreakMenu()
	local ped = PlayerPedId()
	local element = {
		[1] = {label = Config.Sayings[72], value = 'room'},
		[2] = {label = Config.Sayings[73], value = 'wall1'},
		[3] = {label = Config.Sayings[74], value = 'wall2'}
	}

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'Break_Menu2', {
		title    = Config.Sayings[71],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		OpenBreak2Menu(data.current.value)
	end, function(data, menu)
		menu.close()
		OpenInfoMenu()
	end)
end

function OpenBreak2Menu(vali)
	local ped = PlayerPedId()
	local element = {}
	local tit = nil

	if vali == 'room' then
		tit = Config.Sayings[72]
	elseif vali == 'wall1' then
		tit = Config.Sayings[73]
	else
		tit = Config.Sayings[74]
	end

	table.insert(element, {label = Config.Sayings[75], value = 'desc'})
	table.insert(element, {label = Config.Sayings[76], value = 'tools'})

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'Break_Menu3', {
		title    = tit,
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		if data.current.value == 'desc' then
			if vali == 'room' then
				Notification(Config.Sayings[77])
			elseif vali == 'wall1' then
				Notification(Config.Sayings[78])
			else
				Notification(Config.Sayings[79])
			end
		else
			OpenBreak3Menu(vali)
		end
	end, function(data, menu)
		menu.close()
		OpenBreakMenu()
	end)
end

function OpenBreak3Menu(vali)
	local ped = PlayerPedId()
	local element = {}

	if vali == 'wall1' then
		for i = 1, #Config.FenceTool, 1 do 
			table.insert(element, {label = Config.FenceTool[i].Name, value = i})
		end
	else
		for i = 1, #Config.RoomTools, 1 do 
			table.insert(element, {label = Config.RoomTools[i].Name, value = i})
		end
	end

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'Break_Men4', {
		title    = Config.Sayings[76],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		OpenBreak4Menu(vali, data.current.value)
	end, function(data, menu)
		menu.close()
		OpenBreak2Menu(vali)
	end)
end

function OpenBreak4Menu(vali, numy)
	local ped = PlayerPedId()
	local element = {}
	local tit = nil

	if vali == 'wall1' then
		tit = Config.FenceTool[numy].Name
		local per = Config.FenceTool[numy].Percent *10
		table.insert(element, {label = Config.Sayings[80]..Config.FenceTool[numy].Time..Config.Sayings[81], value = 'time'})
		table.insert(element, {label = Config.Sayings[82]..per..'%', value = 'percent'})
	else
		tit = Config.RoomTools[numy].Name
		local per = Config.RoomTools[numy].Percent *10
		table.insert(element, {label = Config.Sayings[80]..Config.RoomTools[numy].Time..Config.Sayings[81], value = 'time'})
		table.insert(element, {label = Config.Sayings[82]..per..'%', value = 'percent'})
	end

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'Break_Men5', {
		title    = tit,
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
	end, function(data, menu)
		menu.close()
		OpenBreak3Menu(vali)
	end)
end

