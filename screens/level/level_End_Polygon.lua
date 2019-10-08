local Level_End = require("lib.level_End")
local Screen = Level_End:extend()

local reList, dirList, spdList, zList
local timeToShow
local a1, a2
local waitTimer

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
	
	waitTimer = 0
	--- here to create shape
	reList = {}
	dirList = {}
	spdList = {}
	zList = {}
	for i = 1, 100 do
		-- body
		local _x = love.math.random(0, base.guiWidth)
		local _y = love.math.random(0, base.guiHeight)
		reList[i] = Rectangle(_x, 0, _y-base.guiHeight-10, base.player.len, 0)

		table.insert(self.shapeList, reList[i])
		table.insert(self.drawList, reList[i])

		dirList[i] = love.math.random(-1, 1)
		spdList[i] = love.math.random(0, 3)
		zList[i] = love.math.random(base.garvity/2,  base.garvity)
	end

	a1 = AllForOne(base.guiWidth/2, 500, 1300, 15, 50)
	table.insert(self.shapeList, a1)
	table.insert(self.drawList, a1)
	a2 = AllForOne(base.guiWidth/2, 500, 1300, 20, 30)
	table.insert(self.shapeList, a2)
	table.insert(self.drawList, a2)
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.timeToEnd then
		for i = 1, #reList do
			reList[i].z = reList[i].z + zList[i]*dt
			reList[i].dir = reList[i].dir + dirList[i]*spdList[i]*dt
		end

		if a1.z > base.guiHeight/2 then
			local dis = math.abs(a1.z-base.guiHeight/2) 
			if dis > base.garvity*dt then
				a1.z = a1.z - base.garvity*dt
				a2.z = a2.z - base.garvity*dt
			else
				a1.z = a1.z - dis
				a2.z = a2.z - dis
			end
		else
			waitTimer = waitTimer + 1*dt
		end
		--
		a1:update(dt)
		a2:update(dt)

		if waitTimer > 5 then
			self.screen:view("MainScreen")
		end
	end
end

function Screen:draw()
	Screen.super.draw(self)

	if waitTimer > 2 then
		love.graphics.setColor(base.cBlack)
		love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)
		love.graphics.setColor(base.cWhite)
		base.print("由衷地感谢您的游玩！！", base.guiWidth/2, base.guiHeight/3, "center", "center")
		base.print("Yaolaotou & Notoj", base.guiWidth/2, base.guiHeight/3*2, "center", "center")
	end
end


return Screen