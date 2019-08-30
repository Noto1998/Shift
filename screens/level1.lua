local Screen = Level:extend()

function Screen:activate()
	Screen.super.activate(self)

	re1 = Cuboid(1,1,130, 150,base.guiHeight-1-1,50)
	re2 = Cuboid(base.guiWidth-150-1,1,130, 150,base.guiHeight-1-1,50)
	re3 = Cuboid(250, 150, 130-50, 50, 50, 50)
	player = Player(100, 150, 130-1)
	destination = Destination(250, 50, 130-50, "level2")

	Screen:addDrawList(re2, re3, player, re1, destination )
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	player:update(dt, shiftMode, drawList)
end

return Screen