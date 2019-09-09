Rectangle = Shape:extend()

--x, left
--z, bottom

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
        self.lenX = math.cos(math.pi/2 - dir) * self.lenX
        self.lenZ = math.tan(math.pi/2 - dir) * self.lenX
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
    local _z
    if self.dir < math.pi/2 then
        _z = self.z - self.lenZ
    else
        _z = self.z
    end

    local x2 = self.x + self.lenX
    local z2 = _z + self.lenZ

    --line
    if mode == 1 then
        love.graphics.setColor(self.cLine)
        love.graphics.line(self.x, _z, x2, z2)
    
    -- polygon
    else
        -- fill
		local table = {
            self.x, self.y+ (-self.y + _z) * mode,--
            x2,     self.y+ (-self.y + z2) * mode,
            x2,     self.y+self.lenY + (-(self.y+self.lenY) + z2)  * mode,--
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