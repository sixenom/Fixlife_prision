print('[Fixlife_prision] fence escape loaded')

local fenceModel = joaat('prop_fnclink_10d')
local brokenFenceModel = joaat('rcore_prop_fnclink_10d')
local cutterModel = joaat('h4_prop_h4_bolt_cutter_01a')
local animationDict = 'anim@scripted@heist@ig4_bolt_cutters@male@'
local cutting = false
local cutFences = {}

local fencePoints = Config.FenceEscapePoints
local function loadAsset(request, loaded, asset)
    request(asset)
    while not loaded(asset) do Wait(0) end
end

local function hasCutInternalFence()
    for index, point in ipairs(fencePoints) do
        if point.type == 'internal' and cutFences[index] then return true end
    end
    return false
end

local function isPointAvailable(point)
    return point.type == 'internal' or hasCutInternalFence()
end

local function getNearestFence(coords)
    local nearest
    for index, point in ipairs(fencePoints) do
        if not cutFences[index] and isPointAvailable(point) then
            local distance = #(coords - point.coords)
            if not nearest or distance < nearest.distance then
                nearest = { index = index, point = point, distance = distance }
            end
        end
    end
    return nearest
end

local function cutFence(target)
    if cutting or not injail or (not breakout2 and not breakout3) or using then return end
    if not target or target.distance > 6.0 then return end

    cutting, using = true, true
    local ped = PlayerPedId()
    local point, coords = target.point, target.point.coords
    SetEntityCoords(ped, coords.x, coords.y, coords.z - 1.0, false, false, false, false)
    SetEntityHeading(ped, point.heading)

    loadAsset(RequestAnimDict, HasAnimDictLoaded, animationDict)
    loadAsset(RequestModel, HasModelLoaded, cutterModel)
    local cutter = CreateObject(cutterModel, coords.x, coords.y, coords.z, true, true, false)
    local rotation = GetEntityRotation(ped)
    local scene = NetworkCreateSynchronisedScene(coords.x, coords.y, coords.z + 0.2, rotation.x, rotation.y, rotation.z, 2, true, false, 1065353216, 5.0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene, animationDict, 'action_male', 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(cutter, scene, animationDict, 'action_cutter', 1.0, -1.0, 1148846080)
    NetworkStartSynchronisedScene(scene)

    lib.progressBar({
        duration = 3800,
        label = point.type == 'internal' and 'Cortando reja interna' or 'Cortando reja exterior',
        position = 'bottom', useWhileDead = false, canCancel = false,
        disable = { car = true, move = true, combat = true, mouse = false },
    })

    NetworkStopSynchronisedScene(scene)
    if DoesEntityExist(cutter) then DeleteEntity(cutter) end
    ClearPedTasksImmediately(ped)
    RemoveAnimDict(animationDict)
    SetModelAsNoLongerNeeded(cutterModel)
    CreateModelSwap(coords, 0.1, fenceModel, brokenFenceModel, true)
    CreateModelHide(coords.x, coords.y, coords.z, 1.5, fenceModel, true)
    cutFences[target.index] = true
    using, cutting = false, false

    if point.type == 'external' then
        IEscaped()
    else
        Notification('Has cortado una reja interna. Continúa hacia la salida.')
    end
end

CreateThread(function()
    while true do
        local wait = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        if injail and (breakout2 or breakout3) and not using then
            local target = getNearestFence(playerCoords)
            for index, point in ipairs(fencePoints) do
                if not cutFences[index] and isPointAvailable(point) and #(playerCoords - point.coords) <= 50.0 then
                    wait = 0
                    DrawMarker(1, point.coords.x, point.coords.y, point.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 120, 0, 120, false, false, 2, false, nil, nil, false)
                end
            end
            if target and target.distance <= 6.0 then
                wait = 0
                BeginTextCommandDisplayHelp('STRING')
                AddTextComponentSubstringPlayerName('Pulsa ~INPUT_CONTEXT~ para cortar la reja')
                EndTextCommandDisplayHelp(0, false, true, -1)
                if IsControlJustReleased(0, 38) then
                    if lib.callback.await('HD_Jail:CheckItemB2', false, 'hd_file') then
                        cutFence(target)
                    else
                        Notification(Config.Sayings[95])
                    end
                end
            end
        end
        Wait(wait)
    end
end)

RegisterCommand('fixlife_fence_debug', function()
    local target = getNearestFence(GetEntityCoords(PlayerPedId()))
    print(('[Fixlife_prision] fence debug injail=%s breakout2=%s breakout3=%s target=%s distance=%s'):format(tostring(injail), tostring(breakout2), tostring(breakout3), target and target.index or 'none', target and string.format('%.2f', target.distance) or 'none'))
    Notification(('Reja: %s | distancia: %s | injail=%s | breakout2=%s | breakout3=%s'):format(target and target.index or 'ninguna', target and string.format('%.2f', target.distance) or 'fuera', tostring(injail), tostring(breakout2), tostring(breakout3)))
end, false)
