local Screen = Level:extend()

function Screen:activate()
	local re1_z = 130
	local re1_xLen = 150
	local re1_yLen = base.guiHeight-1-1
	local re1_zLen = 50

	-- levelName
	local levelName = "Cross the river"
	-- player location
	local playerX = 100
	local playerY = 150
	local playerZ = re1_z - 1
	-- destination location
	local destinationX = 250
	local destinationY = 50
	local destinationZ = 130-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	-- here to create shape
	re1 = Cuboid(	1, 1, re1_z,
					re1_xLen, re1_yLen, re1_zLen)
	
	re2 = Cuboid(	base.guiWidth-re1_xLen-1, 1, re1_z,
					re1_xLen,re1_yLen, re1_zLen)
	
	re3 = Cuboid(	250, 150, re1_z-50,
					50, 50, 50)

	--remember to put obj's name in here
	Screen:addDrawList(re1, re2, re3, re4, re5)
end

return Screen