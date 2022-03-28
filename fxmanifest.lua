fx_version 'cerulean'
game 'gta5'

description 'QB-Shops'
version '1.0.0'


shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@qb-core/shared/locale.lua',
    'locale/en.lua', -- replace with desired language
    'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

lua54 'yes'