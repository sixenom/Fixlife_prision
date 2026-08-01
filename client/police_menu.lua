
function OpenPoliceShitMenu()
	using = true
	lib.callback('HD_Jail:GetPlayerInCell', false, function(players)
		local options = {}
		for i = 1, #players do
			local player = players[i]
			options[#options + 1] = {title = player.name .. Config.Sayings[156] .. player.id, onSelect = function()
				OpenPoliceMenu2(player.name, player.id)
			end}
		end
		if #options == 0 then options[1] = {title = Config.Sayings[69], disabled = true} end
		lib.hideContext()
		lib.registerContext({id = 'fixlife_prision_police_shit', title = Config.Sayings[155], options = options, onExit = function()
			using = false
			inMenu.is = false
			inMenu.coords = nil
		end})
		lib.showContext('fixlife_prision_police_shit')
	end, closestPoliceInv)
end

function OpenPoliceMenu2(name, theirID)
	TriggerServerEvent('HD_Jail:OpenPoliceBedInventory', theirID)
	using = false
	return
end
function OpenInfoMenu()
	lib.hideContext()
	lib.registerContext({id = 'fixlife_prision_info_menu', title = Config.Sayings[45], options = {
		{title = Config.Sayings[47], onSelect = OpenMakeMenu},
	}, onExit = function()
		inMenu.is = false
		inMenu.coords = nil
	end})
	lib.showContext('fixlife_prision_info_menu')
end

function OpenMakeMenu()
	local options = {}
	for i = 1, #Config.Crafts do
		local index = i
		options[#options + 1] = {title = Config.Crafts[index].Name, onSelect = function() OpenCraftMenu(index) end}
	end
	lib.hideContext()
	lib.registerContext({id = 'fixlife_prision_make_menu', title = Config.Sayings[48], options = options, onExit = OpenInfoMenu})
	lib.showContext('fixlife_prision_make_menu')
end

function OpenCraftMenu(itnum)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		local options = {
			{title = Config.Sayings[50], onSelect = function() OpenNeedsMenu(itnum) end},
			{title = Config.Sayings[51], onSelect = function()
				local menu = {close = lib.hideContext}
		lib.hideContext()
				menu.close()
				lib.callback('HD_Jail:CheckItemMake', false, function(can)
					if can == 1 then
						Notification(Config.Sayings[83])
					elseif can == 2 then
						Notification(Config.Sayings[84])
					else
						Citizen.CreateThread(function()
							using = true
							TriggerServerEvent('HD_Jail:TakeItems', itnum)
							local pedi = nil
							for i = 1, #peds, 1 do
								if peds[i].id == 'info' then
									pedi = peds[i].data
								end
							end
							RequestAnimDict('missmic4')
								
							if not HasAnimDictLoaded('missmic4') then
								LoadAnim('missmic4')
							end
	
							FreezeEntityPosition(pedi, false)
							MakeEntityFaceEntity(ped, pedi)
							MakeEntityFaceEntity(pedi, ped)
							TaskPlayAnim(pedi, 'missmic4', 'michael_tux_fidget', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							TaskPlayAnim(ped, 'missmic4', 'michael_tux_fidget', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
							inAnim.Dict = 'missmic4'
							inAnim.Anim = 'michael_tux_fidget'
							inAnim.Atr = 1
							inAnim.Freeze = true
							FreezeEntityPosition(ped, true)
							FreezeEntityPosition(pedi, true)
							lib.progressBar({ --Creando
								duration =  Config.Crafts[itnum].Time *1000,
								label =  Config.Sayings[85],
								icon = 'fixlife.svg',
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
							ClearPedTasksImmediately(pedi)
							ClearPedTasksImmediately(ped)
							FreezeEntityPosition(pedi, false)
							SetEntityHeading(pedi, Config.InfoPedLoc[infoLoc].Heading)
							FreezeEntityPosition(pedi, true)
							FreezeEntityPosition(ped, false)
							inAnim.Dict = nil
							inAnim.Anim = nil
							inAnim.Atr = 0
							inAnim.Freeze = false
							using = false
						end)
					end
				end, itnum)
			end},
		}
		lib.registerContext({id = 'fixlife_prision_make_menu2', title = Config.Crafts[itnum].Name, options = options, onExit = OpenMakeMenu})
		lib.showContext('fixlife_prision_make_menu2')
	end)
end

function OpenNeedsMenu(numzioe)
	local options = {}
	for i = 1, #Config.Crafts[numzioe].Needed do
		local item = Config.Crafts[numzioe].Needed[i]
		options[#options + 1] = {title = item.Amount .. 'x ' .. item.Name}
	end
	lib.hideContext()
	lib.registerContext({id = 'fixlife_prision_need_menu', title = Config.Sayings[52], options = options, onExit = function() OpenCraftMenu(numzioe) end})
	lib.showContext('fixlife_prision_need_menu')
end

