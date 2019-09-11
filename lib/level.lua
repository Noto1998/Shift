Level = Shift:extend()

local levelNameToDraw
local finishFlag
local finishTimer

function Level:activate(playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	-- shift
	Level.super.activate(self)

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
	-- shift
	Level.super.update(self, dt)

	-- shape update
	for i = 1, #shapeList do
		-- turret
		if shapeList[i]:is(Turret) then
			-- hit player
			if shapeList[i]:hit(shiftMode, player) and not finishFlag then
				-- reset
				self.screen:view(resetLevelString)
				-- sfx
				sfx_restart:seek(0.15)
				love.audio.play(sfx_restart)
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
			--sfx
			love.audio.play(sfx_finish)
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
	-- shift
	if Player:onGround(shiftMode) and not finishFlag then
		Level.super.keypressed(self, key)
	end

	-- reset
	if key == keys.Select then
		self.screen:view(resetLevelString)
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