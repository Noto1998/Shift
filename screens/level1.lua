local Screen = Level:extend()

function Screen:activate()
	Screen.super.activate(self, 100, 150, 130-1, 250, 50, 130-50, "level2")
	
	re1 = Cuboid(1,1,130, 150,base.guiHeight-1-1,50)
	re2 = Cuboid(base.guiWidth-150-1,1,130, 150,base.guiHeight-1-1,50)
	re3 = Cuboid(250, 150, 130-50, 50, 50, 50)
	re4 = Circle(20,20,20,10)
	re5 = Cylinder(150,150,120,10,20)
	
	Screen:addDrawList(re2, re3, re1,re4,re5)
end

return Screen