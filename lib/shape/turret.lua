Turret = Shape:extend()

local radius = 10
local len = math.sqrt(math.pow(base.guiHeight, 2) + math.pow(base.guiWidth, 2)) + 1
local timeMax = 2-- second

function Turret:new(x, y, z, sx, sy, sz, cFill, cLine, cMesh)
    Turret.super.new(self, x, y, z, cFill, cLine, cMesh)
    -- 0~1
    self.sx = sx
    self.sy = sy
    self.sz = sz
    -- turn on/off
    self.timer = 0
    self.turnOn = false
end


function Turret:draw(mode)
    local _y = self.y + (-self.y+self.z)*mode
    
    -- draw self
    love.graphics.setColor(self.cFill)
    love.graphics.circle("fill", self.x, _y, radius*2)
    love.graphics.setColor(self.cLine)
    love.graphics.circle("line", self.x, _y, radius)
    love.graphics.circle("line", self.x, _y, radius*2)
    
    -- draw line
    if self.turnOn then
        -- shoot line
        love.graphics.setColor(1, 1, 0)
        love.graphics.line(self.x, _y,
        self.x + self.sx*len, _y + (self.sy + (-self.sy+self.sz)*mode) * len )
    else
        -- warning
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(self.x, _y,
        self.x + self.sx*radius*3, _y + (self.sy + (-self.sy+self.sz)*mode) * radius*3 )
    end
end


function Turret:hit(mode, player)
    local flag = false
    -- xy
    if mode == 0 and self.turnOn then
        -- x
        local xLeft = self.x
        local xRight = self.x + self.sx*len
        if xLeft > xRight then
            xLeft, xRight = xRight, xLeft
        end
        -- y
        local yTop = self.y
        local yBottom = self.y + self.sy*len
        if yTop > yBottom then
            yTop, yBottom = yBottom, yTop
        end
        -- check rectangle
        if  player.x > xLeft - player.lenX
        and player.x < xRight + player.lenX
        and player.y > yTop - player.lenY
        and player.y < yBottom + player.lenY then
            if self.sx == 0 and self.sy == 0 then
                -- point, do nothing
            elseif self.sx == 0 or self.sy == 0 then
                -- vertical or horizontal
                flag = true
            else
                -- both ~= 0
                local dy = math.abs(self.y - player.y)
                local a = math.abs(self.sy)/math.abs(self.sx)
                local dx = dy / a
                local checkX = self.x + dx*base.sign(self.sx)
                --
                if math.abs(player.x - checkX) < player.lenX+math.abs(player.lenY*a) then
                    flag = true
                end
            end
        end
    end
    --
    return flag
end


function Turret:update(dt)
    self.timer = self.timer + dt
    if self.timer > timeMax then
        self.timer = 0
        self.turnOn = not self.turnOn
        --sfx
        if self.turnOn then
            love.audio.play(sfx_shoot)
        end
    end
end