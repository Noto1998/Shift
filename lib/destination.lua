Destination = Cuboid:extend()

local len = 50

function Destination:new(x, y, z, nextScreen) 
    Destination.super.new(self, x, y, z, len, len, len, {0.5, 1, 0.5})
    self.nextScreen = nextScreen
end

-- player touch
function Destination:touch(player)
    local flag = false
    local centerX = self.x + len/2
    local centerY = self.y + len/2
    local disMin = len/2 + player.radius + 1
    local disX = math.abs(player.x - centerX)
    local disY = math.abs(player.y - centerY)
    local dis = math.sqrt(math.pow(disX, 2)+math.pow(disY, 2))
    if dis < disMin then
        flag = true
    end
    return flag
end