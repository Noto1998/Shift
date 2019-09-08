local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local border = 40
	local cubeZ = 130
	local cubeLenX = base.guiWidth-border*2
	local cubeLenY = base.guiHeight-border*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50+2
	
	-- levelName
	local levelName = "教学"
	-- player location
	local playerX = 80
	local playerY = base.guiHeight/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth-playerX-50/2
	local destinationY = base.guiHeight+2
	local destinationZ = cubeZ-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName, dialogTable)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		border, border, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	-- add drawList
	Screen:addDrawList()


	-- tips
	t1 = Tips(180, 80, -50, "按A:切换维度")
	t2 = Tips(180, 500, 20, "←→移动")
end

function Screen:draw()
	Screen.super.draw(self)

	t1:draw(shiftMode)
	t2:draw(shiftMode)
end

return Screen