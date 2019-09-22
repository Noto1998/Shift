Shift = Object:extend()

local shiftTimerMax
local shiftTimer
local shifting
local shiftFlag
local shiftSpd


function Shift:new(ScreenManager)
	self.screen = ScreenManager
end


function Shift:activate()
    -- shift
	self.shiftMode = 0-- 0=xy, 1=xz
	shiftFlag = false
	shifting = false
	shiftTimerMax = 1.25
	shiftTimer = 0
    shiftSpd = 0
end


function Shift:update(dt, canShift)
	-- pressed setting, only use once, so time only add once
	for k, keyName in pairs(base.keys) do
		keyName.isPressed = base.pressedSetting(keyName, dt)
	end

	-- update shiftMode
	if shifting then
		local shiftAddSpd = 2*dt
		local shiftAddTime = 0.3
		-- start spd
		if self.shiftMode == 0 or self.shiftMode == 1 then
			shiftSpd = 0
		end
		-- add spd
		if shiftFlag then
			if self.shiftMode < shiftAddTime then
					shiftSpd = shiftSpd + shiftAddSpd
			elseif self.shiftMode > 1-shiftAddTime then
				shiftSpd = shiftSpd - shiftAddSpd
			end
		else
			if self.shiftMode < shiftAddTime then
				shiftSpd = shiftSpd - shiftAddSpd
			elseif self.shiftMode > 1-shiftAddTime then
				shiftSpd = shiftSpd + shiftAddSpd
			end
		end
		local _dt = math.abs(shiftSpd) / shiftTimerMax * dt
		-- change shiftMode
		if self.shiftMode < 1 and shiftFlag then
			local _border =  1 - self.shiftMode
			if _border < _dt then
				self.shiftMode = 1
				shifting = false -- close
			else
				self.shiftMode = self.shiftMode + _dt
			end
		end
		if self.shiftMode > 0 and not shiftFlag then
			if self.shiftMode < _dt then
				self.shiftMode = 0
				shifting = false -- close
			else
				self.shiftMode = self.shiftMode - _dt
			end
		end
	end
	
	-- switch shiftMode
	if (canShift==nil or canShift==true)
	and base.isPressed(base.keys.shift) and not shifting then
		shiftFlag = not shiftFlag
		shifting = true
		--sfx
		love.audio.play(sfx_shift)
	end

	-- bgmManager
	bgmManager:update()
end