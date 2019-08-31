Player = Circle:extend()

local spd = 100
local r = 30
local spdX
local spdY
local spdZ
local cFill = {base.cFill[1], base.cFill[2], base.cFill[3], 0.5}--alpha

local function isColisionXY(self, obj)
	local flag = false
	-- ignore player self
	if obj ~= nil and not obj:is(Player) then
		if obj:is(Rectangle) then
			local oLeft = obj.x
			local oRight = obj.x + obj.lenX
			local oTop = obj.y
			local oBottom = obj.y + obj.lenY

			local sLeft = self.x - self.radius
			local sRight = self.x + self.radius
			local sTop = self.y - self.radius
			local sBottom = self.y + self.radius
			
			-- using Rectangle collision
			if sRight > oLeft and sLeft < oRight and sTop < oBottom and sBottom > oTop then
				if (self.x > oLeft and self.x < oRight) or (self.y < oBottom and self.y > oTop) then
					flag = true
				else
					--from player's center shot a line to four corners
					local oTableX = {oLeft, oRight}
					local oTableY = {oBottom, oTop}
					for key, corX in pairs(oTableX) do
						for key, corY in pairs(oTableY) do
							local disX = math.abs(self.x - corX)
							local disY = math.abs(self.y - corY)
							local dis = math.floor( math.sqrt(math.pow(disX, 2) + math.pow(disY, 2)) )

							flag = dis < self.radius
							if flag then
								break -- jump
							end
						end
					end
				end
			end
		elseif obj:is(Circle) then
			local disX = math.abs(obj.x - self.x)
			local disY = math.abs(obj.y - self.y)
			local dis = math.floor( math.sqrt(math.pow(disX, 2) + math.pow(disY, 2)) )
			
			flag = self.radius + obj.radius >= dis
		end
	end
	return flag
end

local function limit(self, dt, x, y, lenX, lenY)
	local tableX = {x, x+lenX}
	local tableY = {y, y+lenY}
	-- x -- check self.y is between y and x+lenY
	if ((self.y+self.radius > y) and (self.y-self.radius < y+lenY)) then
		for key, xValue in pairs(tableX) do
			local signX = base.sign(self.x - xValue)-- left or right
			-- stuck
			if math.abs(self.x-xValue)+1 < self.radius then
				self.stuck = true
				spdY = 0
				spdX = 0
			-- psuh
			elseif math.abs(self.x-xValue + spdX*dt) < self.radius then
				self.x = xValue + self.radius*signX
				spdX = 0
			end
		end
	end
	-- y -- check self.x is between x and x+lenX
	if ((self.x+self.radius > x) and (self.x-self.radius-1 < x+lenX)) then
		for key, yValue in pairs(tableY) do
			local signY = base.sign(self.y - yValue)-- up or down
			-- stuck
			if math.abs(self.y-yValue)+1 < self.radius then
				self.stuck = true
				spdY = 0
				spdX = 0
			-- psuh
			elseif math.abs(self.y-yValue + spdY*dt) < self.radius then
				self.y = yValue + self.radius*signY
				spdY = 0
			end
		end
	end
end

function Player:new(x, y, z)
    Player.super.new(self, x, y, z, r, cFill)
	spdX = 0
	spdY = 0
	spdZ = 0
	self.stuck = false
end

function Player:update(dt, mode, list)
	if mode == 0 then	-- xy
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
		-- limit in rectangle
		self.stuck = false
		limit(self, dt, 0, 0, base.guiWidth, base.guiHeight)
		
		if list ~= nil then
			for key, obj in pairs(list) do
				if obj:is(Rectangle) then
					limit(self, dt, obj.x, obj.y, obj.lenX, obj.lenY)
				end
			end
		end
	elseif mode == 1 then	-- xz
		-- test
		if love.keyboard.isDown(keys.DPad_left) then
			spdX = -spd
		elseif love.keyboard.isDown(keys.DPad_right) then
			spdX = spd
		else
			spdX = 0
		end
		if love.keyboard.isDown(keys.DPad_up) then
			spdZ = -spd
		elseif love.keyboard.isDown(keys.DPad_down) then
			spdZ = spd
		else
			spdZ = 0
		end
	else
		-- shifting
		spdX = 0
		spdY = 0
		spdZ = 0
	end
	-- update spd
	self.x = self.x + spdX * dt
	self.y = self.y + spdY * dt
	self.z = self.z + spdZ * dt
end

function Player:draw(mode)
	Player.super.draw(self, mode)
	-- draw stuck warning
	if self.stuck then
		love.graphics.setColor(1,1,1)
		lovePrint("player stuck", base.guiWidth/2, base.guiHeight, "center", "bottom")
	end
end