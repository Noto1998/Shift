Cuboid = Rectangle:extend()

function Cuboid:new(x, y, z, lenX, lenY, lenZ, cFill, cLine)
    Cuboid.super.new(self, x, y, z, lenX, lenY, cFill, cLine)
    self.lenZ = lenZ
end

function Cuboid:draw(mode)
    -- mode from 0 to 1
    if mode == 0 then
        Cuboid.super.draw(self, mode)
    elseif mode == 1 then
        love.graphics.setColor(self.cFill)
        love.graphics.rectangle("fill", self.x, self.z, self.lenX, self.lenZ)
        love.graphics.setColor(self.cLine)
        love.graphics.rectangle("line", self.x, self.z, self.lenX, self.lenZ)
    else
        local re1 = Rectangle(self.x, self.y, self.z, self.lenX, self.lenY, self.cFill, self.cLine)
        re1.y = self.z
        re1.lenY = self.lenZ
        re1.z = self.y + self.lenY
        re1:draw(1 - mode)
        re1.y = self.y
        re1.lenY = self.lenY
        re1.z = self.z
        re1:draw(mode)
    end
end