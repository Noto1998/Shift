Level = Object:extend()

local levelNameToDraw

function Level:new(ScreenManager)
	self.screen = ScreenManager
end

function Level:activate(playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    -- shift
	shiftMode = 0-- 0=xy, 1=xz
	shiftFlag = false
	shifting = false
	_timerMax = 2
    _timer = 0
	-- shapeList, when start a new level, release shape
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
		local _dt = 1 / _timerMax * dt
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
	player:update(dt, shiftMode, drawList)
	-- finish level
	if destination:touch(player) then
		-- goto next level
		levelChoice = levelChoice + 1
		local levelName = "level" .. levelChoice
		self.screen:view(levelName)
	end

	--- update drawList in realtime
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
	---
end

function Level:draw()
	-- draw all obj in drawList
	if drawList ~= nil then
		for key, value in pairs(drawList) do
			value:draw(shiftMode)
		end
	end
	-- finish level
	if destination:touch(player) then
		love.graphics.setColor(1,1,1)
		base.print("level finish", base.guiWidth/2, base.guiHeight/2, "center", "center")
	end
	-- draw levelName
	love.graphics.setColor(1,1,1)
	base.print(levelNameToDraw, 0, base.guiHeight, "right", "bottom")
end

function Level:keypressed(key)
	-- switch shiftMode
	if key == keys.A and not shifting then
		shiftFlag = not shiftFlag
		shifting = true
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
end