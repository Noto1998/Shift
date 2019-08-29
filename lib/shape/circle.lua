Circle = Object:extend()

function Circle:new(x, y, z, radius)
    self.x = x--in center
    self.y = y
    self.z = z
    self.radius = radius
end

function Circle:draw(mode)
	-- mode from 0 to 1
	if mode == 0 then
		love.graphics.setColor(0,0,0,1)
		love.graphics.circle("fill" , self.x, self.y, self.radius)
		love.graphics.setColor(1,1,1,1)
		love.graphics.circle("line" , self.x, self.y, self.radius)
	elseif mode == 1 then
		love.graphics.setColor(1,1,1,1)
		love.graphics.line(self.x - self.radius, self.z, self.x + self.radius, self.z)
	else
		local _x = self.x
		local _rX = self.radius
		local _rY = self.radius * (1 - mode)
		local _y = self.y + (-self.y+self.z) * mode
		
		love.graphics.setColor(0,0,0,1)
		love.graphics.ellipse("fill", _x, _y, _rX, _rY)
		love.graphics.setColor(1,1,1,1)
		love.graphics.ellipse("line", _x, _y, _rX, _rY)
		love.graphics.setColor(0,0,0,1)
	end
end