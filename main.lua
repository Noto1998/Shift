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
-- player
require "lib.player"
-- level
require "lib.level"
-- destination
require "lib.destination"
---

--- LOAD SCREENS
local MainScreen = require "screens.mainScreen"
-- put all level in a table
local LevelScreen = {}
local i = 1
while io.open("./screens/level"..i..".lua") ~= nil do
    local levelName = "screens.level" .. i
    LevelScreen[i] = require(levelName)
    i = i + 1
    io.close()
end
---

--- DEBUG
debugMode = true
debugI = 0-- for choose level
---

--- LOAD GAME
function love.load()
    -- font
    local font = love.graphics.newFont("font/SourceHanSansCN-Normal.otf", 20)
    love.graphics.setFont(font)

    -- register screens
    local screenManager = ScreenManager()
    screenManager:register('/', MainScreen)
    for i, level in ipairs(LevelScreen) do
        local levelName = "level" .. i
        screenManager:register(levelName, level)
    end
end
---

--- HELPER FUNCTION
function lovePrint(string, x, y, xMode, yMode)
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

---