
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
		-- RemoveAnimDict("clothingtie")
		lib.progressBar({ --cambiar ropa en duchas
			duration =  Config.GetReadyTime *1000,
			label =  Config.Sayings[114],
			icon = 'fixlife.svg',
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
		using = false
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
		TriggerEvent('Fix_3dTextUi:actualizar', 'fixlife_prision_shower_ready', 'cambiarse a uniforme')
		for i, coords in ipairs(Config.ShowerLocs) do
			TriggerEvent('Fix_3dTextUi:crear', 'fixlife_prision_shower_' .. i, coords, 3.0, 0.5, 0.5, '#fbfdfd', 'G', 'Ducharse', 'image', 'shower.svg', 'Fixlife_prision:client:take_shower:' .. i)
		end
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

	lib.hideContext()

	Citizen.CreateThread(function()
		local options = {}
		for _, item in ipairs(element) do
			options[#options + 1] = {title = item.label, onSelect = function()
				local data = {current = item}
				local menu = {close = lib.hideContext}
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
							lib.progressBar({ --cavar
								duration =  Config.RoomTools[data.current.value].Time *1000,
								label =  Config.Sayings[96],
								icon = 'fixlife.svg',
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
							-- RemoveAnimDict("mini@repair")
							lib.progressBar({ --cavar
							duration =  Config.RoomTools[data.current.value].Time *1000,
							label =  Config.Sayings[96],
							icon = 'fixlife.svg',
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
							lib.progressBar({ --cortar
								duration =  Config.FenceTool[data.current.value].Time *1000,
								label =  Config.Sayings[97],
								icon = 'fixlife.svg',
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
							-- RemoveAnimDict("mp_arresting")
							lib.progressBar({ --cortar
							duration =  Config.FenceTool[data.current.value].Time *1000,
							label =  Config.Sayings[97],
							icon = 'fixlife.svg',
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
		end}
		end
		lib.registerContext({id = 'fixlife_prision_fence_menu', title = Config.Sayings[94], options = options, onExit = function()
			inMenu.is = false
			inMenu.coords = nil
		end})
		lib.showContext('fixlife_prision_fence_menu')
	end)
end

function IEscaped()
	escapePending = true
	if Config.DebugJail then print(('[Fixlife_prision][DEBUG][CLIENT] IEscaped injail=%s escapePending=%s breakout=%s soltime=%s time=%s'):format(tostring(injail), tostring(escapePending), tostring(breakout), tostring(soltime), tostring(time))) end
	TriggerServerEvent('HD_Jail:PoliceNotify')
	CreateThread(function()
		local lastBucket
		while escapePending and injail do
			Wait(1000)
			local distance = #(GetEntityCoords(PlayerPedId()) - Config.JailLoc)
			local bucket = math.floor(distance / 50)
			if Config.DebugJail and bucket ~= lastBucket then
				lastBucket = bucket
				print(('[Fixlife_prision][DEBUG][CLIENT] fuga pendiente distancia=%.1f limite=%.1f'):format(distance, Config.MaxTpDist))
			end
			if distance > Config.MaxTpDist then
				if Config.DebugJail then print('[Fixlife_prision][DEBUG][CLIENT] enviando EscapeComplete') end
				TriggerServerEvent('HD_Jail:EscapeComplete')
			end
		end
	end)
end

function OpenWallMenu()
	local ped = PlayerPedId()
	local element = {}


	for i = 1, #Config.RoomTools, 1 do
		table.insert(element, {label = Config.RoomTools[i].Name, value = i})
	end

	lib.hideContext()

	Citizen.CreateThread(function()
		local options = {}
		for _, item in ipairs(element) do
			options[#options + 1] = {title = item.label, onSelect = function()
				local data = {current = item}
				local menu = {close = lib.hideContext}
			lib.callback('HD_Jail:CheckItemB', false, function(can)
				if can then
					local hnum = 0
					local rannum = math.random(1,10)
					hnum = rannum
					menu.close()
					if hnum <= Config.RoomTools[data.current.value].Percent then
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
						-- RemoveAnimDict("mini@repair")
						lib.progressBar({ --cabando
							duration =  Config.RoomTools[data.current.value].Time *1000,
							label =  Config.Sayings[96],
							icon = 'fixlife.svg',
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
						TriggerServerEvent('HD_Jail:SuccessFul', data.current.value)
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
						-- RemoveAnimDict("mini@repair")
						lib.progressBar({ --cavando
							duration =  Config.RoomTools[data.current.value].Time *1000,
							label =  Config.Sayings[96],
							icon = 'fixlife.svg',
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
		end}
		end
		lib.registerContext({id = 'fixlife_prision_wall_menu', title = Config.Sayings[87], options = options, onExit = function()
			inMenu.is = false
			inMenu.coords = nil
		end})
		lib.showContext('fixlife_prision_wall_menu')
	end)
end

function BreakOutStart(alreadyAtExit)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        using = true

        if not alreadyAtExit then
            DoScreenFadeOut(1000)
		    Citizen.Wait(1000)
		end
	
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
	
		for i = 1, #Config.WatchCameras, 1 do
			local cameraBlip = CreateWatchCameraBlip(Config.WatchCameras[i], i)
			table.insert(blips, {id = 'tower', data = cameraBlip.blip, camera = i, entity = cameraBlip.entity})
		end
		if not alreadyAtExit then
		    SetEntityCoords(ped, Config.Cells[jailCell].ExitLoc.Loc.x, Config.Cells[jailCell].ExitLoc.Loc.y, Config.Cells[jailCell].ExitLoc.Loc.z - 1, false, false, false, false)
		    SetEntityHeading(ped, Config.Cells[jailCell].ExitLoc.Heading)
		    FreezeEntityPosition(ped, true)
		    Citizen.Wait(1000)
		    FreezeEntityPosition(ped, false)
		end
		breakout = 0
		breakout2 = true
		breakout4 = true
		if not alreadyAtExit then DoScreenFadeIn(1000) end
		Citizen.Wait(1500)
	
		using = false
		for i = 1, #jailLocs, 1 do
			if jailLocs[i].Id == 'break' then
				jailLocs[i].Text = Config.Sayings[28]
			end
		end
	end)
end

