local Screen = Level:extend()

function Screen:activate()
	-- levelName
	local levelName = "激光"
	-- player location
	local playerX = 27
	local playerY = 116-30
	local playerZ = 108
	-- destination location
	local destinationX = 10
	local destinationY = 900
	local destinationZ = 200
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    
	-- Screen:addShapeList(Cuboid,	70, 60,130-20,50,50,50)
    Screen:addShapeList(Cuboid,	2, 2,220,328,238,18)
    Screen:addShapeList(Cuboid, 2,0,110,100,240-100,20)
    Screen:addShapeList(Cuboid, 115,-220,0,10,120,95)
    Screen:addShapeList(Cuboid, 115,2,155,190,50,35)
	Screen:addShapeList(Turret, 130,3,155,0,1,1)
	Screen:addShapeList(Turret, 170,3,155,0,1,1)
	Screen:addShapeList(Turret, 210,3,155,0,1,1)
	Screen:addShapeList(Turret, 250,3,155,0,1,1)
	Screen:addShapeList(Turret, 290,3,155,0,1,1)
	Screen:addShapeList(Cuboid, 125,-390,85,65,80,10)
	Screen:addShapeList(Cuboid, 185,-220,12+10,10,120,83-10)
	Screen:addShapeList(Cuboid, 234,-220,12+20,10,120,93-30)
	Screen:addShapeList(Cuboid, 235,-390,85,65,80,10)
	Screen:addShapeList(Cuboid, 299,-220,12+30,10,120,93-40)
    Screen:addShapeList(Cuboid,	103,0,-40,238,52,18)
	
	-- Screen:addShapeList(Cuboid, 165,500,125,75,60,15)


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