local Screen = Level:extend()

local tipsNum, tipsFlag, tipsTable
local t1, t2, c1
local timeToEnd, timeToEndTimer

function Screen:activate(tipstable, levelName)
	--- shape value
	local cZ = 170
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	---
	tipsNum = 1
	tipsFlag = false
	tipsTable = tipstable
	timeToEnd = false
	timeToEndTimer = 0
	self.timeToEnd = false

	-- player location
	local playerX = base.guiWidth/4-base.player.len/2
	local playerY = base.guiHeight/2-base.player.len/2
	local playerZ = cZ - 1
	-- destination location
	local destinationX = base.guiWidth+1
	local destinationY = base.guiHeight+1
	local destinationZ = base.guiHeight+1
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	c1 = Cuboid(1, 1, cZ,		cLenX, cLenY, cLenZ)
	table.insert(self.shapeList, c1)
	table.insert(self.drawList, c1)

	--- here to create tips
	t1 = Tips(tipsTable[tipsNum], base.guiBorder, -50, base.guiBorder*2)
	t2 = Tips(tipsTable[tipsNum], base.guiBorder, base.guiBorder*2, -50)
	table.insert(self.tipsList, t1)
	table.insert(self.tipsList, t2)
end


function Screen:update(dt)
	local canShift = (timeToEndTimer==0)
	Screen.super.update(self, dt, canShift)
	-- update tips
	if base.isPressed(base.keys.shift) and (self.shiftMode == 0 or self.shiftMode == 1) then
		tipsNum = tipsNum + 1
		-- update string
		if tipsNum <= #tipsTable then
			if self.shiftMode == 0 then
				t1.string = tipsTable[tipsNum]
			elseif self.shiftMode == 1 then
				t2.string = tipsTable[tipsNum]
			end
		else
			t1.z = -50
			t2.z = -50
			c1.z = base.guiHeight+50
			timeToEnd = true
			--self.screen:view("MainScreen")
		end
	end

	if timeToEnd then
		timeToEndTimer = timeToEndTimer + 1*dt
	end
	if timeToEndTimer > 4 then
		self.timeToEnd = true
	end
end

function Screen:draw()
	Screen.super.draw(self)

	if waitTimer > 2 then
		love.graphics.setColor(base.cBlack)
		love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)
		love.graphics.setColor(base.cWhite)
		base.print("由衷地感谢您的游玩！！", base.guiWidth/2, base.guiHeight/3, "center", "center")
		base.print("Yaolaotou & Notoj", base.guiWidth/2, base.guiHeight/3*2, "center", "center")
	end
end


return Screen