local Screen = Object:extend()

local langFile

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

function Screen:activate()
	love.graphics.clear()
end

function Screen:update(dt)
	-- switch lang
	if base.isDown(base.keys.enter) or base.isDown(base.keys.cancel) then
		local langFile
		if base.isDown(base.keys.enter) then
			langFile = "lib.lang.lang_cn"
		elseif base.isDown(base.keys.cancel) then
			langFile = "lib.lang.lang_en"
		end
		lang = require(langFile)
		
		-- goto MainScreen
		self.screen:view("MainScreen")
	end
end

function Screen:draw()
	love.graphics.setColor(base.cWhite)
	base.print("A: 中文\nB: English")
end

return Screen