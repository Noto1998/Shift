local Screen = Level:extend()

function Screen:activate()
	-- levelName
	local levelName = lang.level_OneShot
	
	-- shape value
	local cZ = 200
	local cLenZ = 25

	local reLenX = base.guiWidth-50
	local reLenY = base.guiHeight/2
	local reX = 0
	local reY = 0-reLenY
	local reZ = 70
	local reDir = math.pi/20
	local lenXReal = base.guiWidth - math.cos(reDir)*reLenX
	local reZBorder = 75
	--ball
	local bR = 20
	local bX = bR
	local bY = base.guiHeight/5
	local bZ = 0
	-- turret
	local tX1 = 0
	local tSY1 = base.guiHeight/base.guiWidth
	local tX2 = base.guiWidth/3
	local tSY2 = base.guiHeight/(base.guiWidth/3)
	
	-- player location
	local playerX = 60
	local playerY = base.guiHeight/2
	local playerZ = cZ-1
	-- destination location
	local destinationX = base.guiWidth-playerX-50/2
	local destinationY = base.guiHeight/2-50/2
	local destinationZ = -50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	self:addShapeList(Cuboid,		0, 0, cZ,				base.guiWidth, base.guiHeight, cLenZ)
	
	-- rectangle
	self:addShapeList(Rectangle,	reX, base.guiHeight, reZ,				reLenX, reLenY, 		 math.pi/2 - reDir)
	self:addShapeList(Rectangle,	reX+lenXReal, reY, reZ+reZBorder,		reLenX, reLenY, 		 math.pi/2 + reDir)

	-- ball
	self:addShapeList(Ball,		bX, bY, bZ,												bR)
	self:addShapeList(Ball,		base.guiWidth-bX, base.guiHeight-bY, bZ+reZBorder,		bR)
	--ball to be wall
	self:addShapeList(Ball,		tX2, base.guiHeight/2, cZ-bR,							bR)
	self:addShapeList(Ball,		base.guiWidth-tX2, base.guiHeight/2, cZ-bR,				bR)
	-- turret
	self:addShapeList(Turret,		tX1, 0, 0,					1, tSY1, 1)
	self:addShapeList(Turret,		tX2, 0, 0,					1, tSY2, 1)
	self:addShapeList(Turret,		tX1, base.guiHeight, 0,		1, -tSY1, 1)
	self:addShapeList(Turret,		tX2, base.guiHeight, 0,		1, -tSY2, 1)
end

return Screen