Turret = Shape:extend()

local radius = 10
local lenShoot = base.guiHeight+base.guiWidth
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
        self.x + self.sx*lenShoot, _y + (self.sy + (-self.sy+self.sz)*mode) * lenShoot )
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
        local a = self.sx/self.sy
        local dy = a * (player.x - self.x)
        
        -- hit
        if math.abs(self.y+dy - player.y) < player.lenY*2 then
            flag = true
        end
    end
    return flag
end


function Turret:update(dt)
    self.timer = self.timer + dt
    if self.timer > timeMax then
        self.timer = 0
        self.turnOn = not self.turnOn
    end
end