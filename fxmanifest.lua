fx_version 'cerulean'
game 'gta5'
lua54 'yes'
client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'Config.lua',
    'locale/es.lua',
    'client/appearance.lua',
    'client/ui.lua',
    'client/interactions.lua',
    'client/utils.lua',
    'client/breakout_menu.lua',
    'client/inventory_menu.lua',
    'client/police_menu.lua',
    'client/player_events.lua',
    'client/activities.lua',
    'client/jail_state.lua',
    'client/transitions.lua',
    'client/jobs.lua',
    'client/client.lua',
    'client/targetmenus.lua',
    'client/toilet_escape.lua',
    'client/toilet_utils.lua',
    'client/final_fence_escape.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Config.lua',
    'locale/es.lua',
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
    'server/items.lua'
}

dependencies {
    'qbx_core',
    'qbx_medical',
    'ox_inventory',
    'oxmysql',
    'ox_target',
    'illenium-appearance'
}

shared_scripts {'@ox_lib/init.lua'}

files {
    'config/config_c.lua',
    'locales/*.json',
    'web/**/*',
    'stream/*.ycd',
    'client/minigame/camera_manager.lua',
    'client/minigame/animation_controller.lua',
    'client/minigame/screw_game.lua'
}

ui_page 'web/index.html'

data_file 'DLC_ITYP_REQUEST' 'stream/props_lavanderia.ytyp'
