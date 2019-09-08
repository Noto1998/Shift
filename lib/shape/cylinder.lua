Cylinder = Circle:extend()

function Cylinder:new(x, y, z, radius, height, cFill, cLine, cMesh)
    Cylinder.super.new(self, x, y, z, radius, cFill, cLine, cMesh)
    self.height = height
end

function Cylinder:draw(mode)
    -- mode from 0 to 1
	if mode == 0 then
        Cylinder.super.draw(self, mode)
	elseif mode == 1 then
		love.graphics.setColor(self.cFill)
		love.graphics.rectangle("fill", self.x - self.radius, self.z, self.radius*2, self.height)
		love.graphics.setColor(self.cLine)
        love.graphics.rectangle("line", self.x - self.radius, self.z, self.radius*2, self.height)
    else
        local _rX = self.radius
		local _rY = self.radius * (1 - mode)
        local _y1 = self.y + (-self.y+self.z) * mode
        local _y2 = self.y + (-self.y+self.z + self.height) * mode
        --
        local _z = self.z + self.height
        local c1 = Circle(self.x, self.y, _z, self.radius, self.cFill, self.cLine, self.cMesh)
        c1:draw(mode)
        --
        love.graphics.setColor(self.cFill)
        love.graphics.rectangle("fill", self.x - _rX, _y1, _rX*2, _y2 - _y1)
        --
        _z = self.z
        c1 = Circle(self.x, self.y, _z, self.radius, self.cFill, self.cLine, self.cMesh)
        c1:draw(mode)
        --
        love.graphics.setColor(self.cLine)
		love.graphics.line(self.x - _rX, _y1, self.x - _rX, _y2)
        love.graphics.line(self.x + _rX, _y1, self.x + _rX, _y2)
        -- release
        c1 = nil
	end
end