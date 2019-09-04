Player = Circle:extend()

local spd = 100
local radius = 30
local spdX
local spdY
local spdZ
local cFill = {base.cFill[1], base.cFill[2], base.cFill[3], 0.5}--alpha
---test
local dir = math.pi/2
local lockPoint = 0
local lockPointX = 0
local lockPointZ = 0
local lock = false
local spdGarvity = 100
local point = {}
for i = 1, 2 do
	point[i] = {}
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
	local x = point[i].x
	local z = point[i].z
	local signX = base.sign(x - self.x)
	local checkNum = 1-- not work well
	local lenX = math.abs(x - self.x) / checkNum
	local signZ = base.sign(z - self.z)
	local lenZ = math.abs(z - self.z) / checkNum
	for key, obj in pairs(table) do
		if obj:is(Cuboid) then
			x = point[i].x
			z = point[i].z
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

local function updatePoint(self)
	local lenX = getLenXZ(self, "x")
	local lenZ = getLenXZ(self, "z")
	-- update point
	point[1].x = self.x - lenX
	point[1].z = self.z - lenZ
	point[2].x = self.x + lenX
	point[2].z = self.z + lenZ
end

local function setLockPointXZ(lockPoint)
	lockPointX = point[lockPoint].x
	lockPointZ = point[lockPoint].z
end

local function getOtherPointNum(num)
	if num == 2 then
		return 1
	elseif num == 1 then
		return 2
	end
end
local function otherPoint(num)-- not using --
	local _num = getOtherPointNum(num)
	return point[_num]
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

local function onePointSetting(self, dt, num)
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
		if point[num].x > point[getOtherPointNum(num)].x then
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
		point[i].onGround = false
	end
	updatePoint(self)
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
			point[i].onGround = isCollisionXZ(self, i, shapelist)
		end
		-- both onGround
		if point[1].onGround and point[2].onGround then
			lock = false
			-- setLockPointXZ
			if not lock then
				-- get the most right point
				local rightPoint = 1
				for i, value in ipairs(point) do
					if value.x > point[rightPoint].x then
						rightPoint = i
					end
				end
				if love.keyboard.isDown(keys.DPad_left) then
					-- take the left
					lockPoint = getOtherPointNum(rightPoint)
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
		-- point 1 onGround
		elseif point[1].onGround then
			onePointSetting(self, dt, 1)
		-- point 2 onGround
		elseif point[2].onGround then
			onePointSetting(self, dt, 2)
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
	-- update Point
	updatePoint(self)
end

function Player:draw(mode)
	
	if mode ~= 1 then
		Player.super.draw(self, mode)
	-- draw Point
	else
		love.graphics.setColor(1, 1, 1)
		love.graphics.line(point[1].x, point[1].z, point[2].x, point[2].z)
		local rPoint = 3
		for i = 1, 2 do
			local cPoint = {1, 0.1, 0.1}
			if point[i].onGround then
				cPoint = {0.1, 1, 0.1}
			end
			love.graphics.setColor(cPoint)
			love.graphics.circle("fill", point[i].x, point[i].z, rPoint)	
		end
	end

	-- draw stuck warning
	if mode == 0 and self.stuck then
		love.graphics.setColor(1,1,1)
		base.print("player stuck", base.guiWidth/2, base.guiHeight, "center", "bottom")
	end
	
	--[DEBUG] draw location
	if debugMode then
		love.graphics.setColor(1,1,1)
		base.print("debug:" .. player.x..","..player.y..","..player.z, 0, love.graphics.getFont():getHeight())
	end
end

-- if one point not onGround, can't shift
function Player:onGround(mode)
	local flag
	if mode ~= 1 then
		flag = true
	else
		if point[1].onGround and point[2].onGround then
			flag = true
		else
			flag = false
		end
	end
	return flag
end