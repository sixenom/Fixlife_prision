fx_version 'cerulean' 
game 'gta5'
lua54 'yes'
client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'Config.lua',
    'client/appearance.lua',
    'client/ui.lua',
    'client/utils.lua',
    'client/breakout_menu.lua',
    'client/inventory_menu.lua',
    'client/police_menu.lua',
    'client/admin_jail_menu.lua',
    'client/player_events.lua',
    'client/activities.lua',
    'client/jail_state.lua',
    'client/transitions.lua',
    'client/jobs.lua',
    'client/client.lua',
    'client/targetmenus.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Config.lua',
    'server/core.lua',
    'server/helpers.lua',
    'server/inventory.lua',
    'server/jail_queries.lua',
    'server/jail_actions.lua',
    'server/jail_management.lua',
    'server/prisoner_state.lua',
    'server/lifecycle.lua',
    'server/player_actions.lua',
    'server/solitary.lua',
    'server/lockdown.lua',
    'server/server.lua',
    'server/items.lua',
}

dependencies {
    'qbx_core',
    'ox_inventory',
    'oxmysql',
    'illenium-appearance',
}

shared_scripts {'@ox_lib/init.lua'}
