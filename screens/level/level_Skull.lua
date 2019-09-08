local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeZ = 180
	local cubeLenX = 150
	local cubeLenY = base.guiHeight-1-1
	local cubeLenZ = 50
	local cubeLenZ3 = 100

	-- levelName
	local levelName = "骷髅"
	-- player location
	local playerX = 50
	local playerY = 70
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth/2 - 50/2
	local destinationY = 20+50*2
	local destinationZ = cubeZ-150-50 -100
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	--floor
	Screen:addShapeList(Cuboid,		1, 20, cubeZ,		base.guiWidth-2, 50*2, cubeLenZ)
	
	--nose
	Screen:addShapeList(Cuboid,		base.guiWidth/2 -50, 1, cubeZ-150,		50*2, cubeLenY-50, cubeLenZ)
	
	--eye
	Screen:addShapeList(Cuboid,		base.guiWidth-50-(playerX-50/2), playerY-50/2, cubeZ-cubeLenZ3,		50, 50, cubeLenZ3)

	--tooth
	Screen:addShapeList(Cuboid,		base.guiWidth/2-40/2-40-10, cubeLenY-50+10, -100,		40, 40, 50)
	Screen:addShapeList(Cuboid,		base.guiWidth/2-40/2,		cubeLenY-50+10, -200,		40, 40, 50)
	Screen:addShapeList(Cuboid,		base.guiWidth/2-40/2+40+10, cubeLenY-50+10, -300,		40, 40, 50)

	-- add drawList
	Screen:addDrawList()
end

return Screen