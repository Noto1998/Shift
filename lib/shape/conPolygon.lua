ConPolygon = Shape:extend()

function ConPolygon:new(x, y, z, num, cFill, cLine, cMesh)
    ConPolygon.super.new(self, x, y, z, cFill, cLine, cMesh)

    self.num = num
end


function ConPolygon:draw(mode)
    -- draw self
    local _x = self.x
    local _y = self.y*(1-mode)+self.z*mode
    local borderX = 25
    local lenX = 50
    local dir = 0
    local table = {}
    --[[
    local table = {
        _x+base.dirGetXY(dir, lenX, 0),                 _y+base.dirGetXY(dir, lenX, 1),
        _x+base.dirGetXY(dir+math.pi/4, borderX, 0),    _y+base.dirGetXY(dir+math.pi/4, borderX, 1),
        _x+base.dirGetXY(dir+math.pi/2, lenX, 0),       _y+base.dirGetXY(dir+math.pi/2, lenX, 1),
        _x+base.dirGetXY(dir+math.pi/4*3, borderX, 0),  _y+base.dirGetXY(dir+math.pi/4*3, borderX, 1),
        _x+base.dirGetXY(dir+math.pi, lenX, 0),         _y+base.dirGetXY(dir+math.pi, lenX, 1),
        _x+base.dirGetXY(dir+math.pi/4*5, borderX, 0),  _y+base.dirGetXY(dir+math.pi/4*5, borderX, 1),
        _x+base.dirGetXY(dir+math.pi/2*3, lenX, 0),     _y+base.dirGetXY(dir+math.pi/2*3, lenX, 1),
        _x+base.dirGetXY(dir+math.pi/4*7, borderX, 0),  _y+base.dirGetXY(dir+math.pi/4*7, borderX, 1),
    }
    ]]
    local _dir = math.pi*2/self.num
    for i = 1, self.num do
        table[(i-1)*4+1] = _x+base.dirGetXY(dir+_dir*(i-1), lenX, 0)
        table[(i-1)*4+2] = _y+base.dirGetXY(dir+_dir*(i-1), lenX, 1)
        table[(i-1)*4+3] = _x+base.dirGetXY(dir+_dir*(i-1)+_dir/2, borderX, 0)
        table[(i-1)*4+4] = _y+base.dirGetXY(dir+_dir*(i-1)+_dir/2, borderX, 1)
    end

    love.graphics.setColor(self.cFill)
    local triList = love.math.triangulate(table)
    for key, triTable in pairs(triList) do
        love.graphics.polygon("fill", triTable)
    end
    
    love.graphics.setColor(self.cLine)
    love.graphics.polygon("line", table)
end