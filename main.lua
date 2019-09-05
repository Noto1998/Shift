--- LOADING SCREEN
love.graphics.clear(255,255,255)
love.graphics.print("loading test")
love.graphics.present()
---

--- IMPORT CLASSIC
-- object-oriented
Object = require "lib.classic"
-- input
local keys = require "lib.keys"
-- baseData
local base = require "lib.base"
-- screenManager
local ScreenManager = require "lib.screenManager"
-- shape
require "lib.shape.rectangle"
require "lib.shape.circle"
require "lib.shape.cylinder"
require "lib.shape.cuboid"
--require "lib.shape.trigger"
-- player
require "lib.player"
-- level
require "lib.level"
-- destination
require "lib.destination"
-- dialogue
require "lib.dialogue"
---

--- LOAD SCREENS
local MainScreen = require "screens.mainScreen"
local FinishScreen = require "screens.finishScreen"
-- level
local LevelScreen = {}
for i, value in ipairs(require "screens.level.levelConf") do
    local file = io.open("./screens/level/" .. value .. ".lua")
    if file ~= nil then
        table.insert(LevelScreen, require("screens.level." .. value))
        file:close()
    end
end
---

--- LOAD GAME
function love.load()
    --- DEBUG
    debugMode = true
    debugLevel = nil-- pressed f2 to type, pressed f1 to run level
    ---
    -- for goto next level
    levelChoice = 1
    
    -- font
    local font = love.graphics.newFont("font/SourceHanSansCN-Normal.otf", 20)
    love.graphics.setFont(font)

    --test
    canvasBG = love.graphics.newCanvas()
    love.graphics.setCanvas(canvasBG)
        love.graphics.clear()
        local lineBorder = 40
        love.graphics.setColor(0.25, 0.25, 0.25)
        for i = 1, base.guiHeight/lineBorder-1 do
            local y = i * lineBorder
            love.graphics.line(0, y, base.guiWidth, y)
        end
        for i = 1, base.guiWidth/lineBorder-1 do
            local x = i * lineBorder
            love.graphics.line(x, 0, x, base.guiHeight)
        end
    love.graphics.setCanvas()

    -- register screens
    local screenManager = ScreenManager()
    screenManager:register('/', MainScreen)
    for i, level in ipairs(LevelScreen) do
        local levelName = "levelScreen" .. i
        screenManager:register(levelName, level)
    end
    screenManager:register("levelScreen" .. (#LevelScreen+1), FinishScreen)
end
---