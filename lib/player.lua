Player = Circle:extend()

local spd = 100
local r = 30
local spdX
local spdY

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
	local xMin = x + self.radius
	local yMin = y + self.radius

	local xMax = x+lenX - self.radius
	local yMax = y+lenY - self.radius


	if self.x+spdX*dt < xMin then
		self.x = xMin
		spdX = 0
	elseif self.x+spdX*dt > xMax then
		self.x = xMax
		spdX = 0
	end
	if self.y+spdY*dt < yMin then
		self.y = yMin
		spdY = 0
	elseif self.y+spdY*dt > yMax then
		self.y = yMax
		spdY = 0
	end
end

function Player:new(x, y, z)
    Player.super.new(self, x, y, z, r)
	spdX = 0
	spdY = 0
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
		--[[ collision
		if list ~= nil then
			for key, obj in pairs(list) do
				if isColisionXY(self, obj) then
					if spdX ~= 0 then
						self.x = self.x + (spdX / math.abs(spdX)) *dt
						spdX = 0
					end
					if spdY ~= 0 then
						self.y = self.y + (spdY / math.abs(spdY)) *dt
						spdY = 0
					end
				end
			end
		end
		]]
		-- limit in screen
		limit(self, dt, 0, 0, base.guiWidth, base.guiHeight)
	elseif mode == 1 then	-- xz

	else
		spdX = 0
		spdY = 0
	end

	-- update spd
	self.x = self.x + spdX * dt
	self.y = self.y + spdY * dt

	
end

