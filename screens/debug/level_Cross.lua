local Screen = Level:extend()

function Screen:activate()
	-- levelName
	local levelName = "交叉"
	-- player location
	local playerX = 275
	local playerY = 45
	local playerZ = 209
	-- destination location
	local destinationX = 20
	local destinationY = 20
	local destinationZ = 160
	-- Side Wall
	local SWx = -12
	local SWy = 0
	local SWz = 0 
	local SWLx = 20
	local SWLy = 238
	local SWLz = 211
	--laser
	local Lx = 160
	local Ly = 3
	local Lz = 188
	local LLx = 0
	local LLy = 1
	local LLz = 1
	--
	local Sx=1
	local Sy = 240/(320-2*(Lx-50))
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    --Floor
	Screen:addShapeList(Cuboid,	2,2,210,318,238,30)
	
	--Side Wall
	Screen:addShapeList(Cuboid,SWx,SWy,SWz,SWLx,SWLy,SWLz)
	Screen:addShapeList(Cuboid,SWx+325,SWy,SWz,SWLx,SWLy,SWLz)
	--Laser
	Screen:addShapeList(Turret,Lx,Ly,Lz,LLx,LLy,LLz)--chuizhi
	Screen:addShapeList(Turret,Lx-50,Ly,Lz,Sx,Sy,LLz)--right
	Screen:addShapeList(Turret,Lx+50,Ly,Lz,-Sx,Sy,LLz)--left
	Screen:addShapeList(Turret,0,Ly+210,Lz,1,0,LLz)
	--Middle Wall
	Screen:addShapeList(Cuboid,55,100,110,210,30,30)
	Screen:addShapeList(Cuboid,150,50,190,20,55,20)
	Screen:addShapeList(Cuboid,150,130,190,20,55,20)
	Screen:addShapeList(Cuboid,290,100,110,22,30,30)
	Screen:addShapeList(Cuboid,10,100,110,22,30,30)
	--Bottom Wall
	-- Screen:addShapeList(Cuboid,1) 




	--- here to create shape
	-- use [ Screen:addShapeList(shape,...) ] to create shape:
	-- Rectangle,	x, y, z, lenX, lenY
	-- Circle,		x, y, z, radius
	-- Cuboid,		x, y, z, lenX, lenY, lenZ
	-- Cylinder,	x, y, z, radius, height

	-- e.g. Screen:addShapeList(Circle, 0, 0, 0, 50)
	
	-- add drawList
	Screen:addDrawList()
end

return Screen