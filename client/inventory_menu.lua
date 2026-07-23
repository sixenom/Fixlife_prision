function OpenChest(reOpen)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		if reOpen then
			using = true
			RequestAnimDict('mini@repair')
							
			if not HasAnimDictLoaded('mini@repair') then
				LoadAnim('mini@repair')
			end
			SetEntityCoords(ped, Config.Cells[jailCell].InvLoc.Loc.x, Config.Cells[jailCell].InvLoc.Loc.y, Config.Cells[jailCell].InvLoc.Loc.z - 1, false, false, false, false)
			SetEntityHeading(ped, Config.Cells[jailCell].InvLoc.Heading)
			TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
			inAnim.Dict = 'mini@repair'
			inAnim.Anim = 'fixing_a_ped'
			inAnim.Atr = 1
			inAnim.Freeze = true
			FreezeEntityPosition(ped, true)
			-- exports.rprogress:Start(Config.Sayings[35] , Config.OpenCloseTime *1000)
			lib.progressCircle({ --Creando
				duration =  Config.OpenCloseTime *1000,
				label =  Config.Sayings[35],
				position = 'bottom',
				useWhileDead = false,
				canCancel = false,
				disable = {
					car = true,
					move = true,
					combat = true,
					mouse = false,
				},
			})
			-- Citizen.Wait(Config.OpenCloseTime *1000)
		end
	
		local element = {
			[1] = {label = Config.Sayings[41], value = 'open2'},
			[2] = {label = Config.Sayings[40], value = 'open'}
		}


		NativeMenu.CloseAll()

		NativeMenu.Open('default', GetCurrentResourceName(), 'inv_menu', {
			title    = Config.Sayings[34],
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if data.current.value == 'open' then
				OpenItChest()
			else
				OpenAddChest()
			end
		end, function(data, menu)
			menu.close()
			-- exports.rprogress:Start(Config.Sayings[36] , Config.OpenCloseTime *1000)
			-- Citizen.Wait(Config.OpenCloseTime *1000)
			lib.progressCircle({ --bajando cama
				duration =  Config.OpenCloseTime *1000,
				label =  Config.Sayings[36],
				position = 'bottom',
				useWhileDead = false,
				canCancel = false,
				disable = {
					car = true,
					move = true,
					combat = true,
					mouse = false,
				},
			})
			FreezeEntityPosition(ped, false)
			inAnim.Dict = nil
			inAnim.Anim = nil
			inAnim.Atr = 0
			inAnim.Freeze = false
			RemoveAnimDict('mini@repair')
			ClearPedTasksImmediately(ped)
			using = false
		end)
	end)
end

local bedOpen = false
local CloseBedInventory

RegisterNetEvent('HD_Jail:OpenBedInventory', function(stashId, owner)
    bedOpen = true
    exports.ox_inventory:openInventory('stash', { id = stashId, owner = owner })
    CreateThread(function()
        Wait(500)
        while bedOpen do
            Wait(250)
            if not LocalPlayer.state.invOpen then
                CloseBedInventory()
            end
        end
    end)
end)

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
        lib.progressCircle({ duration = Config.OpenCloseTime * 1000, label = Config.Sayings[35], position = 'bottom', useWhileDead = false, canCancel = false, disable = { car = true, move = true, combat = true } })
    end
    TriggerServerEvent('HD_Jail:OpenBedInventory')
end

function OpenAddChest()
	local ped = PlayerPedId()
	lib.callback('HD_Jail:GetInventory', false, function(inv)
		local invie = nil
		local element = {}

		invie = inv.items
		if invie[1] ~= nil then
			for i=1, #invie, 1 do
				local item = invie[i]
	
				if item.count > 0 then
					table.insert(element, {label = item.count..'x '..item.label, value = i})
				end
			end
		else
			table.insert(element, {label = Config.Sayings[33], value = 'none'})
		end
		if element[1] == nil then
			table.insert(element, {label = Config.Sayings[33], value = 'none'})
		end

		NativeMenu.CloseAll()

		NativeMenu.Open('default', GetCurrentResourceName(), 'inv_menu3', {
			title    = Config.Sayings[34],
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if data.current.value ~= 'none' then
				local numies = data.current.value
				menu.close()
				NativeMenu.Open('dialog', GetCurrentResourceName(), 'inv_amt2', {
					title = (Config.Sayings[42])
				}, function(data, menu)
					local amount = tonumber(data.value)
		
					if amount == nil or amount < 0 then
						Notification(Config.Sayings[38])
					elseif amount > invie[numies].count then
						Notification(Config.Sayings[39])
					else
						menu.close()
						TriggerServerEvent('HD_Jail:AddItem', invie[numies].name, amount, invie[numies].label, GetPlayerServerId(PlayerId()))
						OpenChest(false)
					end
				end, function(data, menu)
					menu.close()
					OpenAddChest()
				end)
			end
		end, function(data, menu)
			menu.close()
			OpenChest(false)
		end)
	end)
end

function OpenItChest()
	local ped = PlayerPedId()
	lib.callback('HD_Jail:GetChest', false, function(cvalue)
		local valuesc = {}
		local element = {}

		valuesc = cvalue
		if valuesc[1] ~= nil then
			for i = 1, #valuesc, 1 do 
				table.insert(element, {label = valuesc[i].amt..'x '..valuesc[i].itemName, value = i})
			end
		else
			table.insert(element, {label = Config.Sayings[33], value = 'none'})
		end

		NativeMenu.CloseAll()

		NativeMenu.Open('default', GetCurrentResourceName(), 'inv_menu2', {
			title    = Config.Sayings[34],
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if data.current.value ~= 'none' then
				local numies = data.current.value
				menu.close()
				NativeMenu.Open('dialog', GetCurrentResourceName(), 'inv_amt', {
					title = (Config.Sayings[37])
				}, function(data, menu)
					local amount = tonumber(data.value)
		
					if amount == nil or amount < 0 then
						Notification(Config.Sayings[38])
					elseif amount > valuesc[numies].amt then
						Notification(Config.Sayings[39])
					else
						menu.close()
						TriggerServerEvent('HD_Jail:RemoveItem', valuesc[numies].ite, amount, valuesc[numies].itemName, GetPlayerServerId(PlayerId()))
						OpenChest(false)
					end
				end, function(data, menu)
					menu.close()
					OpenItChest()
				end)
			end
		end, function(data, menu)
			menu.close()
			OpenChest(false)
		end)
	end)
end

