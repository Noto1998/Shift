local Screen = Level:extend()


function Screen:activate()
	-- levelName = Cross the river
	-- player location
	local playerX = 100
	local playerY = 150
	local playerZ = 130-1
	-- destination location
	local destinationX = 250
	local destinationY = 50
	local destinationZ = 130-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ)
	
	-- here to create shape
	-- c = Circle(x, y, z, radius)
	-- c = Cuboid(x, y, z, lenX, lenY, lenZ)
	-- c = Cylinderx, y, z, radius, height, cFill, cLine)
	-- r = Rectangle(x, y, z, lenX, lenY, cFill, cLine)
	re1 = Cuboid(1,1,130, 150,base.guiHeight-1-1,50)
	re2 = Cuboid(base.guiWidth-150-1,1,130, 150,base.guiHeight-1-1,50)
	re3 = Cuboid(250, 150, 130-50, 50, 50, 50)
	re4 = Circle(20,20,20,10)
	re5 = Cylinder(150,150,120,10,20)

	--remember to put obj's name in here
	Screen:addDrawList(re1, re2, re3, re4, re5)
end

return Screen