local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local cubeZ = base.guiHeight
	local cubeLenX = base.guiWidth-1*2
	local cubeLenY = base.guiHeight-1*2
	local cubeLenZ = 50

	-- levelName
	local levelName = ""
	-- player location
	local playerX = 70
	local playerY = 180+base.guiHeight
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth/2-50/2
	local destinationY = base.guiHeight+cubeLenY
	local destinationZ = cubeZ - 50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		1, 1+base.guiHeight, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	-- add drawList
	Screen:addDrawList()
	
	-- tips
	Screen:addTipsList(base.guiWidth/2, base.guiHeight/3-9, -50*4, "救救我们", "center", "center")
	Screen:addTipsList(base.guiWidth/2, base.guiHeight/3, 	-100, "恭喜您通关游戏！", "center", "center")
	Screen:addTipsList(base.guiWidth/2, base.guiHeight/3 *2,-50*3, "救救我们", "center", "center")
	Screen:addTipsList(base.guiWidth/2, base.guiHeight/3 *2,-100, "按A返回主界面", "center", "center")
	--
	local _x = base.guiWidth/2
	Screen:addTipsList(_x, base.guiHeight, 	-50*2, "救救我们", "center")
	Screen:addTipsList(_x, base.guiHeight+100,   -50, "救救我们", "center")
	Screen:addTipsList(_x, base.guiHeight+100*2, 50*0, "救救我们", "center")
	Screen:addTipsList(_x, base.guiHeight+100*3, 50*1, "救救我们", "center")
	Screen:addTipsList(_x, base.guiHeight+100*4, 50*2, "救救我们", "center")
	-- random location
	for i = 0, 10 do
		local _x = love.math.random(0, base.guiWidth)
		local _y = love.math.random(0, base.guiHeight)
		local _z = love.math.random(0, base.guiHeight-80)
		Screen:addTipsList(_x, base.guiHeight+_y, 	_z, "救救我们", "center")
	end
end

function Screen:keypressed(key)
	-- goto mainScreens
	if shiftMode == 0 and key == keys.A then
		love.load()
		--love.event.quit( "restart" )
	end

	-- should under [goto mainScreens], or no work
	Screen.super.keypressed(self, key)
end







return Screen