First off, thank you for purchasing my script and supporting my development! I work super hard to make these script work with perfection and offer the most content!

# Make sure to go and check out the rest of my scripts that I offer via
> Website: https://hobo-john.tebex.io/
> Youtube: https://www.youtube.com/channel/UCmQCQqmWzxAeU9CGg4MXhzg
> Discord: https://discord.gg/CcNePP9PZh

# For any support please join my discord and make a support ticket!
I don't respond quickly any other way as discord is the easiest to do and I am on it very actively! So if you need any support 
please join the discord!

# For ESX 1.1 or Es_extended 1.1 users

> You will have to add onto your esx!

1. Go into `server/main.lua` and find this 
```lua
MySQL.Async.fetchAll('SELECT job, job_grade, loadout, position FROM `users` WHERE `identifier` = @identifier', {
					['@identifier'] = player.getIdentifier()
				}, function(result)
```
2. You need to add `group` to the top so it looks like this
```lua
MySQL.Async.fetchAll('SELECT job, job_grade, loadout, `group`, position FROM `users` WHERE `identifier` = @identifier', {
					['@identifier'] = player.getIdentifier()
				}, function(result)
```
3. Scroll down until you find this in the function
```lua
					if result[1].loadout ~= nil then
						userData.loadout = json.decode(result[1].loadout)

						-- Compatibility with old loadouts prior to components update
						for k,v in ipairs(userData.loadout) do
							if v.components == nil then
								v.components = {}
							end
						end
					end
```
4. Add this under it so it looks like this
```lua
					if result[1].loadout ~= nil then
						userData.loadout = json.decode(result[1].loadout)

						-- Compatibility with old loadouts prior to components update
						for k,v in ipairs(userData.loadout) do
							if v.components == nil then
								v.components = {}
							end
						end
					end

					--group
					if result[1].group then
						userData.group = result[1].group
					else
						userData.group = 'user'
					end
```
5. Scroll down a little more until you find this
```lua
local xPlayer = CreateExtendedPlayer(player, userData.accounts, userData.inventory, userData.job, userData.loadout, userData.playerName, userData.lastPosition)
```
6. You need to add this `userData.group` to it so it looks like this
```lua
local xPlayer = CreateExtendedPlayer(player, userData.accounts, userData.inventory, userData.job, userData.loadout, userData.playerName, userData.lastPosition, userData.group)
```
7. Now go into `server/classes/player.lua` and at the top add `group` to it so it looks like this
```lua
function CreateExtendedPlayer(player, accounts, inventory, job, loadout, name, lastPosition, group)
```

8. Find where it says this at the top
```lua
	self.player       = player
	self.accounts     = accounts
	self.inventory    = inventory
	self.job          = job
	self.loadout      = loadout
	self.name         = name
	self.lastPosition = lastPosition
```
9. Make it look like this or add `self.group        = group`
```lua
	self.player       = player
	self.accounts     = accounts
	self.inventory    = inventory
	self.job          = job
	self.loadout      = loadout
	self.name         = name
	self.group        = group
	self.lastPosition = lastPosition
```

> Now thats how you add it so it works with 1.1, if you have any questions feel free to make a ticket in discord!

# Instillation Guide
> 1. Insert / Upload the `JailSQL.sql` file into your esx database
> 2. Go into the Configs Folder and grab whichever jail you are using. IF you arn't using any of those jails then you should just copy `UncleJust_Config.lua` as it is the base Config.
> 3. Rename the folder to just `Config.lua` and drag it into the main folder with the `fxmanifest.lua` and `JailSQL.sql files`.
> 4. Go into `server/server.lua` and insert discord webhook where it says `Insert_Discord_Webhook` (if not using webhook just leave as is)
> 5. Go into `server/server.lua` and add admin roles under `adminRoles` and then configure `adminAbilities` below that aswell
> 6. Put `ensure HD_AdvancedJail` in `server.cfg` and restart server

> How to add for police:

1. Go into `esx_policejob/client/main.lua` and find this function:
```lua 
function OpenPoliceActionsMenu()
```

2. Go to where it has the menu detail `elements` and change it to this:
>Before
```lua
		title    = 'Police',
		align    = 'top-left',
		elements = {
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			{label = _U('object_spawner'), value = 'object_spawner'}
```
>After
```lua
		title    = 'Police',
		align    = 'top-left',
		elements = {
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			{label = _U('object_spawner'), value = 'object_spawner'},
            {label = _U('jailing'), value = 'jailmenu'}
```
3. Scroll Down And Add This `if Statment`:
>Before
```lua
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					{label = _U('box'), model = 'prop_boxpile_07d'},
					{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)

				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
```
>After
```lua
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					{label = _U('box'), model = 'prop_boxpile_07d'},
					{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)

				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'jailmenu' then
			menu.close()
			TriggerEvent('HD_Jail:JailMenu')
		end
```
4. Then add this event somewhere in the file:
```lua 
RegisterNetEvent('HD_Jail:ResetPMenu')
AddEventHandler('HD_Jail:ResetPMenu', function()
	OpenPoliceActionsMenu()
end)
```
5. Then go into `esx_policejob/locales/en` and change this: (If using another language go into the local that is your language)
>Before
```lua
  ['citizen_interaction'] = 'citizen Interaction',
  ['vehicle_interaction'] = 'vehicle Interaction',
  ['object_spawner'] = 'object Spawner',
  ['jailing'] = 'jail menu',
```
>After
```lua
  ['citizen_interaction'] = 'citizen Interaction',
  ['vehicle_interaction'] = 'vehicle Interaction',
  ['object_spawner'] = 'object Spawner',
  ['jailing'] = 'jail menu',
```

6. Restart `esx_policejob` and the menu should have the menu addon!

# Extras
> If you had any trouble installing it please please go into the discord and ask for support within a support ticket!
> If you have any suggestions please feel free to put them in `project ideas` / `project requests`
> Once again thank you for supporting my development!