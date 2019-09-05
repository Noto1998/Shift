local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeX = base.guiWidth/2
	local cubeY = 80
	local cubeZ = 180
	local cubeLenX = base.guiWidth/2-2
	local cubeLenY = cubeLenX
	local cubeLenZ = 40
	local border = 50

	local cubeZ2 = 50

	-- levelName
	local levelName = "等高线"
	-- player location
	local playerX = 80
	local playerY = 35
	local playerZ = cubeZ
	-- destination location
	local destinationX = cubeX+(cubeLenX-50)/2
	local destinationY = 35-50/2
	local destinationZ = cubeZ-cubeLenZ*2 - 50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	Screen:addShapeList(Cuboid,		1, 1, cubeZ,		base.guiWidth/2, base.guiHeight-base.guiWidth/2, cubeLenZ)
	-- mountain
	Screen:addShapeList(Cuboid,		cubeX, cubeY, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	Screen:addShapeList(Cuboid,		cubeX+border/2, cubeY+border/2, cubeZ-cubeLenZ,		cubeLenX-border, cubeLenY-border, cubeLenZ)
	Screen:addShapeList(Cuboid,		cubeX+border/2*2, cubeY+border/2*2, cubeZ-cubeLenZ*2,		cubeLenX-border*2, cubeLenY-border*2, cubeLenZ)
	-- fake mountain
	Screen:addShapeList(Cuboid,		1, cubeY, cubeZ2,		cubeLenX, cubeLenY, cubeLenZ)
	Screen:addShapeList(Cuboid,		1+border/2, cubeY+border/2, cubeZ2-cubeLenZ*2,		cubeLenX-border, cubeLenY-border, cubeLenZ)
	Screen:addShapeList(Cuboid,		1+border/2*2, cubeY+border/2*2, cubeZ2-cubeLenZ*4,		cubeLenX-border*2, cubeLenY-border*2, cubeLenZ)

	-- add drawList
	Screen:addDrawList()
end

return Screen