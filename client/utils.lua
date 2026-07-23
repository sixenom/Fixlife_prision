local activePrisonHeli
local activePrisonPilot

function StartPrisonIntro()
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
    end

    local path = Config.PrisonIntroPath
    local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    local function rotationTo(position, target)
        local dx = target.x - position.x
        local dy = target.y - position.y
        local dz = target.z - position.z
        return {
            x = math.deg(math.atan(dz, math.sqrt(dx * dx + dy * dy))),
            y = 0.0,
            z = math.deg(math.atan(-dx, dy))
        }
    end
    local totalDistance = 0.0
    for _, segment in ipairs(path) do
        totalDistance = totalDistance + #(segment.To - segment.From)
    end

    SetCamCoord(cam, path[1].From.x, path[1].From.y, path[1].From.z)
    local firstTarget = path[1].Center or path[1].LookAt
    local firstRotation = rotationTo(path[1].From, firstTarget)
    SetCamRot(cam, firstRotation.x, firstRotation.y, firstRotation.z, 2)
    RenderScriptCams(true, false, 0, true, true)
    createdCamera = cam

    CreateThread(function()
        local fixedRotation
        local function blendRotation(from, to, progress)
            return {
                x = from.x + (to.x - from.x) * progress,
                y = from.y + (to.y - from.y) * progress,
                z = from.z + (to.z - from.z) * progress
            }
        end

        for _, segment in ipairs(path) do
            local fromRotation = GetCamRot(cam, 2)
            fixedRotation = nil
            if segment.FixedRotation then
                fixedRotation = segment.FixedRotation
            elseif segment.HoldRotation then
                fixedRotation = GetCamRot(cam, 2)
            end

            local distance = #(segment.To - segment.From)
            local duration = Config.PrisonIntroDuration * 1000 * distance / totalDistance
            local started = GetGameTimer()
            local startAngle, angleDelta, startRadius, endRadius

            if segment.Mode == 'Orbit' then
                startAngle = math.atan(segment.From.y - segment.Center.y, segment.From.x - segment.Center.x)
                local endAngle = math.atan(segment.To.y - segment.Center.y, segment.To.x - segment.Center.x)
                angleDelta = endAngle - startAngle
                if segment.Direction > 0 and angleDelta < 0 then angleDelta = angleDelta + math.pi * 2 end
                if segment.Direction < 0 and angleDelta > 0 then angleDelta = angleDelta - math.pi * 2 end
                startRadius = #(vector3(segment.From.x, segment.From.y, 0.0) - vector3(segment.Center.x, segment.Center.y, 0.0))
                endRadius = #(vector3(segment.To.x, segment.To.y, 0.0) - vector3(segment.Center.x, segment.Center.y, 0.0))
            end

            while GetGameTimer() - started < duration do
                local elapsed = GetGameTimer() - started
                local progress = math.min(elapsed / duration, 1.0)
                local bob = math.sin(progress * math.pi) * Config.PrisonIntroBob
                local bank = segment.Mode == 'Orbit' and math.sin(progress * math.pi) * Config.PrisonIntroBank * segment.Direction or 0.0
                local x, y, z
                if segment.Mode == 'Orbit' then
                    local angle = startAngle + angleDelta * progress
                    local radius = startRadius + (endRadius - startRadius) * progress
                    x = segment.Center.x + math.cos(angle) * radius
                    y = segment.Center.y + math.sin(angle) * radius
                    z = segment.From.z + (segment.To.z - segment.From.z) * progress
                else
                    x = segment.From.x + (segment.To.x - segment.From.x) * progress
                    y = segment.From.y + (segment.To.y - segment.From.y) * progress
                    z = segment.From.z + (segment.To.z - segment.From.z) * progress
                end
                SetCamCoord(cam, x, y, z + bob)
                if fixedRotation then
                    local rotation = elapsed < Config.PrisonIntroBlend and blendRotation(fromRotation, fixedRotation, elapsed / Config.PrisonIntroBlend) or fixedRotation
                    SetCamRot(cam, rotation.x, rotation.y + bank, rotation.z, 2)
                elseif segment.Mode == 'Orbit' then
                    local targetRotation = rotationTo(vector3(x, y, z + bob), segment.Center)
                    targetRotation.y = bank
                    local rotation = elapsed < Config.PrisonIntroBlend and blendRotation(fromRotation, targetRotation, elapsed / Config.PrisonIntroBlend) or targetRotation
                    SetCamRot(cam, rotation.x, rotation.y, rotation.z, 2)
                else
                    local targetRotation = rotationTo(vector3(x, y, z + bob), segment.LookAt)
                    targetRotation.y = bank
                    SetCamRot(cam, targetRotation.x, targetRotation.y, targetRotation.z, 2)
                end
                Wait(0)
            end

            SetCamCoord(cam, segment.To.x, segment.To.y, segment.To.z)
            if fixedRotation then
                SetCamRot(cam, fixedRotation.x, fixedRotation.y, fixedRotation.z, 2)
            elseif segment.Mode == 'Orbit' then
                local targetRotation = rotationTo(segment.To, segment.Center)
                SetCamRot(cam, targetRotation.x, targetRotation.y, targetRotation.z, 2)
            else
                local targetRotation = rotationTo(segment.To, segment.LookAt)
                SetCamRot(cam, targetRotation.x, targetRotation.y, targetRotation.z, 2)
            end
        end
    end)
end

function StartPrisonHeliTest()
    local path = Config.PrisonIntroPath
    local heliModel = 'polmav'
    local pilotModel = 's_m_y_pilot_01'
    local player = PlayerPedId()
    local previousView = GetFollowVehicleCamViewMode()

    LoadPropDict(heliModel)
    LoadPropDict(pilotModel)

    local start = path[1].From
    local heli = CreateVehicle(joaat(heliModel), start.x, start.y, start.z, 0.0, true, true)
    local pilot = CreatePedInsideVehicle(heli, 4, joaat(pilotModel), -1, true, true)
    activePrisonHeli = heli
    activePrisonPilot = pilot
    SetEntityAsMissionEntity(heli, true, true)
    SetEntityAsMissionEntity(pilot, true, true)
    SetVehicleEngineOn(heli, true, true, false)
    SetHeliBladesFullSpeed(heli)
    SetVehicleDoorsLocked(heli, 2)
    SetEntityInvincible(heli, true)
    SetEntityInvincible(pilot, true)
    TaskStandStill(pilot, -1)
    TaskWarpPedIntoVehicle(player, heli, 1)
    SetFollowVehicleCamViewMode(4)

    local totalDistance = 0.0
    for _, segment in ipairs(path) do
        totalDistance = totalDistance + #(segment.To - segment.From)
    end

    for _, segment in ipairs(path) do
        local duration = Config.PrisonIntroDuration * 1000 * #(segment.To - segment.From) / totalDistance
        local started = GetGameTimer()
        local startAngle, angleDelta, startRadius, endRadius
        if segment.Mode == 'Orbit' then
            startAngle = math.atan(segment.From.y - segment.Center.y, segment.From.x - segment.Center.x)
            local endAngle = math.atan(segment.To.y - segment.Center.y, segment.To.x - segment.Center.x)
            angleDelta = endAngle - startAngle
            if segment.Direction > 0 and angleDelta < 0 then angleDelta = angleDelta + math.pi * 2 end
            if segment.Direction < 0 and angleDelta > 0 then angleDelta = angleDelta - math.pi * 2 end
            startRadius = #(vector3(segment.From.x, segment.From.y, 0.0) - vector3(segment.Center.x, segment.Center.y, 0.0))
            endRadius = #(vector3(segment.To.x, segment.To.y, 0.0) - vector3(segment.Center.x, segment.Center.y, 0.0))
        end

    while GetGameTimer() - started < duration do
            SetFollowVehicleCamViewMode(4)
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            local progress = math.min((GetGameTimer() - started) / duration, 1.0)
            local x, y, z
            if segment.Mode == 'Orbit' then
                local angle = startAngle + angleDelta * progress
                local radius = startRadius + (endRadius - startRadius) * progress
                x = segment.Center.x + math.cos(angle) * radius
                y = segment.Center.y + math.sin(angle) * radius
                z = segment.From.z + (segment.To.z - segment.From.z) * progress
            else
                x = segment.From.x + (segment.To.x - segment.From.x) * progress
                y = segment.From.y + (segment.To.y - segment.From.y) * progress
                z = segment.From.z + (segment.To.z - segment.From.z) * progress
            end
            SetEntityHeading(heli, GetHeadingFromVector_2d(x - GetEntityCoords(heli).x, y - GetEntityCoords(heli).y))
            SetEntityCoordsNoOffset(heli, x, y, z, false, false, false)
            Wait(0)
        end
    end

    SetFollowVehicleCamViewMode(previousView)
end

function CleanupPrisonHeli(coords)
    local player = PlayerPedId()
    if not activePrisonHeli or not DoesEntityExist(activePrisonHeli) then return end

    SetEntityCoordsNoOffset(activePrisonHeli, coords.x, coords.y, coords.z + 1.0, false, false, false)
    TaskLeaveVehicle(player, activePrisonHeli, 16)
    Wait(500)
    ClearPedTasksImmediately(player)
    SetEntityCoords(player, coords.x, coords.y, coords.z, false, false, false, false)

    if activePrisonPilot and DoesEntityExist(activePrisonPilot) then
        DeletePed(activePrisonPilot)
    end
    DeleteVehicle(activePrisonHeli)
    activePrisonPilot = nil
    activePrisonHeli = nil
end

function GetClosestPlayer()
    local closest, distance = -1, -1
    local coords = GetEntityCoords(PlayerPedId())
    for _, player in ipairs(GetActivePlayers()) do
        if player ~= PlayerId() then
            local dist = #(coords - GetEntityCoords(GetPlayerPed(player)))
            if distance == -1 or dist < distance then closest, distance = player, dist end
        end
    end
    return closest, distance
end

function GetPeds(ignore)
    local ignored, peds = {}, {}
    for _, ped in ipairs(ignore or {}) do ignored[ped] = true end
    for _, ped in ipairs(GetGamePool('CPed')) do
        if not ignored[ped] then peds[#peds + 1] = ped end
    end
    return peds
end

function MakeEntityFaceEntity(entity1, entity2)
    local p1, p2 = GetEntityCoords(entity1, true), GetEntityCoords(entity2, true)
    SetEntityHeading(entity1, GetHeadingFromVector_2d(p2.x - p1.x, p2.y - p1.y))
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
	if Config.Box then
		DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	end
    ClearDrawOrigin()
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3, namies, player, network)
	local Player = nil
	if player ~= nil then
		Player = player
	else
		Player = PlayerPedId()
	end
	local x,y,z = table.unpack(GetEntityCoords(Player))
  
	if not HasModelLoaded(prop1) then
	  LoadPropDict(prop1)
	end
  
	if network then
		prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
		table.insert(PlayerHasProp, {id = namies, object = prop})
		SetModelAsNoLongerNeeded(prop1)
	else
		prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  false,  true, true)
		AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
		table.insert(PlayerHasProp, {id = namies, object = prop})
		SetModelAsNoLongerNeeded(prop1)
	end
end

function LoadPropDict(model)
	while not HasModelLoaded(GetHashKey(model)) do
	  RequestModel(GetHashKey(model))
	  Wait(10)
	end
end

function ChangeSecurityCamera(x, y, z, r)
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
        createdCamera = 0
    end

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, x, y, z)
    SetCamRot(cam, r.x, r.y, r.z, 2)
    RenderScriptCams(1, 0, 0, 1, 1)
    Wait(250)
    createdCamera = cam
end

function CloseSecurityCamera()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    SetFocusEntity(GetPlayerPed(PlayerId()))
    FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
end

function Notification(text)
	if Config.Notifications == 'esx' then
		-- ESX.ShowNotification(text)
		TriggerEvent('Fix_systems:notificacioneslibfix', 'PRISION', text, 5000,  'handcuffs',  '#ff00ff', 'bottom')
	elseif Config.Notifications == 'tnotify' then
		exports['t-notify']:Alert({
			style = 'message', 
			message = text
		})
	elseif Config.Notifications == 'mythic' then
		exports['mythic_notify']:DoHudText('inform', text)
	end
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
	  RequestAnimDict(dict)
	  Wait(10)
	end
end


RegisterCommand('capturarcamera', function()
    local pos = GetFinalRenderedCamCoord()
    local rot = GetFinalRenderedCamRot(2)

    print(('Config.Cam = vector3(%.6f, %.6f, %.6f)'):format(pos.x, pos.y, pos.z))
    print(('Config.CamRot = {x = %.6f, y = %.6f, z = %.6f}'):format(rot.x, rot.y, rot.z))
end)


RegisterCommand('probarentrada', function()
    TriggerEvent('HD_Jail:JailStart', 60)
end)
