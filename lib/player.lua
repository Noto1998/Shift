Player = Circle:extend()

local spd = 100
local radius = 30
local spdX
local spdY
local spdZ
local cFill = {0.5, 0.5, 0.5, 0.5}--test
---endPoint
local dir
local lockPoint
local lockPointX
local lockPointZ
local lock
local spdGarvity = 100
local endPoint = {}
for i = 1, 2 do
	endPoint[i] = {}
end

local function moveXY()
	-- move
	if love.keyboard.isDown(keys.DPad_left) then
		spdX = -spd
	elseif love.keyboard.isDown(keys.DPad_right) then
		spdX = spd
	else
		spdX = 0
	end
	if love.keyboard.isDown(keys.DPad_up) then
		spdY = -spd
	elseif love.keyboard.isDown(keys.DPad_down) then
		spdY = spd
	else
		spdY = 0
	end
	if math.abs(spdX) > 0 and math.abs(spdY) > 0 then	-- 45
		spdX = spd / math.sqrt(2) * base.sign(spdX)
		spdY = spd / math.sqrt(2) * base.sign(spdY)
	end
end

local function collisionXY(self, dt, obj)
	-- Rectangle
	if obj:is(Rectangle) then
		local tableX = {obj.x, obj.x+obj.lenX}
		local tableY = {obj.y, obj.y+obj.lenY}
		-- x
		if ((self.y+self.radius > obj.y) and (self.y-self.radius < obj.y+obj.lenY)) then
			-- dis from y to rectangle's center y
			local centerY = obj.y+obj.lenY/2
			local shortLineY = math.abs(self.y - centerY) - obj.lenY/2
			local longLineX = self.radius
			if shortLineY > 0 then
				longLineX = math.sqrt( math.pow(self.radius, 2) - math.pow(shortLineY,2) )
			end
			-- check how far between x and the line
			for key, xValue in pairs(tableX) do
				local disX = math.abs(self.x - xValue)
				local signX = base.sign(self.x - xValue)
				-- stuck
				if disX + 1 < longLineX then
					self.stuck = true
					spdY = 0
					spdX = 0
				-- psuh
				elseif math.abs(disX*signX + spdX * dt) < longLineX then
					self.x = xValue + math.ceil(longLineX) * signX-- left or right
					spdX = 0
				end
			end
		end
		-- y -- some as x
		if ((self.x+self.radius > obj.x) and (self.x-self.radius-1 < obj.x+obj.lenX)) then
			--
			local centerX = obj.x+obj.lenX/2
			local shortLineX = math.abs(self.x - centerX) - obj.lenX/2
			local longLineY = self.radius
			if shortLineX > 0 then
				longLineY = math.sqrt( math.pow(self.radius, 2) - math.pow(shortLineX,2) )
			end
			--
			for key, yValue in pairs(tableY) do
				local disY = math.abs(self.y - yValue)
				local signY = base.sign(self.y - yValue)-- up or down
				-- stuck
				if disY + 1 < longLineY then
					self.stuck = true
					spdY = 0
					spdX = 0
				-- psuh
				elseif math.abs(disY * signY + spdY * dt) < longLineY then
					self.y = yValue + math.ceil(longLineY) * signY
					spdY = 0
				end
			end
		end
	-- Circle
	elseif obj:is(Circle) then
		local disMin = self.radius + obj.radius

		local disX = math.abs(self.x - obj.x)
		local disY = math.abs(self.y - obj.y)
		local signX = base.sign(self.x - obj.x)
		local signY = base.sign(self.y - obj.y)
		--local dis = math.sqrt( math.pow(disX, 2) + math.pow(disY, 2) )
		-- same as Rectangle
		if disY < disMin then
			local shortLineY = disY
			local longLineX = disMin
			if shortLineY > 0 then
				longLineX = math.sqrt( math.pow(disMin, 2) - math.pow(shortLineY, 2) )
			end
			-- stuck
			if disX + 1 < longLineX then
				self.stuck = true
				spdY = 0
				spdX = 0
			-- psuh
			elseif math.abs(disX*signX + spdX*dt) < longLineX then
					self.x = obj.x + math.ceil(longLineX) * signX
					spdX = 0		
			end
		end
		if disX < disMin then
			local shortLineX = disX
			local longLineY = disMin
			--
			if shortLineX > 0 then
				longLineY = math.sqrt( math.pow(disMin, 2) - math.pow(shortLineX, 2) )
			end
			-- stuck
			if disY + 1 < longLineY then
				self.stuck = true
				spdY = 0
				spdX = 0
			-- psuh
			elseif math.abs(disY*signY + spdY*dt) < longLineY then
				self.y = obj.y + math.ceil(longLineY) * signY
				spdY = 0		
			end
		end
	else
		-- other
	end
end

local function isCollisionXZ(self, i, table)
	local flag = false
	local x = endPoint[i].x
	local z = endPoint[i].z
	local signX = base.sign(x - self.x)
	local checkNum = 1-- not work well
	local lenX = math.abs(x - self.x) / checkNum
	local signZ = base.sign(z - self.z)
	local lenZ = math.abs(z - self.z) / checkNum
	for key, obj in pairs(table) do
		if obj:is(Cuboid) then
			x = endPoint[i].x
			z = endPoint[i].z
			for i = 1, checkNum do
				if x >= obj.x and x <= obj.x + obj.lenX then
					if z >= obj.z and z <= obj.z + obj.lenZ then
						flag = true
						break;
					end
				end
				x = x - signX * lenX
				z = z - signZ * lenZ
			end
			if flag then
				break;
			end
		elseif obj:is(Circle) then
			---
		end	
	end

	return flag
end

local function setDir(dir, dt, sign)
	local spdDir = (math.pi/3)
	dir = dir + sign * spdDir * dt
	if dir >= math.pi*2 then
		dir = 0
	elseif dir < 0 then
		dir = math.pi*2 - math.abs(dir)
	end
	return dir
end

local function getLenXZ(self, string)
	local _dir = math.pi/2 - dir
	local lenX = math.floor(math.cos(_dir) * self.radius)
	local lenZ = math.floor(math.sin(_dir) * self.radius)
	if string == "x" then
		return lenX
	elseif string == "z" then
		return lenZ
	end
end

local function updateXZ(self, lockPoint)
	local sign = 0
	local lenX = getLenXZ(self, "x")
	local lenZ = getLenXZ(self, "z")
	if lockPoint == 1 then
		sign = 1
	elseif lockPoint == 2 then
		sign = -1
	end
	 -- update self.x/z
	self.x = lockPointX + sign * lenX
	self.z = lockPointZ + sign * lenZ
end

local function updateEndPoint(self)
	local lenX = getLenXZ(self, "x")
	local lenZ = getLenXZ(self, "z")
	-- update endPoint
	endPoint[1].x = self.x - lenX
	endPoint[1].z = self.z - lenZ
	endPoint[2].x = self.x + lenX
	endPoint[2].z = self.z + lenZ
end

local function setLockPointXZ(lockPoint)
	lockPointX = endPoint[lockPoint].x
	lockPointZ = endPoint[lockPoint].z
end

local function getOtherEndPointNum(num)
	if num == 2 then
		return 1
	elseif num == 1 then
		return 2
	end
end

local function keyPressedLock(self, dt)
	if love.keyboard.isDown(keys.DPad_left) then
		dir = setDir(dir, dt, 1)
		updateXZ(self, lockPoint)
	elseif love.keyboard.isDown(keys.DPad_right) then
		dir = setDir(dir, dt, -1)
		updateXZ(self, lockPoint)
	else
		lock = false
	end
end

local function oneEndPointSetting(self, dt, num)
	-- setLockPointXZ
	if not lock then
		lockPoint = num
		setLockPointXZ(lockPoint)
		lock = true
	end
	-- Player control
	if love.keyboard.isDown(keys.DPad_left) or love.keyboard.isDown(keys.DPad_right) then
		keyPressedLock(self, dt)
	-- garvity
	else
		local sign
		if endPoint[num].x > endPoint[getOtherEndPointNum(num)].x then
			sign = 1
		else
			sign = -1
		end
		dir = setDir(dir, dt, sign)
		if dir < (math.pi/3) * dt then
			dir = 0
		end
		updateXZ(self, lockPoint)
	end
end

function Player:new(x, y, z)
    Player.super.new(self, x, y, z, radius, cFill)
	spdX = 0
	spdY = 0
	spdZ = 0
	self.stuck = false
	for i = 1, 2 do
		endPoint[i].x = 0
		endPoint[i].y = 0
		endPoint[i].onGround = false
	end
	dir = math.pi/2
	lockPoint = 0
	lockPointX = 0
	lockPointZ = 0
	lock = false
	updateEndPoint(self)
end

function Player:update(dt, mode, shapelist)
	if mode == 0 then	-- xy
		moveXY()
		-- collision
		self.stuck = false
		for key, obj in pairs(shapelist) do
				collisionXY(self, dt, obj)
		end
	elseif mode == 1 then	-- xz
		-- test --
		spdZ = 0
		-- onGround
		for i = 1, 2 do
			endPoint[i].onGround = isCollisionXZ(self, i, shapelist)
		end
		-- both onGround
		if endPoint[1].onGround and endPoint[2].onGround then
			lock = false
			-- setLockPointXZ
			if not lock then
				-- get the most right endPoint
				local rightPoint = 1
				for i, value in ipairs(endPoint) do
					if value.x > endPoint[rightPoint].x then
						rightPoint = i
					end
				end
				if love.keyboard.isDown(keys.DPad_left) then
					-- take the left
					lockPoint = getOtherEndPointNum(rightPoint)
					setLockPointXZ(lockPoint)
					lock = true
				elseif love.keyboard.isDown(keys.DPad_right) then
					-- take the right
					lockPoint = rightPoint
					setLockPointXZ(lockPoint)
					lock = true
				end
			end
			-- Player control
			keyPressedLock(self, dt)
		-- endPoint 1 onGround
		elseif endPoint[1].onGround then
			oneEndPointSetting(self, dt, 1)
		-- endPoint 2 onGround
		elseif endPoint[2].onGround then
			oneEndPointSetting(self, dt, 2)
		-- both not onGround
		else
			lock = false
			-- Player can control
			-- garvity
			spdZ = spdGarvity
		end
	else
		-- shifting
		spdX = 0
		spdY = 0
		spdZ = 0
	end
	-- update spd and fix pixel
	self.x = self.x + math.floor(math.abs(spdX * dt)) * base.sign(spdX)
	self.y = self.y + math.floor(math.abs(spdY * dt)) * base.sign(spdY)
	self.z = self.z + math.floor(math.abs(spdZ * dt)) * base.sign(spdZ)
	-- update endPoint
	updateEndPoint(self)
end

function Player:draw(mode)
	if mode == 0 then
		love.graphics.setColor(self.cFill)
		love.graphics.circle("fill" , self.x, self.y, self.radius)
		love.graphics.setColor(self.cLine)
		love.graphics.circle("line" , self.x, self.y, self.radius)
	elseif mode == 1 then
		-- draw line
		love.graphics.setColor(self.cLine)
		love.graphics.line(endPoint[1].x, endPoint[1].z, endPoint[2].x, endPoint[2].z)
		local rPoint = 3
		for i = 1, 2 do
			local cPoint = {0.25, 0.25, 0.25}
			if endPoint[i].onGround then
				cPoint = {1, 1, 1}
			end
			love.graphics.setColor(cPoint)
			love.graphics.circle("fill", endPoint[i].x, endPoint[i].z, rPoint)
		end
	else
		local _x = self.x
		local _rX = self.radius
		local _rY = self.radius * (1 - mode)
		local _y = self.y + (-self.y+self.z) * mode
		
		love.graphics.setColor(self.cFill)
		love.graphics.ellipse("fill", _x, _y, _rX, _rY)
		love.graphics.setColor(self.cLine)
		love.graphics.ellipse("line", _x, _y, _rX, _rY)
	end
end

-- if one endPoint not onGround, can't shift
function Player:onGround(mode)
	local flag
	if mode ~= 1 then
		flag = true
	else
		if endPoint[1].onGround and endPoint[2].onGround then
			flag = true
		else
			flag = false
		end
	end
	return flag
end

-- player touch
function Player:touch(destination, mode)
    local flag = false
	if mode == 0 then
		local centerX = destination.x + destination.lenX/2
		local centerY = destination.y + destination.lenY/2
		local disMin = destination.lenX/2 + self.radius + 1
		local disX = math.abs(self.x - centerX)
		local disY = math.abs(self.y - centerY)
		local dis = math.sqrt(math.pow(disX, 2)+math.pow(disY, 2))
		if dis < disMin then
			flag = true
		end
	end
    return flag
end