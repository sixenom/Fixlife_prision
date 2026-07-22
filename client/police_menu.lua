function OpenPoliceShitMenu()
	using = true
	lib.callback('HD_Jail:GetPlayerInCell', false, function(players)
		local ped = PlayerPedId()
		local element = {}
	
		for i = 1, #players, 1 do
			table.insert(element, {label = players[i].name..Config.Sayings[156]..players[i].id, value = players[i].id, namio = players[i].name})
		end

		if element[1] == nil then
			table.insert(element, {label = Config.Sayings[69], value = 'none'})
		end

		NativeMenu.CloseAll()
	
		NativeMenu.Open('default', GetCurrentResourceName(), 'police_shit', {
			title    = Config.Sayings[155],
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if data.current.value ~= 'none' then
				OpenPoliceMenu2(data.current.namio, data.current.value)
			end
		end, function(data, menu)
			menu.close()
			using = false
			inMenu.is = false
			inMenu.coords = nil
		end)
	end, closestPoliceInv)
end

function OpenPoliceMenu2(name, theirID)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()

		RequestAnimDict('mini@repair')
								
		if not HasAnimDictLoaded('mini@repair') then
			LoadAnim('mini@repair')
		end
		SetEntityCoords(ped, Config.Cells[closestPoliceInv].InvLoc.Loc.x, Config.Cells[closestPoliceInv].InvLoc.Loc.y, Config.Cells[closestPoliceInv].InvLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.Cells[closestPoliceInv].InvLoc.Heading)
		TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'mini@repair'
		inAnim.Anim = 'fixing_a_ped'
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)
		lib.progressCircle({ --comiendo
			duration =  Config.OpenCloseTime *1000,
			label =  Config.Sayings[35],
			position = 'bottom',
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
				move = true,
				combat = true,
				mouse = false,
			},
		})
		-- Citizen.Wait(Config.OpenCloseTime *1000)
	
		lib.callback('HD_Jail:GetChest2', false, function(cvalue)
			local valuesc = {}
			local element = {}
	
			valuesc = cvalue
			if valuesc[1] ~= nil then
				for i = 1, #valuesc, 1 do 
					table.insert(element, {label = valuesc[i].amt..'x '..valuesc[i].itemName, value = i})
				end
			else
				table.insert(element, {label = Config.Sayings[33], value = 'none'})
			end
	
			NativeMenu.CloseAll()
	
			NativeMenu.Open('default', GetCurrentResourceName(), 'inv_menu2', {
				title    = name..Config.Sayings[157],
				align    = Config.MenuLoc,
				elements = element
			}, function(data, menu)
				if data.current.value ~= 'none' then
					local numies = data.current.value
					menu.close()
					NativeMenu.Open('dialog', GetCurrentResourceName(), 'inv_amt', {
						title = (Config.Sayings[37])
					}, function(data, menu)
						local amount = tonumber(data.value)
			
						if amount == nil or amount < 0 then
							Notification(Config.Sayings[38])
						elseif amount > valuesc[numies].amt then
							Notification(Config.Sayings[39])
						else
							menu.close()
							TriggerServerEvent('HD_Jail:RemoveItem2', valuesc[numies].ite, amount, valuesc[numies].itemName, theirID)
						end
					end, function(data, menu)
						menu.close()
						-- exports.rprogress:Start(Config.Sayings[36], Config.OpenCloseTime *1000)
						lib.progressCircle({ --bajando cama
							duration =  Config.OpenCloseTime *1000,
							label =  Config.Sayings[36],
							position = 'bottom',
							useWhileDead = false,
							canCancel = false,
							disable = {
								car = true,
								move = true,
								combat = true,
								mouse = false,
							},
						})
						-- Citizen.Wait(Config.OpenCloseTime *1000)
						FreezeEntityPosition(ped, false)
						inAnim.Dict = nil
						inAnim.Anim = nil
						inAnim.Atr = 0
						inAnim.Freeze = false
						RemoveAnimDict('mini@repair')
						ClearPedTasksImmediately(ped)
						OpenPoliceMenu2(name, theirID)
					end)
				end
			end, function(data, menu)
				menu.close()
				ClearPedTasksImmediately(ped)
				OpenPoliceShitMenu()
			end)
		end, theirID)
	end)
end

function OpenInfoMenu()
	local ped = PlayerPedId()
	local element = {
		[1] = {label = Config.Sayings[47], value = 'make'},
		[2] = {label = Config.Sayings[46], value = 'break'}
	}

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'info_menu', {
		title    = Config.Sayings[45],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		if data.current.value == 'make' then
			OpenMakeMenu()
		else
			OpenBreakMenu()
		end
	end, function(data, menu)
		menu.close()
		inMenu.is = false
		inMenu.coords = nil
	end)
end

function OpenMakeMenu()
	local ped = PlayerPedId()
	local element = {}

	for i = 1, #Config.Crafts, 1 do
		table.insert(element, {label = Config.Crafts[i].Name, value = i})
	end

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'make_menu', {
		title    = Config.Sayings[48],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		OpenCraftMenu(data.current.value)
	end, function(data, menu)
		menu.close()
		OpenInfoMenu()
	end)
end

function OpenCraftMenu(itnum)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		local element = {
			[1] = {label = Config.Sayings[50], value = 'need'},
			[2] = {label = Config.Sayings[51], value = 'make'}
		}
	
		NativeMenu.CloseAll()
	
		NativeMenu.Open('default', GetCurrentResourceName(), 'make_menu2', {
			title    = Config.Crafts[itnum].Name,
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if data.current.value == 'need' then
				OpenNeedsMenu(itnum)
			else
				menu.close()
				lib.callback('HD_Jail:CheckItemMake', false, function(can)
					if can == 1 then
						Notification(Config.Sayings[83])
					elseif can == 2 then
						Notification(Config.Sayings[84])
					else
						Citizen.CreateThread(function()
							using = true
							TriggerServerEvent('HD_Jail:TakeItems', itnum)
							local pedi = nil
							for i = 1, #peds, 1 do
								if peds[i].id == 'info' then
									pedi = peds[i].data
								end
							end
							RequestAnimDict('missmic4')
								
							if not HasAnimDictLoaded('missmic4') then
								LoadAnim('missmic4')
							end
	
							FreezeEntityPosition(pedi, false)
							MakeEntityFaceEntity(ped, pedi)
							MakeEntityFaceEntity(pedi, ped)
							TaskPlayAnim(pedi, 'missmic4', 'michael_tux_fidget', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							TaskPlayAnim(ped, 'missmic4', 'michael_tux_fidget', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = 'missmic4'
							inAnim.Anim = 'michael_tux_fidget'
							inAnim.Atr = 1
							inAnim.Freeze = true
							FreezeEntityPosition(ped, true)
							FreezeEntityPosition(pedi, true)
							-- exports.rprogress:Start(Config.Sayings[85], Config.Crafts[itnum].Time *1000)
							lib.progressCircle({ --Creando
								duration =  Config.Crafts[itnum].Time *1000,
								label =  Config.Sayings[85],
								position = 'bottom',
								useWhileDead = false,
								canCancel = false,
								disable = {
									car = true,
									move = true,
									combat = true,
									mouse = false,
								},
							})
							-- Citizen.Wait(Config.Crafts[itnum].Time *1000)
							ClearPedTasksImmediately(pedi)
							ClearPedTasksImmediately(ped)
							FreezeEntityPosition(pedi, false)
							SetEntityHeading(pedi, Config.InfoPedLoc[infoLoc].Heading)
							FreezeEntityPosition(pedi, true)
							FreezeEntityPosition(ped, false)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							using = false
						end)
					end
				end, itnum)
			end
		end, function(data, menu)
			menu.close()
			OpenMakeMenu()
		end)
	end)
end

function OpenNeedsMenu(numzioe)
	local ped = PlayerPedId()
	local element = {}

	for i = 1, #Config.Crafts[numzioe].Needed, 1 do
		table.insert(element, {label = Config.Crafts[numzioe].Needed[i].Amount..'x '..Config.Crafts[numzioe].Needed[i].Name, value = i})
	end

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'need_menu', {
		title    = Config.Sayings[52],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)

	end, function(data, menu)
		menu.close()
		OpenCraftMenu(numzioe)
	end)
end

