local ids = {}
local policeIds = {}

local function point(id, coords, text, event, icon, key)
    ids[#ids + 1] = id
    TriggerEvent('Fix_3dTextUi:crear', id, coords, 3.0, 0.5, 0.5, '#fbfdfd', key or 'E', text, 'image', icon or 'images/mi_icono.png', event)
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
    if job ~= 0 and doneTasks ~= 0 and Config.JobOptions[job] then
        local task = Config.JobOptions[job].Tasks[doneTasks]
        if task then point('fixlife_prision_task', task.TaskLoc.Loc, Config.Sayings[22] .. task.TaskName, 'Fixlife_prision:client:task') end
    end
end

RegisterNetEvent('Fixlife_prision:client:jobman', function()
    if not injail or using or isDead then return end
    inMenu.coords, inMenu.is = Config.JobManLoc.Loc, true
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
