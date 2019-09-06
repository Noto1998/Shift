local Screen = Object:extend()

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

function Screen:activate()
end

function Screen:draw()
	-- credits
	base.print("mofish", base.guiWidth/2, base.guiHeight/3, "center", "center")

	--pressed start
	base.print("按 A 开始", base.guiWidth/2, base.guiHeight/3 *2, "center", "center")
end

function Screen:keypressed(key)
	if key == keys.A then
		self.screen:view(levelString[1])
	end
end

return Screen