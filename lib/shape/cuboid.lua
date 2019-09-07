Cuboid = Rectangle:extend()--Rectangle

function Cuboid:new(x, y, z, lenX, lenY, lenZ, cFill, cLine, cBG)
    Cuboid.super.new(self, x, y, z, lenX, lenY, math.pi/2, cFill, cLine, cBG)
    self.lenZ = lenZ

    -- 0
    local _y = self.y
    local _lenY = self.lenY
    local _z = self.z
    self.re1 = Rectangle(self.x, _y, _z, self.lenX, _lenY, math.pi/2, self.cFill, self.cLine, self.cBG)
    -- 1
    _y = self.z
    _lenY = self.lenZ
    _z = self.y + self.lenY
    self.re2 = Rectangle(self.x, _y, _z, self.lenX, _lenY, math.pi/2, self.cFill, self.cLine, self.cBG)
end

function Cuboid:draw(mode)
    self.re1:draw(mode)
    self.re2:draw(1 - mode)
end