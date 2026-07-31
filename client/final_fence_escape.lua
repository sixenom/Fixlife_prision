print('[Fixlife_prision] fence escape loaded')

local fenceModel = joaat('prop_fnclink_10d')
local brokenFenceModel = joaat('rcore_prop_fnclink_10d')
local cutterModel = joaat('h4_prop_h4_bolt_cutter_01a')
local animationDict = 'anim@scripted@heist@ig4_bolt_cutters@male@'
local cutting = false
local cutFences = {}

RegisterNetEvent('HD_Jail:ResetEscape', function()
    cutFences = {}
    cutting = false
end)

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

local function cutFence(index)
    if cutting or not injail or (not breakout2 and not breakout3) or using then return end
    local point = fencePoints[index]
    if not point or cutFences[index] or not isPointAvailable(point) then return end

    cutting, using = true, true
    local ped = PlayerPedId()
    local coords = point.coords
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
    cutFences[index] = true
    using, cutting = false, false

    if point.type == 'external' then
        IEscaped()
    else
        Notification('Has cortado una reja interna. Continúa hacia la salida.')
    end
end

for index, point in ipairs(fencePoints) do
    exports.ox_target:addSphereZone({
        coords = point.coords,
        radius = 1.5,
        options = {{
            name = 'fixlife_prision_cut_fence_' .. index,
            label = 'Cortar reja',
            icon = 'fa-solid fa-scissors',
            distance = 2.0,
            canInteract = function()
                return injail and (breakout2 or breakout3) and not using and not cutFences[index] and isPointAvailable(point)
            end,
            onSelect = function()
                if lib.callback.await('HD_Jail:CheckItemB2', false, 'hd_file') then
                    cutFence(index)
                else
                    Notification(Config.Sayings[95])
                end
            end
        }}
    })
end
