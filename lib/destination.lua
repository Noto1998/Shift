Destination = Cuboid:extend()

function Destination:new(x, y, z, nextScreen)
    local len = 50
    
    Destination.super.new(self, x, y, z, len, len, len, {0.5, 1, 0.5})
    self.nextScreen = nextScreen
end

