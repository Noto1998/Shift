local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = base.guiHeight
	local cubeLenX = base.guiWidth-1*2
	local cubeLenY = base.guiHeight-1*2
	local cubeLenZ = 50
	---

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
	self:addShapeList(Cuboid,		1, 1+base.guiHeight, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	--- here to create tips
	self:addTipsList(lang.tips_save_us, 			base.guiWidth/2, base.guiHeight/3-9,	-50*4,	"center", "center")
	self:addTipsList(lang.tips_congratulations,		base.guiWidth/2, base.guiHeight/3,		-100,	"center", "center")
	self:addTipsList(lang.tips_save_us,				base.guiWidth/2, base.guiHeight/3 *2,	-50*3,	"center", "center")
	self:addTipsList(lang.ui_pressed_A_to_continue,	base.guiWidth/2, base.guiHeight/3 *2,	-100,	"center", "center")
	--
	local _x = base.guiWidth/2
	self:addTipsList(lang.tips_save_us, _x, base.guiHeight,		 -50*2, "center")
	self:addTipsList(lang.tips_save_us, _x, base.guiHeight+100,  -50*1,	"center")
	self:addTipsList(lang.tips_save_us, _x, base.guiHeight+100*2, 50*0,	"center")
	self:addTipsList(lang.tips_save_us, _x, base.guiHeight+100*3, 50*1,	"center")
	self:addTipsList(lang.tips_save_us, _x, base.guiHeight+100*4, 50*2,	"center")
	-- random location
	for i = 0, 10 do
		local _x = love.math.random(0, base.guiWidth)
		local _y = love.math.random(0, base.guiHeight)
		local _z = love.math.random(0, base.guiHeight-80)
		self:addTipsList(lang.tips_save_us, _x, base.guiHeight+_y, _z, "center")
	end
end

function Screen:update(dt)
	-- shift and bgm
	Screen.super.update(self, dt)

	-- goto mainScreens
	if self.shiftMode == 0 and base.isPressed(base.keys.enter) then
		self.screen:view("MainScreen")
	end
end


return Screen