xSound = exports.xsound

Citizen.CreateThread(function()
	while QBX.PlayerData.job == nil do
		Citizen.Wait(10)
	end
end)

local infoLoc = 1

time = 0
local difftime = {Hours = 0, Mins = 0, Seconds = 0}

local soltime = 0
local diffSol = {Hours = 0, Mins = 0, Seconds = 0}

isDead = false

job = 0
local doneTasks = 0
local taskMax = 0

injail = false
jailCell = 0
solcell = 0

canGrab = false
local itemzie = {}

createdCamera = 0
beingMsg = {msg = nil, size = 0.0}
beingSent = false

local blips = {}
local peds = {}
PlayerHasProp = {}

local jailLocs = {}
local closestLoc = 1

breakout = 0
local diffBreak = {Hours = 0, Mins = 0, Seconds = 0}
breakout2 = false
breakout3 = false
breakout4 = true
local closestTower = 1
local closestBreak = 1

local inMenu = {is = false, coords = nil}
local inAnim = {Dict = nil, Anim = nil, Atr = 0, Freeze = false}
local needsEat = false

local closestShower = 1
local showerNow = false

local closestOut = 1
local workoutNow = false
local workoutLoc = 0

switchie = false
lockieDown = false
inJailMenu = false

local closestPoliceInv = 1 

local pedsie = nil

Citizen.CreateThread(function()
	Citizen.Wait(500)
	if Config.JailBlip.Spawn then
		local blip2 = AddBlipForCoord(Config.JailLoc.x, Config.JailLoc.y, Config.JailLoc.z)
		SetBlipSprite(blip2, Config.JailBlip.Sprite)
		SetBlipScale(blip2, Config.JailBlip.Size)
		SetBlipColour(blip2, Config.JailBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Sayings[160])
		EndTextCommandSetBlipName(blip2)
		SetBlipAsShortRange(blip2, true)
		if Config.UsingHDBlips then
			exports['HD_Blips']:addBlip('Prison', 'emergency', 'prison', {name = "Name_Of_Blip", coords = Config.JailLoc, sprite = Config.JailBlip.Sprite, color = Config.JailBlip.Color, size = Config.JailBlip.Size, short = true, pulse = false}, blip2, GetCurrentResourceName())
		end
	end
end)

RegisterNetEvent('HD_Blips:ReturnDelete')
AddEventHandler('HD_Blips:ReturnDelete', function(resource, shit)
	if resource == GetCurrentResourceName() then
		if DoesBlipExist(shit) then
			RemoveBlip(shit)
		end
	end
end)

local FirstSpawn = true --cambiado
local restarted = false
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		restarted = true
		Wait(10000)
		restarted = false
    end
end)
Citizen.CreateThread(function() 
	Spawned()
end)
function Spawned()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if QBX and QBX.PlayerData and FirstSpawn then
				if QBX.PlayerData.job ~= nil and not restarted then
					FirstSpawn = false
					Citizen.Wait(3000)
					TriggerServerEvent('HD_Jail:LoadedIn')
					break
				end
			end
		end
	end)
end



AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
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
    end
end)

RegisterNetEvent('HD_Jail:JailStart')
AddEventHandler('HD_Jail:JailStart', function(timez)
	
	local ped = PlayerPedId()
	Citizen.CreateThread(function()
		xSound:PlayUrl("llendoaprision","./sounds/mandandoaprision.mp3",0.5)
		TriggerEvent('aty_hud_v2:ocultarhuds')
		DoScreenFadeOut(1000)
		TriggerEvent("jobs_creator:startProgressBar", 120000, "", "#ff8000")
		RequestAnimDict('mp_character_creation@customise@male_a')
		Citizen.Wait(3000)
		beingMsg.msg = '~r~'..Config.Sayings[5]
		beingMsg.size = 1.0
		beingSent = true

		SetEntityCoords(ped, Config.HandCuffLoc.x, Config.HandCuffLoc.y, Config.HandCuffLoc.z - 1, false, false, false, false)
		Citizen.Wait(500)
		SetEntityCoords(ped, Config.HandCuffLoc.x, Config.HandCuffLoc.y, Config.HandCuffLoc.z - 1, false, false, false, false)
		RequestModel(Config.GuardPed)
		RequestModel(Config.ClothesProp)
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end
		if not HasModelLoaded(Config.GuardPed) then
			LoadPropDict(Config.GuardPed)
		end
		if not HasModelLoaded(Config.ClothesProp) then
			LoadPropDict(Config.ClothesProp)
		end

		TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		inAnim.Dict = 'mp_arresting'
		inAnim.Anim = 'idle'
		inAnim.Atr = 49
		inAnim.Freeze = true
		SetEnableHandcuffs(ped, true)
		DisablePlayerFiring(ped, true)
		SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(ped, false)
		FreezeEntityPosition(ped, true)

		local byped = CreatePed(5, Config.GuardPed, Config.GuardSpawn.Loc.x, Config.GuardSpawn.Loc.y, Config.GuardSpawn.Loc.z - 1, Config.GuardSpawn.Heading, false, true)
		PlaceObjectOnGroundProperly(byped)
		SetEntityAsMissionEntity(byped)
		SetPedDropsWeaponsWhenDead(byped, false)
		SetPedAsEnemy(byped, false)
		SetEntityInvincible(byped, true)
		SetModelAsNoLongerNeeded(Config.GuardPed)
		table.insert(peds, {id = 'guard', data = byped})

		local propo = CreateObject(GetHashKey(Config.ClothesProp), Config.ClothPropLoc.Loc.x, Config.ClothPropLoc.Loc.y, Config.ClothPropLoc.Loc.z - 1,  true,  true, true)
		SetEntityHeading(propo, Config.ClothPropLoc.Heading)
		FreezeEntityPosition(propo, true)
		SetModelAsNoLongerNeeded(Config.ClothesProp)
		table.insert(PlayerHasProp, {id = 'clothesProp', object = propo})

		Citizen.Wait(500)
		AttachEntityToEntity(ped, byped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		SetFocusArea(Config.Cam.x, Config.Cam.y, Config.Cam.z, Config.Cam.x, Config.Cam.y, Config.Cam.z)
		ChangeSecurityCamera(Config.Cam.x, Config.Cam.y, Config.Cam.z, Config.CamRot)
		DoScreenFadeIn(500)
	
		TaskGoStraightToCoord(byped, Config.StopnTurn.Loc.x, Config.StopnTurn.Loc.y, Config.StopnTurn.Loc.z, 1.0, 2500, Config.StopnTurn.Heading, 0)
		Citizen.Wait(2500)
		TaskGoStraightToCoord(byped, Config.EnterLoc.x, Config.EnterLoc.y, Config.EnterLoc.z, 1.0, 2000, 160.0, 0)
		Citizen.Wait(2000)
		TaskGoStraightToCoord(byped, Config.ClothesLoc.Loc.x, Config.ClothesLoc.Loc.y, Config.ClothesLoc.Loc.z, 1.0, 3000, Config.ClothesLoc.Heading, 0)
		Citizen.Wait(3000)
		DetachEntity(ped, true, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedSecondaryTask(ped)
		SetEnableHandcuffs(ped, false)
		DisablePlayerFiring(ped, false)
		SetPedCanPlayGestureAnims(ped, true)
		FreezeEntityPosition(ped, false)

		RequestAnimDict('clothingtie')
		
		if not HasAnimDictLoaded('clothingtie') then
			Citizen.Wait(0)
		end

		TaskGoStraightToCoord(byped, Config.StopnLook.Loc.x, Config.StopnLook.Loc.y, Config.StopnLook.Loc.z, 1.0, 1500, Config.StopnLook2, 0)

		RequestAnimDict('mp_prison_break')
		
		if not HasAnimDictLoaded('mp_prison_break') then
			Citizen.Wait(0)
		end
		Citizen.Wait(1500)
		TaskGoStraightToCoord(byped, Config.ComputerLoc.Loc.x, Config.ComputerLoc.Loc.y, Config.ComputerLoc.Loc.z, 1.0, 2000, Config.ComputerLoc.Heading, 0)
		Citizen.Wait(2000)
		TaskPlayAnim(byped, "mp_prison_break", "hack_loop", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		TaskPlayAnim(ped, "clothingtie", "try_tie_positive_a", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'clothingtie'
		inAnim.Anim = 'try_tie_positive_a'
		inAnim.Atr = 1
		inAnim.Freeze = true

		RequestAnimDict('anim@heists@prison_heistig1_p1_guard_checks_bus')
		
		if not HasAnimDictLoaded('anim@heists@prison_heistig1_p1_guard_checks_bus') then
			Citizen.Wait(0)
		end

		Citizen.Wait(2000)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('HD_Jail:UpdateClothes', skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Undressed.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.Undressed.female)
			end
		end)
		Citizen.Wait(100)
		TaskPlayAnim(ped, "anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus'
		inAnim.Anim = 'loop'
		inAnim.Atr = 1
		inAnim.Freeze = true
		local rem = {}
		for i = 1, #PlayerHasProp, 1 do
			if PlayerHasProp[i].id == 'clothesProp' then
				DeleteObject(PlayerHasProp[i].object)
				table.insert(rem, i)
			end
		end
		for i = 1, #rem, 1 do
			table.remove(PlayerHasProp, rem[i])
		end
		rem = {}
		
		Citizen.Wait(1500)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)
		RequestAnimDict('anim@heists@box_carry@')
								
		if not HasAnimDictLoaded('anim@heists@box_carry@') then
			LoadAnim('anim@heists@box_carry@')
		end
	
		TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'anim@heists@box_carry@'
		inAnim.Anim = 'idle'
		inAnim.Atr = 1
		inAnim.Freeze = true
		RemoveAnimDict('anim@heists@box_carry@')
		AddPropToPlayer(Config.ClothesProp, 60309, 0.000, -0.08, 0.200, -55.0, 290.0, 0.0, 'clothing', nil, false)
		Citizen.Wait(1500)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)
		TaskPlayAnim(ped, "clothingtie", "try_tie_positive_a", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'clothingtie'
		inAnim.Anim = 'try_tie_positive_a'
		inAnim.Atr = 1
		inAnim.Freeze = true
		RemoveAnimDict('clothingtie')
		ClearPedTasksImmediately(byped)
		TaskGoStraightToCoord(byped, Config.PointLoc.Loc.x, Config.PointLoc.Loc.y, Config.PointLoc.Loc.z, 1.0, 2500, Config.PointLoc.Heading, 0)

		RequestAnimDict('gestures@f@standing@casual')
								
		if not HasAnimDictLoaded('gestures@f@standing@casual') then
			LoadAnim('gestures@f@standing@casual')
		end
		Citizen.Wait(2500)
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
			end
		end)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)
		for i = 1, #PlayerHasProp, 1 do
			if PlayerHasProp[i].id == 'clothing' then
				DeleteObject(PlayerHasProp[i].object)
				table.insert(rem, i)
			end
		end
		for i = 1, #rem, 1 do
			table.remove(PlayerHasProp, rem[i])
		end
		rem = {}
		AddPropToPlayer('prop_police_id_board', 58868, 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, 'enter', nil, false)

		TaskPlayAnim(byped, 'gestures@f@standing@casual', 'gesture_point', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		RemoveAnimDict('gestures@f@standing@casual')
		Citizen.Wait(200)
		TaskGoStraightToCoord(ped, Config.EnterLoc.x, Config.EnterLoc.y, Config.EnterLoc.z, 1.0, 4000, Config.EnterHeadings.Front, 0)
		Citizen.Wait(2000)
		ClearPedTasksImmediately(byped)
		TaskGoStraightToCoord(byped, Config.ComputerLoc.Loc.x, Config.ComputerLoc.Loc.y, Config.ComputerLoc.Loc.z, 1.0, 2500, Config.ComputerLoc.Heading, 0)
		Citizen.Wait(2500)
		TaskPlayAnim(byped, "mp_prison_break", "hack_loop", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		RemoveAnimDict('anim@heists@prison_heistig1_p1_guard_checks_bus')
		RemoveAnimDict('mp_prison_break')

		RequestAnimDict('mp_character_creation@customise@male_a')

		if not HasAnimDictLoaded('mp_character_creation@customise@male_a') then
			Citizen.Wait(0)
		end
		TaskPlayAnim(ped, "mp_character_creation@customise@male_a", "loop", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'mp_character_creation@customise@male_a'
		inAnim.Anim = 'loop'
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)

		Citizen.Wait(5500)
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		TaskAchieveHeading(ped, Config.EnterHeadings.Side, 3000)
		Citizen.Wait(3000)
		TaskPlayAnim(ped, "mp_character_creation@customise@male_a", "loop", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		inAnim.Dict = 'mp_character_creation@customise@male_a'
		inAnim.Anim = 'loop'
		inAnim.Atr = 1
		inAnim.Freeze = true
		FreezeEntityPosition(ped, true)
		Citizen.Wait(6000)
		FreezeEntityPosition(ped, false)
		inAnim.Dict = nil
		inAnim.Anim = nil
		inAnim.Atr = 0
		inAnim.Freeze = false
		ClearPedTasksImmediately(ped)
		RemoveAnimDict('mp_character_creation@customise@male_a')
		local rem = {}
		for i = 1, #PlayerHasProp, 1 do
			if PlayerHasProp[i].id == 'enter' then
				DeleteObject(PlayerHasProp[i].object)
				table.insert(rem, i)
			end
		end
		for i = 1, #rem, 1 do
			table.remove(PlayerHasProp, rem[i])
		end
		rem = {}

		ClearPedTasksImmediately(byped)
		TaskGoStraightToCoord(byped, Config.StopnLook.Loc.x, Config.StopnLook.Loc.y, Config.StopnLook.Loc.z, 1.0, 2000, Config.StopnLook.Heading, 0)
		Citizen.Wait(2000)
		TaskGoStraightToCoord(byped, Config.GrabLoc.Loc.x, Config.GrabLoc.Loc.y, Config.GrabLoc.Loc.z, 1.0, 5500, Config.GrabLoc.Heading, 0)
		TaskAchieveHeading(ped, Config.PedGrabHeading, 5500)
		Citizen.Wait(6000)
		TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		RemoveAnimDict('mp_arresting')
		SetEnableHandcuffs(ped, true)
		DisablePlayerFiring(ped, true)
		SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(ped, false)
		FreezeEntityPosition(ped, true)
		Citizen.Wait(500)
		AttachEntityToEntity(ped, byped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		Citizen.Wait(500)
		TaskAchieveHeading(byped, Config.GrabTurnHead, 1500)
		Citizen.Wait(1500)
		TaskGoStraightToCoord(byped, Config.WalkLoc.x, Config.WalkLoc.y, Config.WalkLoc.z, 1.0, 5500, 100, 0)
		Citizen.Wait(5500)
		DetachEntity(ped, true, false)
		ClearPedSecondaryTask(ped)
		SetEnableHandcuffs(ped, false)
		DisablePlayerFiring(ped, false)
		SetPedCanPlayGestureAnims(ped, true)
		FreezeEntityPosition(ped, false)

		local removes = {}
		for i = 1, #peds, 1 do
			if peds[i].id == 'guard' then
				table.insert(removes, i)
			end
		end
		for i = 1, #removes, 1 do
			if DoesEntityExist(peds[removes[i]].data) then
				SetPedAsNoLongerNeeded(peds[removes[i]].data)
				DeletePed(peds[removes[i]].data)
			end
			table.remove(peds[removes[i]])
		end
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		LoadJailCell(timez, true)
	end)

end)



RegisterNetEvent('HD_Jail:TakeBooze')
AddEventHandler('HD_Jail:TakeBooze', function()
	local ped = PlayerPedId()

	Wait(2000)
	SetTimecycleModifier("spectator6")
	SetPedMotionBlur(ped, true)
	SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", true)
	SetPedIsDrunk(ped, true)
	AnimpostfxPlay("ChopVision", 10000001, true)
	ShakeGameplayCam("DRUNK_SHAKE", 1.0)
	Wait(Config.BoozeEffectTime *1000)
	SetPedMoveRateOverride(PlayerId(),1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	SetPedIsDrunk(PlayerPedId(), false)		
	SetPedMotionBlur(ped, false)
	ResetPedMovementClipset(PlayerPedId())
	AnimpostfxStopAll()
	ShakeGameplayCam("DRUNK_SHAKE", 0.0)
	SetTimecycleModifierStrength(0.0)
end)

RegisterNetEvent('HD_Jail:ChangeLoc')
AddEventHandler('HD_Jail:ChangeLoc', function(newLoc)
	if inMenu.is then
		if inMenu.coords == Config.InfoPedLoc[infoLoc].Loc then
			NativeMenu.CloseAll()
			inMenu.is = false
			inMenu.coords = false
		end
	end
	infoLoc = newLoc
	if time > 0 then
		local removes = {}
		for i = 1, #blips, 1 do
			if blips[i].id == 'info' then
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
		for i = 1, #peds, 1 do
			if peds[i].id == 'info' then
				table.insert(removes, i)
			end
		end
		for i = 1, #removes, 1 do
			if DoesEntityExist(peds[removes[i]].data) then
				SetPedAsNoLongerNeeded(peds[removes[i]].data)
				DeletePed(peds[removes[i]].data)
			end
			table.remove(peds[removes[i]])
		end
	
		if Config.InfoPedBlip.Spawn then
			local blip2 = AddBlipForCoord(Config.InfoPedLoc[infoLoc].Loc.x, Config.InfoPedLoc[infoLoc].Loc.y, Config.InfoPedLoc[infoLoc].Loc.z)
			SetBlipSprite(blip2, Config.InfoPedBlip.Sprite)
			SetBlipScale(blip2, Config.InfoPedBlip.Size)
			SetBlipColour(blip2, Config.InfoPedBlip.Color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Sayings[10])
			EndTextCommandSetBlipName(blip2)
			table.insert(blips, {id = 'info', data = blip2})
		end
	
		RequestModel(Config.InfoPed)
	
		LoadPropDict(Config.InfoPed)
	
		local byped = CreatePed(5, Config.InfoPed, Config.InfoPedLoc[infoLoc].Loc.x, Config.InfoPedLoc[infoLoc].Loc.y, Config.InfoPedLoc[infoLoc].Loc.z - 1, Config.InfoPedLoc[infoLoc].Heading, false, true)
		PlaceObjectOnGroundProperly(byped)
		SetEntityAsMissionEntity(byped)
		SetPedDropsWeaponsWhenDead(byped, false)
		FreezeEntityPosition(byped, true)
		SetPedAsEnemy(byped, false)
		SetEntityInvincible(byped, true)
		SetModelAsNoLongerNeeded(Config.InfoPed)
		SetPedCanBeTargetted(byped, false)
		table.insert(peds, {id = 'info', data = byped})
	
		for i = 1, #jailLocs, 1 do
			if jailLocs[i].Id == 'info' then
				jailLocs[i].Loc = Config.InfoPedLoc[newLoc].Loc
			end
		end
	end
end)


RegisterNetEvent('HD_Jail:GoToJail')
AddEventHandler('HD_Jail:GoToJail', function(jtime, job, clothi)
	if clothi then
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
			end
		end)
	end
	LoadJailCell(jtime, false)
	StartJob(job, false)
end)

function LoadJailCell(timu, firstTime)
	local ped = PlayerPedId()
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
	local keepWeapon = {}

	if Config.DontTakeGunUponEntry[1] ~= nil then
		for i = 1, #Config.DontTakeGunUponEntry, 1 do
			if HasPedGotWeapon(ped, GetHashKey(Config.DontTakeGunUponEntry[i]), false) then
				table.insert(keepWeapon, {hash = GetHashKey(Config.DontTakeGunUponEntry[i]), ammo = GetAmmoInPedWeapon(ped, GetHashKey(Config.DontTakeGunUponEntry[i]))})
			end
		end
	end
	RemoveAllPedWeapons(ped, false)
	if keepWeapon[1] ~= nil then
		for i = 1, #keepWeapon, 1 do
			GiveWeaponToPed(ped, keepWeapon.hash, keepWeapon.ammo, true, false)
		end
	end
	keepWeapon = {}

	lib.callback('HD_Jail:GrabInfoLoc', false, function(locnum)
		infoLoc = locnum
	end)


	if Config.InfoPedBlip.Spawn then
		local blip2 = AddBlipForCoord(Config.InfoPedLoc[infoLoc].Loc.x, Config.InfoPedLoc[infoLoc].Loc.y, Config.InfoPedLoc[infoLoc].Loc.z)
		SetBlipSprite(blip2, Config.InfoPedBlip.Sprite)
		SetBlipScale(blip2, Config.InfoPedBlip.Size)
		SetBlipColour(blip2, Config.InfoPedBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Sayings[10])
		EndTextCommandSetBlipName(blip2)
		table.insert(blips, {id = 'info', data = blip2})
	end
	if Config.JobManBlip.Spawn then
		local blip3 = AddBlipForCoord(Config.JobManLoc.Loc.x, Config.JobManLoc.Loc.y, Config.JobManLoc.Loc.z)
		SetBlipSprite(blip3, Config.JobManBlip.Sprite)
		SetBlipScale(blip3, Config.JobManBlip.Size)
		SetBlipColour(blip3, Config.JobManBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Sayings[9])
		EndTextCommandSetBlipName(blip3)
		table.insert(blips, {id = 'jobman', data = blip3})
	end
	if Config.FoodBlip.Spawn then
		local blip4 = AddBlipForCoord(Config.GetFoodLoc.Loc.x, Config.GetFoodLoc.Loc.y, Config.GetFoodLoc.Loc.z)
		SetBlipSprite(blip4, Config.FoodBlip.Sprite)
		SetBlipScale(blip4, Config.FoodBlip.Size)
		SetBlipColour(blip4, Config.FoodBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Sayings[32])
		EndTextCommandSetBlipName(blip4)
		table.insert(blips, {id = 'food', data = blip4})
	end
	if Config.ShowerBlip.Spawn and Config.Showers then
		local blip4 = AddBlipForCoord(Config.ShowerLoc.Loc.x, Config.ShowerLoc.Loc.y, Config.ShowerLoc.Loc.z)
		SetBlipSprite(blip4, Config.ShowerBlip.Sprite)
		SetBlipScale(blip4, Config.ShowerBlip.Size)
		SetBlipColour(blip4, Config.ShowerBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Sayings[112])
		EndTextCommandSetBlipName(blip4)
		table.insert(blips, {id = 'shower', data = blip4})
	end
	if Config.WorkOutBlip.Spawn and Config.WorkingOut then
		for i = 1, #Config.WorkoutLocs, 1 do
			local blip4 = AddBlipForCoord(Config.WorkoutLocs[i].StartLoc.Loc.x, Config.WorkoutLocs[i].StartLoc.Loc.y, Config.WorkoutLocs[i].StartLoc.Loc.z)
			SetBlipSprite(blip4, Config.WorkOutBlip.Sprite)
			SetBlipScale(blip4, Config.WorkOutBlip.Size)
			SetBlipColour(blip4, Config.WorkOutBlip.Color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Sayings[119])
			EndTextCommandSetBlipName(blip4)
			table.insert(blips, {id = 'workout'..i, data = blip4})
		end
	end


	RequestModel(Config.InfoPed)
	RequestModel(Config.JobManPed)

	LoadPropDict(Config.InfoPed)
	LoadPropDict(Config.JobManPed)

	local byped = CreatePed(5, Config.InfoPed, Config.InfoPedLoc[infoLoc].Loc.x, Config.InfoPedLoc[infoLoc].Loc.y, Config.InfoPedLoc[infoLoc].Loc.z - 1, Config.InfoPedLoc[infoLoc].Heading, false, true)
	PlaceObjectOnGroundProperly(byped)
	SetEntityAsMissionEntity(byped)
	SetPedDropsWeaponsWhenDead(byped, false)
	FreezeEntityPosition(byped, true)
	SetPedAsEnemy(byped, false)
	SetEntityInvincible(byped, true)
	SetModelAsNoLongerNeeded(Config.InfoPed)
	SetPedCanBeTargetted(byped, false)
	table.insert(peds, {id = 'info', data = byped})
	local byped2 = CreatePed(5, Config.JobManPed, Config.JobManLoc.Loc.x, Config.JobManLoc.Loc.y, Config.JobManLoc.Loc.z - 1, Config.JobManLoc.Heading, false, true)
	PlaceObjectOnGroundProperly(byped2)
	SetEntityAsMissionEntity(byped2)
	SetPedDropsWeaponsWhenDead(byped2, false)
	FreezeEntityPosition(byped2, true)
	SetPedAsEnemy(byped2, false)
	SetEntityInvincible(byped2, true)
	SetModelAsNoLongerNeeded(Config.JobManPed)
	SetPedCanBeTargetted(byped2, false)
	table.insert(peds, {id = 'jobman', data = byped2})


	table.insert(jailLocs, {Text = Config.Sayings[27], Id = 'info', Loc = Config.InfoPedLoc[infoLoc].Loc, Sub = true, Mark = {Num = Config.IMarkNum, Color = Config.IMarkColor, Size = Config.IMarkSize}})
	table.insert(jailLocs, {Text = Config.Sayings[14], Id = 'jobman', Loc = Config.JobManLoc.Loc, Sub = true, Mark = {Num = Config.JMMarkNum, Color = Config.JMMarkColor, Size = Config.JMMarkSize}})
	table.insert(jailLocs, {Text = Config.Sayings[30], Id = 'food', Loc = Config.GetFoodLoc.Loc, Sub = false, Mark = {Num = Config.FoMarkNum, Color = Config.FoMarkColor, Size = Config.FoMarkSize}})
	if Config.Showers then
		table.insert(jailLocs, {Text = Config.Sayings[113], Id = 'shower', Loc = Config.ShowerLoc.Loc, Sub = false, Mark = {Num = Config.ShowMarkNum, Color = Config.ShowMarkColor, Size = Config.ShowMarkSize}})
	end
	if Config.WorkingOut then
		for i = 1, #Config.WorkoutLocs, 1 do
			table.insert(jailLocs, {Text = Config.Sayings[120], Id = 'workout'..i, Loc = Config.WorkoutLocs[i].StartLoc.Loc, Sub = false, Mark = {Num = Config.WoutMarkNum, Color = Config.WoutMarkColor, Size = Config.WoutMarkSize}})
		end
	end



	Citizen.CreateThread(function()
		lib.callback('HD_Jail:GetCell', false, function(cell)
			if cell ~= 0 then
				TriggerServerEvent('HD_Jail:UpdateCell', cell)
				DoScreenFadeOut(1000)
				if Config.Breakout then
					table.insert(jailLocs, {Text = Config.Sayings[28], Id = 'break', Loc = Config.Cells[cell].BreakLoc.Loc, Sub = false, Mark = {Num = Config.BrMarkNum, Color = Config.BrMarkColor, Size = Config.BrMarkSize}})
				end
				table.insert(jailLocs, {Text = Config.Sayings[29], Id = 'chest', Loc = Config.Cells[cell].InvLoc.Loc, Sub = false, Mark = {Num = Config.ChMarkNum, Color = Config.ChMarkColor, Size = Config.ChMarkSize}})

				local blip5 = AddBlipForCoord(Config.Cells[cell].InvLoc.Loc.x, Config.Cells[cell].InvLoc.Loc.y, Config.Cells[cell].InvLoc.Loc.z)
				SetBlipSprite(blip5, Config.InvBlip.Sprite)
				SetBlipScale(blip5, Config.InvBlip.Size)
				SetBlipColour(blip5, Config.InvBlip.Color)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.Sayings[31])
				EndTextCommandSetBlipName(blip5)
				table.insert(blips, {id = 'chest', data = blip5})

				Citizen.Wait(1500)
				if Config.HaveGuide and firstTime then
					local perTime = Config.TimePer *1000

					SetFocusArea(Config.PrisonCam.x, Config.PrisonCam.y, Config.PrisonCam.z, Config.PrisonCam.x, Config.PrisonCam.y, Config.PrisonCam.z)
					ChangeSecurityCamera(Config.PrisonCam.x, Config.PrisonCam.y, Config.PrisonCam.z, Config.PrisonCamRot)
					beingMsg.size = 0.75
					beingMsg.msg = Config.Sayings[169]
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					Citizen.Wait(perTime + 1000)
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)

					SetFocusArea(Config.JobCam.x, Config.JobCam.y, Config.JobCam.z, Config.JobCam.x, Config.JobCam.y, Config.JobCam.z)
					ChangeSecurityCamera(Config.JobCam.x, Config.JobCam.y, Config.JobCam.z, Config.JobCamRot)
					beingMsg.size = 0.75
					beingMsg.msg = Config.Sayings[170]
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					Citizen.Wait(perTime + 1000)
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)

					SetFocusArea(Config.FoodCam.x, Config.FoodCam.y, Config.FoodCam.z, Config.FoodCam.x, Config.FoodCam.y, Config.FoodCam.z)
					ChangeSecurityCamera(Config.FoodCam.x, Config.FoodCam.y, Config.FoodCam.z, Config.FoodCamRot)
					beingMsg.size = 0.75
					beingMsg.msg = Config.Sayings[171]
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					Citizen.Wait(perTime + 1000)
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)

					if Config.Solitary then
						SetFocusArea(Config.SolCam.x, Config.SolCam.y, Config.SolCam.z, Config.SolCam.x, Config.SolCam.y, Config.SolCam.z)
						ChangeSecurityCamera(Config.SolCam.x, Config.SolCam.y, Config.SolCam.z, Config.SolCamRot)
						beingMsg.size = 0.75
						beingMsg.msg = Config.Sayings[172]
						Citizen.Wait(100)
						DoScreenFadeIn(1000)
						Citizen.Wait(perTime + 1000)
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
					end

					if Config.WorkingOut then
						SetFocusArea(Config.WorkOutCam.x, Config.WorkOutCam.y, Config.WorkOutCam.z, Config.WorkOutCam.x, Config.WorkOutCam.y, Config.WorkOutCam.z)
						ChangeSecurityCamera(Config.WorkOutCam.x, Config.WorkOutCam.y, Config.WorkOutCam.z, Config.WorkOutCamRot)
						beingMsg.size = 0.75
						beingMsg.msg = Config.Sayings[173]
						Citizen.Wait(100)
						DoScreenFadeIn(1000)
						Citizen.Wait(perTime + 1000)
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
					end

					if Config.Showers then
						SetFocusArea(Config.ShowerCam.x, Config.ShowerCam.y, Config.ShowerCam.z, Config.ShowerCam.x, Config.ShowerCam.y, Config.ShowerCam.z)
						ChangeSecurityCamera(Config.ShowerCam.x, Config.ShowerCam.y, Config.ShowerCam.z, Config.ShowerCamRot)
						beingMsg.size = 0.75
						beingMsg.msg = Config.Sayings[174]
						Citizen.Wait(100)
						DoScreenFadeIn(1000)
						Citizen.Wait(perTime + 1000)
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
					end

					if Config.Hospital then
						SetFocusArea(Config.HospitalCam.x, Config.HospitalCam.y, Config.HospitalCam.z, Config.HospitalCam.x, Config.HospitalCam.y, Config.HospitalCam.z)
						ChangeSecurityCamera(Config.HospitalCam.x, Config.HospitalCam.y, Config.HospitalCam.z, Config.HospitalCamRot)
						beingMsg.size = 0.75
						beingMsg.msg = Config.Sayings[175]
						Citizen.Wait(100)
						DoScreenFadeIn(1000)
						Citizen.Wait(perTime + 1000)
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
					end

					SetFocusArea(Config.ItemCam.x, Config.ItemCam.y, Config.ItemCam.z, Config.ItemCam.x, Config.ItemCam.y, Config.ItemCam.z)
					ChangeSecurityCamera(Config.ItemCam.x, Config.ItemCam.y, Config.ItemCam.z, Config.ItemCamRot)
					beingMsg.size = 0.75
					beingMsg.msg = Config.Sayings[176]
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					Citizen.Wait(perTime + 1000)
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)

					SetFocusArea(Config.PrisonCam.x, Config.PrisonCam.y, Config.PrisonCam.z, Config.PrisonCam.x, Config.PrisonCam.y, Config.PrisonCam.z)
					ChangeSecurityCamera(Config.PrisonCam.x, Config.PrisonCam.y, Config.PrisonCam.z, Config.PrisonCamRot)
					beingMsg.size = 0.75
					beingMsg.msg = Config.Sayings[177]
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					Citizen.Wait(perTime + 1000)
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					TriggerEvent('aty_hud_v2:mostrarhuds')
				end
				beingSent = false
				beingMsg = {msg = nil, size = 0.0}
				CloseSecurityCamera()
				SetEntityCoords(ped, Config.Cells[cell].SpawnLoc.Loc.x, Config.Cells[cell].SpawnLoc.Loc.y, Config.Cells[cell].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.Cells[cell].SpawnLoc.Heading)

				Citizen.Wait(200)

				SetEntityCoords(ped, Config.Cells[cell].SpawnLoc.Loc.x, Config.Cells[cell].SpawnLoc.Loc.y, Config.Cells[cell].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.Cells[cell].SpawnLoc.Heading)
				jailCell = cell
				if not Config.SimpleTime then
					local duration = timu
					local extraSeconds = duration%60
					local minutes = (duration-extraSeconds)/60
					if duration >= 60 then
						if minutes >= 60 then
							local extraMinutes = minutes%60
							local hours = (minutes-extraMinutes)/60
							difftime.Hours = math.floor(hours)
							difftime.Mins = math.ceil(extraMinutes)
							difftime.Seconds = extraSeconds
						end
					else
						difftime.Hours = 0
						difftime.Mins = 0
						difftime.Seconds = timu
					end
				end
				time = timu
				Citizen.Wait(500)
				injail = true
				Citizen.Wait(1000)
				TriggerServerEvent('HD_Jail:CheckSol', GetPlayerServerId(PlayerId()))
			end
		end)
	end)
end

RegisterNetEvent('HD_Jail:NotSol')
AddEventHandler('HD_Jail:NotSol', function()
	DoScreenFadeIn(500)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if breakout2 then
			local minDistance3 = 100
			local minDistance2 = 5
			for i = 1, #Config.WatchTowers, 1 do
				dist2 = Vdist(Config.WatchTowers[i].x, Config.WatchTowers[i].y, Config.WatchTowers[i].z, coords)
				if dist2 < minDistance3 then
					minDistance3 = dist2
					closestTower = i
				end
			end

			for i = 1, #Config.BreakLocs, 1 do
				dist = Vdist(Config.BreakLocs[i].StartLoc.Loc.x, Config.BreakLocs[i].StartLoc.Loc.y, Config.BreakLocs[i].StartLoc.Loc.z, coords)
				if dist < minDistance2 then
					minDistance2 = dist
					closestBreak = i
				end
			end
		else
			local minDistance = 5
			local minDistance2 = 5
			local minDistance3 = 5
			local minDistance4 = 15
			for i = 1, #jailLocs, 1 do
				dist = Vdist(jailLocs[i].Loc.x, jailLocs[i].Loc.y, jailLocs[i].Loc.z, coords)
				if dist < minDistance then
					minDistance = dist
					closestLoc = i
				end
			end

			for i = 1, #Config.ShowerLocs, 1 do
				dist = Vdist(Config.ShowerLocs[i].x, Config.ShowerLocs[i].y, Config.ShowerLocs[i].z, coords)
				if dist < minDistance2 then
					minDistance2 = dist
					closestShower = i
				end
			end

			if workoutNow then
				for i = 1, #Config.WorkoutLocs[workoutLoc].Locs, 1 do
					dist = Vdist(Config.WorkoutLocs[workoutLoc].Locs[i].Loc.x, Config.WorkoutLocs[workoutLoc].Locs[i].Loc.y, Config.WorkoutLocs[workoutLoc].Locs[i].Loc.z, coords)
					if dist < minDistance3 then
						minDistance3 = dist
						closestOut = i
					end
				end
			end

			for i = 1, #Config.PoliceRoles, 1 do
				if QBX.PlayerData.job and QBX.PlayerData.job.name == Config.PoliceRoles[i] then
					for k = 1, #Config.Cells, 1 do
						dist = Vdist(Config.Cells[k].InvLoc.Loc.x, Config.Cells[k].InvLoc.Loc.y, Config.Cells[k].InvLoc.Loc.z, coords)
						if dist < minDistance4 then
							minDistance4 = dist
							closestPoliceInv = k
						end
					end
				end
			end
		end
	end
end)



Citizen.CreateThread(function()
	while true do
		if beingSent then
			local ped = PlayerPedId()
			pedsie = GetPeds({ped})
			Citizen.Wait(250)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if beingSent then
			Citizen.Wait(5)
			drawTxt(beingMsg.msg,0,1,0.5,0.8,beingMsg.size,255,255,255,255)
			DisableAllControlActions(0)
			if pedsie ~= nil then
				for i=1, #pedsie, 1 do
					local pedo = pedsie[i]
					if IsPedAPlayer(pedo) then
						SetEntityLocallyInvisible(pedo)
						SetEntityNoCollisionEntity(ped, pedo, true)
					end
				end
			end
		elseif canGrab then
			local dist = Vdist(Config.ItemLoc.Loc.x, Config.ItemLoc.Loc.y, Config.ItemLoc.Loc.z, coords)
			if not using then
				if dist <= Config.ShowItemDist then
					Citizen.Wait(5)
					DrawMarker(Config.LMarkNum, Config.ItemLoc.Loc.x, Config.ItemLoc.Loc.y, Config.ItemLoc.Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.LMarkSize.x, Config.LMarkSize.y, Config.LMarkSize.z, Config.LMarkColor.r, Config.LMarkColor.g, Config.LMarkColor.b, 100, false, false, 2, true, nil, nil, false)
					if dist <= Config.ItemTextDist then
						DrawText3D(Config.ItemLoc.Loc.x, Config.ItemLoc.Loc.y, Config.ItemLoc.Loc.z, Config.Sayings[12])
						if IsControlJustReleased(1,38) then
							canGrab = false
							SetEntityCoords(ped, Config.ItemLoc.Loc.x, Config.ItemLoc.Loc.y, Config.ItemLoc.Loc.z - 1, false, false, false, false)
							SetEntityHeading(ped, Config.ItemLoc.Heading)
							

							RequestAnimDict('anim@amb@clubhouse@bar@drink@idle_a')
							
							LoadAnim('anim@amb@clubhouse@bar@drink@idle_a')

							lib.progressCircle({ --pertenencias
								duration = Config.RetreiveTime *1000,
								label = Config.Sayings[13],
								position = 'bottom',
								useWhileDead = false,
								canCancel = false,
								disable = {
									car = true,
									move = true,
									combat = true,
									mouse = false,
								},
							},
							TaskPlayAnim(ped, "anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
						)
							
							inAnim.Dict = 'anim@amb@clubhouse@bar@drink@idle_a'
							inAnim.Anim = 'idle_a_bartender'
							inAnim.Atr = 1
							inAnim.Freeze = true
							FreezeEntityPosition(ped, true)
							-- Citizen.Wait(Config.RetreiveTime *1000)
							TriggerServerEvent('HD_Jail:RetrieveItems', itemzie)
							local removes = {}
							for i = 1, #blips, 1 do
								if blips[i].id == 'items' then
									table.insert(removes, i)
								end
							end
							for i = 1, #removes, 1 do
								if DoesBlipExist(blips[removes[i]].data) then
									RemoveBlip(blips[removes[i]].data)
								end
								table.remove(blips[removes[i]])
							end
							RemoveAnimDict("anim@amb@clubhouse@bar@drink@idle_a")
							FreezeEntityPosition(ped, false)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							ClearPedTasksImmediately(ped)
							itemzie = {} 
						end
					end
				else
					Citizen.Wait(1000)
				end
			else 
				Citizen.Wait(1000)
			end
		elseif breakout2 then
			local dist = Vdist(Config.WatchTowers[closestTower].x, Config.WatchTowers[closestTower].y, Config.WatchTowers[closestTower].z - 1, coords)

			if not using and not isDead then
				if dist <= Config.SeeWatchDist then
					Citizen.Wait(5)
					DrawMarker(1, Config.WatchTowers[closestTower].x, Config.WatchTowers[closestTower].y, Config.WatchTowers[closestTower].z -1, 0, 0, 0, 0, 0, 0, Config.WatchDist * 2, Config.WatchDist * 2, 2.0, Config.WatchMarkColor.r, Config.WatchMarkColor.g, Config.WatchMarkColor.b, 155, 0, 0, 2, 0, 0, 0, 0)
					if dist <= Config.WatchDist then
						breakout2 = false
						breakout4 = true
						TriggerServerEvent('HD_Jail:UnBreak', GetPlayerServerId(PlayerId()))
					end
				else
					if dist >= Config.MaxWatchDist then
						IEscaped()
						breakout2 = false
						breakout4 = true
					end
					Citizen.Wait(500)
				end
			else
				Citizen.Wait(1000)
			end
		elseif time > 0 then
			local dist = Vdist(jailLocs[closestLoc].Loc.x, jailLocs[closestLoc].Loc.y, jailLocs[closestLoc].Loc.z, coords)
			
			if not using and not isDead then
				if dist <= Config.SeeDist then
					Citizen.Wait(5)
					if jailLocs[closestLoc] ~= nil then
						if jailLocs[closestLoc].Sub then
							DrawMarker(jailLocs[closestLoc].Mark.Num, jailLocs[closestLoc].Loc.x, jailLocs[closestLoc].Loc.y, jailLocs[closestLoc].Loc.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, jailLocs[closestLoc].Mark.Size.x, jailLocs[closestLoc].Mark.Size.y, jailLocs[closestLoc].Mark.Size.z, jailLocs[closestLoc].Mark.Color.r, jailLocs[closestLoc].Mark.Color.g, jailLocs[closestLoc].Mark.Color.b, 100, false, false, 2, true, nil, nil, false)
						else
							DrawMarker(jailLocs[closestLoc].Mark.Num, jailLocs[closestLoc].Loc.x, jailLocs[closestLoc].Loc.y, jailLocs[closestLoc].Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, jailLocs[closestLoc].Mark.Size.x, jailLocs[closestLoc].Mark.Size.y, jailLocs[closestLoc].Mark.Size.z, jailLocs[closestLoc].Mark.Color.r, jailLocs[closestLoc].Mark.Color.g, jailLocs[closestLoc].Mark.Color.b, 100, false, false, 2, true, nil, nil, false)
						end
					end
					
					if dist <= Config.TextDist then
						DrawText3D(jailLocs[closestLoc].Loc.x, jailLocs[closestLoc].Loc.y, jailLocs[closestLoc].Loc.z + Config.TextLift, jailLocs[closestLoc].Text)
						if IsControlJustReleased(1,38) then
							if jailLocs[closestLoc].Id == 'jobman' then
								inMenu.coords = Config.JobManLoc.Loc 
								inMenu.is = true
								OpenJobManMenu()
							elseif jailLocs[closestLoc].Id == 'chest' then
								OpenChest(true)
							elseif jailLocs[closestLoc].Id == 'food' then
								OpenFood()
							elseif jailLocs[closestLoc].Id == 'info' then
								inMenu.coords = Config.InfoPedLoc[infoLoc].Loc 
								inMenu.is = true
								OpenInfoMenu()
							elseif jailLocs[closestLoc].Id == 'shower' then
								StartShower()
							elseif jailLocs[closestLoc].Id == 'break' then
								if breakout3 then
									inMenu.coords = nil
									inMenu.is = false
									BreakOutStart()
								else
									inMenu.coords = Config.Cells[jailCell].BreakLoc.Loc
									inMenu.is = true
									OpenWallMenu()
								end
							else 
								if not workoutNow then
									StartWorkout(closestOut)
								else
									EndWorkout()
								end
							end
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
	end
end)

Citizen.CreateThread(function()
	while true do
		if breakout > 0 and not using then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local dist = Vdist(Config.BreakLocs[closestBreak].StartLoc.Loc.x, Config.BreakLocs[closestBreak].StartLoc.Loc.y, Config.BreakLocs[closestBreak].StartLoc.Loc.z, coords)

			if dist <= Config.SeeBreakDist and not isDead then
				Citizen.Wait(5)
				DrawMarker(Config.BreakMarkNum, Config.BreakLocs[closestBreak].StartLoc.Loc.x, Config.BreakLocs[closestBreak].StartLoc.Loc.y, Config.BreakLocs[closestBreak].StartLoc.Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.BreakMarkSize.x, Config.BreakMarkSize.y, Config.BreakMarkSize.z, Config.BreakMarkColor.r, Config.BreakMarkColor.g, Config.BreakMarkColor.b, 100, false, false, 2, true, nil, nil, false)

				if dist <= Config.BreakTextDist then
					DrawText3D(Config.BreakLocs[closestBreak].StartLoc.Loc.x, Config.BreakLocs[closestBreak].StartLoc.Loc.y, Config.BreakLocs[closestBreak].StartLoc.Loc.z + Config.TextLift, Config.Sayings[93])

					if IsControlJustReleased(0, 38) then
						OpenBreakingMenu()
						inMenu.coords = Config.BreakLocs[closestBreak].StartLoc.Loc
						inMenu.is = true
					end
				end
			else
				Citizen.Wait(1000)
			end
		elseif not isDead and workoutNow then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local dist = Vdist(Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.x, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.y, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.z, coords)

			if dist <= Config.SeeWorkDist and not using then
				Citizen.Wait(5)
				DrawMarker(Config.WoutMarkNum, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.x, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.y, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.WoutMarkSize.x, Config.WoutMarkSize.y, Config.WoutMarkSize.z, Config.WoutMarkColor.r, Config.WoutMarkColor.g, Config.WoutMarkColor.b, 100, false, false, 2, true, nil, nil, false)

				if dist <= Config.WorkText then
					DrawText3D(Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.x, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.y, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.z + Config.TextLift, Config.Sayings[122]..Config.WorkoutLocs[workoutLoc].Locs[closestOut].Label)

					if IsControlJustReleased(0, 47) then
						using = true
						SetEntityCoords(ped, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.x, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.y, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.z - 1, false, false, false, false)
						SetEntityHeading(ped, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Heading)

						if Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Aim ~= nil then
							RequestAnimDict(Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Dict)
		
							if not HasAnimDictLoaded(Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Dict) then
								Citizen.Wait(0)
							end
						
							TaskPlayAnim(ped, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Dict, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Aim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Dict
							inAnim.Anim = Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Aim
							inAnim.Atr = 1
							inAnim.Freeze = true
						else
							TaskStartScenarioInPlace(ped, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Dict, 0, true)
						end
						FreezeEntityPosition(ped, true)

						lib.progressCircle({ --ejercicio
							duration =  Config.WorkoutLocs[workoutLoc].Locs[closestOut].Time *1000,
							label =  Config.Sayings[123],
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
						
						-- Citizen.Wait(Config.WorkoutLocs[workoutLoc].Locs[closestOut].Time *1000)
						if Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Aim ~= nil then
							TaskPlayAnim(ped, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Dict, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Aim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							RemoveAnimDict(Config.WorkoutLocs[workoutLoc].Locs[closestOut].Anim.Dict)
						end
						ClearPedTasksImmediately(ped)
						FreezeEntityPosition(ped, false)
						using = false
					end
				end
			else
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local dist = Vdist(Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.x, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.y, Config.WorkoutLocs[workoutLoc].Locs[closestOut].Loc.z, coords)

				if dist >= Config.MaxDistWorkout then
					workoutNow = false
					Wait(1000)
					workoutLoc = 0
					using = false
					Notification(Config.Sayings[124])
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
							TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
						else
							TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
						end
					end)
				end
				Citizen.Wait(500)
			end
		elseif not isDead and showerNow then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local dist = Vdist(Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z, coords)

			if dist <= Config.ShowerFullDist then
				Citizen.Wait(5)
				for i = 1, #Config.ShowerLocs, 1 do
					local dist2 = Vdist(Config.ShowerLocs[i].x, Config.ShowerLocs[i].y, Config.ShowerLocs[i].z, coords)
					if dist2 <= Config.ShowerMarkerDist then
						DrawMarker(Config.ShowMarkNum, Config.ShowerLocs[i].x, Config.ShowerLocs[i].y, Config.ShowerLocs[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.ShowMarkSize.x, Config.ShowMarkSize.y, Config.ShowMarkSize.z, Config.ShowMarkColor.r, Config.ShowMarkColor.g, Config.ShowMarkColor.b, 100, false, false, 2, true, nil, nil, false)
					end
				end

				if dist <= Config.ShowerDist and not isDead then
					DrawText3D(Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z + Config.TextLift, Config.Sayings[116])

					if IsControlJustReleased(0, 47) then
						showerNow = false
						SetEntityCoords(ped, Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z - 1, false, false, false, false)

						if not HasNamedPtfxAssetLoaded("core") then
							RequestNamedPtfxAsset("core")
							while not HasNamedPtfxAssetLoaded("core") do
								Wait(1)
							end
						end
						TaskStartScenarioInPlace((PlayerPedId()), "PROP_HUMAN_STAND_IMPATIENT", 0, true)
						-- exports.rprogress:Start( Config.Sayings[118], 18 *1000)
						UseParticleFxAssetNextCall("core") particles  = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z +1.8, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) particles2  = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z +1.8, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) particles3  = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z +1.8, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) particles4  = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z +1.8, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) particles5  = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z +1.8, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
						Citizen.Wait(6000)
						ClearPedTasksImmediately(ped)
						using = false
						TriggerEvent('skinchanger:getSkin', function(skin)
							if skin.sex == 0 then
								TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
							else
								TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
							end
						end)
					end
				end
			else
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local dist = Vdist(Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z, coords)

				if dist >= Config.MaxDistShower then
					showerNow = false
					using = false
					Notification(Config.Sayings[117])
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
							TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
						else
							TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
						end
					end)
				end
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

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

