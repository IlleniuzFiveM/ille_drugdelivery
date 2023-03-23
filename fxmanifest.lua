fx_version 'cerulean'
game 'gta5'
author 'Illeniuz'
description 'Drug Delivery Script'
version '1.0.0'

shared_script '@es_extended/locale.lua'

client_scripts {
  'config.lua',
  'client.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server.lua'
}

dependency 'es_extended'
