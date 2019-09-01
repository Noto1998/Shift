local Screen = Level:extend()

function Screen:activate()
	-- player location
	local playerX = 0
	local playerY = 0
	local playerZ = 0
	-- destination location
	local destinationX = 0
	local destinationY = 0
	local destinationZ = 0
	local destinationString = ""-- not work now
	
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, destinationString)
	
	-- here to create shape
	-- c = Circle(x, y, z, radius)
	-- c = Cuboid(x, y, z, lenX, lenY, lenZ)
	-- c = Cylinderx, y, z, radius, height, cFill, cLine)
	-- r = Rectangle(x, y, z, lenX, lenY, cFill, cLine)

	--remember to put obj's name in here
	Screen:addDrawList(--[[pull in here]])
end

return Screen