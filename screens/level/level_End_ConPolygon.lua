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
	local tipsTable = lang.tips_fourD
	-- levelName
	local levelName = ""
	-- create player and destination
	Screen.super.activate(self, tipsTable, levelName)
	
	--- here to create shape
	--self:addShapeList(Cuboid,		1, 1, cZ,		cLenX, cLenY, cLenZ)
	
	cp1 = ConPolygon(base.guiWidth/4*3, base.guiHeight/2, base.guiHeight/3,		15, 30,  30)
	table.insert(self.shapeList, cp1)
	table.insert(self.drawList, cp1)
end

return Screen