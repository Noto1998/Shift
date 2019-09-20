BgmManager = Object:extend()

function BgmManager:new(bgm)
    
end


function BgmManager:draw()
    
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