local postalFile = 'new-postals.json'

fx_version 'cerulean'
game 'gta5'

author 'B.John Studios'
description 'BJS Testing'
version '1.0'

client_scripts {
	'client.lua',
}

server_scripts {
    'server.lua',
}

shared_scripts {
    "config.lua"
}

file(postalFile)
postal_file(postalFile)