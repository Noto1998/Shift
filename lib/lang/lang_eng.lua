local lang = {}

-- ui
function lang.ui_level_choice(Num, Name)   return "<\tlevel " .. Num .. " " .. Name .. "\t>"    end
lang.ui_key_start_and_move = "←→selct\tA start"
lang.ui_key_keyTips = "X control tips"
lang.ui_player_stuck = "player stuck"
lang.ui_level_finish = "level finish"
lang.ui_key_continue = "A continue"
lang.io_key_doc = "B read doc"
lang.ui_key_credits = "Y credits"
lang.ui_key_keyTipsList = {
	"\tArrows - Move\t\t",
	"\tY - Shift Dimensions\t\t",
	"\tStart - Reset Level\t\t",
	"\tSelect - ♫Off/On\t\t",
	"\tB(hold) - go MainMenu\t\t"
}
lang.ui_credits = {
	"code|art|music|level\tNotoj",
	"design|level\tJcat(Yaolaotou)"
}

--level
lang.level_BlockLaser		= "Block"
lang.level_Contour			= "Contour"
lang.level_Cross			= "Cross"
lang.level_CrossTheRiver	= "Cross The River"
lang.level_DonkeyKong		= "Donkey Kong"
lang.level_Invisible		= "Invisible"
lang.level_OneShot			= "OneShot"
lang.level_RockClimbing 	= "Rock Climbing"
lang.level_Skull			= "Skull"
lang.level_StandStraight	= "Stand Straight"
lang.level_SuperLaser		= "Mission Impossible"
lang.level_Tunnel			= "Tunnel"
lang.level_Tutorial_Ball	= "Rolling Stones"
lang.level_Tutorial_Move	= "Tutorial"
lang.level_Tutorial_MoveCuboid = "need for speed"
lang.level_Tutorial_Shift	= "Tutorial"
lang.level_Tutorial_Laser	= "Bit The Dust"

--tips
lang.tips_use_arrows_to_move = "Use arrows to move."
lang.tips_touch_the_green_goal = "Touch the green goal."
lang.tips_wait_not_teach_yet = "Wait, i didnt teach that yet!"
lang.tips_mayoiba_yabureru = "Mayoiba yabureru."
lang.tips_save_us = "SAVE US"
lang.tips_congratulations = "Congratulations!"
lang.tips_where_is_it = "Where is it?"
lang.tips_pressed_Y_to_shift = "Y shift dimensions."
lang.tips_left_and_right_to_move = "←→ move."
lang.tips_yellow_means_danger = "Yellow means danger."
lang.tips_fourD = {
	"You did it, nice work.",
	"Just like other our kind.",
	"We need to survive.",
	"But four don't answer.",
	"Hope we can meet again.",
}
lang.tips_conPolygon = {}

-- doc
----------------------------NEED--------------------------------
lang.docList = {}


return lang