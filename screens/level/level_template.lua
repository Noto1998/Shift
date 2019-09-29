local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	---

	-- levelName
	local levelName = ""
	-- player location
	local playerX = 0
	local playerY = 0
	local playerZ = 0
	-- destination location
	local destinationX = 0
	local destinationY = 0
	local destinationZ = 0
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- use [ self:addShapeList(...) ] to create shape.
	-- e.g. self:addShapeList(Cuboid, 0, 0, 0, 50, 50, 50)

	-- Rectangle,	x, y, z, lenX, lenY, dir(0 ~ -math.pi)
	-- Cuboid,		x, y, z, lenX, lenY, lenZ
	-- Turret,		x, y, z, sx(0 ~ 1), sy(0 ~ 1), sz(0 ~ 1)

	--- here to create tips
	-- self:addTipsList(string, x, y, z [, xMode][, yMode])
end

return Screen