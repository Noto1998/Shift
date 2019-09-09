Player = Object:extend()

local len = 25
local spdMoveXY = 100
local spdMoveXZ = math.pi/2.5
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

-- xy
local function moveXY()
	-- move
	if love.keyboard.isDown(keys.DPad_left) then
		spdX = -spdMoveXY
	elseif love.keyboard.isDown(keys.DPad_right) then
		spdX = spdMoveXY
	else
		spdX = 0
	end
	if love.keyboard.isDown(keys.DPad_up) then
		spdY = -spdMoveXY
	elseif love.keyboard.isDown(keys.DPad_down) then
		spdY = spdMoveXY
	else
		spdY = 0
	end
	if math.abs(spdX) > 0 and math.abs(spdY) > 0 then	-- 45
		spdX = spdMoveXY / math.sqrt(2) * base.sign(spdX)
		spdY = spdMoveXY / math.sqrt(2) * base.sign(spdY)
	end
end
local function isCollisionXY(self, obj)
	local flag = false
	-- Rectangle
	if obj:is(Rectangle) or obj:is(Cuboid) then
		if self.y <= obj.y + obj.lenY and self.y + self.lenY >= obj.y
		and self.x-self.lenX <= obj.x + obj.lenX and self.x + self.lenX >= obj.x then
			flag = true
		end
	-- Circle
	elseif obj:is(Circle) then
	else
		-- other
	end
	return flag
end
local function collisionXY(self, dt, obj)
	-- Rectangle
	if obj:is(Rectangle) or obj:is(Cuboid) then
		local tableX = {obj.x, obj.x+obj.lenX}
		local tableY = {obj.y, obj.y+obj.lenY}
		-- x
		if self.y+self.lenY > obj.y and self.y-self.lenY < obj.y+obj.lenY then
			-- check how far between x and the line
			for key, xValue in pairs(tableX) do
				local disX = math.abs(self.x - xValue)
				local signX = base.sign(self.x - xValue)
				local disMin = self.lenX
				-- stuck
				if disX + 1 < disMin then
					self.stuck = true
					spdY = 0
					spdX = 0
				-- push
				elseif math.abs(disX * signX + spdX * dt) < disMin then
					self.x = xValue + disMin * signX-- left or right
					spdX = 0
				end
			end
		end
		-- y
		if self.x+self.lenX > obj.x and self.x-self.lenX < obj.x+obj.lenX then
			-- check how far between x and the line
			for key, yValue in pairs(tableY) do
				local disY = math.abs(self.y - yValue)
				local signY = base.sign(self.y - yValue)
				local disMin = self.lenY
				-- stuck
				if disY + 1 < disMin then
					self.stuck = true
					spdY = 0
					spdX = 0
				-- push
				elseif math.abs(disY * signY + spdY * dt) < disMin then
					self.y = yValue + disMin * signY
					spdY = 0
				end
			end
		end
	-- Circle
	elseif obj:is(Circle) then
	
	else
		-- other
	end
end
local function collisionXY_Circle(self, dt, obj) -- old, when player is Circle
	--[[
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
	]]
end
-- xz
local function isCollisionXZ(self, i, table)
	local flag = false
	--
	for key, obj in pairs(table) do
		if obj:is(Cuboid) then
			if	endPoint[i].x >= obj.x -1
			and endPoint[i].x <= obj.x + obj.lenX +1
			and endPoint[i].z >= obj.z -1
			and endPoint[i].z <= obj.z + obj.lenZ +1 then
				flag = true
			end
		elseif obj:is(Rectangle) then
			local a = obj.lenZ/obj.lenX 
			local dx = endPoint[i].x - obj.x
			local dz = a * dx
			local centerX = obj.x + obj.lenX/2--left
			local centerZ = obj.z - obj.lenZ/2--bottom
			
			local _z
			-- check in a rectangle
			if 	math.abs(endPoint[i].x - centerX) < obj.lenX/2
			and math.abs(endPoint[i].z - centerZ) < obj.lenZ/2 then
				--
				if obj.dir < math.pi/2 then
					_z = obj.z - obj.lenZ
			    else
        			_z = obj.z
				end
				--
				if math.abs((_z + dz) - endPoint[i].z) <= 1 then
					flag = true
				end
			end
		elseif obj:is(Circle) then
			--
		end	
		-- jump
		if flag then
			break
		end
	end

	return flag
end
local function setDir(dir, dt, sign)
	local spdDir = spdMoveXZ
	dir = dir + sign * spdDir * dt
	-- allways positive
	if dir >= math.pi*2 then
		dir = 0
	elseif dir < 0 then
		dir = math.pi*2 - math.abs(dir)
	end
	return dir
end
local function getLenXZ(string)
	local _dir = math.pi/2 - dir
	local lenX = math.floor(math.cos(_dir) * len)
	local lenZ = math.floor(math.sin(_dir) * len)
	if string == "x" then
		return lenX
	elseif string == "z" then
		return lenZ
	end
end
local function updateXZ(self, lockPoint)
	local sign = 0
	local lenX = getLenXZ("x")
	local lenZ = getLenXZ("z")
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
	local lenX = getLenXZ("x")
	local lenZ = getLenXZ("z")
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
local function endPointSetting(self, dt, num)
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
	self.x = x -- center
	self.y = y -- center
	self.z = z
	self.lenX = len --half
	self.lenY = len	--half
	self.cFill = cFill
	self.cLine = base.cLine
	spdX = 0
	spdY = 0
	spdZ = 0
	self.stuck = false
	-- endPoint
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
	-- xy
	if mode == 0 then
		moveXY()
		-- collision
		self.stuck = false
		for key, obj in pairs(shapelist) do
			collisionXY(self, dt, obj)
		end
	-- xz
	elseif mode == 1 then
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
			endPointSetting(self, dt, 1)
		-- endPoint 2 onGround
		elseif endPoint[2].onGround then
			endPointSetting(self, dt, 2)
		-- both not onGround
		else
			lock = false
			-- Player can't control
			-- garvity
			spdZ = spdGarvity
		end
	else
		-- shifting
		spdX = 0
		spdY = 0
		spdZ = 0
	end
	-- update spdMoveXY and fix pixel
	self.x = self.x + math.floor(math.abs(spdX * dt)) * base.sign(spdX)
	self.y = self.y + math.floor(math.abs(spdY * dt)) * base.sign(spdY)
	self.z = self.z + math.floor(math.abs(spdZ * dt)) * base.sign(spdZ)
	-- update endPoint
	updateEndPoint(self)
	-- update LenX
	self.lenX = math.abs(endPoint[1].x - self.x)
end


function Player:draw(mode)
	if mode == 1 then
		-- draw endPoint
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
		-- polygon
		local table = {
				endPoint[1].x, self.y-self.lenY + (-(self.y-self.lenY) + endPoint[1].z) * mode,--
				endPoint[2].x, self.y-self.lenY + (-(self.y-self.lenY) + endPoint[2].z) * mode,
				endPoint[2].x, self.y+self.lenY + (-(self.y+self.lenY) + endPoint[2].z) * mode,--
				endPoint[1].x, self.y+self.lenY + (-(self.y+self.lenY) + endPoint[1].z) * mode,
			}
		love.graphics.setColor(self.cFill)
		love.graphics.polygon("fill", table)
		love.graphics.setColor(self.cLine)
		love.graphics.polygon("line", table)
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
		flag = isCollisionXY(self, destination)
	elseif mode == 1 then
		-- any endPoint 
		for i = 1, 2 do
			local p = endPoint[i]
			if p.x >= destination.x
			and
			p.x <= destination.x + destination.lenX
			and
			p.z >= destination.z
			and
			p.z <= destination.z + destination.lenZ then
				flag = true
				break
			end
		end
	end
    return flag
end