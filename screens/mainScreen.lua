local Screen = Shift:extend()

local page
local img
local t1
local tipsList

function Screen:activate()
	-- shift
	Screen.super.activate(self)

	page = 1
	img = love.graphics.newImage("img/logo.bmp")

	
	-- level choice
	t1 = Tips(85,145,-50, "<		第" .. page .. "关		>")
	
	tipsList = {
		-- key tips
		Tips(85,185,-50, "←→选择  A开始"),
		--credits
		Tips(30,base.guiHeight+50,120+40*2,	"code/art/level\tNotoj"),
		Tips(30,base.guiHeight+50,120+40, 	"design/level\tYaolaotou"),
		Tips(30,base.guiHeight+50,120, "mofish team"),
	}
end

function Screen:draw()
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
	-- shift
	Screen.super.keypressed(self, key)
	
	if shiftMode == 0 then
		-- start level
		if key == keys.A then
			levelChoice = page
			self.screen:view(levelString[levelChoice])
		end

		-- choice level
		local levelMax = #levelString-1--the last one is finishScreen
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
		if key ==keys.DPad_right or keys.DPad_left then
			t1.string = "<		第" .. page .. "关		>"
		end
	end
end

return Screen