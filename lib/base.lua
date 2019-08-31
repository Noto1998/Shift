-- const
base = require "lib.const"

-- gui
base.guiWidth = love.graphics.getWidth()
base.guiHeight = love.graphics.getHeight()

--player
--base.playerSpd = 

-- color
local cBlack = {0, 0, 0}
local cWhite = {1, 1, 1}
local cGray = {0.5, 0.5, 0.5}

base.cFill = cGray
base.cLine = cWhite

function base.sign(number)
    if number == 0 then
        return 0
    elseif number > 0 then
        return 1
    elseif number < 0 then
        return -1
    end
end

return base