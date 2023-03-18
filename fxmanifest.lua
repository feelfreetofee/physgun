fx_version 'cerulean'
game 'gta5'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts {
	'config.lua'
}

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'tools/**.lua'
}
