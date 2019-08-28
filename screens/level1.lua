local Screen = Object:extend()

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

function Screen:activate()
	--test
	_x = base.guiWidth/2
	_y = base.guiHeight/2
	_y2 = _y
	_r = 50
	_rX = _r
	_rY = _r
	_sideH = 10
	_timer = 0
	_timerMax = 2--sed

	_lineY = 0
end

--test
function Screen:update(dt)
	local _dt = 1 / _timerMax * dt
	_timer = _timer + dt
	if _timer < _timerMax then
		_rY = _rY - _r *_dt
		_y2 = _y2 + _sideH * _dt
		_lineY = _lineY + (_y+_sideH) * _dt
	end	
end

function Screen:draw()
	--test
	love.graphics.setColor(1,1,1,1)
	love.graphics.line(0, _lineY, base.guiWidth, _lineY)--wall

	love.graphics.ellipse("line", _x, _y2, _rX, _rY)
	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", _x - _r, _y, _r*2, _y2 - _y)
	love.graphics.ellipse("fill", _x, _y, _rX, _rY)
	love.graphics.setColor(1,1,1,1)
	love.graphics.ellipse("line", _x, _y, _rX, _rY)
	love.graphics.line(_x - _r, _y, _x - _r, _y2)
	love.graphics.line(_x + _r, _y, _x + _r, _y2)
end

function Screen:keypressed(key)
	if key == keys.A then
		self.screen:view('/')
	end
end

return Screen