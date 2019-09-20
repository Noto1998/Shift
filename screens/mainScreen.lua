local Screen = Shift:extend()

local page
local img
local t1
local tipsList

local function getLevelName(page)
	local string = "bug"
	local test = require ("screens.level." .. levelString[page])
	
	test:activate()
	string = test.levelName
	test = nil--release

	return string
end

function Screen:activate()
	-- shift
	Screen.super.activate(self)

	--
	page = 1
	img = love.graphics.newImage("img/logo.bmp")
	
	-- tips
	local x = 20
	t1 = Tips(base.guiWidth/2,145,-50, lang.ui_level_choice(page, getLevelName(page)), "center")
	tipsList = {
		-- key tips
		Tips(base.guiWidth/2,185,-50, lang.ui_key_start_and_move, "center"),
		--credits
		Tips(base.guiWidth/2, base.guiHeight+50,120+40*2,	"code|art|music|level\tNotoj", "center"),
		Tips(base.guiWidth/2, base.guiHeight+50,120+40, 	"design|level|test\tJcat", "center"),
		Tips(base.guiWidth/2, base.guiHeight+50,120, 		"Mofish", "center"),
	}
end

function Screen:draw()
	-- bgmManager
	bgmManager:draw()

	-- tips
	t1:draw(shiftMode)
	for key, obj in pairs(tipsList) do
		obj:draw(shiftMode)
	end

	-- logo
	love.graphics.setColor(base.cWhite)
	love.graphics.draw(img, 30, 20, 0, 0.75, 0.75)
end

function Screen:keypressed(key)
	-- bgmManager
	bgmManager:keypressed(key)

	-- shift
	Screen.super.keypressed(self, key)
	
	if shiftMode == 0 then
		local levelMax = #levelString-3--finishScreen

		-- start level
		if key == keys.A then
			levelChoice = page
			self.screen:view(levelString[levelChoice])
		end

		-- choice level
		if key == keys.DPad_right then
			if page < levelMax then
				page = page + 1
			else
				page = 1
			end
		elseif key == keys.DPad_left then
			if page > 1 then
				page = page - 1
			else
				page = levelMax
			end
		end

		-- update string
		if key ==keys.DPad_right or key == keys.DPad_left then
			t1.string = lang.ui_level_choice(page, getLevelName(page))

			--sfx
			love.audio.play(sfx_menu)
		end
	end
end

return Screen