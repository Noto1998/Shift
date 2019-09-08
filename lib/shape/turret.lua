Turret = Shape:extend()

local radius = 10
local lenShoot = base.guiHeight+base.guiWidth
local sx
local sy
local sz
local timer
local timeMax = 2-- second
local turnOn


function Turret:new(x, y, z, shootX, shootY, shootZ, cFill, cLine, cMesh)
    Turret.super.new(self, x, y, z, cFill, cLine, cMesh)
    -- 0~1
    sx = shootX
    sy = shootY
    sz = shootZ
    -- turn on/off
    timer = 0
    turnOn = false
end


function Turret:draw(mode)
    local _y = self.y+(-self.y+self.z)*mode
    
    -- draw self
    love.graphics.setColor(self.cFill)
    love.graphics.circle("fill", self.x, _y, radius*2)
    love.graphics.setColor(self.cLine)
    love.graphics.circle("line", self.x, _y, radius)
    love.graphics.circle("line", self.x, _y, radius*2)
    if turnOn then
        -- draw shoot line
        love.graphics.setColor(1, 1, 0)
        love.graphics.line(self.x, _y,
        self.x + sx*lenShoot, _y + (sy+(-sy+sz)*mode)*lenShoot )
    else
        -- draw warning/dir
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(self.x, _y,
        self.x + sx*radius*3, _y + (sy+(-sy+sz)*mode)*radius*3 )
    end
end


function Turret:hit(mode, player)
    local flag = false
    -- xy
    if mode == 0 and turnOn then
        local a = sx/sy
        local dy = a * (player.x - self.x)
        
        -- hit
        if math.abs(self.y+dy - player.y) < player.lenY*2 then
            flag = true
        end
    end
    return flag
end


function Turret:update(dt)
    timer = timer + dt
    if timer > timeMax then
        timer = 0
        turnOn = not turnOn
    end
end