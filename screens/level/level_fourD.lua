local Screen = Level:extend()

local tipsTime, tipsFlag, tipsTable, t1

function Screen:activate()
	--- shape value
	local cZ = 180
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	---
	tipsTime = 0
	tipsFlag = false
	tipsTable = lang.tips_fourD

	-- levelName
	local levelName = "2²"
	-- player location
	local playerX = 100
	local playerY = 180
	local playerZ = cZ - 1
	-- destination location
	local destinationX = base.guiWidth+1
	local destinationY = base.guiHeight+1
	local destinationZ = base.guiHeight+1
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		1, 1, cZ,		cLenX, cLenY, cLenZ)

	self:addShapeList(FourD,		base.guiWidth/2, base.guiHeight/2, base.guiHeight/4,		30,  50)

	--- here to create tips
	t1 = Tips("test", 10, -50, 20)
	table.insert(self.tipsList, t1)
end


function Screen:update(dt)
	Screen.super.update(self, dt)

	-- update tips
	if base.isPressed(base.keys.shift) and (self.shiftMode == 0) then
		tipsTime = tipsTime + 1
		if tipsTime <= #tipsTable then
			t1.string = tipsTable[tipsTime]
		else
			self.screen:view("MainScreen")
		end
	end
end


return Screen