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
