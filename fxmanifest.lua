--[[ FX Information ]]--
fx_version   'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'pm_essentials'
author       'Majorrrr & fsg'
description  'A bunch of integral scripts.'

--[[ Manifest ]]--
dependencies {
	'/server:5888',
	'/onesync',
	'ox_lib',
}

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'modules/**/config.lua',
	'modules/**/server.lua',
	'modules/**/sv*.lua',
}

client_scripts {
	'modules/**/config.lua',
	'modules/**/cl*.lua',
}

files {
	'meta/ai/events.meta',
	'meta/ai/relationships.dat'
}

escrow_ignore {
	'config.lua',
	'modules/**/config.lua',
	'modules/density/*.lua'
  }
-- Relaxed Players --
data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'meta/ai/events.meta'