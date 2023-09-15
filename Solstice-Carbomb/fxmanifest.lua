--[[  
   _____       __     __  _                 ____            __                                 __ 
  / ___/____  / /____/ /_(_)_______        / __ \___ _   __/ /___  ____  ____ ___  ___  ____  / /_
  \__ \/ __ \/ / ___/ __/ / ___/ _ \______/ / / / _ \ | / / / __ \/ __ \/ __ `__ \/ _ \/ __ \/ __/
 ___/ / /_/ / (__  ) /_/ / /__/  __/_____/ /_/ /  __/ |/ / / /_/ / /_/ / / / / / /  __/ / / / /_  
/____/\____/_/____/\__/_/\___/\___/     /_____/\___/|___/_/\____/ .___/_/ /_/ /_/\___/_/ /_/\__/  
                                                               /_/                               
]]
fx_version 'cerulean'

games {'gta5'}

lua54 'yes'

description 'Solstice-Carbomb By Solstice Development Team'

version '1.0.0'

shared_scripts {
	'config/config.lua'
}

server_scripts {
	'server/server.lua',
}

client_scripts {
	'client/client.lua',
}

escrow_ignore {
	'config/config.lua',
	'client/client.lua',
	'server/server.lua'
}