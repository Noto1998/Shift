Ball = Shape:extend()

local spd = 32
local spdG = 80

local function  isCollision(self, table)
    local flag = false
    local _z = self.z + self.radius

    for index, obj in ipairs(table) do
        -- Cuboid
        if obj:is(Cuboid) then
            if  self.x > obj.x
            and self.x < obj.x+obj.lenX 
            and _z > obj.z
            and _z < obj.z+obj.lenZ then
                flag = true
            end
        -- Rectangle
        elseif obj:is(Rectangle) then
            flag = obj:isCollisionXZ(self.x, _z)
        end
        --
        if flag then
            break
        end
    end
    --
    return flag
end

function Ball:new(x, y, z, radius, cFill, cLine, cMesh)
    Ball.super.new(self, x, y, z, cFill, cLine, cMesh)
    self.radius = radius
    self.onGround = false

    self.spdX = 0
    self.spdZ = 0
end


function Ball:update(dt, mode, list)
    
    if mode == 1 then
       -- onGround
        self.onGround = isCollision(self, list)
        -- gravity
        self.spdZ = 0
        if not self.onGround then
            self.spdZ = spdG
        end

        -- roll
        if self.spdX ~= 0 then
            local slowSpd = 10*dt
            if math.abs(self.spdX) > slowSpd then
                self.spdX = self.spdX - base.sign(self.spdX)*slowSpd
            else
                self.spdX = 0
            end
        end
        for key, obj in pairs(list) do
            if obj:is(Rectangle) then
                if obj:isCollisionXZ(self.x, self.z+self.radius+self.spdZ*dt) then
                    local signX = 0
                    if obj.dir < math.pi/2 then
                        signX = 1
                    elseif obj.dir > math.pi/2 then
                        signX = -1
                    end
                    self.spdX = spd*signX
                    break
                end
            end
        end

        --
        self.x = self.x + self.spdX*dt
        self.z = self.z + self.spdZ*dt
    end
end


function Ball:draw(mode)
    local _y = self.y + (-self.y+self.z)*mode

    local cTable = base.cloneTable(base.cYellow)
    for i = 1, #self.cFill do
        cTable[i] = self.cFill[i]*(1-mode) + cTable[i]*mode
    end


    -- fill
    love.graphics.setColor(cTable)
    love.graphics.circle("fill", self.x, _y, self.radius)
    -- line
    love.graphics.setColor(self.cLine)
    love.graphics.circle("line", self.x, _y, self.radius)
end

function Ball:hit(player)
    local flag = false

    for i = 1, 2 do
        if player:isCollisionXZ(i, self) then
            flag = true
            break
        end
    end

    return flag
end
