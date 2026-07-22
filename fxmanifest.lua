fx_version 'cerulean' 
game 'gta5'
lua54 'yes'
client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'Config.lua',
    'client/ui.lua',
    'client/utils.lua',
    'client/breakout_menu.lua',
    'client/inventory_menu.lua',
    'client/police_menu.lua',
    'client/admin_jail_menu.lua',
    'client/player_events.lua',
    'client/client.lua',
    'client/targetmenus.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Config.lua',
    'server/core.lua',
    'server/inventory.lua',
    'server/server.lua',
    'server/items.lua',
}

dependencies {
    'qbx_core',
    'ox_inventory',
    'oxmysql',
}

shared_scripts {'@ox_lib/init.lua'}
