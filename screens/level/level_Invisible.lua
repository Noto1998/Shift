local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeZ = 130
	local cubeLenX = 150
	local cubeLenY = base.guiHeight-1-1
	local cubeLenZ = 50

	-- levelName
	local levelName = "隐形"
	-- player location
	local playerX = 100
	local playerY = 180
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = 250
	local destinationY = 50
	local destinationZ = cubeZ-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	Screen:addShapeList(Cuboid,		base.guiWidth-cubeLenX-1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	Screen:addShapeList(Cuboid,		base.guiWidth-cubeLenX-1, 1, 0,		cubeLenX, cubeLenY, cubeLenZ-40)

	Screen:addShapeList(Cuboid,		250, 50+100, cubeZ-50,		50, 50, 50)

	-- tips
	Screen:addTipsList(10,-80,20,"来找我们。")

	-- add drawList
	Screen:addDrawList()
end

return Screen