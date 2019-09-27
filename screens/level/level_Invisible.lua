local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeZ = 130
	local cubeLenX = 150
	local cubeLenY = base.guiHeight-1*2
	local cubeLenZ = 50
	local cLenZ2 = 50 + 2*2

	-- levelName
	local levelName = lang.level_Invisible
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
	self:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	self:addShapeList(Cuboid,		base.guiWidth-cubeLenX-1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	self:addShapeList(Cuboid,		base.guiWidth-cubeLenX-1, 1, 0,			cubeLenX, cubeLenY, cubeLenZ-40)
	
	self:addShapeList(Cuboid,		destinationX-2, destinationY+100, cubeZ-cLenZ2,		cLenZ2, cLenZ2, cLenZ2)

	-- here to create tips
	self:addTipsList(lang.tips_where_is_it, base.guiBorder, base.guiBorder, -80)	
end

return Screen