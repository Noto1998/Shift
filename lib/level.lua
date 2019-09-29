Level = Shift:extend()

local finishFlag
local finishTimer
local gotoMainScreenTimer
local keyTips
local player, destination

function Level:activate(playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	-- shift
	Level.super.activate(self)
	
	-- player and destination
	player = Player(playerX, playerY, playerZ)
	destination = Destination(destinationX, destinationY, destinationZ)

	-- shapeList
	self.shapeList = {}
	table.insert(self.shapeList, destination)
	
	-- drawList
	self.drawList = {}
	table.insert(self.drawList, player)
	table.insert(self.drawList, destination)

	-- tipsList
	self.tipsList = {}
	
	-- finishLevelTimer
	finishFlag = false
	finishTimer = 0
	gotoMainScreenTimer = 0

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
	local canShift = (self.shiftMode~=1 or player:isOnGround()) and (not finishFlag) and (not keyTips:getShowFlag())
	Level.super.update(self, dt, canShift)
	
	-- keyTips
	keyTips:update()

	-- some key staff
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
		player:update(dt, self.shiftMode, self.shapeList)
	end
	
	-- goto next level
	if finishFlag and base.isPressed(base.keys.enter) then
		levelChoice = levelChoice + 1
		local levelName = levelString[levelChoice]
		self.screen:view(levelName)
	end

	-- shape update
	for i = 1, #self.shapeList do
		-- turret
		if self.shapeList[i]:is(Turret) then
			-- turn on/off
			self.shapeList[i]:update(dt, self.shiftMode)
			-- hit player
			if self.shiftMode == 0 and self.shapeList[i].turnOn and self.shapeList[i]:hit(player) and not finishFlag then
				self:playerDead()
			end
			
			-- ball block laser
			local ballList = {}
			for i = 1, #self.shapeList do
				if self.shapeList[i]:is(Ball) then
					table.insert(ballList, self.shapeList[i])
				end
			end
			self.shapeList[i]:block(ballList)

		-- Ball
		elseif self.shapeList[i]:is(Ball) then
			self.shapeList[i]:update(dt, self.shiftMode, self.shapeList)

			-- hit player
			if self.shiftMode == 1 and self.shapeList[i]:hit(player) and not finishFlag then
				self:playerDead()
			end
		-- FourD
		elseif self.shapeList[i]:is(FourD) then
			self.shapeList[i]:update(self.shiftMode)
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
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].z > self.drawList[j].z then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	elseif self.shiftMode == 1 then
		-- sort by y
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].y < self.drawList[j].y then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	-- shifting, by z, then by y
	else
		-- sort by z
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].z > self.drawList[j].z then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
		-- sort by y
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].z == self.drawList[j].z and self.drawList[k].y < self.drawList[j].y then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	end
	---
end


function Level:draw()
	-- draw BG
	love.graphics.setColor(base.cBlack)
	love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)

	-- draw all obj in drawList
	if self.drawList ~= nil then
		for key, value in pairs(self.drawList) do
			value:draw(self.shiftMode)
		end
	end

	-- draw tips
	if self.tipsList ~= nil then
		for i = 1, #self.tipsList do
			self.tipsList[i]:draw(self.shiftMode)
		end
	end

	-- draw levelName
	love.graphics.setColor(base.cWhite)
	base.print(self.levelName, base.guiBorder, base.guiHeight, "left", "bottom")
	
	-- draw keyTips text
	love.graphics.setColor(base.cDarkGray)
	base.print(lang.ui_key_keyTips, base.guiWidth-base.guiBorder, base.guiHeight, "right", "bottom")

	-- bgmManager
	bgmManager:draw()

	-- draw stuck warning
	if self.shiftMode == 0 and player.stuck then
		love.graphics.setColor(base.cWhite)
		base.print(lang.ui_player_stuck, base.guiWidth/2, base.guiHeight/2, "center", "center")
	end

	-- draw keyTips
	keyTips:draw()

	-- draw finishLevel
	if finishFlag then
		love.graphics.setColor(0,0,0, 0.75)
		love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)
		love.graphics.setColor(base.cWhite)
		base.print(lang.ui_level_finish, base.guiWidth/2, base.guiHeight/3, "center", "center")
		base.print(lang.ui_pressed_A_to_continue, base.guiWidth/2, base.guiHeight/3*2, "center", "center")
	end
end


-- add shapeList
function Level:addShapeList(obj, ...)
	table.insert(self.shapeList, obj(...))
	-- add to drawList
	table.insert(self.drawList, self.shapeList[#self.shapeList])
end


-- add tipsList
function Level:addTipsList(...)
	table.insert(self.tipsList, Tips(...))
end

function Level:playerDead()
	-- sfx
	sfx_restart:seek(0.15)
	love.audio.play(sfx_restart)
	-- reset
	self.screen:view(resetLevelString)
end