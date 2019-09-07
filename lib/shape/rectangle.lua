Rectangle = Object:extend()

function Rectangle:new(x, y, z, lenX, lenY, dir, cFill, cLine, cBG)
    self.x = x
    self.y = y
    self.z = z
    self.lenX = lenX
    self.lenY = lenY
     self.dir = math.pi/2
    if dir ~= nil then
        self.dir = dir
    end
    self.lenZ = 0
    if self.dir ~= math.pi/2 then
        self.lenX = math.cos(math.pi/2 - dir) * self.lenX
        self.lenZ = math.tan(math.pi/2 - dir) * self.lenX
    end
    -- color
    self.cFill = base.cFill
	if cFill ~= nil then
		self.cFill =  cFill
	end
	self.cLine = base.cLine
	if cLine ~= nil then
		self.cLine = cLine
    end
    self.cBG = {1,1,1}
	if cBG ~= nil then
        self.cBG = cBG
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
             value[1], value[2],-- position of the vertex
             value[1]/base.guiWidth, value[2]/base.guiHeight,-- texture coordinate at the vertex position(0~1)
             1, 1, 1-- color of the vertex
         }
     end
     self.mesh = love.graphics.newMesh(vertices, "fan")
     self.mesh:setTexture(canvasBG)
end

function Rectangle:draw(mode)
    --[[
    local _x = self.x
    local _width = self.lenX
    local _y = self.y + (-self.y+self.z) * mode
    local _lenY = self.lenY * (1 - mode)
    -- Fill
    love.graphics.setColor(self.cFill)
    love.graphics.rectangle("fill", _x, _y, _width, _lenY)
    -- draw BG line
    love.graphics.setColor(self.cBG)
    love.graphics.draw(self.mesh, 0, 0+self.z * mode, 0, 1, 1-mode)
    --Line
    love.graphics.setColor(self.cLine)
    love.graphics.rectangle("line", _x, _y, _width, _lenY)
    ]]

    local _x = self.x + self.lenX
    local _z = self.z + self.lenZ
    
    --line
    if mode == 1 then
        love.graphics.setColor(self.cLine)
        love.graphics.line(self.x, self.z, _x, _z)
    
        -- polygon
    else
		local table = {
            self.x, self.y+ (-self.y + self.z) * mode,--
            _x,     self.y+ (-self.y + _z)     * mode,
            _x,     self.y+self.lenY + (-(self.y+self.lenY) + _z)      * mode,--
            self.x, self.y+self.lenY + (-(self.y+self.lenY) + self.z)  * mode
        }
        
        love.graphics.setColor(self.cFill)
        love.graphics.polygon("fill", table)
        
        -- draw BG line
        local table2 = {
            {self.x, self.y+ (-self.y + self.z) * mode},--
            {_x,     self.y+ (-self.y + _z)     * mode},
            {_x,     self.y+self.lenY + (-(self.y+self.lenY) + _z)      * mode},--
            {self.x, self.y+self.lenY + (-(self.y+self.lenY) + self.z)  * mode}
        }
        -- update point
        if mode ~= 0 then
            for i = 1, 4 do
                self.mesh:setVertexAttribute(i, 1, table2[i][1], table2[i][2])
            end
        end
        love.graphics.setColor(self.cBG)
        --love.graphics.draw(self.mesh, 0, 0+self.z * mode, 0, 1, 1-mode)
        love.graphics.draw(self.mesh)

        -- line
		love.graphics.setColor(self.cLine)
		love.graphics.polygon("line", table)
    end
end