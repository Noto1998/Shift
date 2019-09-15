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

    self.len = len
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


function Turret:draw(mode)
    local _y = self.y + (-self.y+self.z)*mode
    
    -- draw self
    love.graphics.setColor(self.cFill)
    love.graphics.circle("fill", self.x, _y, radius*2)
    love.graphics.setColor(self.cLine)
    love.graphics.circle("line", self.x, _y, radius)
    love.graphics.circle("line", self.x, _y, radius*2)
    
    -- draw shoot line
    if self.turnOn then
        local cTable1 = {0.5,0.5,0.5}
        local cTable2 = {1, 1, 0}

        for i = 1, #cTable1 do
            cTable1[i] = cTable1[i]*mode + cTable2[i]*(1-mode)
        end

        love.graphics.setColor(cTable1)
        love.graphics.line(self.x, _y,
        self.x + self.sx * self.len, _y + (self.sy + (-self.sy+self.sz)*mode) * self.len)
        
    -- warning
    else
        if self.timer > timeMax * (1-0.3) then
            love.graphics.setColor(1, 0, 0, 0.35)
            love.graphics.line(self.x, _y,
            self.x + self.sx * self.len, _y + (self.sy + (-self.sy+self.sz)*mode) * self.len)
        end
    end
end

-- player/rectangle
function Turret:hit(player)
    local flag = false
    -- xy
    if self.turnOn then
        -- x
        local xLeft = self.x
        local xRight = self.x + self.sx * self.len
        if xLeft > xRight then
            xLeft, xRight = xRight, xLeft
        end
        -- y
        local yTop = self.y
        local yBottom = self.y + self.sy * self.len
        if yTop > yBottom then
            yTop, yBottom = yBottom, yTop
        end
        -- check rectangle
        if  player.x + player.lenX > xLeft
        and player.x - player.lenX < xRight
        and player.y + player.lenY > yTop
        and player.y - player.lenY < yBottom then
            if self.sx == 0 and self.sy == 0 then
                -- point, do nothing
            elseif self.sx == 0 or self.sy == 0 then
                -- vertical or horizontal
                flag = true
            else
                -- both ~= 0
                local dy = math.abs(self.y - player.y)
                local a = math.abs(self.sy/self.sx)
                local dx = dy / a
                local checkX = self.x + dx*base.sign(self.sx)
                --
                if math.abs(player.x - checkX) < player.lenX + math.abs(player.lenY/a) then
                    flag = true
                end
            end
        end
    end
    --
    return flag
end


--ball
function Turret:hitBall(obj)
    local flag = false

    -- x
    local xLeft = self.x
    local xRight = self.x + self.sx * self.len
    if xLeft > xRight then
        xLeft, xRight = xRight, xLeft
    end
    -- y
    local yTop = self.y
    local yBottom = self.y + self.sy * self.len
    if yTop > yBottom then
        yTop, yBottom = yBottom, yTop
    end
    -- check rectangle
    if  obj.x + obj.radius > xLeft
    and obj.x - obj.radius < xRight
    and obj.y + obj.radius > yTop
    and obj.y - obj.radius < yBottom then
        if self.sx == 0 and self.sy == 0 then
            -- point, do nothing
        elseif self.sx == 0 or self.sy == 0 then
            -- vertical or horizontal
            flag = true
        else
            -- both ~= 0
            -- turret to ball
            local lenX = self.x - obj.x
            local lenY = self.y - obj.y
            local tanBall = lenX/lenY
            local dirBall = math.atan(tanBall)
            -- real
            local tanReal = self.sx/self.sy
            local dirReal = math.atan(tanReal)
            -- min
            local c = math.sqrt(math.pow(lenX, 2) + math.pow(lenY, 2))
            local sin = obj.radius/c
            local dirMin = math.asin(sin)
            --
            if math.abs(dirBall - dirReal) < dirMin then
                flag = true
            end
        end
    end

    return flag
end

-- ball
function Turret:blockTable(table)
    local lenMin = len

    for key, obj in pairs(table) do
        if self:hitBall(obj) then
            local lenX = math.abs(self.x - obj.x)
            local lenY = math.abs(self.y - obj.y)
            local c = math.sqrt(math.pow(lenX, 2)+math.pow(lenY, 2))
            local c2 = math.sqrt(math.pow(self.sx, 2)+math.pow(self.sy, 2))
            local _len = c/c2

            -- record min len
            if _len < lenMin then
                lenMin = _len
            end

        end
    end

    self.len = lenMin
end