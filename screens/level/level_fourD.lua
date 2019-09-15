local Screen = Level:extend()

local tipsTime
local tipsFlag
local tipsTable = {
	"恭喜你，你做到了。",
	"就像我们其他同胞那样。",
	"我们需要生存的方法。",
	"但四维从不回应。",
	"希望我们能再次相见。",
}

function Screen:activate()
	-- shape value
	local cZ = 180
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	
	tipsTime = 0
	tipsFlag = false

	-- levelName
	local levelName = "2²"
	-- player location
	local playerX = 100
	local playerY = 180
	local playerZ = cZ - 1
	-- destination location
	local destinationX = base.guiWidth+1
	local destinationY = base.guiHeight+1
	local destinationZ = base.guiHeight+1
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	Screen:addShapeList(Cuboid,		1, 1, cZ,		cLenX, cLenY, cLenZ)

	f1 = FourD(base.guiWidth/2, base.guiHeight/2, base.guiHeight/4,		30,  50,
	{0.92, 0.02, 0.76, 0.25}, {0.02, 0.92, 0.7, 0.25})
	table.insert(shapeList, f1)

	-- tips
	t1 = Tips(10, -50, 20, "test")
	table.insert(tipsList, t1)

	-- add drawList
	Screen:addDrawList()
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	--
	local modeMin = 0.1
	local mode1 = 0.33
	if (shiftMode >= mode1-modeMin and shiftMode <= mode1+modeMin) or
	(shiftMode >= (1-mode1)-modeMin and shiftMode <= (1-mode1)+modeMin) then
		f1.lenX, f1.lenY = f1.lenY, f1.lenX
	end


	--
	tipsFlag = (shiftMode == 0)
end

function Screen:keypressed(key)
	Screen.super.keypressed(self, key)

	--
	if key == keys.Y and tipsFlag then
		tipsTime = tipsTime + 1
		if tipsTime <= #tipsTable then
			t1.string = tipsTable[tipsTime]
		else
			love.load()
		end
	end
end

return Screen