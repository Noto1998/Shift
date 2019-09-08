Cuboid = Shape:extend()--Rectangle

function Cuboid:new(x, y, z, lenX, lenY, lenZ, cFill, cLine, cMesh)
    Cuboid.super.new(self, x, y, z, cFill, cLine, cMesh)
    self.lenX = lenX
    self.lenY = lenY
    self.lenZ = lenZ
end

function Cuboid:draw(mode)
    local _dir = math.pi/2
    -- 0
    local _y = self.y
    local _lenY = self.lenY
    local _z = self.z
    local re1 = Rectangle(self.x, _y, _z, self.lenX, _lenY, _dir, self.cFill, self.cLine, self.cMesh)
    re1:draw(mode)
    -- 1
    _y = self.z
    _lenY = self.lenZ
    _z = self.y + self.lenY
    re1 = Rectangle(self.x, _y, _z, self.lenX, _lenY, _dir, self.cFill, self.cLine, self.cMesh)
    re1:draw(1 - mode)

    re1 = nil--release
end