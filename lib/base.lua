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

return base