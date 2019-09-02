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
    if number > 0 then
        return 1
    elseif number < 0 then
        return -1
    else
        return 0
    end
end

function base.print(string, x, y, xMode, yMode)
    -- easy text print, xMode using love.graphics.printf(), yMode get font's pixels height and move x/y
    -- xMode
    if xMode == nil and yMode == nil then
        love.graphics.print(string, x, y)
    else
        local w = love.graphics.getFont():getWidth(string) * 2
        local h = love.graphics.getFont():getHeight()
        local y2 = y
        -- yMode
        if yMode == "top" or yMode == nil then
            --default
        elseif yMode == "center" then
            y2 = math.floor(y - h/2)
        elseif yMode == "bottom" then
            y2 = y - h
        else
            error("Invalid alignment " .. yMode .. ", expected one of: 'top','center','bottom'");
        end

        love.graphics.printf(string, math.floor(x-w/2), y2, w, xMode)
    end
end

return base