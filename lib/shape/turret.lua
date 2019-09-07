Turret = Object:extend()

local radius = 10
local sx
local sy
local sz
local lenShoot = base.guiHeight+base.guiWidth


function Turret:new(x, y, z, shootX, shootY, shootZ)
    self.x = x
    self.y = y
    self.z = z

    -- 0~1
    sx = shootX
    sy = shootY
    sz = shootZ
end


function Turret:draw(mode)
    local _y = self.y+(-self.y+self.z)*mode
    
    -- draw self
    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", self.x, _y, radius)
    love.graphics.circle("line", self.x, _y, radius*2)

    -- test draw line
    love.graphics.setColor(1, 1, 0)
    love.graphics.line(self.x, _y,
    self.x + sx*lenShoot, _y + (sy+(-sy+sz)*mode)*lenShoot )
end


function Turret:hit(mode, player)
    local flag = false
    -- xy
    if mode == 0 then
        local a = sx/sy
        local dy = a * (player.x - self.x)
        
        -- hit
        if math.abs(self.y+dy - player.y) < player.lenY*2 then
            flag = true
        end
    end
    return flag
end