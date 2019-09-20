-- const
base = require "lib.const"

-- gui
base.guiWidth = love.graphics.getWidth()
base.guiHeight = love.graphics.getHeight()

-- color
base.cBlack = {0, 0, 0}
base.cWhite = {1, 1, 1}
base.cYellow = {1, 1, 0}
base.cGray = {0.5, 0.5, 0.5}
base.cDarkGray = {0.25, 0.25, 0.25}
base.cDestination = {0.5, 1, 0.5}
base.cWarning = {1, 0, 0, 0.35}--loaser
base.cfourD1 = {0.92, 0.02, 0.76, 0.25}
base.cfourD2 = {0.02, 0.92, 0.7, 0.25}

base.cFill = base.cBlack
base.cLine = base.cWhite

-- function
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

function base.cloneTable(table)
    local t1 ={}--new table
    for i = 1, #table do
        t1[i] = table[i]
    end

    return t1
end

return base