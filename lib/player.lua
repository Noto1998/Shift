Player = Circle:extend()

local spd = 100
local r = 30

function Player:new(x, y, z)
    Player.super.new(self, x, y, z, r)
	spdX = 0
	spdY = 0
end

function Player:update(dt)
	-- x
	if love.keyboard.isDown(keys.DPad_left) then
		spdX = -spd
	elseif love.keyboard.isDown(keys.DPad_right) then
		spdX = spd
	else
		spdX = 0
	end
	-- y
	if love.keyboard.isDown(keys.DPad_up) then
		spdY = -spd
	elseif love.keyboard.isDown(keys.DPad_down) then
		spdY = spd
	else
		spdY = 0
	end
	
	-- move
	self.x = self.x + spdX * dt
	self.y = self.y + spdY * dt
end