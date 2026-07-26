local bedOpen = false
local CloseBedInventory

local function TrackBedInventory()
    bedOpen = true
    CreateThread(function()
        Wait(500)
        while bedOpen do
            Wait(250)
            if not LocalPlayer.state.invOpen then
                CloseBedInventory()
            end
        end
    end)
end

RegisterNetEvent('HD_Jail:OpenBedInventory', function(stashId, owner)
    exports.ox_inventory:openInventory('stash', { id = stashId, owner = owner })
    TrackBedInventory()
end)

RegisterNetEvent('HD_Jail:TrackBedInventory', TrackBedInventory)

CloseBedInventory = function()
    if not bedOpen then return end
    bedOpen = false
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    inAnim.Dict = nil
    inAnim.Anim = nil
    inAnim.Atr = 0
    inAnim.Freeze = false
    RemoveAnimDict('mini@repair')
    ClearPedTasksImmediately(ped)
    using = false
end

function OpenChest(reOpen)
    if reOpen then
        using = true
        local ped = PlayerPedId()
        LoadAnim('mini@repair')
        SetEntityCoords(ped, Config.Cells[jailCell].InvLoc.Loc.x, Config.Cells[jailCell].InvLoc.Loc.y, Config.Cells[jailCell].InvLoc.Loc.z - 1, false, false, false, false)
        SetEntityHeading(ped, Config.Cells[jailCell].InvLoc.Heading)
        TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        FreezeEntityPosition(ped, true)
        lib.progressBar({ duration = Config.OpenCloseTime * 1000, label = Config.Sayings[35], icon = 'fixlife.svg', position = 'bottom', useWhileDead = false, canCancel = false, disable = { car = true, move = true, combat = true } })
    end
    TriggerServerEvent('HD_Jail:OpenBedInventory')
end

