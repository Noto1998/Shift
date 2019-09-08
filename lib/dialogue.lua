Dialogue = Object:extend()

local textTable
local page

function Dialogue:new(table)
    page = 0-- 0 = not draw
    textTable = table
end

function Dialogue:draw()
    if page ~= 0 then
        -- bg
        local bgX = 0
        local bgY = bgX
        local bgWidth = base.guiWidth
        local bgHeight = base.guiHeight
        love.graphics.setColor(0,0,0, 0.75)
        love.graphics.rectangle("fill", bgX, bgY, bgWidth, bgHeight)
        -- head
        local headX = bgX + 40
        local headY = bgY + 20
        local headWidth = 80
        local headHeight = 100
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", headX, headY, headWidth, headHeight)
        love.graphics.rectangle("line", base.guiWidth-headX-headWidth, headY, headWidth, headHeight)
        -- text
        local textX = headX
        local textY = headY+headHeight+20
        love.graphics.setColor(1,1,1)
        base.print(textTable[page], textX, textY)
    end
end

function Dialogue:nextPage()
    if page < #textTable then 
        page = page + 1
    else
        page = 0
    end
end

function Dialogue:isDraw()
    return page ~= 0
end