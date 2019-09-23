Level = Shift:extend()

local finishFlag
local finishTimer
local gotoMainScreenTimer
local keyTips

function Level:activate(playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	-- shift
	Level.super.activate(self)
	
	-- finishLevelTimer
	finishFlag = false
	finishTimer = 0
	gotoMainScreenTimer = 0

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
	self.levelName = "levelName missing!"
	if levelName ~= nil then
		self.levelName = levelName
	end

	-- keyTips
	keyTips = KeyTips()
end


function Level:update(dt)
	-- shift/bgmManager/pressedSetting
	local canShift = Player:onGround(self.shiftMode) and (not finishFlag) and (not keyTips:getShowFlag())
	Level.super.update(self, dt, canShift)
	
	-- keyTips
	keyTips:update()

	--
	if (not finishFlag) and (not keyTips:getShowFlag()) then
		-- reset
		if base.isPressed(base.keys.reset) then
			self.screen:view(resetLevelString)
		end
		
		-- goto MainScreens
		if base.isDown(base.keys.cancel) then
			gotoMainScreenTimer = gotoMainScreenTimer + dt
		else
			gotoMainScreenTimer = 0
		end
		if gotoMainScreenTimer > 1 then
			self.screen:view("MainScreen")
		end
		
		-- player move
		player:update(dt, self.shiftMode, shapeList)
	end
	
	
	-- goto next level
	if finishFlag and base.isPressed(base.keys.enter) then
		levelChoice = levelChoice + 1
		local levelName = levelString[levelChoice]
		self.screen:view(levelName)
	end

	-- shape update
	for i = 1, #shapeList do
		-- turret
		if shapeList[i]:is(Turret) then
			-- turn on/off
			if not shifting then
				shapeList[i]:update(dt)
			end
			-- hit player
			if self.shiftMode == 0 and shapeList[i]:hit(player) and not finishFlag then
				-- reset
				self.screen:view(resetLevelString)
				-- sfx
				sfx_restart:seek(0.15)
				love.audio.play(sfx_restart)
				break
			end
			
			-- ball block laser
			local ballTable = {}
			for i = 1, #shapeList do
				if shapeList[i]:is(Ball) then
					table.insert(ballTable, shapeList[i])
				end
			end
			shapeList[i]:blockTable(ballTable)

		-- Ball
		elseif shapeList[i]:is(Ball) then
			shapeList[i]:update(dt, self.shiftMode, shapeList)

			-- hit player
			if self.shiftMode == 1 and shapeList[i]:hit(player) and not finishFlag then
				-- reset
				self.screen:view(resetLevelString)
				-- sfx
				sfx_restart:seek(0.15)
				love.audio.play(sfx_restart)
				break
			end
		end
	end
	
	-- finish level
	if player:touch(destination, self.shiftMode) then
		if not finishFlag then
			finishFlag = true
			--sfx
			love.audio.play(sfx_finish)
		end
	end

	--- sort drawList
	if self.shiftMode == 0 then
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
	elseif self.shiftMode == 1 then
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
	love.graphics.setColor(base.cBlack)
	love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)

	-- draw all obj in drawList
	if drawList ~= nil then
		for key, value in pairs(drawList) do
			value:draw(self.shiftMode)
		end
	end

	-- tips
	if tipsList ~= nil then
		for i = 1, #tipsList do
			tipsList[i]:draw(self.shiftMode)
		end
	end

	-- draw levelName
	love.graphics.setColor(base.cWhite)
	base.print(self.levelName, base.guiBorder, base.guiHeight, "right", "bottom")
	
	-- draw keyTips text
	love.graphics.setColor(base.cDarkGray)
	base.print(lang.ui_key_keyTips, base.guiWidth-base.guiBorder, base.guiHeight, "left", "bottom")
	

	-- draw stuck warning
	if self.shiftMode == 0 and player.stuck then
		love.graphics.setColor(base.cWhite)
		base.print(lang.ui_player_stuck, base.guiWidth/2, base.guiHeight/2, "center", "center")
	end

	-- keyTips
	keyTips:draw()

	-- finish level
	if finishFlag then
		love.graphics.setColor(0,0,0, 0.75)
		love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)
		love.graphics.setColor(base.cWhite)
		base.print(lang.ui_level_finish, base.guiWidth/2, base.guiHeight/3, "center", "center")
		base.print(lang.ui_pressed_A_to_continue, base.guiWidth/2, base.guiHeight/3*2, "center", "center")
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