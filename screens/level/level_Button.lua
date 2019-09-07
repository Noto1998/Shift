local Screen = Level:extend()

function Screen:activate()
	-- levelName
	local levelName = "按钮"
	-- player location
	local playerX = 33
	local playerY = 116
	local playerZ = 186
	-- destination location
	local destinationX = 250
	local destinationY = 900
	local destinationZ = 200
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    
	-- Screen:addShapeList(Cuboid,	70, 60,130-20,50,50,50)
	Screen:addShapeList(Cuboid,	2, 2,190,130,238,18)
	Screen:addShapeList(Cuboid,	155, 2,190,158,238,18)
	Screen:addShapeList(Cuboid,	193, 42,2,20,128,165)
	Screen:addShapeList(Circle, 168,15,188,10)
	-- Screen:addShapeList(Cuboid,	273, 2,2,20,238,185)



	--- here to create shape
	-- use [ Screen:addShapeList(shape,...) ] to create shape:
	-- Rectangle,	x, y, z, lenX, lenY
	-- Circle,		x, y, z, radius
	-- Cuboid,		x, y, z, lenX, lenY, lenZ
	-- Cylinder,	x, y, z, radius, height

	-- e.g. Screen:addShapeList(Circle, 0, 0, 0, 50)
	
	-- add drawList
	Screen:addDrawList()
end

return Screen