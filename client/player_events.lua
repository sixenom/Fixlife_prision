RegisterNetEvent('HD_Jail:onPlayerDeath')
AddEventHandler('HD_Jail:onPlayerDeath', function()
	local PedKiller = GetPedSourceOfDeath(GetPlayerPed(PlayerId()))
	local Killer = nil
	isDead = true
	TriggerServerEvent('HD_Jail:PlayerDie', true)
	if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
		if GetPlayerServerId(PedKiller) ~= GetPlayerServerId(PlayerId()) then
			Killer = GetPlayerServerId(PedKiller)
		end
	elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
		if GetPlayerServerId(GetPedInVehicleSeat(PedKiller, -1)) ~= GetPlayerServerId(PlayerId()) then
			Killer = GetPlayerServerId(GetPedInVehicleSeat(PedKiller, -1))
		end
	end
	if Killer ~= nil and Config.Sol4Kill and Config.Solitary then
		TriggerServerEvent('HD_Jail:KilledBy', Killer)
	end
end)

RegisterNetEvent('HD_Jail:onPlayerSpawn')
AddEventHandler('HD_Jail:onPlayerSpawn', function()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		if isDead and time > 0 then
			using = true
			DoScreenFadeOut(1000)
			Citizen.Wait(3000)
			if Config.Hospital then
				RequestAnimDict('anim@gangops@morgue@table@')
				RequestAnimDict('missfam4')
				RequestModel(Config.DoctorPed)
		
				if not HasAnimDictLoaded('anim@gangops@morgue@table@') then
					LoadAnim('anim@gangops@morgue@table@')
				end
				if not HasModelLoaded(Config.DoctorPed) then
					LoadPropDict(Config.DoctorPed)
				end
				if not HasAnimDictLoaded('missfam4') then
					LoadAnim('missfam4')
				end
		
		
				local bLocs = 0
				local numo = 0
				local removes = {}
		
				TriggerServerEvent('HD_Jail:UnSee', GetPlayerServerId(PlayerId()))
		
				for i = 1, #Config.BedLocs, 1 do
					bLocs = bLocs + 1
				end
				numo = math.random(1, bLocs)
		
				SetEntityCoords(ped, Config.BedLocs[numo].SpawnLoc.Loc.x, Config.BedLocs[numo].SpawnLoc.Loc.y, Config.BedLocs[numo].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.BedLocs[numo].SpawnLoc.Heading)
				Citizen.Wait(500)
				SetEntityCoords(ped, Config.BedLocs[numo].SpawnLoc.Loc.x, Config.BedLocs[numo].SpawnLoc.Loc.y, Config.BedLocs[numo].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.BedLocs[numo].SpawnLoc.Heading)
				TaskPlayAnim(ped, 'anim@gangops@morgue@table@', 'body_search', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
				RemoveAnimDict('anim@gangops@morgue@table@')
				inAnim.Dict = 'anim@gangops@morgue@table@'
				inAnim.Anim = 'body_search'
				inAnim.Atr = 1
				inAnim.Freeze = true
				FreezeEntityPosition(ped, true)
		
				local byped = CreatePed(5, Config.DoctorPed, Config.BedLocs[numo].DoctorSpawn.Loc.x, Config.BedLocs[numo].DoctorSpawn.Loc.y, Config.BedLocs[numo].DoctorSpawn.Loc.z - 1, Config.BedLocs[numo].DoctorSpawn.Heading, false, true)
				PlaceObjectOnGroundProperly(byped)
				SetEntityAsMissionEntity(byped)
				SetPedDropsWeaponsWhenDead(byped, false)
				SetPedAsEnemy(byped, false)
				SetEntityInvincible(byped, true)
				SetModelAsNoLongerNeeded(Config.DoctorPed)
				table.insert(peds, {id = 'doc', data = byped})
				TaskPlayAnim(byped, 'missfam4', 'base', 8.0, 8.0, -1, 51, 1, 0, 0, 0)
				RemoveAnimDict('missfam4')
				AddPropToPlayer('p_amb_clipboard_01', 36029, 0.16, 0.08, 0.1, -130.0, -50.0, 0.0, 'doc', byped, false)
		
				DoScreenFadeIn(1000)
				Citizen.Wait(1500)
				TaskGoStraightToCoord(byped, Config.BedLocs[numo].DocCheck.Loc.x, Config.BedLocs[numo].DocCheck.Loc.y, Config.BedLocs[numo].DocCheck.Loc.z, 1.0, Config.BedLocs[numo].DocWalkTime *1000, Config.BedLocs[numo].DocCheck.Heading, 0)
				Citizen.Wait(Config.BedLocs[numo].DocWalkTime *1000)
				TaskAchieveHeading(byped, Config.BedLocs[numo].DocCheck.Heading, 1000)
				Citizen.Wait(1000)
				-- exports.rprogress:Start( Config.Sayings[70] ,Config.CheckUpTime *1000)
				lib.progressBar({ --tomando bandeja
					duration =  Config.CheckUpTime *1000,
					label =  Config.Sayings[70],
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
				})
				-- Citizen.Wait(Config.CheckUpTime *1000)
				TaskGoStraightToCoord(byped, Config.BedLocs[numo].DoctorSpawn.Loc.x, Config.BedLocs[numo].DoctorSpawn.Loc.y, Config.BedLocs[numo].DoctorSpawn.Loc.z, 1.0, Config.BedLocs[numo].DocWalkTime *1000, Config.BedLocs[numo].DoctorSpawn.Heading, 0)
				Citizen.Wait(Config.BedLocs[numo].DocWalkTime *1000)
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				SetEntityCoords(ped, Config.Cells[jailCell].SpawnLoc.Loc.x, Config.Cells[jailCell].SpawnLoc.Loc.y, Config.Cells[jailCell].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.Cells[jailCell].SpawnLoc.Heading)
				FreezeEntityPosition(ped, false)
				inAnim.Dict = nil
				inAnim.Anim = nil
				inAnim.Atr = 0
				inAnim.Freeze = false
				ClearPedTasksImmediately(ped)
				ClearPedTasksImmediately(byped)
				TriggerServerEvent('HD_Jail:See', GetPlayerServerId(PlayerId()))
		
				removes = {}
				for i = 1, #PlayerHasProp, 1 do
					if PlayerHasProp[i].id == 'doc' then
						table.insert(removes, i)
					end
				end
				for i = 1, #removes, 1 do
					if DoesEntityExist(PlayerHasProp[removes[i]].object) then
						DeleteObject(PlayerHasProp[removes[i]].object)
					end
					table.remove(PlayerHasProp, removes[i])
				end
				removes = {}
				for i = 1, #peds, 1 do
					if peds[i].id == 'doc' then
						table.insert(removes, i)
					end
				end
				for i = 1, #removes, 1 do
					if DoesEntityExist(peds[removes[i]].data) then
						SetPedAsNoLongerNeeded(peds[removes[i]].data)
						DeletePed(peds[removes[i]].data)
					end
					table.remove(peds, removes[i])
				end
			else
				SetEntityCoords(ped, Config.Cells[jailCell].SpawnLoc.Loc.x, Config.Cells[jailCell].SpawnLoc.Loc.y, Config.Cells[jailCell].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.Cells[jailCell].SpawnLoc.Heading)
				Citizen.Wait(500)
			end
			TriggerServerEvent('HD_Jail:PlayerDie', false)
			isDead = false
			using = false
			DoScreenFadeIn(1000)
			Citizen.Wait(1500)
		end
	end)
end)

RegisterNetEvent('HD_Jail:ShankPull')
AddEventHandler('HD_Jail:ShankPull', function()
	local ped = PlayerPedId()
	local current, curent = GetCurrentPedWeapon(ped, 1)
	local shankie = GetHashKey(Config.ShankWeapon)
	if shankie == curent then
		RemoveWeaponFromPed(ped, shankie)
	else
		GiveWeaponToPed(ped, shankie, 100, false, true)
	end
end)

RegisterNetEvent('HD_Jail:GiveShankie')
AddEventHandler('HD_Jail:GiveShankie', function()
	local ped = PlayerPedId()
	local shankie = GetHashKey(Config.ShankWeapon)
	GiveWeaponToPed(ped, shankie, 100, false, true)
end)

RegisterNetEvent('HD_Jail:PoliceWarning')
AddEventHandler('HD_Jail:PoliceWarning', function(name)
	local goodo = false
	for i = 1, #Config.PoliceRoles, 1 do
		if QBX.PlayerData.job.name == Config.PoliceRoles[i] then
			goodo = true
		end
	end

	if goodo then
		Wait(Config.PoliceNotifyTime *60000)
		Notification(name..Config.Sayings[178])
	end
end)

RegisterNetEvent('HD_Jail:SendNotif2')
AddEventHandler('HD_Jail:SendNotif2', function(msg)
	if QBX.PlayerData.job.name == 'prisoner' or QBX.PlayerData.job.name == 'police'  then
		if time > 0 then
			Notification(msg)
		end
	end
end)

RegisterNetEvent('HD_Jail:SendNotif')
AddEventHandler('HD_Jail:SendNotif', function(msg)
	if QBX.PlayerData.job.name == 'prisoner' or QBX.PlayerData.job.name == 'police'  then
		print(msg)
		Notification(msg)
	else
		print('error')
	end
end)

RegisterNetEvent('HD_Jail:CountWarn')
AddEventHandler('HD_Jail:CountWarn', function(time)
	if QBX.PlayerData.job.name == 'prisoner' or QBX.PlayerData.job.name == 'police'  then
		if time > 0 then
			Notification(time..Config.Sayings[149])
		end
	end
end)

RegisterNetEvent('HD_Jail:TurnOffLock')
AddEventHandler('HD_Jail:TurnOffLock', function()
	lockieDown = false
	if inJailMenu then
		TriggerEvent('HD_Jail:JailMenu')
	end
	if time > 0 then
		Notification(Config.Sayings[151])
	end
end)

RegisterNetEvent('HD_Jail:CountFinish')
AddEventHandler('HD_Jail:CountFinish', function()
	if inJailMenu then
		TriggerEvent('HD_Jail:JailMenu')
	end
	lockieDown = true
	DoLockCheck()
	if time > 0 then
		Notification(Config.Sayings[152])
	end
end)

function DoLockCheck()
	Citizen.CreateThread(function()
		while true do
			if lockieDown then
				if time > 0 then
					if not using then
						Citizen.Wait(250)
						if soltime == 0 and breakout == 0 then
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local dist = Vdist(Config.Cells[jailCell].SpawnLoc.Loc.x, Config.Cells[jailCell].SpawnLoc.Loc.y, Config.Cells[jailCell].SpawnLoc.Loc.z, coords)
							if dist > Config.LockDownDist then
								if Config.Solitary and Config.Sol4Lock then
									using = true
									TriggerServerEvent('HD_Jail:SendToSol', GetPlayerServerId(PlayerId()), Config.SolLockTime, Config.Sayings[150])
								else
									using = true
									SetEntityCoords(ped, Config.Cells[jailCell].SpawnLoc.Loc.x, Config.Cells[jailCell].SpawnLoc.Loc.y, Config.Cells[jailCell].SpawnLoc.Loc.z - 1, false, false, false, false)
									SetEntityHeading(ped, Config.Cells[jailCell].SpawnLoc.Heading)
									Citizen.Wait(500)
									using = false
								end
							end
						end
					else
						Citizen.Wait(500)
					end
				else
					Citizen.Wait(1000)
				end
			else
				Citizen.Wait(5)
				break
			end
		end
	end)
end

