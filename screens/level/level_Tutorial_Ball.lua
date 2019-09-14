local Screen = Level:extend()

function Screen:activate()
	-- levelName
	local levelName = "滚石"
	
	-- shape value
	local cLenX = base.guiWidth-1*2
	local cLenY = 100
	local cLenZ = 50
	local cX = 1
	local cY = base.guiHeight/2-cLenY/2
	local cZ = base.guiHeight
	--ball
	local cR = 20

	-- player location
	local playerX = 120
	local playerY = base.guiHeight/2
	local playerZ = 50
	-- destination location
	local destinationX = base.guiWidth-50/2
	local destinationY = base.guiWidth+50
	local destinationZ = base.guiHeight-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Rectangle,	cX, cY, cZ,		cLenX, cLenY, 		 math.pi/2 -math.pi/10)
	Screen:addShapeList(Cuboid,		base.guiWidth/2-25/2, cY, 1,		25, cLenY, 25)
	
	Screen:addShapeList(Ball,		cR, base.guiHeight/2, 50,		cR)

	-- add drawList
	Screen:addDrawList()
end

return Screen