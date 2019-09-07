Trigger = Cuboid:extend()

function Trigger:new(x, y, z, obj, moveX, moveY, moveZ)
    local len = 50
    local cFill = {1, 0.5, 0.5}

    Trigger.super.new(self, x, y, z, len, len, len, cFill)
    self.obj = obj
    self.moveX = moveX
    self.moveY = moveY
    self.moveZ = moveZ
end

function Trigger:moveObj(dt)
    local signX = base.sign(self.obj.x - self.moveX)
    local signY = base.sign(self.obj.y - self.moveY)
    local signZ = base.sign(self.obj.z - self.moveZ)

    if signX ~= 0 then
        self.obj.x = self.obj.x + signX*dt    
    end
    if signY ~= 0 then
        self.obj.y = self.obj.y + signY*dt    
    end
    if signZ ~= 0 then
        self.obj.z = self.obj.z + signZ*dt    
    end

    self.obj.x = math.floor(math.abs(self.obj.x)) * base.sign(self.obj.x)
    self.obj.y = math.floor(math.abs(self.obj.y)) * base.sign(self.obj.y)
    self.obj.z = math.floor(math.abs(self.obj.z)) * base.sign(self.obj.z)
end