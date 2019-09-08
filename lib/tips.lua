Tips = Object:extend()

function Tips:new(x, y, z, string)
    self.x = x
    self.y = y
    self.z = z
    self.string = string
end

function Tips:draw(mode)
    local font = love.graphics.getFont()
    local fWidth = font:getWidth(self.string)
    local fHeight = font:getHeight()
    local reWidth = fWidth + 10
    local _y = self.y + (-self.y +self.z)*mode

    -- bg
    love.graphics.setColor(base.cWhite)
    local radius = 8
    local x1 = self.x   +radius
    local y1 = _y       +radius
    local x2 = self.x + reWidth -radius
    local y2 = _y + fHeight     -radius
    local xyTable = {
        {x1, y1},
        {x2, y1},
        {x2, y2},
        {x1, y2}
    }
    local dirTable = {
        {-math.pi/2, -math.pi},
        {-math.pi/2, 0},
        {0, math.pi/2},
        {math.pi/2, math.pi},
    }
    for i = 1, 4 do
        love.graphics.arc("fill", xyTable[i][1], xyTable[i][2], radius, dirTable[i][1], dirTable[i][2])
    end
    love.graphics.rectangle("fill", self.x, y1, reWidth, fHeight-radius*2)
    love.graphics.rectangle("fill", x1, _y, reWidth-radius*2, fHeight)


    -- text
    love.graphics.setColor(base.cBlack)
    base.print(self.string, self.x+reWidth/2, _y, "center")
end