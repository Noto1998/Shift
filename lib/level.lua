Level = Object:extend()

local levelNameToDraw
local shiftTimerMax
local shiftTimer
local shifting
local shiftFlag
local shiftSpd
local finishFlag
local finishTimer

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

	-- finishLevelTimer
	finishFlag = false
	finishTimer = 0

	-- shapeList, when start a new level, release shape
	if shapeList ~= nil then
		for key, value in pairs(shapeList) do
			if value.mesh ~= nil then
				value.mesh:release()
			end
		end
	end
	shapeList = {}

	-- drawList
	drawList = {}

	-- tipsList
	tipsList = {}

	-- player and destination
	player = Player(playerX, playerY, playerZ)
	destination = Destination(destinationX, destinationY, destinationZ)
	
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

	-- shape update
	for i = 1, #shapeList do
		-- turret
		if shapeList[i]:is(Turret) then
			-- hit player
			if shapeList[i]:hit(shiftMode, player) then
				-- reset
				self.screen:view(resetLevelString)
				break
			end
			-- turn on/off
			if not shifting then
				shapeList[i]:update(dt)
			end
		-- Ball
		elseif shapeList[i]:is(Ball) then
			shapeList[i]:update(dt, shiftMode, shapeList)
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
	if shiftMode == 0 then
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
	elseif shiftMode == 1 then
		-- then sort by y
		for i=1, #drawList do
			local j = i
			for k=i+1, #drawList do
				if drawList[k].y < drawList[j].y then
					j, k = k, j
				end
			end
			drawList[i], drawList[j] = drawList[j], drawList[i]
		end
	else
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

	-- tips
	if tipsList ~= nil then
		for i = 1, #tipsList do
			tipsList[i]:draw(shiftMode)
		end
	end

	love.graphics.setColor(base.cWhite)
	-- draw levelName
	base.print(levelNameToDraw, 0, base.guiHeight, "right", "bottom")
	-- draw bottom tips
	base.print("select 重置关卡", base.guiWidth, base.guiHeight, "left", "bottom")

	-- draw stuck warning
	if shiftMode == 0 and player.stuck then
		love.graphics.setColor(base.cWhite)
		base.print("player stuck", base.guiWidth/2, base.guiHeight/2, "center", "center")
	end

	-- finish level
	if finishFlag then
		love.graphics.setColor(0,0,0, 0.75)
		love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)
		love.graphics.setColor(base.cWhite)
		base.print("关卡完成", base.guiWidth/2, base.guiHeight/3, "center", "center")
		base.print("按A继续", base.guiWidth/2, base.guiHeight/3*2, "center", "center")
	end
end


function Level:keypressed(key)
	-- reset
	if key == keys.Select then
		self.screen:view(resetLevelString)
	end

	-- switch shiftMode
	if key == keys.Y and not shifting and Player:onGround(shiftMode)
	and (dialogue==nil or not dialogue:isDraw()) and not finishFlag then
		shiftFlag = not shiftFlag
		shifting = true
	end

	-- goto next level
	if finishFlag and key == keys.A then
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

-- shapeList
function Level:addShapeList(obj, ...)
	table.insert(shapeList, obj(...))
end

-- tipsList
function Level:addTipsList(...)
	table.insert(tipsList, Tips(...))
end