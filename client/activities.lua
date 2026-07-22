function StartWorkout(Loc)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()

		using = true
		workoutLoc = Loc
		SetEntityCoords(ped, Config.WorkoutLocs[Loc].StartLoc.Loc.x, Config.WorkoutLocs[Loc].StartLoc.Loc.y, Config.WorkoutLocs[Loc].StartLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.WorkoutLocs[Loc].StartLoc.Heading)
		
		RequestAnimDict('clothingtie')
		
		if not HasAnimDictLoaded('clothingtie') then
			Citizen.Wait(0)
		end
	
		TaskPlayAnim(ped, "clothingtie", "try_tie_positive_a", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'clothingtie'
		inAnim.Anim = 'try_tie_positive_a'
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)
		lib.progressCircle({ --cambiar ropa en gimnasio
			duration =  Config.WorkReadyTime *1000,
			label =  Config.Sayings[114],
			position = 'bottom',
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
				move = true,
				combat = true,
				mouse = false,
			},
		}, RemoveAnimDict("clothingtie"))		
		-- Citizen.Wait(Config.WorkReadyTime *1000)
		-- RemoveAnimDict("clothingtie")
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		for i = 1, #jailLocs, 1 do
			if jailLocs[i].Id == 'workout'..workoutLoc then
				jailLocs[i].Text = Config.Sayings[126]
			end
		end
		ClearPedTasksImmediately(ped)
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.WorkoutFit.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.WorkoutFit.female)
			end
		end)
		Notification(Config.Sayings[121])
		using = false
		workoutNow = true
	end)
end

function EndWorkout()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()

		using = true
		workoutNow = false
		SetEntityCoords(ped, Config.WorkoutLocs[workoutLoc].StartLoc.Loc.x, Config.WorkoutLocs[workoutLoc].StartLoc.Loc.y, Config.WorkoutLocs[workoutLoc].StartLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.WorkoutLocs[workoutLoc].StartLoc.Heading)
	
		RequestAnimDict('clothingtie')
		
		if not HasAnimDictLoaded('clothingtie') then
			Citizen.Wait(0)
		end
	
		TaskPlayAnim(ped, "clothingtie", "try_tie_positive_a", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'clothingtie'
		inAnim.Anim = 'try_tie_positive_a'
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)
		lib.progressCircle({ --cambiar ropa en gimnasio
		duration =  Config.WorkReadyTime *1000,
		label =  Config.Sayings[114],
		position = 'bottom',
		useWhileDead = false,
		canCancel = false,
		disable = {
			car = true,
			move = true,
			combat = true,
			mouse = false,
		},
	}, RemoveAnimDict("clothingtie"))		
		-- Citizen.Wait(Config.WorkReadyTime *1000)
		-- RemoveAnimDict("clothingtie")
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)

		for i = 1, #jailLocs, 1 do
			if jailLocs[i].Id == 'workout'..workoutLoc then
				jailLocs[i].Text = Config.Sayings[120]
			end
		end
		workoutLoc = 0		
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
			end
		end)
		Notification(Config.Sayings[125])
		using = false
	end)
end

function StartShower()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()

		using = true
		SetEntityCoords(ped, Config.ShowerLoc.Loc.x, Config.ShowerLoc.Loc.y, Config.ShowerLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.ShowerLoc.Heading)
		
		RequestAnimDict('clothingtie')
		
		if not HasAnimDictLoaded('clothingtie') then
			Citizen.Wait(0)
		end
	
		TaskPlayAnim(ped, "clothingtie", "try_tie_positive_a", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'clothingtie'
		inAnim.Anim = 'try_tie_positive_a'
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)
		-- exports.rprogress:Start(Config.Sayings[114], Config.GetReadyTime *1000)
		-- Citizen.Wait(Config.GetReadyTime *1000)
		-- RemoveAnimDict("clothingtie")
		lib.progressCircle({ --cambiar ropa en duchas
			duration =  Config.WorkReadyTime *1000,
			label =  Config.Sayings[114],
			position = 'bottom',
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
				move = true,
				combat = true,
				mouse = false,
			},
		}, RemoveAnimDict("clothingtie"))			
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.ShowerFit.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.ShowerFit.female)
			end
		end)
		Notification(Config.Sayings[115])
		showerNow = true
	end)
end

function OpenBreakingMenu()
	local ped = PlayerPedId()
	local element = {}
	local flip = false

	if not Config.BreakLocs[closestBreak].ExitFence then
		for i = 1, #Config.FenceTool, 1 do
			table.insert(element, {label = Config.FenceTool[i].Name, value = i})
		end
		flip = false
	else
		for i = 1, #Config.RoomTools, 1 do
			table.insert(element, {label = Config.RoomTools[i].Name, value = i})
		end
		flip = true
	end

	NativeMenu.CloseAll()

	Citizen.CreateThread(function()
		NativeMenu.Open('default', GetCurrentResourceName(), 'fence_menu', {
			title    = Config.Sayings[94],
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if flip then
				lib.callback('HD_Jail:CheckItemB2', false, function(can)
					if can then
						menu.close()
						local hnum = 0
						local rannum = math.random(1,10)
						hnum = rannum
						if hnum <= Config.RoomTools[data.current.value].Percent then
							print('no')
							using = true
							RequestAnimDict('mini@repair')
										
							if not HasAnimDictLoaded('mini@repair') then
								LoadAnim('mini@repair')
							end
			
							SetEntityCoords(ped, Config.BreakLocs[closestBreak].StartLoc.Loc.x, Config.BreakLocs[closestBreak].StartLoc.Loc.y, Config.BreakLocs[closestBreak].StartLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.BreakLocs[closestBreak].StartLoc.Heading)
							TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = 'mini@repair'
							inAnim.Anim = 'fixing_a_ped'
							inAnim.Atr = 1
							inAnim.Freeze = true
							FreezeEntityPosition(ped, true)
							-- exports.rprogress:Start(Config.Sayings[96], Config.RoomTools[data.current.value].Time *1000)
							lib.progressCircle({ --cavar
								duration =  Config.RoomTools[data.current.value].Time *1000,
								label =  Config.Sayings[96],
								position = 'bottom',
								useWhileDead = false,
								canCancel = false,
								disable = {
									car = true,
									move = true,
									combat = true,
									mouse = false,
								},
							}, RemoveAnimDict("mini@repair"))				
							-- Citizen.Wait(Config.RoomTools[data.current.value].Time *1000)
							-- RemoveAnimDict("mini@repair")
							FreezeEntityPosition(ped, false)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							ClearPedTasksImmediately(ped)
							DoScreenFadeOut(1000)
							Citizen.Wait(1500)
							SetEntityCoords(ped, Config.BreakLocs[closestBreak].ExitLoc.Loc.x, Config.BreakLocs[closestBreak].ExitLoc.Loc.y, Config.BreakLocs[closestBreak].ExitLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.BreakLocs[closestBreak].ExitLoc.Heading)
							TriggerServerEvent('HD_Jail:UpdateBreaking')
							breakout3 = false
							breakout4 = false
							breakout = 0
							local removes = {}
							for i = 1, #blips, 1 do
								if blips[i].id == 'escape' then
									table.insert(removes, i)
								end
							end
							for i = 1, #removes, 1 do
								if DoesBlipExist(blips[removes[i]].data) then
									RemoveBlip(blips[removes[i]].data)
								end
								table.remove(blips[removes[i]])
							end
							DoScreenFadeIn(1000)
							Citizen.Wait(1000)
							using = false
							Notification(Config.Sayings[90])
						else
							TriggerServerEvent('HD_Jail:TakeItems2', Config.RoomTools[data.current.value].Item)
							using = true
							RequestAnimDict('mini@repair')
										
							if not HasAnimDictLoaded('mini@repair') then
								LoadAnim('mini@repair')
							end
			
							SetEntityCoords(ped, Config.BreakLocs[closestBreak].StartLoc.Loc.x, Config.BreakLocs[closestBreak].StartLoc.Loc.y, Config.BreakLocs[closestBreak].StartLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.BreakLocs[closestBreak].StartLoc.Heading)
							TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = 'mini@repair'
							inAnim.Anim = 'fixing_a_ped'
							inAnim.Atr = 0
							inAnim.Freeze = false
							FreezeEntityPosition(ped, true)
							-- exports.rprogress:Start(Config.Sayings[96], Config.RoomTools[data.current.value].Time *1000)
							-- Citizen.Wait(Config.RoomTools[data.current.value].Time *1000)
							-- RemoveAnimDict("mini@repair")
							lib.progressCircle({ --cavar
							duration =  Config.RoomTools[data.current.value].Time *1000,
							label =  Config.Sayings[96],
							position = 'bottom',
							useWhileDead = false,
							canCancel = false,
							disable = {
								car = true,
								move = true,
								combat = true,
								mouse = false,
							},
						}, RemoveAnimDict("mini@repair"))	
							FreezeEntityPosition(ped, false)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							ClearPedTasksImmediately(ped)
							using = false
							Notification(Config.Sayings[91])
						end
					else
						Notification(Config.Sayings[95])
					end
				end, Config.RoomTools[data.current.value].Item)
			else
				lib.callback('HD_Jail:CheckItemB2', false, function(can)
					if can then
						menu.close()
						local hnum = 0
						local rannum = math.random(1,10)
						hnum = rannum
						if hnum <= Config.FenceTool[data.current.value].Percent then
							using = true
							RequestAnimDict('mp_arresting')
										
							if not HasAnimDictLoaded('mp_arresting') then
								LoadAnim('mp_arresting')
							end
			
							SetEntityCoords(ped, Config.BreakLocs[closestBreak].StartLoc.Loc.x, Config.BreakLocs[closestBreak].StartLoc.Loc.y, Config.BreakLocs[closestBreak].StartLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.BreakLocs[closestBreak].StartLoc.Heading)
							TaskPlayAnim(ped, 'mp_arresting', 'a_uncuff', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = 'mp_arresting'
							inAnim.Anim = 'a_uncuff'
							inAnim.Atr = 1
							inAnim.Freeze = true
							FreezeEntityPosition(ped, true)
							-- exports.rprogress:Start(Config.Sayings[97], Config.FenceTool[data.current.value].Time *1000)
							lib.progressCircle({ --cortar
								duration =  Config.FenceTool[data.current.value].Time *1000,
								label =  Config.Sayings[97],
								position = 'bottom',
								useWhileDead = false,
								canCancel = false,
								disable = {
									car = true,
									move = true,
									combat = true,
									mouse = false,
								},
							}, RemoveAnimDict("mp_arresting"))	
							-- Citizen.Wait(Config.FenceTool[data.current.value].Time *1000)
							-- RemoveAnimDict("mp_arresting")
							FreezeEntityPosition(ped, false)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							ClearPedTasksImmediately(ped)
							using = false
							DoScreenFadeOut(1000)
							Citizen.Wait(1500)
							SetEntityCoords(ped, Config.BreakLocs[closestBreak].ExitLoc.Loc.x, Config.BreakLocs[closestBreak].ExitLoc.Loc.y, Config.BreakLocs[closestBreak].ExitLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.BreakLocs[closestBreak].ExitLoc.Heading)
							DoScreenFadeIn(1000)
							Citizen.Wait(1000)
							Notification(Config.Sayings[90])
						else
							TriggerServerEvent('HD_Jail:TakeItems2', Config.RoomTools[data.current.value].Item)
							using = true
							RequestAnimDict('mp_arresting')
										
							if not HasAnimDictLoaded('mp_arresting') then
								LoadAnim('mp_arresting')
							end
			
							SetEntityCoords(ped, Config.BreakLocs[closestBreak].StartLoc.Loc.x, Config.BreakLocs[closestBreak].StartLoc.Loc.y, Config.BreakLocs[closestBreak].StartLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.BreakLocs[closestBreak].StartLoc.Heading)
							TaskPlayAnim(ped, 'mp_arresting', 'a_uncuff', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = 'mp_arresting'
							inAnim.Anim = 'a_uncuff'
							inAnim.Atr = 0
							inAnim.Freeze = false
							FreezeEntityPosition(ped, true)
							-- exports.rprogress:Start(Config.Sayings[97], Config.FenceTool[data.current.value].Time *1000)
							-- Citizen.Wait(Config.FenceTool[data.current.value].Time *1000)
							-- RemoveAnimDict("mp_arresting")
							lib.progressCircle({ --cortar
							duration =  Config.FenceTool[data.current.value].Time *1000,
							label =  Config.Sayings[97],
							position = 'bottom',
							useWhileDead = false,
							canCancel = false,
							disable = {
								car = true,
								move = true,
								combat = true,
								mouse = false,
							},
						}, RemoveAnimDict("mp_arresting"))	
							FreezeEntityPosition(ped, false)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							ClearPedTasksImmediately(ped)
							using = false
							Notification(Config.Sayings[91])
						end
					else
						Notification(Config.Sayings[95])
					end
				end, Config.FenceTool[data.current.value].Item)
			end
		end, function(data, menu)
			menu.close()
			inMenu.is = false
			inMenu.coords = nil
		end)
	end)
end

function IEscaped()
	TriggerServerEvent('HD_Jail:UnJailPlayer', GetPlayerServerId(PlayerId()), false)
	TriggerServerEvent('HD_Jail:PoliceNotify')
	time = 0
	soltime = 0
	job = 0
	doneTasks = 0
	taskMax = 0
	injail = false
	jailCell = 0
	solcell = 0
	canGrab = false	
	createdCamera = 0
	local removes = {}
	for i = 1, #blips, 1 do
		table.insert(removes, i)
	end
	for i = 1, #removes, 1 do
		if DoesBlipExist(blips[removes[i]].data) then
			RemoveBlip(blips[removes[i]].data)
		end
		table.remove(blips[removes[i]])
	end
	removes = {}
	for i = 1, #peds, 1 do
		table.insert(removes, i)
	end
	for i = 1, #removes, 1 do
		if DoesEntityExist(peds[removes[i]].data) then
			SetPedAsNoLongerNeeded(peds[removes[i]].data)
			DeletePed(peds[removes[i]].data)
		end
		table.remove(peds[removes[i]])
	end
	removes = {}
	for i = 1, #PlayerHasProp, 1 do
		table.insert(removes, i)
	end
	for i = 1, #removes, 1 do
		if DoesEntityExist(PlayerHasProp[removes[i]].object) then
			DeleteObject(PlayerHasProp[removes[i]].object)
		end
		table.remove(PlayerHasProp[removes[i]])
	end
	removes = {}
	closestLoc = 1
	breakout = 0
	breakout2 = false
	breakout3 = false
	breakout4 = true
	closestTower = 1
	closestBreak = 1
    Wait(500)
	jailLocs = {}
	inMenu = {is = false, coords = nil}
	needsEat = false
end

function OpenWallMenu()
	local ped = PlayerPedId()
	local element = {}


	for i = 1, #Config.RoomTools, 1 do
		table.insert(element, {label = Config.RoomTools[i].Name, value = i})
	end

	NativeMenu.CloseAll()

	Citizen.CreateThread(function()
		NativeMenu.Open('default', GetCurrentResourceName(), 'wall_menu', {
			title    = Config.Sayings[87],
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			lib.callback('HD_Jail:CheckItemB', false, function(can)
				if can then
					local hnum = 0
					local rannum = math.random(1,10)
					hnum = rannum
					menu.close()
					if hnum <= Config.RoomTools[data.current.value].Percent then
						TriggerServerEvent('HD_Jail:SuccessFul', GetPlayerServerId(PlayerId()), Config.RoomTools[data.current.value].Time *1000)
						using = true
						RequestAnimDict('mini@repair')
									
						if not HasAnimDictLoaded('mini@repair') then
							LoadAnim('mini@repair')
						end
		
						SetEntityCoords(ped, Config.Cells[jailCell].BreakLoc.Loc.x, Config.Cells[jailCell].BreakLoc.Loc.y, Config.Cells[jailCell].BreakLoc.Loc.z - 1, false, false, false, false)
						SetEntityHeading(ped, Config.Cells[jailCell].BreakLoc.Heading)
						TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
						inAnim.Dict = 'mini@repair'
						inAnim.Anim = 'fixing_a_ped'
						inAnim.Atr = 1
						inAnim.Freeze = true
						FreezeEntityPosition(ped, true)
						-- exports.rprogress:Start(Config.Sayings[96], Config.RoomTools[data.current.value].Time *1000)
						-- Citizen.Wait(Config.RoomTools[data.current.value].Time *1000)
						-- RemoveAnimDict("mini@repair")
						lib.progressCircle({ --cabando
							duration =  Config.RoomTools[data.current.value].Time *1000,
							label =  Config.Sayings[96],
							position = 'bottom',
							useWhileDead = false,
							canCancel = false,
							disable = {
								car = true,
								move = true,
								combat = true,
								mouse = false,
							},
						}, RemoveAnimDict("mini@repair"))	
						FreezeEntityPosition(ped, false)
						inAnim.Dict = nil
						inAnim.Anim = nil
						inAnim.Atr = 0
						inAnim.Freeze = false
						ClearPedTasksImmediately(ped)
						using = false
						Notification(Config.Sayings[90])
					else
						TriggerServerEvent('HD_Jail:TakeItems4', data.current.value)
						using = true
						RequestAnimDict('mini@repair')
									
						if not HasAnimDictLoaded('mini@repair') then
							LoadAnim('mini@repair')
						end
		
						SetEntityCoords(ped, Config.Cells[jailCell].BreakLoc.Loc.x, Config.Cells[jailCell].BreakLoc.Loc.y, Config.Cells[jailCell].BreakLoc.Loc.z - 1, false, false, false, false)
						SetEntityHeading(ped, Config.Cells[jailCell].BreakLoc.Heading)
						TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
						inAnim.Dict = 'mini@repair'
						inAnim.Anim = 'fixing_a_ped'
						inAnim.Atr = 1
						inAnim.Freeze = false
						FreezeEntityPosition(ped, true)
						-- exports.rprogress:Start(Config.Sayings[96] ,Config.RoomTools[data.current.value].Time *1000)
						-- Citizen.Wait(Config.RoomTools[data.current.value].Time *1000)
						-- RemoveAnimDict("mini@repair")
						lib.progressCircle({ --cavando
							duration =  Config.RoomTools[data.current.value].Time *1000,
							label =  Config.Sayings[96],
							position = 'bottom',
							useWhileDead = false,
							canCancel = false,
							disable = {
								car = true,
								move = true,
								combat = true,
								mouse = false,
							},
						}, RemoveAnimDict("mini@repair"))	
						FreezeEntityPosition(ped, false)
						inAnim.Dict = nil
						inAnim.Anim = nil
						inAnim.Atr = 0
						inAnim.Freeze = false
						ClearPedTasksImmediately(ped)
						using = false
						Notification(Config.Sayings[91])
					end
				else
					Notification(Config.Sayings[88])
				end
			end, data.current.value)
		end, function(data, menu)
			menu.close()
			inMenu.is = false
			inMenu.coords = nil
		end)
	end)
end

function BreakOutStart()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		using = true
		RequestAnimDict('mini@repair')
					
		if not HasAnimDictLoaded('mini@repair') then
			LoadAnim('mini@repair')
		end
	
		SetEntityCoords(ped, Config.Cells[jailCell].BreakLoc.Loc.x, Config.Cells[jailCell].BreakLoc.Loc.y, Config.Cells[jailCell].BreakLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.Cells[jailCell].BreakLoc.Heading)
		TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'mini@repair'
		inAnim.Anim = 'fixing_a_ped'
		inAnim.Atr = 1
		inAnim.Freeze = false
		FreezeEntityPosition(ped, true)
		-- exports.rprogress:Start(Config.Sayings[161], Config.CrawlTime *1000)
		-- Citizen.Wait(Config.CrawlTime *1000)
		-- RemoveAnimDict("mini@repair")
		lib.progressCircle({ --escapando por el tunel
			duration =  Config.CrawlTime *1000,
			label =  Config.Sayings[161],
			position = 'bottom',
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
				move = true,
				combat = true,
				mouse = false,
			},
		}, RemoveAnimDict("mini@repair"))	
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
	
		for i = 1, #Config.BreakLocs, 1 do
			local blip5 = AddBlipForCoord(Config.BreakLocs[i].StartLoc.Loc.x, Config.BreakLocs[i].StartLoc.Loc.y, Config.BreakLocs[i].StartLoc.Loc.z)
			SetBlipSprite(blip5, Config.BreakBlips.Sprite)
			SetBlipScale(blip5, Config.BreakBlips.Size)
			SetBlipColour(blip5, Config.BreakBlips.Color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Sayings[98])
			EndTextCommandSetBlipName(blip5)
			table.insert(blips, {id = 'escape', data = blip5})
		end
	
		for i = 1, #Config.WatchTowers, 1 do
			local blip5 = AddBlipForCoord(Config.WatchTowers[i].x, Config.WatchTowers[i].y, Config.WatchTowers[i].z)
			SetBlipSprite(blip5, Config.WatchBlip.Sprite)
			SetBlipScale(blip5, Config.WatchBlip.Size)
			SetBlipColour(blip5, Config.WatchBlip.Color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Sayings[99])
			EndTextCommandSetBlipName(blip5)
			table.insert(blips, {id = 'tower', data = blip5})
		end
		SetEntityCoords(ped, Config.Cells[jailCell].ExitLoc.Loc.x, Config.Cells[jailCell].ExitLoc.Loc.y, Config.Cells[jailCell].ExitLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.Cells[jailCell].ExitLoc.Heading)
		FreezeEntityPosition(ped, true)
		Citizen.Wait(1000)
		FreezeEntityPosition(ped, false)
		TriggerServerEvent('HD_Jail:UpdateBreak')
		breakout = Config.BreakoutTime 
		breakout2 = true
		DoScreenFadeIn(1000)
		Citizen.Wait(1500)
	
		using = false
		for i = 1, #jailLocs, 1 do
			if jailLocs[i].Id == 'break' then
				jailLocs[i].Text = Config.Sayings[28]
			end
		end
	end)
end

