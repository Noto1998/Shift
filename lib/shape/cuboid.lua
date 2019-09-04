Cuboid = Rectangle:extend()

function Cuboid:new(x, y, z, lenX, lenY, lenZ, cFill, cLine, drawBG)
    Cuboid.super.new(self, x, y, z, lenX, lenY, cFill, cLine, drawBG)
    self.lenZ = lenZ
end

function Cuboid:draw(mode)
    -- mode from 0 to 1
        local re1 = Rectangle(self.x, self.y, self.z, self.lenX, self.lenY, self.cFill, self.cLine, self.cBG)
        re1.y = self.z
        re1.lenY = self.lenZ
        re1.z = self.y + self.lenY
        re1:draw(1 - mode)
        re1.y = self.y
        re1.lenY = self.lenY
        re1.z = self.z
        re1:draw(mode)
end