local Screen = Object:extend()

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

function Screen:activate()
end

function Screen:draw()
	-- credits
	base.print("恭喜你通关了！", base.guiWidth/2, base.guiHeight/3, "center", "center")

	--pressed start
	base.print("按 A 重新开始", base.guiWidth/2, base.guiHeight/3 *2, "center", "center")
end

function Screen:keypressed(key)
	if key == keys.A then
		love.load()
		--love.event.quit( "restart" )
	end
end

return Screen