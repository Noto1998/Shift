Rectangle = Object:extend()

function Rectangle:new(x, y, z, lenX, lenY, cFill, cLine)
    self.x = x
    self.y = y
    self.z = z
    self.lenX = lenX
    self.lenY = lenY
    self.cFill = base.cFill
	if cFill ~= nil then
		self.cFill =  cFill
	end
	self.cLine = base.cLine
	if cLine ~= nil then
		self.cLine = cLine
	end
end

function Rectangle:draw(mode)
    -- mode from 0 to 1
    if mode == 0 then
        love.graphics.setColor(self.cFill)
        love.graphics.rectangle("fill", self.x, self.y, self.lenX, self.lenY)
        love.graphics.setColor(self.cLine)
        love.graphics.rectangle("line", self.x, self.y, self.lenX, self.lenY)
    elseif mode == 1 then
        love.graphics.setColor(self.cLine)
        love.graphics.line(self.x, self.z, self.x + self.lenX, self.z)
    else
        local _x = self.x
        local _width = self.lenX
        local _y1 = self.y + (-self.y+self.z) * mode
        local _lenY = self.lenY * (1 - mode)

        love.graphics.setColor(self.cFill)
        love.graphics.rectangle("fill", _x, _y1, _width, _lenY)
        love.graphics.setColor(self.cLine)
        love.graphics.rectangle("line", _x, _y1, _width, _lenY)
    end
end