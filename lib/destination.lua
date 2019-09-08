Destination = Cuboid:extend()

local len = 50

function Destination:new(x, y, z)
    local cFill = {0.5, 1, 0.5}
    local cLine = base.cWhite
    local cMesh = {0, 0, 0, 0}
    Destination.super.new(self, x, y, z, len, len, len, cFill, cLine, cMesh)
end