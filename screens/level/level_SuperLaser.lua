local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- player wall
	local c1Z = 80
	local c1LenX = 2.5*40
	local c1LenY = 140
	local c1LenZ = 80
	-- turret wall
	local c2LenX = 40 * 4
	local c2LenY = c1LenY
	local c2LenZ = 20
	-- hole
	local hLenX = 40 * 2
	local hLenZ = 10
	local hX1 = 3*40
	local hX2 = hX1 + 40*3
	local hZ = c1Z
	-- left wall
	local leftLenY = 50
	local leftLenZ = 200
	local leftX = hX1-1
	local leftY = -200
	local leftZ = hZ - leftLenZ + hLenZ

	-- ball
	local ballR = hLenX/2

	-- turret
	local tX = 3.5*40
	local tBorderX = 40
	local tY = -100
	local tZ = 100
	local tSX = 0
	local tSY = 1
	local tSZ = 1
	---

	-- levelName
	local levelName = "不可能的任务"
	-- player location
	local playerX = 50
	local playerY = 116-30
	local playerZ = c1Z-1
	-- destination location
	local destinationX = playerX-50/2
	local destinationY = base.guiHeight+10
	local destinationZ = base.guiHeight-20-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    
	--- here to create shape
	-- floor
    Screen:addShapeList(Cuboid,	1, 1, base.guiHeight-20,		base.guiWidth, base.guiHeight, 1)


	-- player wall
	Screen:addShapeList(Cuboid, 1, 1, c1Z,							c1LenX, c1LenY, c1LenZ)
	-- turret wall
	Screen:addShapeList(Cuboid, 1+c1LenX, 1, c1Z+c1LenZ,			c2LenX, c2LenY, c2LenZ)
	

	--left wall
	Screen:addShapeList(Cuboid, leftX, leftY, leftZ,				10, leftLenY, leftLenZ)
	
	
	-- hole1
	Screen:addShapeList(Cuboid, hX1, leftY, hZ,					hLenX, leftLenY, hLenZ)
	Screen:addShapeList(Ball, hX1+ballR, leftY, hZ-ballR,		ballR)
	

	-- hole2
	Screen:addShapeList(Cuboid, hX2, leftY, hZ,						hLenX, leftLenY, hLenZ)
	Screen:addShapeList(Ball, hX2+ballR, leftY, hZ-ballR,			ballR)
	

	-- Turret
	for i = 0, 4 do
		Screen:addShapeList(Turret, tX+tBorderX*i, tY, tZ,		tSX, tSY, tSZ)
	end


	-- add drawList
	Screen:addDrawList()
end

return Screen