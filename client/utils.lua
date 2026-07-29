local activePrisonHeli
local activePrisonPilot

function StartPrisonIntro(extraTime)
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
    local introDuration = (Config.PrisonIntroDuration * 1000) + (extraTime or 0)
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
            local duration = introDuration * distance / totalDistance
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

function StartPrisonHeliTest(extraTime)
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
    SetEntityHasGravity(heli, false)
    TaskStandStill(pilot, -1)
    TaskWarpPedIntoVehicle(player, heli, 2)
    SetFollowVehicleCamViewMode(4)

    local totalDistance = 0.0
    local introDuration = (Config.PrisonIntroDuration * 1000) + (extraTime or 0)
    for _, segment in ipairs(path) do
        totalDistance = totalDistance + #(segment.To - segment.From)
    end

    for _, segment in ipairs(path) do
        local duration = introDuration * #(segment.To - segment.From) / totalDistance
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

    local finalPoint = path[#path].To
    SetEntityCoordsNoOffset(heli, finalPoint.x, finalPoint.y, finalPoint.z, false, false, false)
    SetEntityVelocity(heli, 0.0, 0.0, 0.0)
    SetEntityHasGravity(heli, false)
    FreezeEntityPosition(heli, true)
    SetFollowVehicleCamViewMode(previousView)
end

function CleanupPrisonHeli(coords, movePlayer)
    if not activePrisonHeli or not DoesEntityExist(activePrisonHeli) then return end

    SetEntityCoordsNoOffset(activePrisonHeli, coords.x, coords.y, coords.z + 1.0, false, false, false)
    if movePlayer ~= false then
        local player = PlayerPedId()
        TaskLeaveVehicle(player, activePrisonHeli, 16)
        Wait(500)
        ClearPedTasksImmediately(player)
        SetEntityCoords(player, coords.x, coords.y, coords.z, false, false, false, false)
    end

    if activePrisonPilot and DoesEntityExist(activePrisonPilot) then
        DeletePed(activePrisonPilot)
    end
    DeleteVehicle(activePrisonHeli)
    activePrisonPilot = nil
    activePrisonHeli = nil
end

function ParkPrisonHeli(coords, heliCoords)
    if not activePrisonHeli or not DoesEntityExist(activePrisonHeli) then return end

    local player = PlayerPedId()
    SetEntityInvincible(player, true)
    FreezeEntityPosition(activePrisonHeli, false)
    SetEntityHasGravity(activePrisonHeli, false)
    SetEntityCoordsNoOffset(activePrisonHeli, coords.x, coords.y, coords.z + 1.0, false, false, false)
    SetEntityVelocity(activePrisonHeli, 0.0, 0.0, 0.0)
    TaskLeaveVehicle(player, activePrisonHeli, 16)
    Wait(250)
    ClearPedTasksImmediately(player)
    SetEntityCoordsNoOffset(player, coords.x, coords.y, coords.z, false, false, false)
    SetEntityVelocity(player, 0.0, 0.0, 0.0)
    SetEntityCoordsNoOffset(activePrisonHeli, heliCoords.x, heliCoords.y, heliCoords.z, false, false, false)
    SetEntityHeading(activePrisonHeli, Config.FinalHeliStartHeading)
    SetEntityHasGravity(activePrisonHeli, false)
    SetEntityVelocity(activePrisonHeli, 0.0, 0.0, 0.0)
    FreezeEntityPosition(activePrisonHeli, true)
    SetEntityInvincible(player, false)
end

function StartFinalPrisonHeli()
    local heliModel = 'polmav'
    local pilotModel = 's_m_y_pilot_01'

    LoadPropDict(heliModel)
    LoadPropDict(pilotModel)

    local start = Config.FinalHeliStart
    local landing = Config.FinalHeliLanding
    local heli = activePrisonHeli
    local pilot = activePrisonPilot
    if not heli or not DoesEntityExist(heli) then
        heli = CreateVehicle(joaat(heliModel), start.x, start.y, start.z, Config.FinalHeliStartHeading, true, true)
        pilot = CreatePedInsideVehicle(heli, 4, joaat(pilotModel), -1, true, true)
        activePrisonHeli = heli
        activePrisonPilot = pilot
        SetEntityAsMissionEntity(heli, true, true)
        SetEntityAsMissionEntity(pilot, true, true)
    else
        FreezeEntityPosition(heli, false)
        SetEntityCoordsNoOffset(heli, start.x, start.y, start.z, false, false, false)
        SetEntityHeading(heli, Config.FinalHeliStartHeading)
    end
    SetVehicleEngineOn(heli, true, true, false)
    SetHeliBladesFullSpeed(heli)
    SetVehicleDoorsLocked(heli, 2)
    SetEntityInvincible(heli, true)
    SetEntityInvincible(pilot, true)
    TaskStandStill(pilot, -1)
    local started = GetGameTimer()
    while GetGameTimer() - started < Config.FinalHeliDuration * 1000 do
        DisableAllControlActions(0)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 2, true)
        local progress = math.min((GetGameTimer() - started) / (Config.FinalHeliDuration * 1000), 1.0)
        progress = progress * progress * (3.0 - 2.0 * progress)
        local x = start.x + (landing.x - start.x) * progress
        local y = start.y + (landing.y - start.y) * progress
        local z = start.z + (landing.z - start.z) * progress
        SetEntityHeading(heli, Config.FinalHeliStartHeading + (Config.FinalHeliLandingHeading - Config.FinalHeliStartHeading) * progress)
        SetEntityCoordsNoOffset(heli, x, y, z, false, false, false)
        SetEntityVelocity(heli, 0.0, 0.0, 0.0)
        Wait(0)
    end

    SetEntityCoordsNoOffset(heli, landing.x, landing.y, landing.z, false, false, false)
    SetEntityHeading(heli, Config.FinalHeliLandingHeading)

    local descentStarted = GetGameTimer()
    while GetGameTimer() - descentStarted < Config.FinalHeliDescentDuration * 1000 do
        local progress = math.min((GetGameTimer() - descentStarted) / (Config.FinalHeliDescentDuration * 1000), 1.0)
        progress = progress * progress * (3.0 - 2.0 * progress)
        local z = landing.z + (Config.FinalHeliTouchdownZ - landing.z) * progress
        SetEntityCoordsNoOffset(heli, landing.x, landing.y, z, false, false, false)
        SetEntityHeading(heli, Config.FinalHeliLandingHeading)
        SetEntityVelocity(heli, 0.0, 0.0, 0.0)
        Wait(0)
    end

    SetEntityCoordsNoOffset(heli, landing.x, landing.y, Config.FinalHeliTouchdownZ, false, false, false)
    SetVehicleForwardSpeed(heli, 0.0)
    SetEntityVelocity(heli, 0.0, 0.0, 0.0)
    FreezeEntityPosition(heli, true)
end

function StartFinalOrbit(duration)
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
    end

    local center = Config.FinalOrbitCenter
    local radius = Config.FinalOrbitRadius
    local startAngle = 0.0
    local endAngle = math.rad(Config.FinalOrbitAngle) * Config.FinalOrbitDirection
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    createdCamera = cam
    RenderScriptCams(1, 0, 0, 1, 1)

    local started = GetGameTimer()
    while GetGameTimer() - started < duration do
        local progress = math.min((GetGameTimer() - started) / duration, 1.0)
        local angle = startAngle + endAngle * progress
        local x = center.x + math.cos(angle) * radius
        local y = center.y + math.sin(angle) * radius
        local z = Config.FinalOrbitHeight
        local rotation = {
            x = math.deg(math.atan(center.z - z, radius)),
            y = 0.0,
            z = math.deg(math.atan(-(center.x - x), center.y - y))
        }
        SetCamCoord(cam, x, y, z)
        SetCamRot(cam, rotation.x, rotation.y, rotation.z, 2)
        Wait(0)
    end
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

local laundryWasherProps = {}
local laundryDryerProps = {}
local laundryWasherBusy
local laundryWasherDict = 'anim@scripted@cbr1@ig1_washmach_grab_cash@male@'
local laundryWasherModel = 'm23_2_prop_m32_prtmachine_dryer_op'

function RemoveLaundryWasherProps()
    laundryWasherBusy = false
    for i, prop in pairs(laundryWasherProps) do
        if DoesEntityExist(prop) then DeleteObject(prop) end
        laundryWasherProps[i] = nil
    end
    for i, prop in pairs(laundryDryerProps) do
        if DoesEntityExist(prop) then DeleteObject(prop) end
        laundryDryerProps[i] = nil
    end
end

function EnsureLaundryWasherProps()
    for index, location in ipairs(Config.LaundryWasherLocs) do
        if not laundryWasherProps[index] or not DoesEntityExist(laundryWasherProps[index]) then
            LoadPropDict(laundryWasherModel)
            local prop = CreateObject(joaat(laundryWasherModel), location.Loc.x, location.Loc.y, location.Loc.z, true, true, true)
            SetEntityHeading(prop, location.Heading)
            SetEntityAsMissionEntity(prop, true, true)
            laundryWasherProps[index] = prop
            SetModelAsNoLongerNeeded(laundryWasherModel)
        end
    end
end

function EnsureLaundryDryerProps()
    for index, location in ipairs(Config.LaundryDryerLocs) do
        if not laundryDryerProps[index] or not DoesEntityExist(laundryDryerProps[index]) then
            LoadPropDict(laundryWasherModel)
            local prop = CreateObject(joaat(laundryWasherModel), location.Loc.x, location.Loc.y, location.Loc.z, true, true, true)
            SetEntityHeading(prop, location.Heading)
            SetEntityAsMissionEntity(prop, true, true)
            laundryDryerProps[index] = prop
            SetModelAsNoLongerNeeded(laundryWasherModel)
        end
    end
end

function GetLaundryWasherInteractionCoords(index)
    local prop = laundryWasherProps[index]
    local offset = Config.LaundryWasherInteractionOffsets[index]
    if prop and DoesEntityExist(prop) and offset then
        return GetOffsetFromEntityInWorldCoords(prop, table.unpack(offset))
    end
    return Config.LaundryWasherLocs[index].Loc
end

function GetLaundryDryerInteractionCoords(index)
    local prop = laundryDryerProps[index]
    local offset = Config.LaundryDryerInteractionOffsets[index]
    if prop and DoesEntityExist(prop) and offset then
        return GetOffsetFromEntityInWorldCoords(prop, table.unpack(offset))
    end
    return Config.LaundryDryerLocs[index].Loc
end

function SetLaundryMachineOutline(machine, index, enabled, color)
    local props = machine == 'dryer' and laundryDryerProps or laundryWasherProps
    local prop = props[index]
    if prop and DoesEntityExist(prop) then
        local rgb = color == 'yellow' and {255, 200, 0} or {255, 255, 255}
        SetEntityDrawOutlineColor(rgb[1], rgb[2], rgb[3], 255)
        SetEntityDrawOutlineShader(1)
        SetEntityDrawOutline(prop, enabled)
    end
end

function SetLaundryMachineOutlines(machine, enabled, color)
    local props = machine == 'dryer' and laundryDryerProps or laundryWasherProps
    for index in pairs(props) do SetLaundryMachineOutline(machine, index, enabled, color) end
end

function ClearLaundryMachineOutlines()
    for _, props in ipairs({laundryWasherProps, laundryDryerProps}) do
        for _, prop in pairs(props) do
            if DoesEntityExist(prop) then SetEntityDrawOutline(prop, false) end
        end
    end
end

--[[
    if not laundryStorageProp or not DoesEntityExist(laundryStorageProp) then
        laundryStorageProp = GetClosestObjectOfType(Config.LaundryStorageProp.Loc.x, Config.LaundryStorageProp.Loc.y, Config.LaundryStorageProp.Loc.z, 20.0, joaat(Config.LaundryStorageProp.Model), false, false, false)
        if not laundryStorageProp or not DoesEntityExist(laundryStorageProp) then
            local action = Config.LaundryStorageAction.Loc
            laundryStorageProp = GetClosestObjectOfType(action.x, action.y, action.z, 20.0, joaat(Config.LaundryStorageProp.Model), false, false, false)
        end
        if not laundryStorageProp or not DoesEntityExist(laundryStorageProp) then
            local target = Config.LaundryStorageProp.Loc
            laundryStorageProp = GetClosestObjectOfType(target.x, target.y, target.z, 5.0, 161765395, false, false, false)
        end
        if not laundryStorageProp or not DoesEntityExist(laundryStorageProp) then
            local target = Config.LaundryStorageProp.Loc
            laundryStorageProp = GetClosestObjectOfType(target.x, target.y, target.z, 5.0, 3340290, false, false, false)
        end
    end
    if laundryStorageProp and DoesEntityExist(laundryStorageProp) then
        SetEntityDrawOutlineColor(255, 255, 255, 255)
        SetEntityDrawOutlineShader(1)
        SetEntityDrawOutline(laundryStorageProp, enabled)
        return true
    end
    return false
end

RegisterCommand('probar_estante', function()
    if SetLaundryStorageOutline(true) then
        local coords = GetEntityCoords(laundryStorageProp)
        print(('[Fixlife_prision] Estante encontrado en %.4f, %.4f, %.4f'):format(coords.x, coords.y, coords.z))
    else
        print('[Fixlife_prision] No se encontró ch_prop_ch_laundry_shelving_01b.')
        local target = Config.LaundryStorageProp.Loc
        local nearby = 0
        for _, entity in ipairs(GetGamePool('CObject')) do
            local coords = GetEntityCoords(entity)
            local distance = Vdist(target.x, target.y, target.z, coords.x, coords.y, coords.z)
            if distance <= 20.0 then
                nearby = nearby + 1
                print(('[Fixlife_prision] Objeto cercano hash %s en %.4f, %.4f, %.4f (%.2fm)'):format(GetEntityModel(entity), coords.x, coords.y, coords.z, distance))
            end
        end
        print(('[Fixlife_prision] Objetos cercanos: %d'):format(nearby))
    end
end)

RegisterCommand('quitar_estante', function()
    SetLaundryStorageOutline(false)
end)

]]
function StartLaundryStorageAction(finished)
    using = true
    local ped = PlayerPedId()
    local action = Config.LaundryStorageAction
    inAnim.Dict = nil
    inAnim.Anim = nil
    inAnim.Atr = 0
    inAnim.Freeze = false
    for i = #PlayerHasProp, 1, -1 do
        if PlayerHasProp[i].id == 'task' then
            if DoesEntityExist(PlayerHasProp[i].object) then DeleteObject(PlayerHasProp[i].object) end
            table.remove(PlayerHasProp, i)
        end
    end
    ClearPedTasksImmediately(ped)
    SetEntityCoords(ped, action.Loc.x, action.Loc.y, action.Loc.z - 1.0, false, false, false, false)
    SetEntityHeading(ped, action.Heading)
    LoadAnim(action.Dict)
    TaskPlayAnim(ped, action.Dict, action.Anim, 8.0, 8.0, action.Duration, 1, 1.0, false, false, false)
    Wait(action.Duration)
    ClearPedTasksImmediately(ped)
    using = false
    if finished then finished() end
end

CreateThread(function()
    while true do
        Wait(2000)
        if injail and NetworkIsSessionStarted() then
            EnsureLaundryWasherProps()
            EnsureLaundryDryerProps()
        elseif not injail and next(laundryWasherProps) then
            RemoveLaundryWasherProps()
        end
    end
end)

local function StartLaundryMachineAction(machine, index, finished, collecting)
    if laundryWasherBusy then return end
    local locations = machine == 'dryer' and Config.LaundryDryerLocs or Config.LaundryWasherLocs
    local props = machine == 'dryer' and laundryDryerProps or laundryWasherProps
    local location = locations[index]
    if not location then return end
    laundryWasherBusy = true
    using = true
    inAnim.Dict = nil
    inAnim.Anim = nil
    inAnim.Atr = 0
    inAnim.Freeze = false
    ClearPedTasksImmediately(PlayerPedId())
    if collecting and machine == 'dryer' then
        local ped = PlayerPedId()
        for _, item in ipairs(PlayerHasProp) do
            if item.id == 'task' and DoesEntityExist(item.object) then
                DetachEntity(item.object, true, true)
                AttachEntityToEntity(item.object, ped, GetPedBoneIndex(ped, 60309), 0.0, -0.1, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                break
            end
        end
    end
    if machine == 'dryer' then EnsureLaundryDryerProps() else EnsureLaundryWasherProps() end
    local prop = props[index]

    CreateThread(function()
        local ped = PlayerPedId()
        SetEntityCoords(ped, location.Loc.x, location.Loc.y, location.Loc.z - 1.0, false, false, false, false)
        SetEntityHeading(ped, location.Heading)
        LoadAnim(laundryWasherDict)
        StopEntityAnim(prop, 'enter_dryer', laundryWasherDict, true)
        local scene = NetworkCreateSynchronisedScene(location.Loc.x, location.Loc.y, location.Loc.z, 0.0, 0.0, location.Heading, 2, true, false, 1.0, 0.0, 1.0)
        NetworkAddPedToSynchronisedScene(ped, scene, laundryWasherDict, 'enter', 8.0, -8.0, 0, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(prop, scene, laundryWasherDict, 'enter_dryer', 1.0, 1.0, 1)
        NetworkStartSynchronisedScene(scene)
        Wait(GetAnimDuration(laundryWasherDict, 'enter') * 1000)
        if collecting then
            LoadAnim('custom@pluck_fruits')
            TaskPlayAnim(ped, 'custom@pluck_fruits', 'pluck_fruits', 8.0, 8.0, -1, 51, 1.0, false, false, false)
        else
            TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, true)
        end
        Wait(10000)
        for i = #PlayerHasProp, 1, -1 do
            if PlayerHasProp[i].id == 'task' then
                if DoesEntityExist(PlayerHasProp[i].object) then DeleteObject(PlayerHasProp[i].object) end
                table.remove(PlayerHasProp, i)
            end
        end
        local closeScene = CreateSynchronizedScene(location.Loc.x, location.Loc.y, location.Loc.z, 0.0, 0.0, location.Heading, 2)
        TaskSynchronizedScene(ped, closeScene, laundryWasherDict, 'enter', 8.0, -8.0, 0, 0, 1000.0, 0)
        SetSynchronizedScenePhase(closeScene, 0.99)
        SetSynchronizedSceneRate(closeScene, -1.0)
        PlayEntityAnim(prop, 'enter_dryer', laundryWasherDict, 1.0, false, true, 0, 1.0, 0)
        local duration = GetAnimDuration(laundryWasherDict, 'enter_dryer')
        local time = 1.0
        while time >= 0.0 and DoesEntityExist(prop) do
            SetEntityAnimCurrentTime(prop, laundryWasherDict, 'enter_dryer', time)
            time = time - (GetFrameTime() / duration)
            Wait(0)
        end
        if DoesEntityExist(prop) then
            SetEntityAnimCurrentTime(prop, laundryWasherDict, 'enter_dryer', 0.0)
            SetEntityAnimSpeed(prop, laundryWasherDict, 'enter_dryer', 0.0)
        end
        ClearPedTasksImmediately(ped)
        laundryWasherBusy = false
        if finished then finished() end
    end)
end

function StartLaundryWasherAction(index, finished, collecting)
    StartLaundryMachineAction('washer', index, finished, collecting)
end

function StartLaundryDryerAction(index, finished, collecting)
    StartLaundryMachineAction('dryer', index, finished, collecting)
end

local dryerTestProp
local dryerTestScene
local dryerTestLocalScene
local dryerTestClosing
local dryerTestCoords = vector3(3915.29468, 28.22179, 22.8701782)
local dryerTestDict = 'anim@scripted@cbr1@ig1_washmach_grab_cash@male@'
local dryerTestAnims = {
	enter = true, enter_bag = true, enter_dryer = true, enter_dryermoney = true,
	enter_facial = true, exit = true, exit_bag = true, exit_dryer = true,
	exit_dryermoney = true, exit_facial = true, grab = true, grab_bag = true,
	grab_dryer = true, grab_dryermoney = true, grab_facial = true, idle = true,
	idle_bag = true, idle_dryer = true, idle_dryermoney = true, idle_facial = true
}

RegisterCommand('probarsecadora', function(_, args)
	dryerTestClosing = false
	local closing = args[1] == 'cerrar' or args[1] == 'reverse'
	local anim = closing and 'exit' or (args[1] or 'enter')
	local propAnim = dryerTestAnims[anim .. '_dryer'] and anim .. '_dryer' or anim
	if not dryerTestAnims[anim] then
		print('Animaciones: enter, enter_bag, enter_dryer, enter_dryermoney, enter_facial, exit, exit_bag, exit_dryer, exit_dryermoney, exit_facial, grab, grab_bag, grab_dryer, grab_dryermoney, grab_facial, idle, idle_bag, idle_dryer, idle_dryermoney, idle_facial')
		return
	end

	if dryerTestScene then NetworkStopSynchronisedScene(dryerTestScene) end
	if not closing or not dryerTestProp or not DoesEntityExist(dryerTestProp) then
		if dryerTestProp and DoesEntityExist(dryerTestProp) then DeleteObject(dryerTestProp) end
		LoadPropDict('m23_2_prop_m32_prtmachine_dryer_op')
		dryerTestProp = CreateObject(joaat('m23_2_prop_m32_prtmachine_dryer_op'), dryerTestCoords.x, dryerTestCoords.y, dryerTestCoords.z, true, true, true)
		SetEntityHeading(dryerTestProp, 0.0)
		SetModelAsNoLongerNeeded('m23_2_prop_m32_prtmachine_dryer_op')
	end

	local ped = PlayerPedId()
	SetEntityCoords(ped, dryerTestCoords.x, dryerTestCoords.y, dryerTestCoords.z - 1.0, false, false, false, false)
	SetEntityHeading(ped, 0.0)
	LoadAnim(dryerTestDict)
	if closing then
		dryerTestClosing = true
		dryerTestLocalScene = CreateSynchronizedScene(dryerTestCoords.x, dryerTestCoords.y, dryerTestCoords.z, 0.0, 0.0, 0.0, 2)
		TaskSynchronizedScene(ped, dryerTestLocalScene, dryerTestDict, 'enter', 8.0, -8.0, 0, 0, 1000.0, 0)
		SetSynchronizedScenePhase(dryerTestLocalScene, 0.99)
		SetSynchronizedSceneRate(dryerTestLocalScene, -1.0)
            CreateThread(function()
                local duration = GetAnimDuration(dryerTestDict, 'enter_dryer')
                if duration <= 0.0 then return end
                PlayEntityAnim(dryerTestProp, 'enter_dryer', dryerTestDict, 1.0, false, true, 0, 1.0, 0)
                local time = 1.0
                while dryerTestClosing and DoesEntityExist(dryerTestProp) and time >= 0.0 do
                    SetEntityAnimCurrentTime(dryerTestProp, dryerTestDict, 'enter_dryer', time)
                    time = time - (GetFrameTime() / duration)
                    Wait(0)
                end
                if DoesEntityExist(dryerTestProp) then
                    SetEntityAnimCurrentTime(dryerTestProp, dryerTestDict, 'enter_dryer', 0.0)
                    SetEntityAnimSpeed(dryerTestProp, dryerTestDict, 'enter_dryer', 0.0)
                end
                dryerTestClosing = false
            end)
		print('Secadora y jugador cerrando con enter invertida.')
		return
	end
	dryerTestScene = NetworkCreateSynchronisedScene(dryerTestCoords.x, dryerTestCoords.y, dryerTestCoords.z, 0.0, 0.0, 0.0, 2, true, false, 1.0, 0.0, 1.0)
	NetworkAddPedToSynchronisedScene(ped, dryerTestScene, dryerTestDict, anim, 8.0, -8.0, 0, 0, 1000.0, 0)
	NetworkAddEntityToSynchronisedScene(dryerTestProp, dryerTestScene, dryerTestDict, propAnim, 1.0, 1.0, 1)
	NetworkStartSynchronisedScene(dryerTestScene)
	print(('Secadora creada. Ped: %s | Prop: %s | Dirección: %s'):format(anim, propAnim, closing and 'cerrando' or 'abriendo'))
end)

RegisterCommand('pararsecadora', function()
	dryerTestClosing = false
	if dryerTestScene then NetworkStopSynchronisedScene(dryerTestScene) end
	ClearPedTasks(PlayerPedId())
	if dryerTestProp and DoesEntityExist(dryerTestProp) then DeleteObject(dryerTestProp) end
	dryerTestProp = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource ~= GetCurrentResourceName() then return end
	RemoveLaundryWasherProps()
	dryerTestClosing = false
	if dryerTestScene then NetworkStopSynchronisedScene(dryerTestScene) end
	ClearPedTasks(PlayerPedId())
	if dryerTestProp and DoesEntityExist(dryerTestProp) then DeleteObject(dryerTestProp) end
end)

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

function StartJobIntro(duration, customFrom, customTo, customHeading, customEndHeading)
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
    end

    local from = customFrom or Config.JobIntroCam1
    local to = customTo or Config.JobIntroCam2
    local heading = customHeading or Config.JobIntroCamHeading
    local endHeading = customEndHeading or heading
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    createdCamera = cam
    RenderScriptCams(1, 0, 0, 1, 1)

    local started = GetGameTimer()
    while GetGameTimer() - started < duration do
        local progress = math.min((GetGameTimer() - started) / duration, 1.0)
        SetCamCoord(cam,
            from.x + (to.x - from.x) * progress,
            from.y + (to.y - from.y) * progress,
            from.z + (to.z - from.z) * progress
        )
        SetCamRot(cam, 0.0, 0.0, heading + (endHeading - heading) * progress, 2)
        Wait(0)
    end

    SetCamCoord(cam, to.x, to.y, to.z)
    SetCamRot(cam, 0.0, 0.0, endHeading, 2)
end

function StartFoodIntro(duration, customCenter, customDirection, customRadius, customAngle, customStartAngle)
    if createdCamera ~= 0 then
        DestroyCam(createdCamera, 0)
    end

    local center = customCenter or Config.FoodIntroCenter
    local radius = customRadius or Config.FoodIntroRadius
    local startAngle = math.rad(customStartAngle or 0.0)
    local angle = customAngle or Config.FoodIntroAngle
    local endAngle = startAngle + math.rad(angle) * (customDirection or Config.FoodIntroDirection)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    createdCamera = cam
    RenderScriptCams(1, 0, 0, 1, 1)

    local started = GetGameTimer()
    while GetGameTimer() - started < duration do
        local progress = math.min((GetGameTimer() - started) / duration, 1.0)
        local angle = startAngle + (endAngle - startAngle) * progress
        local x = center.x + math.cos(angle) * radius
        local y = center.y + math.sin(angle) * radius
        local z = center.z
        local rotation = {
            x = math.deg(math.atan(center.z - z, radius)),
            y = 0.0,
            z = math.deg(math.atan(-(center.x - x), center.y - y))
        }
        SetCamCoord(cam, x, y, z)
        SetCamRot(cam, rotation.x, rotation.y, rotation.z, 2)
        Wait(0)
    end
end

function Notification(text)
    exports.qbx_core:Notify(Config.Sayings[1], nil, 5000, text, "center-left", nil, "fa-solid fa-handcuffs", "#ffffff")
	-- if Config.Notifications == 'esx' then
	-- 	-- ESX.ShowNotification(text)
	-- 	TriggerEvent('Fix_systems:notificacioneslibfix', 'PRISION', text, 5000,  'handcuffs',  '#ff00ff', 'bottom')
	-- elseif Config.Notifications == 'tnotify' then
	-- 	exports['t-notify']:Alert({
	-- 		style = 'message', 
	-- 		message = text
	-- 	})
	-- elseif Config.Notifications == 'mythic' then
	-- 	exports['mythic_notify']:DoHudText('inform', text)
	-- end
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
