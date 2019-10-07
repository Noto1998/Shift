local Level_End = require("lib.level_End")
local Screen = Level_End:extend()

local reList

function Screen:activate()
	--- shape value
	local cZ = 180
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	---
	local tipsTable = lang.tips_polygon 
	-- levelName
	local levelName = ""
	-- create player and destination
	Screen.super.activate(self, tipsTable, levelName)
	
	--- here to create shape
	for i = 1, 10 do
		-- body
		local _x = love.math.random(0, base.guiWidth)
		local _y = love.math.random(0, base.guiHeight)
		reList[i] = Rectangle(_x, 0, _y, base.player.len, 0)

		table.insert(self.shapeList, reList[i])
		table.insert(self.drawList, reList[i])
	end
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.timeToEnd then
		--cp1.len = cp1.len + 1*dt
		--cp1.border = cp1.border - 1*dt
	end
end

return Screen