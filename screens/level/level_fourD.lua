local Screen = Level:extend()

local tipsTime
local tipsFlag
local tipsTable = lang.tips_fourD
local f1, t1

function Screen:activate()
	-- shape value
	local cZ = 180
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	
	tipsTime = 0
	tipsFlag = false

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
	Screen:addShapeList(Cuboid,		1, 1, cZ,		cLenX, cLenY, cLenZ)

	f1 = FourD(base.guiWidth/2, base.guiHeight/2, base.guiHeight/4,		30,  50)
	table.insert(shapeList, f1)

	-- tips
	t1 = Tips("test", 10, -50, 20)
	table.insert(tipsList, t1)

	-- add drawList
	Screen:addDrawList()
end


function Screen:update(dt)
	-- shift
	Screen.super.update(self, dt)

	-- update fourD len
	local modeMin = 0.1
	local mode1 = 0.33
	if (self.shiftMode >= mode1-modeMin and self.shiftMode <= mode1+modeMin) or
	(self.shiftMode >= (1-mode1)-modeMin and self.shiftMode <= (1-mode1)+modeMin) then
		f1.lenX, f1.lenY = f1.lenY, f1.lenX
	end

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