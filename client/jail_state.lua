RegisterNetEvent('HD_Jail:JailStart')
AddEventHandler('HD_Jail:JailStart', function(timez)
	
	local ped = PlayerPedId()
	Citizen.CreateThread(function()
		
		DoScreenFadeOut(1000)
		RequestAnimDict('mp_character_creation@customise@male_a')
		exports['Fixlife_hud']:setCinematicMode(true)
		Citizen.Wait(3000)
		SetEntityCoords(ped, Config.HandCuffLoc.Loc.x, Config.HandCuffLoc.Loc.y, Config.HandCuffLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.HandCuffLoc.Heading)
		Citizen.Wait(500)
		SetEntityCoords(ped, Config.HandCuffLoc.Loc.x, Config.HandCuffLoc.Loc.y, Config.HandCuffLoc.Loc.z - 1, false, false, false, false)
		SetEntityHeading(ped, Config.HandCuffLoc.Heading)
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

		TaskGoStraightToCoord(byped, Config.PreComputerLoc.Loc.x, Config.PreComputerLoc.Loc.y, Config.PreComputerLoc.Loc.z, 1.0, 2000, Config.PreComputerLoc.Heading, 0)
		Citizen.Wait(2000)
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
		if Config.TestSceneOnly then
			exports['Fixlife_hud']:setCinematicMode(false)
			CloseSecurityCamera()
			ClearPedTasksImmediately(ped)
			SetEnableHandcuffs(ped, false)
			DisablePlayerFiring(ped, false)
			SetPedCanPlayGestureAnims(ped, true)
			FreezeEntityPosition(ped, false)
			DoScreenFadeIn(500)
			Config.TestSceneOnly = false
			return
		end
		LoadJailCell(timez, true)
	end)

end)

RegisterCommand('probarentrada', function()
	Config.TestSceneOnly = true
	TriggerEvent('HD_Jail:JailStart', 60)
end)

RegisterCommand('probarpresentacion', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1200)
	StartPrisonIntro(1000)
	Citizen.Wait(100)
	DoScreenFadeIn(1000)
	Citizen.Wait((Config.PrisonIntroDuration * 1000) + 1000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	CloseSecurityCamera()
	exports['Fixlife_hud']:setCinematicMode(false)
	DoScreenFadeIn(500)
end)

RegisterCommand('probartrabajo', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CreateThread(function()
		StartJobIntro((Config.TimePer * 1000) + 1000)
	end)
	Citizen.Wait(100)
	DoScreenFadeIn(500)
	Citizen.Wait(Config.TimePer * 1000)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CloseSecurityCamera()
	exports['Fixlife_hud']:setCinematicMode(false)
	DoScreenFadeIn(500)
end)

RegisterCommand('probarcomedor', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CreateThread(function()
		StartFoodIntro((Config.TimePer * 1000) + 1000)
	end)
	Citizen.Wait(100)
	DoScreenFadeIn(500)
	Citizen.Wait(Config.TimePer * 1000)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CloseSecurityCamera()
	exports['Fixlife_hud']:setCinematicMode(false)
	DoScreenFadeIn(500)
end)

RegisterCommand('probaraislamiento', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CreateThread(function()
		StartJobIntro((Config.TimePer * 1000) + 1000, Config.SolIntroCam1, Config.SolIntroCam2, Config.SolIntroCamHeading)
	end)
	Citizen.Wait(100)
	DoScreenFadeIn(500)
	Citizen.Wait(Config.TimePer * 1000)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CloseSecurityCamera()
	exports['Fixlife_hud']:setCinematicMode(false)
	DoScreenFadeIn(500)
end)

RegisterCommand('probarduchas', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CreateThread(function()
		StartFoodIntro((Config.TimePer * 1000) + 1000, Config.ShowerIntroCenter, Config.ShowerIntroDirection, Config.ShowerIntroRadius, Config.ShowerIntroAngle, Config.ShowerIntroStartAngle)
	end)
	Citizen.Wait(100)
	DoScreenFadeIn(500)
	Citizen.Wait(Config.TimePer * 1000)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CloseSecurityCamera()
	exports['Fixlife_hud']:setCinematicMode(false)
	DoScreenFadeIn(500)
end)

RegisterCommand('probarobjetos', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CreateThread(function()
		StartJobIntro((Config.TimePer * 1000) + 1000, Config.ItemIntroCam1, Config.ItemIntroCam2, Config.ItemIntroHeading1, Config.ItemIntroHeading2)
	end)
	Citizen.Wait(100)
	DoScreenFadeIn(500)
	Citizen.Wait(Config.TimePer * 1000)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CloseSecurityCamera()
	exports['Fixlife_hud']:setCinematicMode(false)
	DoScreenFadeIn(500)
end)

RegisterCommand('probarcierre', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	CreateThread(function()
		StartFinalPrisonHeli()
	end)
	CreateThread(function()
	StartFinalOrbit(((Config.FinalHeliDuration + Config.FinalHeliDescentDuration) * 1000) + 1000)
	end)
	Citizen.Wait(100)
	DoScreenFadeIn(500)
	Citizen.Wait(((Config.FinalHeliDuration + Config.FinalHeliDescentDuration) * 1000) + 500)
	DoScreenFadeOut(500)
	Citizen.Wait(700)
	CleanupPrisonHeli(GetEntityCoords(PlayerPedId()), false)
	CloseSecurityCamera()
	exports['Fixlife_hud']:setCinematicMode(false)
	DoScreenFadeIn(500)
end)

RegisterCommand('probarhelicoptero', function()
	exports['Fixlife_hud']:setCinematicMode(true)
	StartPrisonHeliTest()
	CleanupPrisonHeli(Config.PrisonIntroPath[#Config.PrisonIntroPath].To)
	exports['Fixlife_hud']:setCinematicMode(false)
end)

local watchCamerasDebug = false
local watchCameraDebugBlips = {}
local watchCameraEntities = {}
local GetWatchCameraHeading
local GetWatchCameraBlipHeading

local function SetupWatchCameraCone(blip, heading)
	local radians = (heading + 180.0) * math.pi / 180.0
	Citizen.InvokeNative(0xF83D0FEBE75E62C9, blip, -1.0, 1.0, Config.WatchCameraConeWidth, 1.0, Config.WatchCameraConeLength, radians, 0, Config.WatchBlip.ConeColor)
	SetBlipShowCone(blip, true, Config.WatchBlip.ConeColor)
end

function CreateWatchCameraBlip(camera, index)
	local model = joaat('prop_cctv_cam_01a')
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end

	local entity = CreateObjectNoOffset(model, camera.x, camera.y, camera.z, false, false, false)
	SetEntityVisible(entity, true, false)
	SetEntityAlpha(entity, 0, false)
	SetEntityCollision(entity, false, false)
	FreezeEntityPosition(entity, true)
	SetEntityInvincible(entity, true)
	SetEntityAsMissionEntity(entity, true, true)
	SetEntityHeading(entity, GetWatchCameraHeading(index))
	SetModelAsNoLongerNeeded(model)

	local blip = AddBlipForEntity(entity)
	SetBlipSprite(blip, Config.WatchBlip.Sprite)
	SetBlipScale(blip, Config.WatchBlip.Size)
	SetBlipColour(blip, Config.WatchBlip.Color)
	SetBlipDisplay(blip, 4)
	SetupWatchCameraCone(blip, (GetWatchCameraBlipHeading(GetWatchCameraHeading(index)) + 180.0) % 360.0)
	SetBlipSprite(blip, Config.WatchBlip.Sprite)
	SetBlipColour(blip, Config.WatchBlip.Color)
	SetBlipAsShortRange(blip, false)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(('Camara %d'):format(index))
	EndTextCommandSetBlipName(blip)

	local entry = {blip = blip, entity = entity, camera = index}
	watchCameraEntities[#watchCameraEntities + 1] = entry
	return entry
end

local function SetWatchCameraDebugBlips(enabled)
	if not enabled then
		for _, entry in ipairs(watchCameraDebugBlips) do
			if DoesBlipExist(entry.blip) then RemoveBlip(entry.blip) end
		end
		watchCameraDebugBlips = {}
		return
	end

	for i, camera in ipairs(Config.WatchCameras) do
		watchCameraDebugBlips[#watchCameraDebugBlips + 1] = CreateWatchCameraBlip(camera, i)
	end
end

GetWatchCameraHeading = function(index)
	local center = (index - 1) * 360.0 / #Config.WatchCameras
	local cycle = (GetGameTimer() / 1000.0 * Config.WatchCameraSweepSpeed + index * 37.0) % 360.0
	local halfSweep = Config.WatchCameraSweepAngle / 2.0
	local offset = cycle <= 180.0 and (cycle / 180.0 * Config.WatchCameraSweepAngle - halfSweep) or ((360.0 - cycle) / 180.0 * Config.WatchCameraSweepAngle - halfSweep)
	return (center + offset) % 360.0
end

local function IsPlayerInWatchCamera(camera, heading, coords)
	local distance = #(vector3(coords.x, coords.y, 0.0) - vector3(camera.x, camera.y, 0.0))
	if distance > Config.WatchCameraRange then return false end

	local targetHeading = (math.deg(math.atan(coords.x - camera.x, coords.y - camera.y)) + 360.0) % 360.0
	local delta = math.abs((targetHeading - heading + 180.0) % 360.0 - 180.0)
	return delta <= Config.WatchCameraFov / 2.0
end

local function DrawWatchCameraCone(camera, heading)
	local function pointAt(angle, distance, z)
		local radians = math.rad(angle)
		return vector3(camera.x + math.sin(radians) * distance, camera.y + math.cos(radians) * distance, z)
	end

	local left = pointAt(heading - Config.WatchCameraFov / 2.0, Config.WatchCameraRange, camera.z - 1.0)
	local right = pointAt(heading + Config.WatchCameraFov / 2.0, Config.WatchCameraRange, camera.z - 1.0)
	local origin = vector3(camera.x, camera.y, camera.z)
	DrawPoly(origin.x, origin.y, origin.z, left.x, left.y, left.z, right.x, right.y, right.z, 255, 220, 0, 45)
	DrawLine(origin.x, origin.y, origin.z, left.x, left.y, left.z, 255, 220, 0, 180)
	DrawLine(origin.x, origin.y, origin.z, right.x, right.y, right.z, 255, 220, 0, 180)
end

GetWatchCameraBlipHeading = function(heading)
	return (360.0 - heading) % 360.0
end

RegisterCommand('probar_camaras', function()
	watchCamerasDebug = not watchCamerasDebug
	SetWatchCameraDebugBlips(watchCamerasDebug)
	Notification(watchCamerasDebug and 'Prueba de camaras activada' or 'Prueba de camaras desactivada')
end)

CreateThread(function()
	while true do
		for i = #watchCameraEntities, 1, -1 do
			local entry = watchCameraEntities[i]
			if not DoesBlipExist(entry.blip) then
				if DoesEntityExist(entry.entity) then DeleteEntity(entry.entity) end
				table.remove(watchCameraEntities, i)
			else
				local heading = GetWatchCameraHeading(entry.camera)
				local radarHeading = GetWatchCameraBlipHeading(heading)
				SetEntityHeading(entry.entity, radarHeading)
				SetupWatchCameraCone(entry.blip, (radarHeading + 180.0) % 360.0)
				SetBlipRotation(entry.blip, math.floor(radarHeading))
			end
		end
		Wait(#watchCameraEntities > 0 and 100 or 500)
	end
end)

CreateThread(function()
	while true do
		if not watchCamerasDebug then
			Wait(500)
		else
			local coords = GetEntityCoords(PlayerPedId())
			for i, tower in ipairs(Config.WatchCameras) do
				local heading = GetWatchCameraHeading(i)
				local distance = #(coords - tower)
				DrawWatchCameraCone(tower, heading)
				DrawMarker(Config.WatchMarkNum, tower.x, tower.y, tower.z, 0.0, 0.0, 0.0, 0.0, 0.0, heading, 0.6, 0.6, 0.6, Config.WatchMarkColor.r, Config.WatchMarkColor.g, Config.WatchMarkColor.b, 180, false, false, 2, false, nil, nil, false)
				if distance <= Config.SeeWatchDist then
					local seen = IsPlayerInWatchCamera(tower, heading, coords)
					DrawText3D(tower.x, tower.y, tower.z + 0.5, ('Camara %d | %.1fm | %s'):format(i, distance, seen and 'TE VE' or 'seguro'))
				end
			end
			Wait(0)
		end
	end
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

	infoLoc = lib.callback.await('HD_Jail:GrabInfoLoc', false) or infoLoc


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
		local blip3b = AddBlipForCoord(Config.JobManLoc2.Loc.x, Config.JobManLoc2.Loc.y, Config.JobManLoc2.Loc.z)
		SetBlipSprite(blip3b, Config.JobManBlip.Sprite)
		SetBlipScale(blip3b, Config.JobManBlip.Size)
		SetBlipColour(blip3b, Config.JobManBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Sayings[9])
		EndTextCommandSetBlipName(blip3b)
		table.insert(blips, {id = 'jobman2', data = blip3b})
	end
	if Config.LaundryVehicleBlip.Spawn then
		local blipLaundryVehicle = AddBlipForCoord(Config.LaundryVehicleNpcLoc.Loc.x, Config.LaundryVehicleNpcLoc.Loc.y, Config.LaundryVehicleNpcLoc.Loc.z)
		SetBlipSprite(blipLaundryVehicle, Config.LaundryVehicleBlip.Sprite)
		SetBlipScale(blipLaundryVehicle, Config.LaundryVehicleBlip.Size)
		SetBlipColour(blipLaundryVehicle, Config.LaundryVehicleBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Vehículo de lavandería')
		EndTextCommandSetBlipName(blipLaundryVehicle)
		table.insert(blips, {id = 'laundry_vehicle', data = blipLaundryVehicle})
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


	RequestModel(Config.InfoPed)
	RequestModel(Config.JobManPed)
	RequestModel(Config.LaundryVehicleNpc)

	LoadPropDict(Config.InfoPed)
	LoadPropDict(Config.JobManPed)
	LoadPropDict(Config.LaundryVehicleNpc)

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
	local byped3 = CreatePed(5, Config.JobManPed, Config.JobManLoc2.Loc.x, Config.JobManLoc2.Loc.y, Config.JobManLoc2.Loc.z - 1, Config.JobManLoc2.Heading, false, true)
	PlaceObjectOnGroundProperly(byped3)
	SetEntityAsMissionEntity(byped3)
	SetPedDropsWeaponsWhenDead(byped3, false)
	FreezeEntityPosition(byped3, true)
	SetPedAsEnemy(byped3, false)
	SetEntityInvincible(byped3, true)
	SetPedCanBeTargetted(byped3, false)
	table.insert(peds, {id = 'jobman2', data = byped3})
	local byped4 = CreatePed(5, Config.LaundryVehicleNpc, Config.LaundryVehicleNpcLoc.Loc.x, Config.LaundryVehicleNpcLoc.Loc.y, Config.LaundryVehicleNpcLoc.Loc.z - 1, Config.LaundryVehicleNpcLoc.Heading, false, true)
	PlaceObjectOnGroundProperly(byped4)
	SetEntityAsMissionEntity(byped4)
	SetPedDropsWeaponsWhenDead(byped4, false)
	FreezeEntityPosition(byped4, true)
	SetPedAsEnemy(byped4, false)
	SetEntityInvincible(byped4, true)
	SetPedCanBeTargetted(byped4, false)
	table.insert(peds, {id = 'laundry_vehicle', data = byped4})


	table.insert(jailLocs, {Text = Config.Sayings[27], Id = 'info', Loc = Config.InfoPedLoc[infoLoc].Loc, Sub = true, Mark = {Num = Config.IMarkNum, Color = Config.IMarkColor, Size = Config.IMarkSize}})
	table.insert(jailLocs, {Text = Config.Sayings[14], Id = 'jobman', Loc = Config.JobManLoc.Loc, Sub = true, Mark = {Num = Config.JMMarkNum, Color = Config.JMMarkColor, Size = Config.JMMarkSize}})
	table.insert(jailLocs, {Text = Config.Sayings[14], Id = 'jobman2', Loc = Config.JobManLoc2.Loc, Sub = true, Mark = {Num = Config.JMMarkNum, Color = Config.JMMarkColor, Size = Config.JMMarkSize}})
	table.insert(jailLocs, {Text = Config.Sayings[30], Id = 'food', Loc = Config.GetFoodLoc.Loc, Sub = false, Mark = {Num = Config.FoMarkNum, Color = Config.FoMarkColor, Size = Config.FoMarkSize}})
	if Config.Showers then
		table.insert(jailLocs, {Text = Config.Sayings[113], Id = 'shower', Loc = Config.ShowerLoc.Loc, Sub = false, Mark = {Num = Config.ShowMarkNum, Color = Config.ShowMarkColor, Size = Config.ShowMarkSize}})
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

					CloseSecurityCamera()
					CreateThread(function()
						StartPrisonHeliTest(1000)
					end)
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					lib.progressBar({ duration = (Config.PrisonIntroDuration * 1000) + 1000, label = Config.Sayings[169], icon = 'fixlife.svg', canCancel = false })
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					CleanupPrisonHeli(Config.Cells[cell].SpawnLoc.Loc)

					SetFocusArea(Config.JobCam.x, Config.JobCam.y, Config.JobCam.z, Config.JobCam.x, Config.JobCam.y, Config.JobCam.z)
					CreateThread(function()
						StartJobIntro(perTime + 1000)
					end)
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					lib.progressBar({ duration = perTime, label = Config.Sayings[170], icon = 'fixlife.svg', canCancel = false })
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)

					SetFocusArea(Config.FoodCam.x, Config.FoodCam.y, Config.FoodCam.z, Config.FoodCam.x, Config.FoodCam.y, Config.FoodCam.z)
					CreateThread(function()
						StartFoodIntro(perTime + 1000)
					end)
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					lib.progressBar({ duration = perTime, label = Config.Sayings[171], icon = 'fixlife.svg', canCancel = false })
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)

					if Config.Solitary then
						SetFocusArea(Config.SolCam.x, Config.SolCam.y, Config.SolCam.z, Config.SolCam.x, Config.SolCam.y, Config.SolCam.z)
						CreateThread(function()
							StartJobIntro(perTime + 1000, Config.SolIntroCam1, Config.SolIntroCam2, Config.SolIntroCamHeading)
						end)
						Citizen.Wait(100)
						DoScreenFadeIn(1000)
						lib.progressBar({ duration = perTime, label = Config.Sayings[172], icon = 'fixlife.svg', canCancel = false })
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
					end


					if Config.Showers then
						SetFocusArea(Config.ShowerCam.x, Config.ShowerCam.y, Config.ShowerCam.z, Config.ShowerCam.x, Config.ShowerCam.y, Config.ShowerCam.z)
						CreateThread(function()
							StartFoodIntro(perTime + 1000, Config.ShowerIntroCenter, Config.ShowerIntroDirection, Config.ShowerIntroRadius, Config.ShowerIntroAngle, Config.ShowerIntroStartAngle)
						end)
						Citizen.Wait(100)
						DoScreenFadeIn(1000)
						lib.progressBar({ duration = perTime, label = Config.Sayings[174], icon = 'fixlife.svg', canCancel = false })
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
					end

					if Config.Hospital then
						SetFocusArea(Config.HospitalCam.x, Config.HospitalCam.y, Config.HospitalCam.z, Config.HospitalCam.x, Config.HospitalCam.y, Config.HospitalCam.z)
						ChangeSecurityCamera(Config.HospitalCam.x, Config.HospitalCam.y, Config.HospitalCam.z, Config.HospitalCamRot)
						Citizen.Wait(100)
						DoScreenFadeIn(1000)
						lib.progressBar({ duration = perTime, label = Config.Sayings[175], icon = 'fixlife.svg', canCancel = false })
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
					end

					SetFocusArea(Config.ItemCam.x, Config.ItemCam.y, Config.ItemCam.z, Config.ItemCam.x, Config.ItemCam.y, Config.ItemCam.z)
					CreateThread(function()
						StartJobIntro(perTime + 1000, Config.ItemIntroCam1, Config.ItemIntroCam2, Config.ItemIntroHeading1, Config.ItemIntroHeading2)
					end)
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					lib.progressBar({ duration = perTime, label = Config.Sayings[176], icon = 'fixlife.svg', canCancel = false })
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)

					CreateThread(function()
						StartFinalPrisonHeli()
					end)
					CreateThread(function()
						StartFinalOrbit(((Config.FinalHeliDuration + Config.FinalHeliDescentDuration) * 1000) + 1000)
					end)
					Citizen.Wait(100)
					DoScreenFadeIn(1000)
					lib.progressBar({ duration = ((Config.FinalHeliDuration + Config.FinalHeliDescentDuration) * 1000) + 1000, label = Config.Sayings[177], icon = 'fixlife.svg', canCancel = false })
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					CleanupPrisonHeli(Config.Cells[cell].SpawnLoc.Loc, false)
					exports['Fixlife_hud']:setCinematicMode(false)
				end
				CloseSecurityCamera()
				SetEntityCoords(ped, Config.Cells[cell].SpawnLoc.Loc.x, Config.Cells[cell].SpawnLoc.Loc.y, Config.Cells[cell].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.Cells[cell].SpawnLoc.Heading)
				CleanupPrisonHeli(Config.Cells[cell].SpawnLoc.Loc)

				Citizen.Wait(200)

				SetEntityCoords(ped, Config.Cells[cell].SpawnLoc.Loc.x, Config.Cells[cell].SpawnLoc.Loc.y, Config.Cells[cell].SpawnLoc.Loc.z - 1, false, false, false, false)
				SetEntityHeading(ped, Config.Cells[cell].SpawnLoc.Heading)
				jailCell = cell
				CreatePrisonTargets(cell)
				CreatePrisonInteractionPoints()
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
				exports['Fixlife_hud']:setHudTimer(timu / 60, 'Tiempo restante')
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
			for i = 1, #Config.WatchCameras, 1 do
				dist2 = Vdist(Config.WatchCameras[i].x, Config.WatchCameras[i].y, Config.WatchCameras[i].z, coords)
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
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if canGrab then
			local dist = Vdist(Config.ItemLoc.Loc.x, Config.ItemLoc.Loc.y, Config.ItemLoc.Loc.z, coords)
			if not using then
				if dist <= Config.ShowItemDist then
					Citizen.Wait(250)
				else
					Citizen.Wait(1000)
				end
			else 
				Citizen.Wait(1000)
			end
		elseif breakout2 then
			if not using and not isDead then
				local seen = false
				local nearestDistance = math.huge
				for i, camera in ipairs(Config.WatchCameras) do
					local distance = #(coords - camera)
					if distance < nearestDistance then
						nearestDistance = distance
						closestTower = i
					end
					if IsPlayerInWatchCamera(camera, GetWatchCameraHeading(i), coords) then
						seen = true
						break
					end
				end

				if seen then
					breakout2 = false
					breakout4 = true
					TriggerServerEvent('HD_Jail:UnBreak', GetPlayerServerId(PlayerId()))
				elseif nearestDistance >= Config.MaxWatchDist then
					IEscaped()
					breakout2 = false
					breakout4 = true
				else
					Citizen.Wait(100)
				end
			else
				Citizen.Wait(1000)
			end
		elseif time > 0 then
			local dist = Vdist(jailLocs[closestLoc].Loc.x, jailLocs[closestLoc].Loc.y, jailLocs[closestLoc].Loc.z, coords)
			
			if not using and not isDead then
				if dist <= Config.SeeDist then
					Citizen.Wait(250)
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
				Citizen.Wait(250)

			else
				Citizen.Wait(1000)
			end
		elseif not isDead and showerNow then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local dist = Vdist(Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z, coords)

			if dist <= Config.ShowerFullDist then
				Citizen.Wait(250)
			else
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local dist = Vdist(Config.ShowerLocs[closestShower].x, Config.ShowerLocs[closestShower].y, Config.ShowerLocs[closestShower].z, coords)

				if dist >= Config.MaxDistShower then
					showerNow = false
					using = false
					ResetShowerInteraction()
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

