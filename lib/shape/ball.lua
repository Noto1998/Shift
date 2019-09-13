Ball = Shape:extend()

local spd = 25
local spdG = 80
local spdX, spdZ

local function  isCollision(self, table)
    local flag = false
    local _z = self.z+self.radius

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

    spdX = 0
    spdZ = 0
end


function Ball:update(dt, mode, list)
    
    if mode == 1 then
       -- onGround
        self.onGround = isCollision(self, list)
        -- gravity
        spdZ = 0
        if not self.onGround then
            spdZ = spdG
        end

        -- roll
        if spdX ~= 0 then
            local slowSpd = 10*dt
            if math.abs(spdX) > slowSpd then
                spdX = spdX - base.sign(spdX)*slowSpd
            else
                spdX = 0
            end
        end
        for key, obj in pairs(list) do
            if obj:is(Rectangle) then
                if obj:isCollisionXZ(self.x, self.z+self.radius+spdZ*dt) then
                    local signX = 0
                    if obj.dir < math.pi/2 then
                        signX = 1
                    elseif obj.dir > math.pi/2 then
                        signX = -1
                    end
                    spdX = spd*signX
                    break
                end
            end
        end

        --
        self.x = self.x + spdX*dt
        self.z = self.z + spdZ*dt
    end
end


function Ball:draw(mode)
    local _y = self.y + (-self.y+self.z)*mode
    -- fill
    love.graphics.setColor(self.cFill)
    love.graphics.circle("fill", self.x, _y, self.radius)
    -- line
    love.graphics.setColor(self.cLine)
    love.graphics.circle("line", self.x, _y, self.radius)
end
