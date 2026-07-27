local ids = {}
local policeIds = {}
local taskProp
local taskProps = {}
local laundryIcons = {
    [1] = 'shirt-long-sleeve.svg',
    [2] = 'dryer.svg', [3] = 'dryer.svg', [4] = 'dryer.svg', [5] = 'dryer.svg',
    [6] = 'raindrops.svg',
    [7] = 'dryer-heat.svg',
    [8] = 'raindrops.svg',
    [9] = 'dryer-heat.svg',
    [10] = 'raindrops.svg',
    [11] = 'dryer-heat.svg',
    [12] = 'raindrops.svg',
    [13] = 'dryer-heat.svg',
    [14] = 'sparkles.svg', [15] = 'sparkles.svg', [16] = 'sparkles.svg', [17] = 'sparkles.svg',
    [18] = 'grid-2.svg'
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

local function CreatePrisonTaskProp(task)
    local model = 'ch_prop_ch_laundry_trolley_01b'
    LoadPropDict(model)
    local prop = CreateObject(joaat(model), task.TaskLoc.Loc.x, task.TaskLoc.Loc.y, task.TaskLoc.Loc.z - 1.0, false, false, false)
    SetEntityHeading(prop, task.TaskLoc.Heading)
    SetEntityAsMissionEntity(prop, true, true)
    SetEntityDrawOutlineColor(255, 200, 0, 255)
    SetEntityDrawOutlineShader(1)
    SetEntityDrawOutline(prop, true)
    table.insert(taskProps, prop)
    SetModelAsNoLongerNeeded(model)
    return prop
end

local function SpawnPrisonTaskProp(task)
    RemovePrisonTaskProp()
    if job ~= 3 or doneTasks % 2 ~= 1 then return end
    taskProp = CreatePrisonTaskProp(task)
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
    if job ~= 0 and doneTasks ~= 0 and Config.JobOptions[job] then
        if job == 3 and doneTasks % 2 == 1 then
            RemovePrisonTaskProp()
            for i = 1, 7, 2 do
                local task = Config.JobOptions[job].Tasks[i]
                local prop = CreatePrisonTaskProp(task)
                local interactionCoords = GetOffsetFromEntityInWorldCoords(prop, 0.5, 0.0, 1.0)
                point('fixlife_prision_task_' .. i, interactionCoords, Config.Sayings[22] .. task.TaskName, 'Fixlife_prision:client:laundry_task:' .. i)
            end
            return
        end
        local task = Config.JobOptions[job].Tasks[doneTasks]
        if task then
            SpawnPrisonTaskProp(task)
            local interactionCoords = task.TaskLoc.Loc
            if taskProp then interactionCoords = GetOffsetFromEntityInWorldCoords(taskProp, 0.5, 0.0, 1.0) end
            point('fixlife_prision_task', interactionCoords, Config.Sayings[22] .. task.TaskName, 'Fixlife_prision:client:task', job == 2 and laundryIcons[doneTasks] or nil)
        end
    end
end

for i = 1, 7, 2 do
    RegisterNetEvent('Fixlife_prision:client:laundry_task:' .. i, function()
        if not injail or using or isDead or job ~= 3 or doneTasks % 2 ~= 1 then return end
        doneTasks = i
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
RegisterNetEvent('Fixlife_prision:client:task', function() if injail and not using and not isDead and job ~= 0 then TaskComplete() end end)
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
