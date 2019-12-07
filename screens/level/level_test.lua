local Screen = Level:extend()

function Screen:activate()
	--- shape value
	
	
	-- levelName
	local levelName = lang.level_Moving
	-- player location
	local playerX = 20
	local playerY = 180
	local playerZ = 209
	-- destination location
	local destinationX = 250
	local destinationY = 20
	local destinationZ = 160
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--here to create the shape
	--Floor
	self:addShapeList(Cuboid, 2,2,210,	318,238,30)
	--moving wall on the top
	self:addShapeList(MoveCuboid, 210,18,25, 80,150,20, 20 )
	-- Laser
	self:addShapeList(Laser,  5, 5, 20,	 0.5, -1, 1)
	-- first middle wall
	self:addShapeList(Cuboid, 110,5,5,   20,230,202)
	-- second middle wall
	self:addShapeList(Cuboid, 210,5,5,   20,230,202)


	
	-- here to create tips
	-- self:addTipsList(lang.tips_mayoiba_yabureru, 20, -80, 10)
end

return Screen