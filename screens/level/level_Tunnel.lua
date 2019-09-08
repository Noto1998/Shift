local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeZ = 130
	local cubeLenX = base.guiWidth-1-1
	local cubeLenY = base.guiHeight-1-1
	local cubeLenZ = 50

	local cubeY2 = base.guiHeight/2
	local cubeZ2 = -80
	local cubeLenX2 = cubeLenX/2-30/2
	local cubeLenY2 = 50

	local cubeLenZ3 = 60

	-- levelName
	local levelName = "隧道"
	-- player location
	local playerX = 100
	local playerY =50
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth/2-50/2
	local destinationY = 180
	local destinationZ = cubeZ2
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	-- gate
	Screen:addShapeList(Cuboid,		1, cubeY2, cubeZ2,		cubeLenX2, cubeLenY2, cubeLenZ)
	Screen:addShapeList(Cuboid,		base.guiWidth-cubeLenX2-1, cubeY2, cubeZ2,		cubeLenX2, cubeLenY2, cubeLenZ)
	-- wall
	Screen:addShapeList(Cuboid,		250-1, cubeY2, cubeZ-cubeLenZ3,		50, 50, cubeLenZ3)

	-- add drawList
	Screen:addDrawList()

	-- tips
	Screen:addTipsList(10, -200, 20, "/这有点难/")
end

return Screen