local config = require 'config.config_c'
local ScrewGame = require 'client.minigame.screw_game'

local active = false
local mapToiletModel = joaat('hei_heist_toilet01')
local hiddenToiletCoords
local replacementToilet

local function restoreMapToilet()
    if not hiddenToiletCoords then return end

    local coords = hiddenToiletCoords
    RemoveModelHide(coords.x, coords.y, coords.z, 2.0, mapToiletModel, true)
    RemoveModelHide(coords.x, coords.y, coords.z, 2.0, mapToiletModel, false)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    hiddenToiletCoords = nil
end

function StartToiletEscape()
    if active or not injail or jailCell <= 0 or using or isDead or breakout2 then return end

    active = true
    using = true

    if replacementToilet and DoesEntityExist(replacementToilet) then
        DeleteEntity(replacementToilet)
    end
    replacementToilet = nil

    local cell = Config.Cells[jailCell]
    local toiletCoords = cell and cell.BreakLoc
    if not toiletCoords then
        active, using = false, false
        return
    end

    CreateModelHide(toiletCoords.Loc.x, toiletCoords.Loc.y, toiletCoords.Loc.z, 2.0, mapToiletModel, true)
    hiddenToiletCoords = toiletCoords.Loc

    local model = config.toilet.toiletModel
    lib.requestModel(model)
    local toilet = CreateObject(model, toiletCoords.Loc.x, toiletCoords.Loc.y, toiletCoords.Loc.z, false, false, false)

    if not DoesEntityExist(toilet) then
        restoreMapToilet()
        active, using = false, false
        return
    end

    SetEntityHeading(toilet, toiletCoords.Heading)
    FreezeEntityPosition(toilet, true)

    local game = ScrewGame.new(toilet)
    local completed = game:start()

    SetEntityVisible(toilet, true, false)
    SetEntityCollision(toilet, true, true)
    FreezeEntityPosition(toilet, false)
    replacementToilet = toilet
    active, using = false, false

    if completed then BreakOutStart(true) end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == cache.resource then
        SetNuiFocus(false, false)
        if replacementToilet and DoesEntityExist(replacementToilet) then
            DeleteEntity(replacementToilet)
        end
        replacementToilet = nil
        restoreMapToilet()
    end
end)
