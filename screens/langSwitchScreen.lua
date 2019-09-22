local Screen = Object:extend()

local langFile

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end


function Screen:activate()
	langFile = langFile
end

function Screen:update(dt)
	-- switch lang
	if base.isDown(base.keys.enter) or base.isDown(base.keys.cancel) then
		local langFile
		if base.isDown(base.keys.enter) then
			langFile = "lib.lang.lang_cn"
		elseif base.isDown(base.keys.cancel) then
			langFile = "lib.lang.lang_eng"
		end
		lang = require(langFile)

		-- load level data
		levelString = require "screens.level.levelConf"
		local LevelScreen = {}
		for i, value in ipairs(levelString) do
			local fileName = "screens/level/" .. value .. ".lua"
			local file = love.filesystem.getInfo(fileName)
			if file ~= nil then
				table.insert(LevelScreen, require("screens.level." .. value))
			end
		end
		-- register level
		for i, level in ipairs(LevelScreen) do
			local levelName = levelString[i]
			screenManager:register(levelName, level)
		end
		-- goto MainScreen
		self.screen:view('MainScreen')
	end
end

function Screen:draw()
	love.graphics.clear()
	love.graphics.setColor(base.cWhite)
	base.print("A: 中文\nB: English")
end

return Screen