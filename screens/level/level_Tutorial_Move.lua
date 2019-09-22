local Screen = Level:extend()

function Screen:activate()
	-- shape value
	local border = 40
	local cubeZ = 130
	local cubeLenX = base.guiWidth-border*2
	local cubeLenY = base.guiHeight-border*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50+2
	
	-- levelName
	local levelName = lang.level_Tutorial_Move
	-- player location
	local playerX = 80
	local playerY = base.guiHeight/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth-playerX-50/2
	local destinationY = playerY-50/2
	local destinationZ = cubeZ-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		border, border, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	-- add drawList
	Screen:addDrawList()

	-- tips
	Screen:addTipsList(lang.tips_use_arrows_to_move,	10, 5, 80)
	Screen:addTipsList(lang.tips_touch_the_green_goal,	destinationX-50, destinationY-50, destinationZ-50)
	Screen:addTipsList(lang.tips_good_luck,				base.guiWidth/2-50, 300, cubeZ+10)
end


return Screen