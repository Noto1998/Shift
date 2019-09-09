local Screen = Level:extend()

function Screen:activate()
	-- levelName
	local levelName = "按钮"
	-- player location
	local playerX = 27
	local playerY = 116
	local playerZ = 118
	-- destination location
	local destinationX = 250
	local destinationY = 900
	local destinationZ = 200
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    
	-- Screen:addShapeList(Cuboid,	70, 60,130-20,50,50,50)
    Screen:addShapeList(Cuboid,	2, 2,220,328,238,18)
    Screen:addShapeList(Cuboid, 2,0,120,100,240,20)
    Screen:addShapeList(Cuboid, 115,-220,2,10,120,120)
    Screen:addShapeList(Cuboid, 115,2,155,190,50,35)
	Screen:addShapeList(Turret, 115,2,155,0,1,1)
	Screen:addShapeList(Turret, 145,2,155,0,1,1)
	Screen:addShapeList(Turret, 175,2,155,0,1,1)
	Screen:addShapeList(Turret, 205,2,155,0,1,1)
	Screen:addShapeList(Turret, 235,2,155,0,1,1)
	Screen:addShapeList(Cuboid, 145,-50,85,30,30,30)
	Screen:addShapeList(Cuboid, 165,500,125,75,60,15)


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