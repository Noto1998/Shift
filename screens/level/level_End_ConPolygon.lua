local Screen = Level:extend()

local tipsTime, tipsFlag, tipsTable, t1

function Screen:activate()
	--- shape value
	local border = 40
	local cubeZ = base.guiHeight/3*2
	local cubeLenX = base.guiWidth-border*2
	local cubeLenY = base.guiHeight-border*2
	local cubeLenZ = 50
	---
	tipsTime = 0
	tipsFlag = false
	tipsTable = lang.tips_conPolygon

	-- levelName
	local levelName = ""
	-- player location
	local playerX = 80-base.player.len/2
	local playerY = base.guiHeight/2-base.player.len/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth+1
	local destinationY = base.guiHeight+1
	local destinationZ = base.guiHeight+1
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		border, border, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	--self:addShapeList(
	cp1 = ConPolygon(base.guiWidth/4*3, base.guiHeight/2, base.guiHeight/4,		15, 30,  30)
	--)
	table.insert(self.shapeList, cp1)
	table.insert(self.drawList, cp1)

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
			cp1.len = cp1.len+1
			cp1.border = cp1.border-1
		else
			self.screen:view("MainScreen")
		end
	end
end


return Screen