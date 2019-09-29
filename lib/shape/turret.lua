Turret = Shape:extend()

local radius = 10
local len = math.sqrt(base.guiHeight^2 + base.guiWidth^2) + 1
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
    -- len
    self.len = len
end


function Turret:update(dt, mode)
    if mode == 0 or mode == 1 then
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
        local cTable1 = base.cloneTable(base.cGray)
        local cTable2 = base.cloneTable(base.cYellow)

        for i = 1, #cTable1 do
            cTable1[i] = cTable1[i]*mode + cTable2[i]*(1-mode)
        end

        love.graphics.setColor(cTable1)
        love.graphics.line(self.x, _y,
        self.x + self.sx * self.len, _y + (self.sy + (-self.sy+self.sz)*mode) * self.len)
        
    -- warning
    else
        if self.timer > timeMax * (1-0.3) then
            love.graphics.setColor(base.cWarning)
            love.graphics.line(self.x, _y,
            self.x+self.sx*self.len, _y+(self.sy + (-self.sy+self.sz)*mode) * self.len)
        end
    end
end


function Turret:hit(obj)
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
    --
    if obj:is(Rectangle) then
        local pX1 = obj:getX(obj:getLeftX())
        local pX2 = obj:getX(obj:getRightX())
        local pY1 = obj.y
        local pY2 = obj.y+obj.lenY
        -- check rectangle
        if  pX2 > xLeft
        and pX1 < xRight
        and pY2 > yTop
        and pY1 < yBottom then
            if self.sx == 0 and self.sy == 0 then
                -- point, do nothing
            elseif self.sx == 0 or self.sy == 0 then
                -- vertical or horizontal
                flag = true
            else
                -- fix
                if pY1 < yTop+1 then
                    pY1 = yTop+1
                end
                if pY2 > yBottom-1 then
                    pY2 = yBottom-1
                end
                --
                local pTable = {
                    {pX1, pY1},
                    {pX2, pY1},
                    {pX2, pY2},
                    {pX1, pY2},
                }
                local sign = nil
                -- real
                local dirReal = math.atan2(self.sy, self.sx)
                --
                for i = 1, 4 do
                    local vX = pTable[i][1]
                    local vY = pTable[i][2]
                    -- turret to 4 point
                    local lenX = vX-self.x
                    local lenY = vY-self.y
                    local dir = math.atan2(lenY, lenX)
                    local pSign = base.sign(dirReal-dir)
                    --
                    if sign == nil then
                        sign = pSign
                    else
                        -- check dir(show point in which side)
                        if sign ~= pSign then
                            flag = true
                            break
                        end
                    end
                end
            end
        end
    elseif obj:is(Ball) then
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
                -- real
                local dirReal = math.atan2(self.sy, self.sx)
                -- turret to ball
                local lenX = obj.x - self.x
                local lenY = obj.y - self.y
                local dirBall = math.atan2(lenY, lenX)
                -- min
                local c = math.sqrt(lenX^2 + lenY^2)
                local sin = obj.radius/c
                local dirMin = math.asin(sin)
                --
                if math.abs(dirBall - dirReal) < dirMin then
                    flag = true
                end
            end
        end
    end
    --
    return flag
end

-- block
function Turret:block(ballList)
    local lenMin = len

    for key, obj in pairs(ballList) do
        if self:hit(obj) then
            local lenX = math.abs(self.x - obj.x)
            local lenY = math.abs(self.y - obj.y)
            local c = math.sqrt(lenX^ 2 + lenY^2)
            local c2 = math.sqrt(self.sx^2 + self.sy^2)
            local _len = c/c2

            -- record min len
            if _len < lenMin then
                lenMin = _len
            end

        end
    end

    self.len = lenMin
end