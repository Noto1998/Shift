local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeZ = 50
	local cubeLenX = 150
	local cubeLenY = base.guiHeight-1-1
	local cubeLenZ = 40

	-- levelName
	local levelName = "攀岩"
	-- player location
	local playerX = 100
	local playerY = 180
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = cubeLenX - 50
	local destinationY = 50
	local destinationZ = cubeZ+cubeLenZ*2
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	Screen:addShapeList(Cuboid,		1 + cubeLenX + 45, 1, cubeZ+cubeLenZ,		cubeLenX, cubeLenY, cubeLenZ)
	-- add drawList
	Screen:addDrawList()
end

return Screen