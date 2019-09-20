local Screen = Object:extend()

local langFile

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end


function Screen:activate()
	langFile = langFile
end

function Screen:draw()
	love.graphics.clear()
	love.graphics.setColor(base.cWhite)
	base.print("A: 中文\nB: English")
end

function Screen:keypressed(key)
	-- switch lang
	if key == keys.A or key == keys.B then
		local langFile
		if key == keys.A then
			langFile = "lib.lang.lang_cn"
		elseif key == keys.B then
			langFile = "lib.lang.lang_eng"
		end
		lang = require(langFile)

		-- level
		levelString = require "screens.level.levelConf"
		local LevelScreen = {}
		for i, value in ipairs(levelString) do
			local fileName = "screens/level/" .. value .. ".lua"
			local file = love.filesystem.getInfo(fileName)
			if file ~= nil then
				table.insert(LevelScreen, require("screens.level." .. value))
			end
		end
		---
		for i, level in ipairs(LevelScreen) do
			local levelName = levelString[i]
			screenManager:register(levelName, level)
		end
		--
		self.screen:view('MainScreen')
	end

	if key == keys.B then
		lang = require "lib.lang.lang_eng"
	end
end

return Screen