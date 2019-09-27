local BgmManager = Object:extend()

function BgmManager:new(bgm)
    self.bgm = bgm
    self.turnOn = true

    -- play
	self.bgm:setLooping(true)
	love.audio.play(self.bgm)
end


function BgmManager:update()
    if base.isPressed(base.keys.music) then
        self.turnOn = not self.turnOn

        --play
        if self.turnOn then
            --
            if not self.bgm:play() then
                self.bgm:setLooping(true)
                love.audio.play(self.bgm)
            end
        else
            --
            if self.bgm:play() then
                love.audio.stop(self.bgm)
            end
        end
    end
end


function BgmManager:draw()
    love.graphics.setColor(base.cDarkGray)
    base.print("♫", base.guiWidth-base.guiBorder, 0, "right")
    if not self.turnOn then
        love.graphics.setColor(base.cRed)
        base.print("x", base.guiWidth-base.guiBorder, 0, "right")
    end
end


return BgmManager