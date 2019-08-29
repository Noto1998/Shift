local Screen = Object:extend()

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

function Screen:activate()
	shiftMode = "xy" -- switch shiftMode
	shiftNum = 0
	shifting = false
	
	re1 = Cuboid(1,1,130, 100,base.guiHeight-2,50)
	re2 = Cuboid(10,10,130-50, 50,70,50)
	cy1 = Cylinder(100, 50, 50, 50, 50)
	player = Player(100, 150, 50)

	_timerMax = 2
	_timer = 0
	
end

--test
function Screen:update(dt)
	-- update shiftNum
	local _dt = 1 / _timerMax * dt
	if shiftNum < 1 and shiftMode == "xz" then
		local _border =  1 - shiftNum
		if _border < _dt then
			shiftNum = shiftNum + _border
		else
			shiftNum = shiftNum + _dt
		end
	end
	if shiftNum > 0 and shiftMode == "xy" then
		if shiftNum < _dt then
			shiftNum = 0
		else
			shiftNum = shiftNum - _dt
		end
	end
	-- update shifting
	shifting = shiftNum ~= 0 and shiftNum ~= 1

	
	--
	if not shifting then
		player:update(dt)
	end
end

function Screen:draw()
	re1:draw(shiftNum)
	re2:draw(shiftNum)
	cy1:draw(shiftNum)
	player:draw(shiftNum)
	
end

function Screen:keypressed(key)
	-- switch shiftMode
	if key == keys.A and not shifting then
		if shiftMode == "xy" then
			shiftMode = "xz"
		elseif shiftMode == "xz" then
			shiftMode = "xy"
		end
	end
end

return Screen