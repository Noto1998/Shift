local Screen = Object:extend()

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

local page

function Screen:activate()
	page = 1
end

function Screen:draw()
	love.graphics.setColor(1,1,1)

	-- credits
	base.print("mofish", base.guiWidth/2, base.guiHeight/3, "center", "center")

	--pressed start
	base.print("左右选关，A开始", base.guiWidth/2, base.guiHeight/3 *2, "center", "center")
	-- level choice
	base.print("\n关卡选择  <   " .. page .. "   >", base.guiWidth/2, base.guiHeight/3 *2, "center", "center")
end

function Screen:keypressed(key)
	-- start level
	if key == keys.A then
		levelChoice = page
		self.screen:view(levelString[levelChoice])
	end

	-- choice level
	local levelMax = #levelString-1--the last one is finishScreen
	if key == keys.DPad_right then
		if page < levelMax then
			page = page + 1
		else
			page = 1
		end
	elseif key == keys.DPad_left then
		if page > 1 then
			page = page - 1
		else
			page = levelMax
		end
	end
end

return Screen