function TaskComplete()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		RequestAnimDict(Config.JobOptions[job].Tasks[doneTasks].Anim.Dict)
								
		if not HasAnimDictLoaded(Config.JobOptions[job].Tasks[doneTasks].Anim.Dict) then
			LoadAnim(Config.JobOptions[job].Tasks[doneTasks].Anim.Dict)
		end
	
		local rem = {}
		for i = 1, #PlayerHasProp, 1 do
			if PlayerHasProp[i].id == 'task' then
				DeleteObject(PlayerHasProp[i].object)
				table.insert(rem, i)
			end
		end
		for i = 1, #rem, 1 do
			table.remove(PlayerHasProp, rem[i])
		end
		rem = {}
		using = true
		SetEntityCoords(ped, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.x, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.y, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Heading)
		if Config.JobOptions[job].Tasks[doneTasks].AttachItem.Attach then
			AddPropToPlayer(Config.JobOptions[job].Tasks[doneTasks].AttachItem.Prop, 28422, Config.JobOptions[job].Tasks[doneTasks].AttachItem.Offsets.First, Config.JobOptions[job].Tasks[doneTasks].AttachItem.Offsets.Second, Config.JobOptions[job].Tasks[doneTasks].AttachItem.Offsets.Third, Config.JobOptions[job].Tasks[doneTasks].AttachItem.Offsets.Four, Config.JobOptions[job].Tasks[doneTasks].AttachItem.Offsets.Five, Config.JobOptions[job].Tasks[doneTasks].AttachItem.Offsets.Six , 'task', nil, true)
		end
		TaskPlayAnim(ped, Config.JobOptions[job].Tasks[doneTasks].Anim.Dict, Config.JobOptions[job].Tasks[doneTasks].Anim.AnimName, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = Config.JobOptions[job].Tasks[doneTasks].Anim.Dict
		inAnim.Anim = Config.JobOptions[job].Tasks[doneTasks].Anim.AnimName
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)
		-- exports.rprogress:Start(Config.Sayings[23] ,Config.JobOptions[job].Tasks[doneTasks].Time *1000)
		-- Citizen.Wait(Config.JobOptions[job].Tasks[doneTasks].Time *1000)
		lib.progressCircle({ --Creando
			duration =  Config.JobOptions[job].Tasks[doneTasks].Time *1000,
			label =  Config.Sayings[23],
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
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		RemoveAnimDict(Config.JobOptions[job].Tasks[doneTasks].Anim.Dict)
		if Config.JobOptions[job].Tasks[doneTasks].AttachItem.Attach then
			for i = 1, #PlayerHasProp, 1 do
				if PlayerHasProp[i].id == 'task' then
					DeleteObject(PlayerHasProp[i].object)
					table.insert(rem, i)
				end
			end
			for i = 1, #rem, 1 do
				table.remove(PlayerHasProp, rem[i])
			end
			rem = {}
		end
		ClearPedTasksImmediately(ped)
		using = false
		
		if Config.JobOptions[job].Tasks[doneTasks].CarryItem.Attach then
			AddPropToPlayer(Config.JobOptions[job].Tasks[doneTasks].CarryItem.Prop, 28422, Config.JobOptions[job].Tasks[doneTasks].CarryItem.Offsets.First, Config.JobOptions[job].Tasks[doneTasks].CarryItem.Offsets.Second, Config.JobOptions[job].Tasks[doneTasks].CarryItem.Offsets.Third, Config.JobOptions[job].Tasks[doneTasks].CarryItem.Offsets.Four, Config.JobOptions[job].Tasks[doneTasks].CarryItem.Offsets.Five, Config.JobOptions[job].Tasks[doneTasks].CarryItem.Offsets.Six , 'task', nil, true)
		end
		if doneTasks >= taskMax then
			doneTasks = 1
			Notification(Config.Sayings[25])
			time = time - Config.JobOptions[job].TimeRemove
			TriggerServerEvent('HD_Jail:TaskComplete', job)
		else
			doneTasks = doneTasks + 1
			Notification(Config.Sayings[24])
		end
	
		TriggerServerEvent('HD_Jail:TaskComplete1', job)
	
		local removes = {}
		for i = 1, #blips, 1 do
			if blips[i].id == 'task' then
				table.insert(removes, i)
			end
		end
		for i = 1, #removes, 1 do
			if DoesBlipExist(blips[removes[i]].data) then
				RemoveBlip(blips[removes[i]].data)
			end
			table.remove(blips[removes[i]])
		end
	
		local blip4 = AddBlipForCoord(Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.x, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.y, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.z)
		SetBlipSprite(blip4, Config.JobOptions[job].Tasks[doneTasks].TBlip.Sprite)
		SetBlipScale(blip4, Config.JobOptions[job].Tasks[doneTasks].TBlip.Size)
		SetBlipColour(blip4, Config.JobOptions[job].Tasks[doneTasks].TBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.JobOptions[job].Tasks[doneTasks].TaskName..' | '..Config.Sayings[26]..doneTasks..'/'..taskMax)
		EndTextCommandSetBlipName(blip4)
		table.insert(blips, {id = 'task', data = blip4})
	end)
end

Citizen.CreateThread(function()
	while true do
		if time > 0 and not isDead and breakout4 then
			Citizen.Wait(1000)
			if breakout > 0 then
				breakout = breakout - 1

				if not Config.SimpleTime then
					local duration = breakout
					local extraSeconds = duration%60
					local minutes = (duration-extraSeconds)/60
					if duration >= 60 then
						if minutes >= 60 then
							local extraMinutes = minutes%60
							local hours = (minutes-extraMinutes)/60
							diffBreak.Hours = math.floor(hours)
							diffBreak.Mins = math.ceil(extraMinutes)
							diffBreak.Seconds = extraSeconds
						else
							diffBreak.Hours = 0
							diffBreak.Mins = math.floor(minutes)
							diffBreak.Seconds = extraSeconds
						end
					else
						diffBreak.Hours = 0
						diffBreak.Mins = 0
						diffBreak.Seconds = breakout
					end
				end
		    elseif soltime > 0 then
				soltime = soltime - 1

				if not Config.SimpleTime then
					local duration = soltime
					local extraSeconds = duration%60
					local minutes = (duration-extraSeconds)/60
					if duration >= 60 then
						if minutes >= 60 then
							local extraMinutes = minutes%60
							local hours = (minutes-extraMinutes)/60
							diffSol.Hours = math.floor(hours)
							diffSol.Mins = math.ceil(extraMinutes)
							diffSol.Seconds = extraSeconds
						else
							diffSol.Hours = 0
							diffSol.Mins = math.floor(minutes)
							diffSol.Seconds = extraSeconds
						end
					else
						diffSol.Hours = 0
						diffSol.Mins = 0
						diffSol.Seconds = soltime
					end
				end

				if Config.TpBack then
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					local dist = Vdist(Config.SolCells[solcell].Loc.x, Config.SolCells[solcell].Loc.y, Config.SolCells[solcell].Loc.z, coords)
					if dist > Config.MaxSolTpDist then
						DoScreenFadeOut(1000)
						Citizen.Wait(1500)
						SetEntityCoords(ped, Config.SolCells[solcell].Loc.x, Config.SolCells[solcell].Loc.y, Config.SolCells[solcell].Loc.z - 1, false, false, false, false)
						SetEntityHeading(ped, Config.SolCells[solcell].Heading)
						FreezeEntityPosition(ped, true)
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
					end
				end
			else
				time = time - 1

				if not Config.SimpleTime then
					local duration = time
					local extraSeconds = duration%60
					local minutes = (duration-extraSeconds)/60
					if duration >= 60 then
						if minutes >= 60 then
							local extraMinutes = minutes%60
							local hours = (minutes-extraMinutes)/60
							difftime.Hours = math.floor(hours)
							difftime.Mins = math.ceil(extraMinutes)
							difftime.Seconds = extraSeconds
						else
							difftime.Hours = 0
							difftime.Mins = math.floor(minutes)
							difftime.Seconds = extraSeconds
						end
					else
						difftime.Hours = 0
						difftime.Mins = 0
						difftime.Seconds = time
					end
				end

				if Config.TpBack then
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					local dist = Vdist(Config.JailLoc.x, Config.JailLoc.y, Config.JailLoc.z, coords)
					if dist > Config.MaxTpDist then
						if Config.Sol4Run and Config.Solitary then
							TriggerServerEvent('HD_Jail:SendToSol', GetPlayerServerId(PlayerId()), Config.SolRunTime, Config.Sayings[109])
							Citizen.Wait(1000)
						else
							DoScreenFadeOut(1000)
							Citizen.Wait(1500)
							SetEntityCoords(ped, Config.Cells[jailCell].SpawnLoc.Loc.x, Config.Cells[jailCell].SpawnLoc.Loc.y, Config.Cells[jailCell].SpawnLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.Cells[jailCell].SpawnLoc.Heading)
							Citizen.Wait(1000)
							DoScreenFadeIn(1000)
						end
					end
				end
			end

			if inAnim.Dict ~= nil and inAnim.Anim ~= nil then
				local ped = PlayerPedId()
				if not IsEntityPlayingAnim(ped, inAnim.Dict, inAnim.Anim, 3) then
					ClearPedTasksImmediately(ped)
					RequestAnimDict(inAnim.Dict)
								
					if not HasAnimDictLoaded(inAnim.Dict) then
						LoadAnim(inAnim.Dict)
					end

					if inAnim.Freeze then
						FreezeEntityPosition(ped, false)
					end
					TaskPlayAnim(ped, inAnim.Dict, inAnim.Anim, 8.0, 8.0, -1, inAnim.Atr, 1, 0, 0, 0)
					if inAnim.Freeze then
						FreezeEntityPosition(ped, true)
					end
					RemoveAnimDict(inAnim.Dict)
				end
			end
			if inMenu.is and inMenu.coords ~= nil then
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local dist = Vdist(inMenu.coords.x, inMenu.coords.y, inMenu.coords.z, coords)

				if dist > Config.MaxMenuDist then
					NativeMenu.CloseAll()
					if inMenu.coords == Config.Cells[closestPoliceInv].InvLoc.Loc then
						using = false
					end
					inMenu.is = false
					inMenu.coords = nil
					Notification(Config.Sayings[111])
				end
			end
		else
			if inMenu.is and inMenu.coords ~= nil then
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local dist = Vdist(inMenu.coords.x, inMenu.coords.y, inMenu.coords.z, coords)

				if dist > Config.MaxMenuDist then
					NativeMenu.CloseAll()
					if inMenu.coords == Config.Cells[closestPoliceInv].InvLoc.Loc then
						using = false
					end
					inMenu.is = false
					inMenu.coords = nil
					Notification(Config.Sayings[111])
				end
			end
			if inAnim.Dict ~= nil and inAnim.Anim ~= nil then
				local ped = PlayerPedId()
				if not IsEntityPlayingAnim(ped, inAnim.Dict, inAnim.Anim, 3) then
					ClearPedTasksImmediately(ped)
					RequestAnimDict(inAnim.Dict)
								
					if not HasAnimDictLoaded(inAnim.Dict) then
						LoadAnim(inAnim.Dict)
					end

					if inAnim.Freeze then
						FreezeEntityPosition(ped, false)
					end
					TaskPlayAnim(ped, inAnim.Dict, inAnim.Anim, 8.0, 8.0, -1, inAnim.Atr, 1, 0, 0, 0)
					if inAnim.Freeze then
						FreezeEntityPosition(ped, true)
					end
					RemoveAnimDict(inAnim.Dict)
				end
			end
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if injail and time > 0 and breakout4 then
			Citizen.Wait(5)
			if breakout > 0 then
				if not Config.SimpleTime then
					drawTxt(Config.Sayings[92]..diffBreak.Hours..'~w~H~o~ '..diffBreak.Mins..'~w~M~o~ '..diffBreak.Seconds..'~w~S',0,1,0.5,0.9,0.35,255,255,255,255)
				else
					drawTxt(Config.Sayings[92]..breakout..Config.Sayings[54],0,1,0.5,0.9,0.35,255,255,255,255)
				end
			elseif soltime > 0 then
				local ped = PlayerPedId()

				if not Config.SimpleTime then
					drawTxt(Config.ServerName..Config.Sayings[53]..diffSol.Hours..'~w~H~y~ '..diffSol.Mins..'~w~M~y~ '..diffSol.Seconds..'~w~S',0,1,0.5,0.9,0.35,255,255,255,255)
				else
					drawTxt(Config.ServerName..Config.Sayings[53]..soltime..Config.Sayings[54],0,1,0.5,0.9,0.35,255,255,255,255)
				end

				SetEntityCanBeDamaged(ped, false)
				SetPlayerCanDoDriveBy(ped, false)
				DisablePlayerFiring(ped, true)
				DisableControlAction(0, 140)
			else
				if Config.SimpleTime then
					if job ~= 0 then
						drawTxt(Config.ServerName..Config.Sayings[3]..time..Config.Sayings[4]..Config.JobOptions[job].Name..Config.Sayings[26]..doneTasks..'~w~/~b~'..taskMax,0,1,0.5,0.9,0.35,255,255,255,255)
					else
						drawTxt(Config.ServerName..Config.Sayings[3]..time..Config.Sayings[4]..Config.Sayings[6],0,1,0.5,0.9,0.35,255,255,255,255)
					end
				else
					if job ~= 0 then
						drawTxt(Config.ServerName..Config.Sayings[137]..difftime.Hours..'~w~H~r~ '..difftime.Mins..'~w~M~r~ '..difftime.Seconds..'~w~S'..Config.Sayings[138]..Config.JobOptions[job].Name,0,1,0.5,0.9,0.35,255,255,255,255)
					else
						drawTxt(Config.ServerName..Config.Sayings[137]..difftime.Hours..'~w~H~r~ '..difftime.Mins..'~w~M~r~ '..difftime.Seconds..'~w~S'..Config.Sayings[138]..Config.Sayings[6],0,1,0.5,0.9,0.35,255,255,255,255)
					end
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

function OpenJobManMenu()
	local ped = PlayerPedId()
	local element = {}
	
	table.insert(element, {label = Config.Sayings[16], value = 0})
	for i = 1, #Config.JobOptions, 1 do 
		table.insert(element, {label = Config.JobOptions[i].Name, value = i})
	end
	
	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'job_menu', {
		title    = Config.Sayings[15],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		OpenManMenu(data.current.value)
	end, function(data, menu)
		menu.close()
		inMenu.is = false
		inMenu.coords = nil
	end)
end

function OpenManMenu(numVal)
	local ped = PlayerPedId()
	local element = {}
	
	if numVal ~= 0 then
		local tTasks = 0 
		
		for i = 1, #Config.JobOptions[numVal].Tasks, 1 do 
			tTasks = tTasks + 1
		end
	
		table.insert(element, {label = Config.Sayings[17]..tTasks, value = 'task'})
		table.insert(element, {label = Config.Sayings[18]..Config.JobOptions[numVal].TimeRemove..'(s)', value = 'tR'})
		table.insert(element, {label = Config.Sayings[19] , value = 'confirm'})
	end
	
	NativeMenu.CloseAll()

	if numVal ~= 0 then
		NativeMenu.Open('default', GetCurrentResourceName(), 'job_menu2', {
			title    = Config.JobOptions[numVal].Name,
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if data.current.value == 'confirm' then
				menu.close()
				StartJob(numVal, true)
			end
		end, function(data, menu)
			menu.close()
			OpenJobManMenu()
		end)
	else
		StartJob(numVal, true)
	end
end

function OpenFood()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		using = true

		RequestAnimDict('anim@amb@clubhouse@bar@drink@idle_a')

		if not HasAnimDictLoaded('anim@amb@clubhouse@bar@drink@idle_a') then
			LoadAnim('anim@amb@clubhouse@bar@drink@idle_a')
		end

		SetEntityCoords(ped, Config.GetFoodLoc.Loc.x, Config.GetFoodLoc.Loc.y, Config.GetFoodLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.GetFoodLoc.Heading)
		TaskPlayAnim(ped, 'anim@amb@clubhouse@bar@drink@idle_a', 'idle_a_bartender', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'anim@amb@clubhouse@bar@drink@idle_a'
		inAnim.Anim = 'idle_a_bartender'
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)
		-- exports.rprogress:Start(Config.Sayings[43] , Config.GrabFoodTime *1000)
		lib.progressCircle({ --tomando bandeja
			duration =  Config.GrabFoodTime *1000,
			label =  Config.Sayings[43],
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
		-- Citizen.Wait(Config.GrabFoodTime *1000)
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		RemoveAnimDict('anim@amb@clubhouse@bar@drink@idle_a')
		ClearPedTasksImmediately(ped)

		needsEat = true

		RequestAnimDict('anim@heists@box_carry@')
								
		if not HasAnimDictLoaded('anim@heists@box_carry@') then
			LoadAnim('anim@heists@box_carry@')
		end
	
		TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 51, 1, 0, 0, 0)
		inAnim.Dict = 'anim@heists@box_carry@'
		inAnim.Anim = 'idle'
		inAnim.Atr = 51
		inAnim.Freeze = false
		RemoveAnimDict('anim@heists@box_carry@')
		AddPropToPlayer('prop_food_bs_tray_02', 60309, 0.000, -0.08, 0.200, -55.0, 290.0, 0.0, 'food', nil, true)
	end)
end

function StartJob(jobie, trip)
	TriggerServerEvent('HD_Jail:SetJob', jobie, trip)
	local removes = {}
	for i = 1, #blips, 1 do
		if blips[i].id == 'task' then
			table.insert(removes, i)
		end
	end
	for i = 1, #removes, 1 do
		if DoesBlipExist(blips[removes[i]].data) then
			RemoveBlip(blips[removes[i]].data)
		end
		table.remove(blips[removes[i]])
	end
	removes = {}

	for i = 1, #PlayerHasProp, 1 do
		if PlayerHasProp[i].id == 'task' then
			table.insert(removes, i)
		end
	end
	for i = 1, #removes, 1 do
		if DoesEntityExist(PlayerHasProp[removes[i]].object) then
			DeleteObject(PlayerHasProp[removes[i]].object)
		end
		table.remove(PlayerHasProp[removes[i]])
	end
	removes = {}

	if jobie ~= 0 then
		job = jobie
		doneTasks = 1
		taskMax = 0
		for i = 1, #Config.JobOptions[jobie].Tasks, 1 do
			taskMax = taskMax + 1
		end
		Notification(Config.Sayings[20])
	
		local blip2 = AddBlipForCoord(Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.x, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.y, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.z)
		SetBlipSprite(blip2, Config.JobOptions[job].Tasks[doneTasks].TBlip.Sprite)
		SetBlipScale(blip2, Config.JobOptions[job].Tasks[doneTasks].TBlip.Size)
		SetBlipColour(blip2, Config.JobOptions[job].Tasks[doneTasks].TBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.JobOptions[job].Tasks[doneTasks].TaskName..' | '..Config.Sayings[26]..doneTasks..'/'..taskMax)
		EndTextCommandSetBlipName(blip2)
		table.insert(blips, {id = 'task', data = blip2})
	else
		job = jobie
		doneTasks = 1
		taskMax = 0
	end
end

