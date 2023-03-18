Config = {}

Config.weapon = 'weapon_metaldetector'

-- https://docs.fivem.net/docs/game-references/controls/#controls
Config.controller = {
	key = 20, -- Z, DPAD DOWN
	action = function()
		tool = tool == #tools and 1 or tool + 1
		notify(tools[tool].name)
	end
}