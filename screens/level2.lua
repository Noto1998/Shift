local Screen = Level:extend()

function Screen:activate()
	Screen.super.activate(self, 100, 150, 130-1, 250, 50, 130-50, "level2")--123 player's address,456 end address,"string"

    re4 = Circle(20,20,20,5)
	
	Screen:addDrawList(re2, re3, re1,re4)
end

return Screen