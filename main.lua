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
levelChoice = 1--- for choose level
---

--- DEBUG
debugMode = true
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