local Screen = Level:extend()

local tipsNum, tipsFlag, tipsTable, t1, t2

function Screen:activate(tipstable, levelName)
	--- shape value
	local cZ = 180
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	---
	tipsNum = 1
	tipsFlag = false
	tipsTable = tipstable


	-- player location
	local playerX = base.guiWidth/4-base.player.len/2
	local playerY = base.guiHeight/2-base.player.len/2
	local playerZ = cZ - 1
	-- destination location
	local destinationX = base.guiWidth+1
	local destinationY = base.guiHeight+1
	local destinationZ = base.guiHeight+1
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	

	--- here to create tips
	t1 = Tips(tipsTable[tipsNum], base.guiBorder, -50, base.guiBorder*2)
	t2 = Tips(tipsTable[tipsNum], base.guiBorder, base.guiBorder*2, -50)
	table.insert(self.tipsList, t1)
	table.insert(self.tipsList, t2)
end


function Screen:update(dt)
	Screen.super.update(self, dt)
	-- update tips
	if base.isPressed(base.keys.shift) and (self.shiftMode == 0 or self.shiftMode == 1) then
		tipsNum = tipsNum + 1
		-- update string
		if tipsNum <= #tipsTable then
			if self.shiftMode == 0 then
				t1.string = tipsTable[tipsNum]
			elseif self.shiftMode == 1 then
				t2.string = tipsTable[tipsNum]
			end
		else
			self.screen:view("MainScreen")
		end
	end
end


return Screen