RegisterNetEvent('HD_Jail:UpBreaks')
AddEventHandler('HD_Jail:UpBreaks', function(amt, flip, time)
	local ped = PlayerPedId()
	if amt >= Config.BreakHole then
		breakout3 = true
		if flip then
			Wait(time)
			Notification(Config.Sayings[102])
		end
		for i = 1, #jailLocs, 1 do
			if jailLocs[i].Id == 'break' then
				jailLocs[i].Text = Config.Sayings[89]
			end
		end
	else
		local leftamt = 0
		leftamt = Config.BreakHole - amt
		if flip then
			Wait(time)
			Notification(Config.Sayings[100]..leftamt..Config.Sayings[101])
		end
	end
end)

RegisterNetEvent('HD_Jail:UnBreak2')
AddEventHandler('HD_Jail:UnBreak2', function()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		breakout3 = false
		breakout = 0
		breakout2 = false
		DoScreenFadeOut(1000)
		FreezeEntityPosition(ped, true)
		Citizen.Wait(1500)
		FreezeEntityPosition(ped, false)
		local removes = {}
		for i = 1, #blips, 1 do
			if blips[i].id == 'escape' then
				table.insert(removes, i)
			elseif blips[i].id == 'tower' then
				table.insert(removes, i)
			end
		end
		for i = 1, #removes, 1 do
			if DoesBlipExist(blips[removes[i]].data) then
				RemoveBlip(blips[removes[i]].data)
			end
			table.remove(blips[removes[i]])
		end
		if Config.FailBreakToSol and Config.Solitary then
			TriggerServerEvent('HD_Jail:SendToSol', GetPlayerServerId(PlayerId()), Config.SolBreakTime, Config.Sayings[108])
		else
			SetEntityCoords(ped, Config.Cells[jailCell].SpawnLoc.Loc.x, Config.Cells[jailCell].SpawnLoc.Loc.y, Config.Cells[jailCell].SpawnLoc.Loc.z - 1, false, false, false, false)
			SetEntityHeading(ped, Config.Cells[jailCell].SpawnLoc.Heading)
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		if not using and time > 0 then
			if job ~= 0 then
				if doneTasks ~= 0 then
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					local dist = Vdist(Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.x, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.y, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.z, coords)
	
					if dist <= Config.SeeTaskMark then
						Citizen.Wait(5)
						DrawMarker(Config.JobOptions[job].Tasks[doneTasks].MarkNum, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.x, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.y, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JobOptions[job].Tasks[doneTasks].MarkSize.x, Config.JobOptions[job].Tasks[doneTasks].MarkSize.y, Config.JobOptions[job].Tasks[doneTasks].MarkSize.z, Config.JobOptions[job].Tasks[doneTasks].MarkColor.r, Config.JobOptions[job].Tasks[doneTasks].MarkColor.g, Config.JobOptions[job].Tasks[doneTasks].MarkColor.b, 100, false, false, 2, true, nil, nil, false)
						if dist <= Config.SeeTaskText then
							DrawText3D(Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.x, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.y, Config.JobOptions[job].Tasks[doneTasks].TaskLoc.Loc.z + Config.TextLift, Config.Sayings[22]..Config.JobOptions[job].Tasks[doneTasks].TaskName)
							if IsControlJustReleased(0, 38) then
								TaskComplete()
							end
						end
					else
						Citizen.Wait(1000)
					end
				else
					Citizen.Wait(1000)
				end
			else
				Citizen.Wait(1000)
			end
		elseif needsEat then
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			DrawText3D(coords.x, coords.y, coords.z, Config.Sayings[44])
			if IsControlJustReleased(0, 38) then
				-- exports.rprogress:Start(Config.Sayings[139], Config.EatTime *1000)
				-- Citizen.Wait(Config.EatTime *1000)
				lib.progressCircle({ --comiendo
					duration =  Config.EatTime *1000,
					label =  Config.Sayings[139],
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
				using = false
				needsEat = false
				inAnim.Dict = nil
				inAnim.Anim = nil
				inAnim.Atr = 0
				inAnim.Freeze = false
				ClearPedTasksImmediately(ped)
				local rem = {}
				for i = 1, #PlayerHasProp, 1 do
					if PlayerHasProp[i].id == 'food' then
						DeleteObject(PlayerHasProp[i].object)
						table.insert(rem, i)
					end
				end
				for i = 1, #rem, 1 do
					table.remove(PlayerHasProp, rem[i])
				end
				TriggerServerEvent('HD_Jail:Ate')
			elseif IsControlJustReleased(0, 47) then
				using = false
				needsEat = false
				inAnim.Dict = nil
				inAnim.Anim = nil
				inAnim.Atr = 0
				inAnim.Freeze = false
				ClearPedTasksImmediately(ped)
				local rem = {}
				for i = 1, #PlayerHasProp, 1 do
					if PlayerHasProp[i].id == 'food' then
						DeleteObject(PlayerHasProp[i].object)
						table.insert(rem, i)
					end
				end
				for i = 1, #rem, 1 do
					table.remove(PlayerHasProp, rem[i])
				end
			end
		elseif not using and Config.PoliceCanSearchInv then
			if QBX.PlayerData.job ~= nil then
				local policep = false
				for i = 1, #Config.PoliceRoles, 1 do
					if QBX.PlayerData.job and QBX.PlayerData.job.name == Config.PoliceRoles[i] then
						policep = true
					end
				end
				if policep then
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					local dist = Vdist(Config.Cells[closestPoliceInv].InvLoc.Loc.x, Config.Cells[closestPoliceInv].InvLoc.Loc.y, Config.Cells[closestPoliceInv].InvLoc.Loc.z, coords)

					if dist <= Config.SeePoliceDist then
						Citizen.Wait(5)
						DrawMarker(Config.PMarkNum, Config.Cells[closestPoliceInv].InvLoc.Loc.x, Config.Cells[closestPoliceInv].InvLoc.Loc.y, Config.Cells[closestPoliceInv].InvLoc.Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PMarkSize.x, Config.PMarkSize.y, Config.PMarkSize.z, Config.PMarkColor.r, Config.PMarkColor.g, Config.PMarkColor.b, 100, false, false, 2, true, nil, nil, false)
						if dist <= Config.UsePoliceDist then
							DrawText3D(Config.Cells[closestPoliceInv].InvLoc.Loc.x, Config.Cells[closestPoliceInv].InvLoc.Loc.y, Config.Cells[closestPoliceInv].InvLoc.Loc.z + Config.TextLift, Config.Sayings[158])
							if IsControlJustReleased(0, 38) then
								OpenPoliceShitMenu()
								inMenu.coords = Config.Cells[closestPoliceInv].InvLoc.Loc
								inMenu.is = true
							end
						end
					else
						Citizen.Wait(1000)
					end
				else
					Citizen.Wait(3000)
				end
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('HD_Jail:UnnJail')
AddEventHandler('HD_Jail:UnnJail', function(itemie, clothesi)
	Citizen.CreateThread(function()
		if not using then
			local ped = PlayerPedId()
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)
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
		
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, clothesi)
			end)
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
			beingSent = false
			beingMsg = {msg = nil, size = 0.0}
			closestLoc = 1
			breakout = 0
			breakout2 = false
			breakout3 = false
			breakout4 = true
			closestTower = 1
			closestBreak = 1
			inMenu = {is = false, coords = nil}
			needsEat = false
			itemzie = itemie
			if itemzie[1] ~= nil then
				canGrab = true
				local blip2 = AddBlipForCoord(Config.ItemLoc.Loc.x, Config.ItemLoc.Loc.y, Config.ItemLoc.Loc.z)
				SetBlipSprite(blip2, Config.ItemBlip.Sprite)
				SetBlipScale(blip2, Config.ItemBlip.Size)
				SetBlipColour(blip2, Config.ItemBlip.Color)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.Sayings[11])
				EndTextCommandSetBlipName(blip2)
				table.insert(blips, {id = 'items', data = blip2})
			end
			clothesi = {}
			SetEntityCoords(ped, Config.LeaveLoc.Loc.x, Config.LeaveLoc.Loc.y, Config.LeaveLoc.Loc.z - 1, false, false, false, false)
			SetEntityHeading(ped, Config.LeaveLoc.Heading)
			FreezeEntityPosition(ped, false)
			Citizen.Wait(500)
			jailLocs = {}
			DoScreenFadeIn(500)
		else
			ResetLeave(itemie, clothesi)
		end
	end)
end)

function ResetLeave(oneone, twotwo)
	Citizen.CreateThread(function()
		if not using then
			TriggerEvent('HD_Jail:UnnJail', oneone, twotwo)
		else
			Citizen.Wait(3000)
			ResetLeave(oneone, twotwo)
		end
	end)
end

RegisterNetEvent('HD_Jail:SendSol')
AddEventHandler('HD_Jail:SendSol', function(soltimez, cell)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		soltime = soltimez
		solcell = cell
		SetEntityCoords(ped, Config.SolCells[cell].Loc.x, Config.SolCells[cell].Loc.y, Config.SolCells[cell].Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.SolCells[cell].Heading)
		FreezeEntityPosition(ped, true)
		Citizen.Wait(500)
		DoScreenFadeIn(1000)
	end)
end)

RegisterNetEvent('HD_Jail:UnnSol')
AddEventHandler('HD_Jail:UnnSol', function()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		using = true
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		soltime = 0
		solcell = 0
		SetEntityCoords(ped, Config.Cells[jailCell].SpawnLoc.Loc.x, Config.Cells[jailCell].SpawnLoc.Loc.y, Config.Cells[jailCell].SpawnLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.Cells[jailCell].SpawnLoc.Heading)
		FreezeEntityPosition(ped, false)
		Citizen.Wait(500)
		using = false
		DoScreenFadeIn(1000)
	end)
end)

