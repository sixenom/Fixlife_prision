fx_version 'cerulean' 
game 'gta5'
lua54 'yes'
client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'Config.lua',
    'qbox_compat.lua',
    'client/client.lua',
    'client/targetmenus.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Config.lua',
    'qbox_compat.lua',
    'server/server.lua',
    'server/items.lua',
}

dependencies {
    'qbx_core',
    'ox_inventory',
    'oxmysql',
}

shared_scripts {'@ox_lib/init.lua'}
