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
local BgmManager = require "lib.bgmManager"
-- lang
lang = require "lib.lang.lang_cn"       -- cn default
---

--- LOAD SCREENS
local MainScreen = require "screens.mainScreen"
local LangSwitchScreen = require "screens.langSwitchScreen"


--- LOAD GAME
function love.load()
    -- DEBUG
    debugMode = false       -- close
    debugLevel = nil        -- pressed f1 to run level
    
    -- level
    levelChoice = 1         -- for goto next level
    resetLevelString = nil  -- for reset level, set in screenManager.lua
    
    -- font
    local font = love.graphics.newFont("font/SourceHanSansCN-Medium.otf", 20)
    love.graphics.setFont(font)

    -- sound
    sfx_menu        = love.audio.newSource("sound/bibi_MP3.mp3", "static")
    sfx_touchGound  = love.audio.newSource("sound/touchGound_MP3.mp3", "static")
    sfx_shift       = love.audio.newSource("sound/shift_MP3.mp3", "static")
    sfx_finish      = love.audio.newSource("sound/leida_MP3.mp3", "static")
    sfx_restart     = love.audio.newSource("sound/switch_MP3.mp3", "static")
    sfx_shoot       = love.audio.newSource("sound/leida2_MP3.mp3", "static")
    bgm_mainScreens = love.audio.newSource("sound/test_MP3.mp3", "stream")
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
    screenManager = ScreenManager()
    screenManager:register('/', LangSwitchScreen)
    screenManager:register('MainScreen', MainScreen)
    
end
---