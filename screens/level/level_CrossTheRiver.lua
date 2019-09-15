local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeZ = 130
	local cubeLenX = 150
	local cubeLenY = base.guiHeight-1-1
	local cubeLenZ = 50
	local cubeLenZ3 = 50+3

	-- levelName
	local levelName = "过河"
	-- player location
	local playerX = 100
	local playerY = 180
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = 250
	local destinationY = 50
	local destinationZ = 130-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	Screen:addShapeList(Cuboid,		base.guiWidth-cubeLenX-1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	Screen:addShapeList(Cuboid,		250-1, 150, cubeZ-cubeLenZ3,		cubeLenZ3, cubeLenZ3, cubeLenZ3)

	-- add drawList
	Screen:addDrawList()
end

return Screen