Tips = Object:extend()

local radius = 8


function Tips:new(string, x, y, z, xMode, yMode)
    self.string = string
    self.x = 0
    if x ~= nil then
        self.x = x
    end
    self.y = 0
    if y ~= nil then
        self.y = y
    end
    self.z = 0
    if z ~= nil then
        self.z = z
    end
    self.xMode = xMode
    self.yMode = yMode
end


function Tips:draw(mode)
    local font = love.graphics.getFont()
    local fWidth = font:getWidth(self.string)
    local fHeight = font:getHeight()
    local reWidth = fWidth + radius*2
    local _y = self.y + (-self.y +self.z)*mode
    local _x = self.x
    
    -- center
    if self.xMode ~= nil then
        if self.xMode == "center" then
            _x = _x - reWidth/2
        elseif self.xMode == "right" then
            _x = _x - reWidth
        end
    end
    if self.yMode ~= nil then
        if self.yMode == "center" then
            _y = _y - fHeight/2
        elseif self.yMode == "bottom" then
            _y = _y - fHeight
        end
    end

    -- bg
    love.graphics.setColor(base.cWhite)
    local x1 = _x           +radius
    local y1 = _y           +radius
    local x2 = _x + reWidth -radius
    local y2 = _y + fHeight -radius
    local xyTable = {
        {x1, y1},
        {x2, y1},
        {x2, y2},
        {x1, y2}
    }
    local dirTable = {
        {-math.pi/2,    -math.pi},
        {-math.pi/2,    0},
        {0,             math.pi/2},
        {math.pi/2,     math.pi},
    }
    for i = 1, 4 do
        love.graphics.arc("fill", xyTable[i][1], xyTable[i][2], radius, dirTable[i][1], dirTable[i][2])
    end
    love.graphics.rectangle("fill", _x, y1, reWidth, fHeight-radius*2)
    love.graphics.rectangle("fill", x1, _y, reWidth-radius*2, fHeight)

    -- text
    love.graphics.setColor(base.cBlack)
    base.print(self.string, _x+reWidth/2, _y, "center")
end