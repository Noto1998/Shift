Level = Object:extend()

local levelNameToDraw
local shiftTimerMax
local shiftTimer
local shifting
local shiftFlag
local shiftSpd

local finishFlag
local finishTimer

local dialogue

function Level:new(ScreenManager)
	self.screen = ScreenManager
end

function Level:activate(playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName, dialogTable)
    -- shift
	shiftMode = 0-- 0=xy, 1=xz
	shiftFlag = false
	shifting = false
	shiftTimerMax = 1.25
	shiftTimer = 0
	shiftSpd = 0

	-- finishLevelTimer
	finishFlag = false
	finishTimer = 0

	-- shapeList, when start a new level, release shape
	if shapeList ~= nil then
		for key, value in pairs(shapeList) do
			value.mesh:release()
		end
	end
	shapeList = {}

	--- drawList
	drawList = {}

	-- player and destination
	player = Player(playerX, playerY, playerZ)
	destination = Destination(destinationX, destinationY, destinationZ)
	
	-- levelName
	levelNameToDraw = "levelName missing!"
	if levelName ~= nil then
		levelNameToDraw = levelName
	end

	dialogue = nil
	if dialogTable ~= nil then
		dialogue = Dialogue(dialogTable)
	end
end

function Level:update(dt)
	-- update shiftMode
	if shifting then
		local shiftAddSpd = 2*dt
		local shiftAddTime = 0.3
		-- start spd
		if shiftMode == 0 or shiftMode == 1 then
			shiftSpd = 0
		end
		-- add spd
		if shiftFlag then
			if shiftMode < shiftAddTime then
					shiftSpd = shiftSpd + shiftAddSpd
			elseif shiftMode > 1-shiftAddTime then
				shiftSpd = shiftSpd - shiftAddSpd
			end
		else
			if shiftMode < shiftAddTime then
				shiftSpd = shiftSpd - shiftAddSpd
			elseif shiftMode > 1-shiftAddTime then
				shiftSpd = shiftSpd + shiftAddSpd
			end
		end
		local _dt = math.abs(shiftSpd) / shiftTimerMax * dt
		-- change shiftMode
		if shiftMode < 1 and shiftFlag then
			local _border =  1 - shiftMode
			if _border < _dt then
				shiftMode = 1
				shifting = false -- close
			else
				shiftMode = shiftMode + _dt
			end
		end
		if shiftMode > 0 and not shiftFlag then
			if shiftMode < _dt then
				shiftMode = 0
				shifting = false -- close
			else
				shiftMode = shiftMode - _dt
			end
		end
	end

	-- player's move and update location
	if not finishFlag then
		player:update(dt, shiftMode, shapeList)
	end
	
	-- finish level
	if player:touch(destination, shiftMode) then
		if not finishFlag then
			finishFlag = true
		end
	end

	--- sort drawList
	if shiftMode ~= 1 then
		-- sort by z
		for i=1, #drawList do
			local j = i
			for k=i+1, #drawList do
				if drawList[k].z > drawList[j].z then
					j, k = k, j
				end
			end
			drawList[i], drawList[j] = drawList[j], drawList[i]
		end
		-- then sort by y
		for i=1, #drawList do
			local j = i
			for k=i+1, #drawList do
				if drawList[k].z == drawList[j].z and drawList[k].y < drawList[j].y then
					j, k = k, j
				end
			end
			drawList[i], drawList[j] = drawList[j], drawList[i]
		end
	end
	---
end

function Level:draw()
	-- draw BG
	love.graphics.setColor(base.cFill)
	love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)

	-- draw all obj in drawList
	if drawList ~= nil then
		for key, value in pairs(drawList) do
			value:draw(shiftMode)
		end
	end

	-- draw levelName
	love.graphics.setColor(1,1,1)
	base.print(levelNameToDraw, 0, base.guiHeight, "right", "bottom")

	-- draw stuck warning
	if shiftMode == 0 and player.stuck then
		love.graphics.setColor(1,1,1)
		base.print("player stuck", base.guiWidth/2, base.guiHeight, "center", "bottom")
	end

	-- draw bottom tips
	love.graphics.setColor(1,1,1)
	base.print("A:切换,Select:重置", base.guiWidth, base.guiHeight, "left", "bottom")

	-- dialogue
	if dialogue ~= nil then
		dialogue:draw()
	end

	-- finish level
	if finishFlag then
		love.graphics.setColor(0,0,0, 0.75)
		love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)
		love.graphics.setColor(1, 1, 1)
		base.print("关卡完成", base.guiWidth/2, base.guiHeight/3, "center", "center")
		base.print("按A继续", base.guiWidth/2, base.guiHeight/3*2, "center", "center")
	end

	--[DEBUG]
	if debugMode then
		love.graphics.setColor(1,1,1)
		-- player location
		base.print("debug:" .. player.x..","..player.y..","..player.z, 0, love.graphics.getFont():getHeight())
	end
end

function Level:keypressed(key)
	-- switch shiftMode
	if key == keys.A and not shifting and Player:onGround(shiftMode)
	and (dialogue==nil or not dialogue:isDraw()) and not finishFlag then
		shiftFlag = not shiftFlag
		shifting = true
	end
	
	-- reset
	if key == keys.Select then
		self.screen:view(resetLevelString)
	end

	-- dialogueTable
	if key == keys.Y and dialogue ~= nil and not shifting then
		dialogue:nextPage()
	end

	-- goto next level
	if finishFlag and key == keys.A then
		-- goto next level
		levelChoice = levelChoice + 1
		local levelName = levelString[levelChoice]
		self.screen:view(levelName)
	end
end

-- add obj to drawList
function Level:addDrawList()
	local arg = {}
	-- add player and destination
	table.insert(arg, player)
	table.insert(arg, destination)
	-- put all shape in drawList
	for key, value in pairs(shapeList) do
		if value ~= nil then
			table.insert(arg, value)
		end
	end
	--
	drawList = arg
	-- test add destination to shapeList
	table.insert(shapeList, destination)
end

-- add obj to shapeList
function Level:addShapeList(obj, ...)
	table.insert(shapeList, obj(...))
	return obj(...)--test
end