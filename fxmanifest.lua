fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'lootify'
author 'You + ChatGPT'
description 'Tarkov-like inventory skeleton for FiveM (ESX & Qbox/QBCore compatible)'
version '0.1.0'

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/app.js'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/**/*.lua',
    'data/**/*.lua',
    'locales/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua'
}

client_scripts {
    'client/**/*.lua'
}

dependencies {
    'oxmysql',
    'ox_lib'
}
