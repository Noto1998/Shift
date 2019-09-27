Rectangle = Shape:extend()

-- for draw shape right, x will always be left, z always be bottom

function Rectangle:new(x, y, z, lenX, lenY, dir, cFill, cLine, cMesh)
    Circle.super.new(self, x, y, z, cFill, cLine, cMesh)
    self.lenX = lenX
    self.lenY = lenY
    self.lenZ = 0
    -- dir
    self.dir = math.pi/2
    if dir ~= nil then
        self.dir = dir
    end
    -- update lenX/Z
    if self.dir ~= math.pi/2 then
        self.lenX = math.abs(math.cos(math.pi/2 - dir) * self.lenX)
        self.lenZ = math.abs(math.tan(math.pi/2 - dir) * self.lenX)
    end
    -- mesh
    local vertices ={}
    local xy = {
        {self.x, self.y},
        {self.x+self.lenX, self.y},
        {self.x+self.lenX, self.y+self.lenY},
        {self.x, self.y+self.lenY}
    }
    for i, value in ipairs(xy) do
        vertices[i] = {
            value[1], value[2],                                -- position of the vertex
            value[1]/base.guiWidth, value[2]/base.guiHeight,   -- texture coordinate at the vertex position(0~1)
            1, 1, 1                                            -- color of the vertex
        }
    end
    self.mesh = love.graphics.newMesh(vertices, "fan")
    self.mesh:setTexture(canvasBG)
end

function Rectangle:draw(mode)
    local _x2 = self.x + self.lenX
    --
    local _z = self.z
    local _z2 = self.z - self.lenZ
    if self.dir < math.pi/2 then
        _z, _z2 = _z2, _z        
    end

    --line
    if mode == 1 then
        love.graphics.setColor(self.cLine)
        love.graphics.line(self.x, _z, _x2, _z2)
    
    -- polygon
    else
        -- fill
		local table = {
            self.x, self.y+ (-self.y + _z) * mode,--
            _x2,    self.y+ (-self.y + _z2) * mode,
            _x2,    self.y+self.lenY + (-(self.y+self.lenY) + _z2)  * mode,--
            self.x, self.y+self.lenY + (-(self.y+self.lenY) + _z)  * mode
        }
        
        love.graphics.setColor(self.cFill)
        love.graphics.polygon("fill", table)
        
        -- mesh
        if mode ~= 0 then
            -- update point location
            for i = 2, 4*2, 2 do
                self.mesh:setVertexAttribute(i/2, 1, table[i-1], table[i])
            end
        end
        love.graphics.setColor(self.cMesh)
        love.graphics.draw(self.mesh)

        -- line
		love.graphics.setColor(self.cLine)
		love.graphics.polygon("line", table)
    end
end

function  Rectangle:isCollisionXZ(x, z)
    local flag = false
    local centerX = self.x + self.lenX/2--left
    local centerZ = self.z - self.lenZ/2--bottom
    
    -- check in a rectangle
    if 	math.abs(x - centerX) < self.lenX/2
    and math.abs(z - centerZ) < self.lenZ/2 then

        local _x2 = self.x + self.lenX
        local _z = self.z
        local _z2 = self.z - self.lenZ
        local signX = -1
        if self.dir < math.pi/2 then
            _z, _z2 = _z2, _z
            signX = 1
        end

        --
        local a = self.lenZ/self.lenX
        local dx = math.abs(self.x - x)
        local dz = dx * a
        --
        if math.abs((_z + dz*signX) - z) <= 1.5 then
            flag = true
        end
    end
    --
    return flag
end