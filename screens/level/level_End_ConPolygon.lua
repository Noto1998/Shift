local Level_End = require("lib.level_End")
local Screen = Level_End:extend()

local cp1

function Screen:activate()
	--- shape value
	local cZ = 180
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	---
	local tipsTable = lang.tips_conPolygon 
	-- levelName
	local levelName = ""
	-- create player and destination
	Screen.super.activate(self, tipsTable, levelName)
	
	--- here to create shape
	cp1 = ConPolygon(base.guiWidth/4*3, base.guiHeight/2, base.guiHeight/3,		15, 30,  30)
	table.insert(self.shapeList, cp1)
	table.insert(self.drawList, cp1)
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.timeToEnd then
		cp1.len = cp1.len + 1*dt
		cp1.border = cp1.border - 1*dt
	end
end

return Screen