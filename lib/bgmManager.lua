BgmManager = Object:extend()

function BgmManager:new(bgm)
    self.bgm = bgm
    self.turnOn = true

    -- play
	self.bgm:setLooping(true)
	love.audio.play(self.bgm)
end


function BgmManager:draw()
    love.graphics.setColor(0.25, 0.25, 0.25)
    base.print(lang.ui_key_music, base.guiWidth-10, 0, "left")
    if not self.turnOn then
        base.print("\\", base.guiWidth-10, 0, "left")
    end
end


function BgmManager:keypressed(key)
    if key == keys.Start then
        self.turnOn = not self.turnOn
    end

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


return BgmManager