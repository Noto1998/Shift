Level = Object:extend()

function Level:new(ScreenManager)
	self.screen = ScreenManager
end

function Level:activate()
    -- shift
	shiftMode = 0-- 0=xy, 1=xz
	shiftFlag = false
	shifting = false
	_timerMax = 2
    _timer = 0
	-- draw
	drawList = {}
end

function Level:update(dt)
	-- update shiftMode
	if shifting then
		local _dt = 1 / _timerMax * dt
		if shiftMode < 1 and shiftFlag then
			local _border =  1 - shiftMode
			if _border < _dt then
				shiftMode = 1
				shifting = false -- close
			else
				shiftMode = shiftMode + _dt
			end
		end
		if shiftMode > 0 and not shiftFlag then
			if shiftMode < _dt then
				shiftMode = 0
				shifting = false -- close
			else
				shiftMode = shiftMode - _dt
			end
		end
	end
end

function Level:draw()
	-- draw all obj in drawList
	-- [BUG] miss using xyz sort to draw
	if drawList ~= nil then
		for key, value in pairs(drawList) do
			value:draw(shiftMode)
		end
	end
end

function Level:keypressed(key)
	-- switch shiftMode
	if key == keys.A and not shifting then
		shiftFlag = not shiftFlag
		shifting = true
    end
end

-- add obj to drawList
function Level:addDrawList(...)
	local arg={...}
	-- sort by z
	for i=1, #arg do
		local j = i
		for k=i+1, #arg do
			if arg[k].z > arg[j].z then
				j, k = k, j
			end
		end
		arg[i], arg[j] = arg[j], arg[i]
	end
	-- then sort by y
	for i=1, #arg do
		local j = i
		for k=i+1, #arg do
			if arg[k].z == arg[j].z and arg[k].y < arg[j].y then
				j, k = k, j
			end
		end
		arg[i], arg[j] = arg[j], arg[i]
	end
	drawList = arg
end