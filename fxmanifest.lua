local postalFile = 'new-postals.json'

fx_version 'cerulean'
game 'gta5'

author 'B.John Studios'
description 'BJS 911 Advanced'
version '2.0'

client_scripts {
	'client.lua',
}

server_scripts {
    'server.lua',
}

shared_scripts {
    "config.lua"
}

ui_page 'html/index.html'

files {
	'html/*.*'
}

file(postalFile)
postal_file(postalFile)