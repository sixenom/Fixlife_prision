xSound = exports.xsound

Citizen.CreateThread(function()
	while QBX.PlayerData.job == nil do
		Citizen.Wait(10)
	end
end)

infoLoc = 1

time = 0
local difftime = {Hours = 0, Mins = 0, Seconds = 0}

local soltime = 0
local diffSol = {Hours = 0, Mins = 0, Seconds = 0}

isDead = false

job = 0
doneTasks = 0
taskMax = 0

injail = false
jailCell = 0
solcell = 0

canGrab = false
local itemzie = {}

createdCamera = 0
beingMsg = {msg = nil, size = 0.0}
beingSent = false

blips = {}
peds = {}
PlayerHasProp = {}

jailLocs = {}
closestLoc = 1

breakout = 0
local diffBreak = {Hours = 0, Mins = 0, Seconds = 0}
breakout2 = false
breakout3 = false
breakout4 = true
local closestTower = 1
local closestBreak = 1

inMenu = {is = false, coords = nil}
inAnim = {Dict = nil, Anim = nil, Atr = 0, Freeze = false}
needsEat = false

local closestShower = 1
showerNow = false

local closestOut = 1
workoutNow = false
workoutLoc = 0

switchie = false
lockieDown = false
inJailMenu = false

local closestPoliceInv = 1 

pedsie = nil

Citizen.CreateThread(function()
	Citizen.Wait(500)
	if Config.JailBlip.Spawn then
		local blip2 = AddBlipForCoord(Config.JailLoc.x, Config.JailLoc.y, Config.JailLoc.z)
		SetBlipSprite(blip2, Config.JailBlip.Sprite)
		SetBlipScale(blip2, Config.JailBlip.Size)
		SetBlipColour(blip2, Config.JailBlip.Color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Sayings[160])
		EndTextCommandSetBlipName(blip2)
		SetBlipAsShortRange(blip2, true)
		if Config.UsingHDBlips then
			exports['HD_Blips']:addBlip('Prison', 'emergency', 'prison', {name = "Name_Of_Blip", coords = Config.JailLoc, sprite = Config.JailBlip.Sprite, color = Config.JailBlip.Color, size = Config.JailBlip.Size, short = true, pulse = false}, blip2, GetCurrentResourceName())
		end
	end
end)

RegisterNetEvent('HD_Blips:ReturnDelete')
AddEventHandler('HD_Blips:ReturnDelete', function(resource, shit)
	if resource == GetCurrentResourceName() then
		if DoesBlipExist(shit) then
			RemoveBlip(shit)
		end
	end
end)

local FirstSpawn = true --cambiado
local restarted = false
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		restarted = true
		Wait(10000)
		restarted = false
    end
end)
Citizen.CreateThread(function() 
	Spawned()
end)
function Spawned()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if QBX and QBX.PlayerData and FirstSpawn then
				if QBX.PlayerData.job ~= nil and not restarted then
					FirstSpawn = false
					Citizen.Wait(3000)
					TriggerServerEvent('HD_Jail:LoadedIn')
					break
				end
			end
		end
	end)
end



AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
		local removes = {}
		for i = 1, #blips, 1 do
			table.insert(removes, i)
		end
		for i = 1, #removes, 1 do
			if DoesBlipExist(blips[removes[i]].data) then
				RemoveBlip(blips[removes[i]].data)
			end
			table.remove(blips[removes[i]])
		end
		removes = {}
		for i = 1, #peds, 1 do
			table.insert(removes, i)
		end
		for i = 1, #removes, 1 do
			if DoesEntityExist(peds[removes[i]].data) then
				SetPedAsNoLongerNeeded(peds[removes[i]].data)
				DeletePed(peds[removes[i]].data)
			end
			table.remove(peds[removes[i]])
		end
		removes = {}
		for i = 1, #PlayerHasProp, 1 do
			table.insert(removes, i)
		end
		for i = 1, #removes, 1 do
			if DoesEntityExist(PlayerHasProp[removes[i]].object) then
				DeleteObject(PlayerHasProp[removes[i]].object)
			end
			table.remove(PlayerHasProp[removes[i]])
		end
		removes = {}
    end
end)


