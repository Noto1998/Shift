local Screen = Level:extend()

function Screen:activate()
	-- levelName
	local levelName = "Block"
	
	-- shape value
	local cLenX = 40*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	local cX = base.guiWidth/2 -cLenX/2
	local cY = 0
	local cZ = base.guiHeight-cLenZ
	--ball
	local cR = 20

	-- player location
	local playerX = base.guiWidth/2
	local playerY = 50
	local playerZ = 150
	-- destination location
	local destinationX = base.guiWidth/2-50/2
	local destinationY = base.guiHeight-50/2
	local destinationZ = -50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	Screen:addShapeList(Cuboid,		cX, cY, cZ,		cLenX, cLenY, cLenZ)
	
	Screen:addShapeList(Rectangle,	0, base.guiHeight+10, 150,		base.guiWidth+40, base.guiHeight/2, 		 math.pi/2 -math.pi/10)
	
	Screen:addShapeList(Ball,		cR, 50+50, 0,		cR)

	Screen:addShapeList(Turret,		base.guiWidth/2, 1, 1,		0, 1, 1)

	-- add drawList
	Screen:addDrawList()
end

return Screen