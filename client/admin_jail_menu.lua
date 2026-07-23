RegisterNetEvent('HD_Jail:JailMenu')
AddEventHandler('HD_Jail:JailMenu', function()
	lib.callback('HD_Jail:CheckLockdown', false, function(elemento)
		local element = {}
		element = elemento

		local ped = PlayerPedId()
		local police = false
		inJailMenu = true
	
		for i = 1, #Config.PoliceRoles, 1 do
			if QBX.PlayerData.job and QBX.PlayerData.job.name == Config.PoliceRoles[i] then
				police = true
			end
		end
	
	
	
		NativeMenu.CloseAll()
	
		NativeMenu.Open('default', GetCurrentResourceName(), 'jail_main_menu', {
			title    = Config.Sayings[133],
			align    = Config.MenuLoc,
			elements = element
		}, function(data, menu)
			if data.current.value == 'jailplayer' then
				if false then
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						inJailMenu = false
						TriggerEvent('HD_Jail:GetJailInfo', GetPlayerServerId(closestPlayer), nil, nil)
					else
						Notification(Config.Sayings[135])
					end
				else
					inJailMenu = false
					NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt', {
						title = (Config.Sayings[134])
					}, function(data, menu)
						local amount = tonumber(data.value)
			
						if amount == nil or amount < 0 then
							Notification(Config.Sayings[38])
						else
							lib.callback('HD_Jail:CheckID', false, function(can)
								if can then
									TriggerEvent('HD_Jail:GetJailInfo', amount, nil, nil)
								else
									Notification(Config.Sayings[127])
								end
							end, amount)
						end
					end, function(data, menu)
						TriggerEvent('HD_Jail:JailMenu')
					end)
				end
			elseif data.current.value == 'unjail' then
				if false then
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						inJailMenu = false
						TriggerServerEvent('HD_Jail:UnJailPlayer', GetPlayerServerId(closestPlayer), true)
					else
						Notification(Config.Sayings[135])
					end
				else
					inJailMenu = false
					NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt', {
						title = (Config.Sayings[134])
					}, function(data, menu)
						local amount = tonumber(data.value)
			
						if amount == nil or amount < 0 then
							Notification(Config.Sayings[38])
						else
							lib.callback('HD_Jail:CheckID2', false, function(can)
								if can then
									NativeMenu.CloseAll()
									TriggerServerEvent('HD_Jail:UnJailPlayer', amount, true)
								else
									Notification(Config.Sayings[127])
								end
							end, amount)
						end
					end, function(data, menu)
						TriggerEvent('HD_Jail:JailMenu')
					end)
				end
			elseif data.current.value == 'add' then
				if false then
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						inJailMenu = false
						TriggerEvent('HD_Jail:AddJailTime', GetPlayerServerId(closestPlayer), nil, nil)
					else
						Notification(Config.Sayings[135])
					end
				else
					inJailMenu = false
					NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt', {
						title = (Config.Sayings[134])
					}, function(data, menu)
						local amount = tonumber(data.value)
			
						if amount == nil or amount < 0 then
							Notification(Config.Sayings[38])
						else
							lib.callback('HD_Jail:CheckID2', false, function(can)
								if can then
									TriggerEvent('HD_Jail:AddJailTime', amount, nil, nil)
								else
									Notification(Config.Sayings[127])
								end
							end, amount)
						end
					end, function(data, menu)
						TriggerEvent('HD_Jail:JailMenu')
					end)
				end
			elseif data.current.value == 'remove' then
				if false then
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						inJailMenu = false
						TriggerEvent('HD_Jail:RemoveJailTime', GetPlayerServerId(closestPlayer), nil, nil)
					else
						Notification(Config.Sayings[135])
					end
				else
					inJailMenu = false
					NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt', {
						title = (Config.Sayings[134])
					}, function(data, menu)
						local amount = tonumber(data.value)
			
						if amount == nil or amount < 0 then
							Notification(Config.Sayings[38])
						else
							lib.callback('HD_Jail:CheckID2', false, function(can)
								if can then
									TriggerEvent('HD_Jail:RemoveJailTime', amount, nil, nil)
								else
									Notification(Config.Sayings[127])
								end
							end, amount)
						end
					end, function(data, menu)
						TriggerEvent('HD_Jail:JailMenu')
					end)
				end
			elseif data.current.value == 'solitary' then
				if Config.Solitary then
					if false then
						local closestPlayer, closestDistance = GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance <= 3.0 then
							inJailMenu = false
							TriggerEvent('HD_Jail:SolitaryMenu', GetPlayerServerId(closestPlayer), nil, nil)
						else
							Notification(Config.Sayings[135])
						end
					else
						inJailMenu = false
						NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt', {
							title = (Config.Sayings[134])
						}, function(data, menu)
							local amount = tonumber(data.value)
				
							if amount == nil or amount < 0 then
								Notification(Config.Sayings[38])
							else
								lib.callback('HD_Jail:CheckID2', false, function(can)
									if can then
										TriggerEvent('HD_Jail:SolitaryMenu', amount, nil, nil)
									else
										Notification(Config.Sayings[127])
									end
								end, amount)
							end
						end, function(data, menu)
							TriggerEvent('HD_Jail:JailMenu')
						end)
					end
				else
					Notification(Config.Sayings[136])
				end
			elseif data.current.value == 'unsolitary' then
				if false then
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						inJailMenu = false
						TriggerServerEvent('HD_Jail:UnSol', GetPlayerServerId(closestPlayer))
					else
						Notification(Config.Sayings[135])
					end
				else
					inJailMenu = false
					NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt', {
						title = (Config.Sayings[134])
					}, function(data, menu)
						local amount = tonumber(data.value)
			
						if amount == nil or amount < 0 then
							Notification(Config.Sayings[38])
						else
							lib.callback('HD_Jail:CheckID2', false, function(can)
								if can then
									NativeMenu.CloseAll()
									
									TriggerServerEvent('HD_Jail:UnSol', amount)
								else
									Notification(Config.Sayings[127])
								end
							end, amount)
						end
					end, function(data, menu)
						TriggerEvent('HD_Jail:JailMenu')
					end)
				end
			elseif data.current.value == 'lockdown' then
				if not switchie then
					switchie = true
					TriggerServerEvent('HD_Jail:SwitchLock')
					Wait(3000)
					switchie = false
				end
			elseif data.current.value == 'mssg' then
				inJailMenu = false
				OpenReason(nil, nil, nil, 5)
			end
		end, function(data, menu)
			menu.close()
			inJailMenu = false
			for i=1, #Config.PoliceRoles, 1 do
				if QBX.PlayerData.job.name == Config.PoliceRoles[i] then
					TriggerEvent('HD_Jail:ResetPMenu')
				end
			end
		end)
	end)
end)

RegisterNetEvent('HD_Jail:GetJailInfo')
AddEventHandler('HD_Jail:GetJailInfo', function(id, time, reason)
	local ped = PlayerPedId()
	local element = {
		[1] = {label = Config.Sayings[56]..id, value = 'id'}
	}

	if time ~= nil then
		table.insert(element, {label = Config.Sayings[57]..time..'(m)', value = 'time'})
	else
		table.insert(element, {label = Config.Sayings[58], value = 'time'})
	end
	table.insert(element, {label = Config.Sayings[59], value = 'reason'})
	table.insert(element, {label = Config.Sayings[60], value = 'confirm'})

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'jail_menu', {
		title    = Config.Sayings[55],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		if data.current.value == 'id' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt', {
				title = (Config.Sayings[61])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
			    else
					lib.callback('HD_Jail:CheckID', false, function(can)
						if can then
							TriggerEvent('HD_Jail:GetJailInfo', amount, time, reason)
						else
							Notification(Config.Sayings[127])
						end
					end, amount)
				end
			end, function(data, menu)
				TriggerEvent('HD_Jail:GetJailInfo', id, time, reason)
			end)
		elseif data.current.value == 'time' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'time_amt', {
				title = (Config.Sayings[63])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
				elseif amount > Config.MaxJail then
					Notification(Config.Sayings[62])
			    else
					TriggerEvent('HD_Jail:GetJailInfo', id, amount, reason)
				end
			end, function(data, menu)
				TriggerEvent('HD_Jail:GetJailInfo', id, time, reason)
			end)
		elseif data.current.value == 'reason' then
			OpenReason(id, time, reason, 1)
		else
			if reason ~= nil and id ~= nil and time ~= nil then
				menu.close()
				TriggerServerEvent('HD_Jail:sendToJail', id, time *60, reason)
			else
				if reason == nil then
					Notification(Config.Sayings[105])
				elseif id == nil then
					Notification(Config.Sayings[106])
				else
					Notification(Config.Sayings[107])
				end
			end
		end
	end, function(data, menu)
		menu.close()
		TriggerEvent('HD_Jail:JailMenu')
	end)
end)

RegisterNetEvent('HD_Jail:AddJailTime')
AddEventHandler('HD_Jail:AddJailTime', function(id, time, reason)
	local ped = PlayerPedId()
	local element = {
		[1] = {label = Config.Sayings[56]..id, value = 'id'},
	}

	if time ~= nil then
		table.insert(element, {label = Config.Sayings[57]..time..'(m)', value = 'time'})
	else
		table.insert(element, {label = Config.Sayings[58], value = 'time'})
	end
	table.insert(element, {label = Config.Sayings[59], value = 'reason'})
	table.insert(element, {label = Config.Sayings[60], value = 'confirm'})

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'jail_menu5', {
		title    = Config.Sayings[55],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		if data.current.value == 'id' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt2', {
				title = (Config.Sayings[61])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
			    else
					lib.callback('HD_Jail:CheckID2', false, function(yurrrr)
						if yurrrr then
							menu.close()
							TriggerEvent('HD_Jail:AddJailTime', amount, time, reason)
						else
							Notification(Config.Sayings[103])
						end
					end, amount)
				end
			end, function(data, menu)
				menu.close()
				TriggerEvent('HD_Jail:AddJailTime', id, time, reason)
			end)
		elseif data.current.value == 'time' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'time_amt2', {
				title = (Config.Sayings[63])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
				elseif amount > Config.MaxJail then
					Notification(Config.Sayings[62])
			    else
					menu.close()
					TriggerEvent('HD_Jail:AddJailTime', id, amount, reason)
				end
			end, function(data, menu)
				menu.close()
				TriggerEvent('HD_Jail:AddJailTime', id, time, reason)
			end)
		elseif data.current.value == 'reason' then
			OpenReason(id, time, reason, 2)
		else
			if reason ~= nil and id ~= nil and time ~= nil then
				menu.close()
				TriggerServerEvent('HD_Jail:AddSomeTime', id, time *60, reason)
			end
		end
	end, function(data, menu)
		menu.close()
		TriggerEvent('HD_Jail:JailMenu')
	end)
end)

RegisterNetEvent('HD_Jail:RemoveJailTime')
AddEventHandler('HD_Jail:RemoveJailTime', function(id, time, reason)
	local ped = PlayerPedId()
	local element = {
		[1] = {label = Config.Sayings[56]..id, value = 'id'},
	}

	if time ~= nil then
		table.insert(element, {label = Config.Sayings[57]..time..'(m)', value = 'time'})
	else
		table.insert(element, {label = Config.Sayings[58], value = 'time'})
	end
	table.insert(element, {label = Config.Sayings[59], value = 'reason'})
	table.insert(element, {label = Config.Sayings[60], value = 'confirm'})

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'jail_menu6', {
		title    = Config.Sayings[55],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		if data.current.value == 'id' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt2', {
				title = (Config.Sayings[61])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
			    else
					lib.callback('HD_Jail:CheckID2', false, function(yurrrr)
						if yurrrr then
							menu.close()
							TriggerEvent('HD_Jail:RemoveJailTime', amount, time, reason)
						else
							Notification(Config.Sayings[103])
						end
					end, amount)
				end
			end, function(data, menu)
				menu.close()
				TriggerEvent('HD_Jail:RemoveJailTime', id, time, reason)
			end)
		elseif data.current.value == 'time' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'time_amt2', {
				title = (Config.Sayings[63])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
				elseif amount > Config.MaxJail then
					Notification(Config.Sayings[62])
			    else
					menu.close()
					TriggerEvent('HD_Jail:RemoveJailTime', id, amount, reason)
				end
			end, function(data, menu)
				menu.close()
				TriggerEvent('HD_Jail:RemoveJailTime', id, time, reason)
			end)
		elseif data.current.value == 'reason' then
			OpenReason(id, time, reason, 3)
		else
			if reason ~= nil and id ~= nil and time ~= nil then
				menu.close()
				TriggerServerEvent('HD_Jail:RemoveSomeTime', id, time *60, reason)
			end
		end
	end, function(data, menu)
		menu.close()
		TriggerEvent('HD_Jail:JailMenu')
	end)
end)

RegisterNetEvent('HD_Jail:SolitaryMenu')
AddEventHandler('HD_Jail:SolitaryMenu', function(id, time, reason)
	local ped = PlayerPedId()
	local element = {
		[1] = {label = Config.Sayings[56]..id, value = 'id'},
	}

	if time ~= nil then
		table.insert(element, {label = Config.Sayings[57]..time..'(m)', value = 'time'})
	else
		table.insert(element, {label = Config.Sayings[58], value = 'time'})
	end
	table.insert(element, {label = Config.Sayings[59], value = 'reason'})
	table.insert(element, {label = Config.Sayings[60], value = 'confirm'})

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'jail_menu6', {
		title    = Config.Sayings[55],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		if data.current.value == 'id' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'id_amt2', {
				title = (Config.Sayings[61])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
			    else
					lib.callback('HD_Jail:CheckID2', false, function(yurrrr)
						if yurrrr then
							menu.close()
							TriggerEvent('HD_Jail:SolitaryMenu', amount, time, reason)
						else
							Notification(Config.Sayings[103])
						end
					end, amount)
				end
			end, function(data, menu)
				menu.close()
				TriggerEvent('HD_Jail:SolitaryMenu', id, time, reason)
			end)
		elseif data.current.value == 'time' then
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'time_amt2', {
				title = (Config.Sayings[63])
			}, function(data, menu)
				local amount = tonumber(data.value)
	
				if amount == nil or amount < 0 then
					Notification(Config.Sayings[38])
				elseif amount > Config.MaxJail then
					Notification(Config.Sayings[62])
			    else
					menu.close()
					TriggerEvent('HD_Jail:SolitaryMenu', id, amount, reason)
				end
			end, function(data, menu)
				menu.close()
				TriggerEvent('HD_Jail:SolitaryMenu', id, time, reason)
			end)
		elseif data.current.value == 'reason' then
			OpenReason(id, time, reason, 4)
		else
			if reason ~= nil and id ~= nil and time ~= nil then
				menu.close()
				TriggerServerEvent('HD_Jail:SendToSol', id, time, reason)
			end
		end
	end, function(data, menu)
		menu.close()
		TriggerEvent('HD_Jail:JailMenu')
	end)
end)

RegisterNetEvent('HD_Jail:AddItUp')
AddEventHandler('HD_Jail:AddItUp', function(timy)
	if time > 0 then
		time = time + timy

		if not Config.SimpleTime then
			local dope = {Hours = 0, Mins = 0, Seconds = 0}

			local duration = timy
			local extraSeconds = duration%60
			local minutes = (duration-extraSeconds)/60
			if duration >= 60 then
				if minutes >= 60 then
					local extraMinutes = minutes%60
					local hours = (minutes-extraMinutes)/60
					dope.Hours = math.floor(hours)
					dope.Mins = math.ceil(extraMinutes)
					dope.Seconds = extraSeconds
				else
					dope.Hours = 0
					dope.Mins = math.floor(minutes)
					dope.Seconds = extraSeconds
				end
			else
				dope.Hours = 0
				dope.Mins = 0
				dope.Seconds = timy
			end
			Notification(dope.Hours..'H '..dope.Mins..'M '..dope.Seconds..'S '..Config.Sayings[140])
		else
			Notification(timy..Config.Sayings[104])
		end
	end
end)

RegisterNetEvent('HD_Jail:Removeit')
AddEventHandler('HD_Jail:Removeit', function(timy)
	if time > 0 then
		time = time - timy

		if not Config.SimpleTime then
			local dope = {Hours = 0, Mins = 0, Seconds = 0}

			local duration = timy
			local extraSeconds = duration%60
			local minutes = (duration-extraSeconds)/60
			if duration >= 60 then
				if minutes >= 60 then
					local extraMinutes = minutes%60
					local hours = (minutes-extraMinutes)/60
					dope.Hours = math.floor(hours)
					dope.Mins = math.ceil(extraMinutes)
					dope.Seconds = extraSeconds
				else
					dope.Hours = 0
					dope.Mins = math.floor(minutes)
					dope.Seconds = extraSeconds
				end
			else
				dope.Hours = 0
				dope.Mins = 0
				dope.Seconds = timy
			end
			Notification(dope.Hours..'H '..dope.Mins..'M '..dope.Seconds..'S '..Config.Sayings[142])
		else
			Notification(timy..Config.Sayings[143])
		end
	end
end)

function OpenReason(id, time, reason, menuz)
	local element = {
		[1] = {label = Config.Sayings[65], value = 'edit'},
		[2] = {label = Config.Sayings[67], value = 'see'},
		[3] = {label = Config.Sayings[66], value = 'confirm'}
	}

	NativeMenu.CloseAll()

	NativeMenu.Open('default', GetCurrentResourceName(), 'reason_menu', {
		title    = Config.Sayings[68],
		align    = Config.MenuLoc,
		elements = element
	}, function(data, menu)
		if data.current.value == 'confirm' then
			if reason ~= nil then
				if menuz == 1 then
					TriggerEvent('HD_Jail:GetJailInfo', id, time, reason)
				elseif menuz == 2 then
					TriggerEvent('HD_Jail:AddJailTime', id, time, reason)
				elseif menuz == 3 then
					TriggerEvent('HD_Jail:RemoveJailTime', id, time, reason)
				elseif menuz == 4 then
					TriggerEvent('HD_Jail:SolitaryMenu', id, time, reason)
				elseif menuz == 5 then
					menu.close()
					TriggerServerEvent('HD_Jail:Send2Prisoners', reason)
				end
			else
				Notification(Config.Sayings[167])
			end
		elseif data.current.value == 'see' then
			if reason ~= nil then
				Notification(reason)
			else
				Notification(Config.Sayings[69])
			end
		else
			NativeMenu.Open('dialog', GetCurrentResourceName(), 'text_re', {
				title = (Config.Sayings[68])
			}, function(data, menu)
				local val = data.value
				if val == nil then
					Notification(Config.Sayings[38])
			    else
					menu.close()
					OpenReason(id, time, val, menuz)
				end
			end, function(data, menu)
				menu.close()
				OpenReason(id, time, reason, menuz)
			end)
		end
	end, function(data, menu)
		menu.close()
		if menuz == 1 then
			TriggerEvent('HD_Jail:GetJailInfo', id, time, reason)
		elseif menuz == 2 then
			TriggerEvent('HD_Jail:AddJailTime', id, time, reason)
		elseif menuz == 3 then
			TriggerEvent('HD_Jail:RemoveSomeTime', id, time, reason)
		elseif menuz == 4 then
			TriggerEvent('HD_Jail:SolitaryMenu', id, time, reason)
		elseif menuz == 5 then
			TriggerEvent('HD_Jail:JailMenu')
		end
	end)
end

local checkDeath = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if time > 0 then
			if IsPedDeadOrDying(ped, 1) and not checkDeath then
				Citizen.Wait(5)
				checkDeath = true
				TriggerEvent('HD_Jail:onPlayerDeath')
			elseif checkDeath and not IsPedDeadOrDying(ped, 1) then
				Citizen.Wait(5)
				checkDeath = false
				TriggerEvent('HD_Jail:onPlayerSpawn')
			else
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

