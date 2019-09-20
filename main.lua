--- LOADING SCREEN
love.graphics.clear(1, 1, 1)
local img = love.graphics.newImage("img/loading.jpg")
love.graphics.draw(img)
love.graphics.present()
---

--- IMPORT CLASSIC
-- object-oriented
Object = require "lib.classic"
-- input
keys = require "lib.keys"
-- baseClassic
base = require "lib.base"
-- shape
require "lib.shape.shape"
require "lib.shape.rectangle"
require "lib.shape.circle"
require "lib.shape.cylinder"
require "lib.shape.cuboid"
require "lib.shape.turret"
require "lib.shape.ball"
require "lib.shape.tips"
require "lib.shape.fourD"
-- player
require "lib.player"
-- destination
require "lib.destination"
-- level
require "lib.shift"-- frist
require "lib.level"
-- screenManager
local ScreenManager = require "lib.screenManager"
-- bgmManager
local BgmManager = require"lib.bgmManager"
---

--- LOAD SCREENS
local MainScreen = require "screens.mainScreen"
-- level
levelString = require "screens.level.levelConf"
local LevelScreen = {}
for i, value in ipairs(levelString) do
    local fileName = "screens/level/" .. value .. ".lua"
    local file = love.filesystem.getInfo(fileName)
    if file ~= nil then
        table.insert(LevelScreen, require("screens.level." .. value))
    end
end
---

--- LOAD GAME
function love.load()
    -- DEBUG
    debugMode = false       -- close
    debugLevel = nil        -- pressed f1 to run level
    
    -- level
    levelChoice = 1         -- for goto next level
    resetLevelString = nil  -- for reset level, set in screenManager.lua
    
    -- font
    local font = love.graphics.newFont("font/sarasa-mono-sc-medium.ttf", 20)
    love.graphics.setFont(font)

    -- sound
    sfx_menu        = love.audio.newSource("sound/bibi.wav", "static")
    sfx_touchGound  = love.audio.newSource("sound/touchGound.wav", "static")
    sfx_shift       = love.audio.newSource("sound/shift.wav", "static")
    sfx_finish      = love.audio.newSource("sound/leida.wav", "static")
    sfx_restart     = love.audio.newSource("sound/switch.wav", "static")
    sfx_shoot       = love.audio.newSource("sound/leida2.wav", "static")
    bgm_mainScreens = love.audio.newSource("sound/test.wav", "stream")
    bgmManager = BgmManager(bgm_mainScreens)

    --- canvas
    canvasBG = love.graphics.newCanvas()
    love.graphics.setCanvas(canvasBG)
        love.graphics.clear()
        local lineBorder = 40
        love.graphics.setColor(base.cDarkGray)
        for i = 1, base.guiHeight/lineBorder-1 do
            local y = i * lineBorder
            love.graphics.line(0, y, base.guiWidth, y)
        end
        for i = 1, base.guiWidth/lineBorder-1 do
            local x = i * lineBorder
            love.graphics.line(x, 0, x, base.guiHeight)
        end
    love.graphics.setCanvas()
    ---

    -- register screens
    local screenManager = ScreenManager()
    screenManager:register('/', MainScreen)
    for i, level in ipairs(LevelScreen) do
        local levelName = levelString[i]
        screenManager:register(levelName, level)
    end
end
---