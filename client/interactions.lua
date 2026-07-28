local ids = {}
local policeIds = {}
local taskProp
local taskProps = {}
local laundryDropProps = {}
local laundryDirtyProps = {}
local laundryDirtyPropByIndex = {}
local taskAnimationLocation
local laundryAnimationProp
local laundryStageLocation
local laundryDirtyInteractionOffset = {0.0, -0.5, 1.0}
local laundryDirtyInteractionOffsets = {
    [1] = {0.0, 0.7, 1.0},
    [2] = {0.0, 0.7, 1.0},
    [3] = {0.0, 0.7, 1.0},
    [4] = {0.0, -0.5, 1.0}
}
local laundryDirtyAnimationHeadingOffsets = {[1] = 180.0, [2] = 180.0, [3] = 180.0, [4] = 0.0}
local laundryRunnerInteractionOffset = {0.5, 0.0, 1.0}
local laundryPicked = {}
local laundryDeliveryIndex
local laundryWasherIndex
local laundryMachineType
local laundryWetPicked = {}
local laundryDryPicked = {}
local laundryIcons = {
    [1] = 'shirt-long-sleeve.svg', [2] = 'dryer.svg',
    [3] = 'shirt-long-sleeve.svg', [4] = 'dryer.svg',
    [5] = 'shirt-long-sleeve.svg', [6] = 'dryer.svg',
    [7] = 'shirt-long-sleeve.svg', [8] = 'dryer.svg',
    [9] = 'raindrops.svg', [10] = 'dryer-heat.svg',
    [11] = 'raindrops.svg', [12] = 'dryer-heat.svg',
    [13] = 'raindrops.svg', [14] = 'dryer-heat.svg',
    [15] = 'raindrops.svg', [16] = 'dryer-heat.svg',
    [17] = 'sparkles.svg', [18] = 'sparkles.svg', [19] = 'sparkles.svg', [20] = 'sparkles.svg',
    [21] = 'grid-2.svg'
}

local function point(id, coords, text, event, icon, key)
    ids[#ids + 1] = id
    TriggerEvent('Fix_3dTextUi:crear', id, coords, 3.0, 0.5, 0.5, '#fbfdfd', key or 'E', text, 'image', icon or 'images/mi_icono.png', event)
end

function RemovePrisonTaskProp()
    for _, prop in ipairs(taskProps) do
        if DoesEntityExist(prop) then
            SetEntityDrawOutline(prop, false)
            DeleteObject(prop)
        end
    end
    taskProps = {}
    taskProp = nil
end

function RemoveLaundryDropProps()
    for _, prop in ipairs(laundryDropProps) do
        if DoesEntityExist(prop) then
            SetEntityDrawOutline(prop, false)
            DeleteObject(prop)
        end
    end
    laundryDropProps = {}
end

function RemoveLaundryDirtyProps()
    for _, prop in ipairs(laundryDirtyProps) do
        if DoesEntityExist(prop) then DeleteObject(prop) end
    end
    laundryDirtyProps = {}
    laundryDirtyPropByIndex = {}
end

function SpawnLaundryDropProp(index)
    local drop = Config.LaundryDropLocs[index]
    if not drop then return end
    LoadPropDict('ch_prop_ch_laundry_trolley_01b')
    local prop = CreateObject(joaat('ch_prop_ch_laundry_trolley_01b'), drop.Loc.x, drop.Loc.y, drop.Loc.z - 1.0, false, false, false)
    SetEntityHeading(prop, drop.Heading)
    SetEntityAsMissionEntity(prop, true, true)
    laundryDropProps[index] = prop
    SetModelAsNoLongerNeeded('ch_prop_ch_laundry_trolley_01b')
end

local function CreatePrisonTaskProp(task, location, heading)
    local model = 'ch_prop_ch_laundry_trolley_01b'
    LoadPropDict(model)
    local spawn = location or task.TaskLoc
    local prop = CreateObject(joaat(model), spawn.Loc.x, spawn.Loc.y, spawn.Loc.z - 1.0, false, false, false)
    SetEntityHeading(prop, heading or spawn.Heading)
    SetEntityAsMissionEntity(prop, true, true)
    if task.TaskName == 'Dejar la ropa sucia' then
        SetEntityCollision(prop, false, false)
        SetEntityAlpha(prop, 90, false)
        SetEntityDrawOutlineColor(255, 255, 255, 255)
    else
        SetEntityDrawOutlineColor(255, 200, 0, 255)
    end
    SetEntityDrawOutlineShader(1)
    SetEntityDrawOutline(prop, true)
    table.insert(taskProps, prop)
    SetModelAsNoLongerNeeded(model)
    return prop
end

function ResetLaundryRoute()
    ClearLaundryMachineOutlines()
    laundryPicked = {}
    laundryDeliveryIndex = nil
    taskAnimationLocation = nil
    laundryStageLocation = nil
    laundryWasherIndex = nil
    laundryMachineType = nil
    laundryWetPicked = {}
    laundryDryPicked = {}
end

function SetTaskAnimationLocation(location)
    taskAnimationLocation = location
end

function GetTaskAnimationLocation()
    return taskAnimationLocation
end

function ClearTaskAnimationLocation()
    taskAnimationLocation = nil
end

function SetLaundryStageLocation(location)
    laundryStageLocation = location
end

function ClearLaundryStageLocation()
    laundryStageLocation = nil
end

function SetLaundryMachineStage(machine, index, showOutline, outlineColor)
    laundryStageLocation = machine == 'dryer' and Config.LaundryDryerLocs[index] or Config.LaundryWasherLocs[index]
    laundryWasherIndex = index
    laundryMachineType = machine
    if showOutline ~= false then
        SetLaundryMachineOutline(machine, index, true, outlineColor or (machine == 'washer' and 'yellow' or nil))
    end
end

function GetLaundryMachineIndex()
    return laundryWasherIndex
end

function HighlightAvailableLaundryWashers()
    for i = 1, 4 do SetLaundryMachineOutline('washer', i, not laundryWetPicked[i], 'yellow') end
end

function HighlightAvailableLaundryDryers()
    for i = 1, 4 do SetLaundryMachineOutline('dryer', i, not laundryDryPicked[i], 'yellow') end
end

function SetLaundryAnimationProp(prop)
    laundryAnimationProp = prop
end

function RemoveLaundryAnimationProp()
    if laundryAnimationProp and DoesEntityExist(laundryAnimationProp) then
        SetEntityDrawOutline(laundryAnimationProp, false)
        DeleteObject(laundryAnimationProp)
    end
    laundryAnimationProp = nil
end

function GetLaundryTaskIndex()
    return job == 3 and doneTasks % 2 == 0 and laundryDeliveryIndex and laundryDeliveryIndex * 2 or doneTasks
end

function GetLaundryDropIndex()
    return laundryDeliveryIndex
end

local function SpawnPrisonTaskProp(task)
    RemovePrisonTaskProp()
    if job ~= 3 then return end
    local drop = laundryDeliveryIndex and Config.LaundryDropLocs[laundryDeliveryIndex]
    local heading = doneTasks % 2 == 0 and drop and drop.Heading or nil
    taskProp = CreatePrisonTaskProp(task, nil, heading)
end

local function setShowerPoints(prepared)
    TriggerEvent('Fix_3dTextUi:actualizar', 'fixlife_prision_shower_ready', prepared and 'cambiarse a uniforme' or 'cambiarse para ducharse')
    for i, coords in ipairs(Config.ShowerLocs) do
        local id = 'fixlife_prision_shower_' .. i
        TriggerEvent('Fix_3dTextUi:eliminar', id)
        if prepared then point(id, coords, 'Ducharse', 'Fixlife_prision:client:take_shower:' .. i, 'shower.svg', 'G') end
    end
end

function ResetShowerInteraction()
    setShowerPoints(false)
end

function CreatePrisonInteractionPoints()
    RemovePoliceInteractionPoints()
    point('fixlife_prision_info', Config.InfoPedLoc[infoLoc].Loc, Config.Sayings[27], 'Fixlife_prision:client:info')
    point('fixlife_prision_jobman', Config.JobManLoc.Loc, Config.Sayings[14], 'Fixlife_prision:client:jobman', 'hammer.svg')
    point('fixlife_prision_jobman2', Config.JobManLoc2.Loc, Config.Sayings[14], 'Fixlife_prision:client:jobman2', 'hammer.svg')
    point('fixlife_prision_laundry_vehicle', Config.LaundryVehicleNpcLoc.Loc, 'Vehículo de lavandería', 'Fixlife_prision:client:laundry_vehicle', 'car-rear.svg')
    point('fixlife_prision_food', Config.GetFoodLoc.Loc, Config.Sayings[30], 'Fixlife_prision:client:food')
    point('fixlife_prision_item', Config.ItemLoc.Loc, Config.Sayings[12], 'Fixlife_prision:client:item')
    if Config.Showers then
        point('fixlife_prision_shower_ready', Config.ShowerLoc.Loc, 'cambiarse para ducharse', 'Fixlife_prision:client:shower', 'shorts.svg')
    end
    if jailCell > 0 then point('fixlife_prision_chest', Config.Cells[jailCell].InvLoc.Loc, Config.Sayings[29], 'Fixlife_prision:client:chest', 'angles-up.svg') end
end

function RemovePrisonInteractionPoints()
    for i = 1, #ids do TriggerEvent('Fix_3dTextUi:eliminar', ids[i]) end
    ids = {}
    RemovePrisonTaskProp()
    RemoveLaundryDropProps()
    RemoveLaundryDirtyProps()
    if RemoveLaundryVehicle then RemoveLaundryVehicle() end
    TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_task')
    ResetShowerInteraction()
end

function CreatePoliceInteractionPoints()
    local isPolice = false
    for _, role in ipairs(Config.PoliceRoles) do
        if QBX.PlayerData.job and QBX.PlayerData.job.name == role then isPolice = true break end
    end
    if not isPolice then return end

    for i, cell in ipairs(Config.Cells) do
        local id = 'fixlife_prision_police_bed_' .. i
        policeIds[#policeIds + 1] = id
        TriggerEvent('Fix_3dTextUi:crear', id, cell.InvLoc.Loc, 3.0, 0.5, 0.5, '#fbfdfd', 'E', Config.Sayings[158], 'image', 'angles-up.svg', 'Fixlife_prision:client:police_chest:' .. i)
    end
end

function RemovePoliceInteractionPoints()
    for i = 1, #Config.Cells do
        TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_police_bed_' .. i)
    end
    policeIds = {}
end

for i = 1, #Config.Cells do
    RegisterNetEvent('Fixlife_prision:client:police_chest:' .. i, function()
        for j = 1, #Config.PoliceRoles do
            if QBX.PlayerData.job and QBX.PlayerData.job.name == Config.PoliceRoles[j] then
                closestPoliceInv = i
                OpenPoliceShitMenu()
                inMenu.coords, inMenu.is = Config.Cells[i].InvLoc.Loc, true
                return
            end
        end
    end)
end

function UpdatePrisonTaskPoint()
    TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_task')
    for i = 1, 7, 2 do TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_task_' .. i) end
    for i = 1, 4 do TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_laundry_dirty_' .. i) end
    if job ~= 0 and doneTasks ~= 0 and Config.JobOptions[job] then
        if job == 2 and doneTasks % 2 == 1 and doneTasks <= 7 then
            RemovePrisonTaskProp()
            local task = Config.JobOptions[job].Tasks[1]
            for i, location in ipairs(Config.LaundryDirtyLocs) do
                if not laundryPicked[i] then
                    local prop = laundryDirtyPropByIndex[i]
                    if not prop or not DoesEntityExist(prop) then
                        prop = CreatePrisonTaskProp(task, location)
                        table.insert(laundryDirtyProps, prop)
                        laundryDirtyPropByIndex[i] = prop
                    else
                        SetEntityDrawOutlineColor(255, 200, 0, 255)
                        SetEntityDrawOutline(prop, true)
                    end
                    table.insert(taskProps, prop)
                    local interactionCoords = GetOffsetFromEntityInWorldCoords(prop, table.unpack(laundryDirtyInteractionOffsets[i] or laundryDirtyInteractionOffset))
                    point('fixlife_prision_laundry_dirty_' .. i, interactionCoords, Config.Sayings[22] .. task.TaskName, 'Fixlife_prision:client:laundry_dirty:' .. i, 'shirt-long-sleeve.svg')
                end
            end
            return
        end
        if job == 3 and doneTasks % 2 == 1 then
            RemovePrisonTaskProp()
            for i = 1, 7, 2 do
                if not laundryPicked[i] then
                local task = Config.JobOptions[job].Tasks[i]
                local prop = CreatePrisonTaskProp(task)
                local interactionCoords = GetOffsetFromEntityInWorldCoords(prop, table.unpack(laundryRunnerInteractionOffset))
                point('fixlife_prision_task_' .. i, interactionCoords, Config.Sayings[22] .. task.TaskName, 'Fixlife_prision:client:laundry_task:' .. i, 'hand-holding.svg')
                end
            end
            return
        end
        if job == 2 and doneTasks % 2 == 1 and doneTasks >= 9 and doneTasks <= 15 then
            RemovePrisonTaskProp()
            for i = 1, 4 do
                if not laundryWetPicked[i] then
                    local interactionCoords = GetLaundryWasherInteractionCoords(i)
                    point('fixlife_prision_laundry_wet_' .. i, interactionCoords, 'Recoger la ropa mojada', 'Fixlife_prision:client:laundry_wet:' .. i, 'raindrops.svg')
                end
            end
            return
        end
        if job == 2 and doneTasks >= 17 and doneTasks <= 20 then
            RemovePrisonTaskProp()
            for i = 1, 4 do
                if not laundryDryPicked[i] then
                    point('fixlife_prision_laundry_dry_' .. i, GetLaundryDryerInteractionCoords(i), 'Recoger la ropa seca', 'Fixlife_prision:client:laundry_dry:' .. i, 'sparkles.svg')
                end
            end
            return
        end
        local task = Config.JobOptions[job].Tasks[GetLaundryTaskIndex()]
        if task then
            SpawnPrisonTaskProp(task)
            local stageLocation = job == 2 and laundryStageLocation or nil
            local interactionCoords = job == 2 and laundryStageLocation and laundryWasherIndex and (laundryMachineType == 'dryer' and GetLaundryDryerInteractionCoords(laundryWasherIndex) or GetLaundryWasherInteractionCoords(laundryWasherIndex)) or (stageLocation or task.TaskLoc).Loc
            if taskProp then interactionCoords = GetOffsetFromEntityInWorldCoords(taskProp, 0.5, 0.0, 1.0) end
            local icon = job == 3 and doneTasks % 2 == 0 and 'down-right.svg' or job == 2 and laundryIcons[doneTasks] or nil
            point('fixlife_prision_task', interactionCoords, Config.Sayings[22] .. task.TaskName, 'Fixlife_prision:client:task', icon)
        end
    end
end

for i = 1, 4 do
    RegisterNetEvent('Fixlife_prision:client:laundry_wet:' .. i, function()
        if not injail or using or isDead or job ~= 2 or doneTasks % 2 ~= 1 or doneTasks < 9 or doneTasks > 15 then return end
        if laundryWetPicked[i] then return end
        TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_laundry_wet_' .. i)
        laundryWetPicked[i] = true
        SetLaundryMachineOutlines('washer', false)
        SetLaundryMachineStage('dryer', i)
        StartLaundryWasherAction(i, function() TaskComplete(true) end)
    end)
end

for i = 1, 4 do
    RegisterNetEvent('Fixlife_prision:client:laundry_dry:' .. i, function()
        if not injail or using or isDead or job ~= 2 or doneTasks < 17 or doneTasks > 20 then return end
        if laundryDryPicked[i] then return end
        TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_laundry_dry_' .. i)
        laundryDryPicked[i] = true
        SetLaundryMachineOutlines('dryer', false)
        StartLaundryDryerAction(i, function() TaskComplete(true) end)
    end)
end

for i = 1, 4 do
    RegisterNetEvent('Fixlife_prision:client:laundry_dirty:' .. i, function()
        if not injail or using or isDead or job ~= 2 or doneTasks % 2 ~= 1 or doneTasks > 7 then return end
        local selected = laundryDirtyPropByIndex[i]
        if laundryPicked[i] or not selected then return end
        TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_laundry_dirty_' .. i)
        local animationOffset = laundryDirtyInteractionOffsets[i] or laundryDirtyInteractionOffset
        local animationCoords = selected and GetOffsetFromEntityInWorldCoords(selected, table.unpack(animationOffset))
        SetLaundryAnimationProp(selected)
        SetEntityDrawOutline(selected, false)
        for j = #taskProps, 1, -1 do
            local prop = taskProps[j]
            if prop ~= selected then SetEntityDrawOutline(prop, false) end
            table.remove(taskProps, j)
        end
        taskProp = nil
        local animationLocation = animationCoords and vector3(animationCoords.x+0.4, animationCoords.y, animationCoords.z - 1.0)
        local animationHeading = (GetEntityHeading(selected) + (laundryDirtyAnimationHeadingOffsets[i] or 0.0)) % 360.0
        SetTaskAnimationLocation(animationLocation and {Loc = animationLocation, Heading = animationHeading, World = true} or Config.LaundryDirtyLocs[i])
        SetLaundryMachineStage('washer', i, true, 'white')
        laundryPicked[i] = true
        TaskComplete()
    end)
end

for i = 1, 7, 2 do
    RegisterNetEvent('Fixlife_prision:client:laundry_task:' .. i, function()
        if not injail or using or isDead or job ~= 3 or doneTasks % 2 ~= 1 then return end
        local allPicked = true
        for j = 1, 7, 2 do if not laundryPicked[j] then allPicked = false break end end
        if allPicked then ResetLaundryRoute(); RemoveLaundryDropProps() end
        if laundryPicked[i] then return end
        laundryPicked[i] = true
        laundryDeliveryIndex = (i + 1) / 2
        TaskComplete()
    end)
end

RegisterNetEvent('Fixlife_prision:client:jobman', function()
    if not injail or using or isDead then return end
    inMenu.coords, inMenu.is = Config.JobManLoc.Loc, true
    OpenJobManMenu()
end)
RegisterNetEvent('Fixlife_prision:client:jobman2', function()
    if not injail or using or isDead then return end
    inMenu.coords, inMenu.is = Config.JobManLoc2.Loc, true
    OpenJobManMenu()
end)
RegisterNetEvent('Fixlife_prision:client:laundry_vehicle', function()
    if not injail or using or isDead then return end
    inMenu.coords, inMenu.is = Config.LaundryVehicleNpcLoc.Loc, true
    OpenLaundryVehicleMenu()
end)
RegisterNetEvent('Fixlife_prision:client:info', function()
    if not injail or using or isDead then return end
    inMenu.coords, inMenu.is = Config.InfoPedLoc[infoLoc].Loc, true
    OpenInfoMenu()
end)
RegisterNetEvent('Fixlife_prision:client:food', function() if injail and not using and not isDead then OpenFood() end end)
RegisterNetEvent('Fixlife_prision:client:shower', function() if injail and not using and not isDead and not showerNow then StartShower() end end)
local function takeShower(index)
    if not injail or using or isDead or not showerNow then return end
    showerNow = false
    local ped, coords = PlayerPedId(), Config.ShowerLocs[index]
    SetEntityCoords(ped, coords.x, coords.y, coords.z - 1, false, false, false, false)
    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_STAND_IMPATIENT', 0, true)
    RequestNamedPtfxAsset('core')
    while not HasNamedPtfxAssetLoaded('core') do Wait(1) end
    for i = 1, 5 do
        UseParticleFxAssetNextCall('core')
        StartParticleFxLoopedAtCoord('ent_sht_water', coords.x, coords.y, coords.z + 1.8, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        Wait(3000)
    end
    Wait(6000)
    ClearPedTasksImmediately(ped)
    using = false
    ResetShowerInteraction()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadClothes', skin, skin.sex == 0 and Config.Uniforms.male or Config.Uniforms.female)
    end)
end

for i = 1, #Config.ShowerLocs do
    RegisterNetEvent('Fixlife_prision:client:take_shower:' .. i, function() takeShower(i) end)
end
RegisterNetEvent('Fixlife_prision:client:chest', function()
    if not injail or using or isDead then return end
    for i = 1, #Config.PoliceRoles do
        if QBX.PlayerData.job and QBX.PlayerData.job.name == Config.PoliceRoles[i] then
            OpenPoliceShitMenu()
            inMenu.coords, inMenu.is = Config.Cells[jailCell].InvLoc.Loc, true
            return
        end
    end
    OpenChest(true)
end)
RegisterNetEvent('Fixlife_prision:client:task', function()
    if not injail or using or isDead or job == 0 then return end
    TriggerEvent('Fix_3dTextUi:eliminar', 'fixlife_prision_task')
    if job == 2 and doneTasks % 2 == 0 and doneTasks <= 16 then
        if not laundryWasherIndex then return end
        SetLaundryMachineOutline(laundryMachineType, laundryWasherIndex, false)
        local action = laundryMachineType == 'dryer' and StartLaundryDryerAction or StartLaundryWasherAction
        action(laundryWasherIndex, function() TaskComplete(true) end)
        return
    end
    if job == 3 and doneTasks % 2 == 0 then
        local hasTrolley = false
        for _, item in ipairs(PlayerHasProp) do
            if item.id == 'task' and DoesEntityExist(item.object) then hasTrolley = true break end
        end
        if not hasTrolley then
            Notification('Debes descargar el carrito antes de entregar la ropa.')
            return
        end
    end
    TaskComplete()
end)
RegisterNetEvent('Fixlife_prision:client:item', function()
    if not injail or using or isDead or not canGrab or not itemzie[1] then return end
    canGrab = false
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config.ItemLoc.Loc.x, Config.ItemLoc.Loc.y, Config.ItemLoc.Loc.z - 1, false, false, false, false)
    SetEntityHeading(ped, Config.ItemLoc.Heading)
    LoadAnim('anim@amb@clubhouse@bar@drink@idle_a')
    lib.progressBar({duration = Config.RetreiveTime * 1000, label = Config.Sayings[13], icon = 'fixlife.svg', position = 'bottom', useWhileDead = false, canCancel = false, disable = {car = true, move = true, combat = true, mouse = false}})
    TaskPlayAnim(ped, 'anim@amb@clubhouse@bar@drink@idle_a', 'idle_a_bartender', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    TriggerServerEvent('HD_Jail:RetrieveItems', itemzie)
    for i = #blips, 1, -1 do if blips[i].id == 'items' then RemoveBlip(blips[i].data); table.remove(blips, i) end end
    RemoveAnimDict('anim@amb@clubhouse@bar@drink@idle_a')
    ClearPedTasksImmediately(ped)
    itemzie = {}
end)
