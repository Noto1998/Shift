Rectangle = Object:extend()

function Rectangle:new(x, y, z, lenX, lenY, cFill, cLine, cBG)
    self.x = x
    self.y = y
    self.z = z
    self.lenX = lenX
    self.lenY = lenY
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
    
     -- test
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
    --[[ mode from 0 to 1
    if mode == 0 then
        love.graphics.setColor(self.cFill)
        love.graphics.rectangle("fill", self.x, self.y, self.lenX, self.lenY)
        love.graphics.setColor(self.cLine)
        love.graphics.rectangle("line", self.x, self.y, self.lenX, self.lenY)
    elseif mode == 1 then
        love.graphics.setColor(self.cLine)
        love.graphics.line(self.x, self.z, self.x + self.lenX, self.z)
    else
        ]]
    local _x = self.x
    local _width = self.lenX
    local _y = self.y + (-self.y+self.z) * mode
    local _lenY = self.lenY * (1 - mode)

    -- Fill
    love.graphics.setColor(self.cFill)
    love.graphics.rectangle("fill", _x, _y, _width, _lenY)

    -- draw BG line
    local xy = {
         {self.x, self.y},
         {self.x+self.lenX, self.y},
         {self.x+self.lenX, self.y+self.lenY},
         {self.x, self.y+self.lenY}
     }
    for i = 1, 4 do
        self.mesh:setVertexAttribute(i, 1, xy[i][1], xy[i][2])
        self.mesh:setVertexAttribute(i, 2, xy[i][1]/base.guiWidth, xy[i][2]/base.guiHeight)
    end
    love.graphics.setColor(self.cBG)
    love.graphics.draw(self.mesh, 0, 0+self.z * mode, 0, 1, 1-mode)
    --Line
    love.graphics.setColor(self.cLine)
    love.graphics.rectangle("line", _x, _y, _width, _lenY)
end