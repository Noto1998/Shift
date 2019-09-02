Player = Circle:extend()

local spd = 100
local r = 30
local spdX
local spdY
local spdZ
local cFill = {base.cFill[1], base.cFill[2], base.cFill[3], 0.5}--alpha

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
		-- collision
		self.stuck = false
		for key, obj in pairs(list) do
			if obj ~= nil and not obj:is(Player) then
				collisionXY(self, dt, obj)
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

		-- 
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
end

function Player:draw(mode)
	Player.super.draw(self, mode)
	-- draw stuck warning
	if mode == 0 and self.stuck then
		love.graphics.setColor(1,1,1)
		base.print("player stuck", base.guiWidth/2, base.guiHeight, "center", "bottom")
	end
	--[DEBUG] draw location
	if debugMode then
		base.print(player.x..","..player.y..","..player.z, base.guiWidth/2)
	end
end