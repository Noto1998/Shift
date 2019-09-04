Level = Object:extend()

local levelNameToDraw
local shiftTimerMax
local shiftTimer
local shifting
local shiftFlag
local shiftSpd

function Level:new(ScreenManager)
	self.screen = ScreenManager
end

function Level:activate(playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    -- shift
	shiftMode = 0-- 0=xy, 1=xz
	shiftFlag = false
	shifting = false
	shiftTimerMax = 1.25
	shiftTimer = 0
	shiftSpd = 0

	-- shapeList, when start a new level, release shape
	if shapeList ~= nil then
		for key, value in pairs(shapeList) do
			value.mesh:release()
		end
	end
	shapeList = {}

	--- drawList
	player = Player(playerX, playerY, playerZ)
	destination = Destination(destinationX, destinationY, destinationZ)
	drawList = {player, destination}
	---
	
	-- levelName
	levelNameToDraw = "levelName missing!"
	if levelName ~= nil then
		levelNameToDraw = levelName
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
		local _dt = shiftSpd / shiftTimerMax * dt
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

	-- update player
	player:update(dt, shiftMode, shapeList)
	
	-- finish level
	if player:touch(destination, shiftMode) then
		-- goto next level
		levelChoice = levelChoice + 1
		local levelName = "levelScreen" .. levelChoice
		self.screen:view(levelName)
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
	
	-- finish level
	if player:touch(destination, shiftMode) then
		love.graphics.setColor(1,1,1)
		base.print("level finish", base.guiWidth/2, base.guiHeight/2, "center", "center")
	end
	
	-- draw levelName
	love.graphics.setColor(1,1,1)
	base.print(levelNameToDraw, 0, base.guiHeight, "right", "bottom")

	-- draw stuck warning
	if shiftMode == 0 and player.stuck then
		love.graphics.setColor(1,1,1)
		base.print("player stuck", base.guiWidth/2, base.guiHeight, "center", "bottom")
	end

	-- draw bottom
	love.graphics.setColor(1,1,1)
	base.print("A=shift Select=reset", base.guiWidth, base.guiHeight, "left", "bottom")

	--[DEBUG] draw location
	if debugMode then
		love.graphics.setColor(1,1,1)
		base.print("debug:" .. player.x..","..player.y..","..player.z, 0, love.graphics.getFont():getHeight())
	end
end

function Level:keypressed(key)
	-- switch shiftMode
	if key == keys.A and not shifting and Player:onGround(shiftMode) then
		shiftFlag = not shiftFlag
		shifting = true
	end
	-- reset
	if key == keys.Select then
		local levelName = "levelScreen" .. levelChoice
		self.screen:view(levelName)
	end
end

-- add obj to drawList
function Level:addDrawList()
	local arg = {}
	-- add player and destination
	for key, value in pairs(drawList) do
		if value ~= nil then
			table.insert(arg, value)
		end
	end
	-- put all shape in
	for key, value in pairs(shapeList) do
		if value ~= nil then
			table.insert(arg, value)
		end
	end
	--
	drawList = arg
end

-- add obj to shapeList
function Level:addShapeList(obj, ...)
	table.insert(shapeList, obj(...))
	return obj(...)--test
end