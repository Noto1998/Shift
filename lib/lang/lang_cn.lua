local lang = {}

-- ui
function lang.ui_level_choice(Num, Name)   return "<\t第" .. Num .. "关 " .. Name .. "\t>"    end
lang.ui_key_start_and_move = "←→选择\tA开始"
lang.ui_key_keyTips = "X 按键说明"
lang.ui_player_stuck = "玩家卡住"
lang.ui_level_finish = "关卡完成"
lang.ui_pressed_A_to_continue = "按A继续"
lang.ui_key_credits = "Y 名单"
lang.ui_key_keyTipsList = {
	"\t方向键 - 移动\t\t",
	"\tY - 维度切换\t\t",
	"\tStart - 重置关卡\t\t",
	"\tSelect - 音乐开关\t\t",
	"\tB(长按) - 返回主界面\t\t"
}
lang.ui_credits = {
	"程序|美术|音乐|关卡\tNotoj",
	"策划|关卡\tJcat(Yaolaotou)"
}

--level
lang.level_BlockLaser		= "我来挡住"
lang.level_Contour			= "等高线"
lang.level_Cross			= "交叉"
lang.level_CrossTheRiver	= "过河"
lang.level_DonkeyKong		= "大金刚"
lang.level_Invisible		= "隐形"
lang.level_OneShot			= "一次机会"
lang.level_RockClimbing		= "攀岩"
lang.level_Skull			= "骷髅"
lang.level_SuperLaser		= "不可能的任务"
lang.level_Tunnel			= "隧道"
lang.level_Tutorial_Ball	= "滚石"
lang.level_Tutorial_Move	= "教学"
lang.level_Tutorial_Shift	= "教学"
lang.level_Tutorial_Turret	= "败者食尘"

--tips
lang.tips_use_arrows_to_move = "用方向键移动。"
lang.tips_touch_the_green_goal = "到达绿色终点。"
lang.tips_wait_not_teach_yet = "等一下，我还没教你这招呢！"
lang.tips_mayoiba_yabureru = "犹豫就会败北。"
lang.tips_save_us = "救救我们"
lang.tips_congratulations = "恭喜您通关游戏！"
lang.tips_where_is_it = "它去哪了？"
lang.tips_fourD = {
	"恭喜你，你做到了。",
	"就像我们其他同胞那样。",
	"我们需要生存的方法。",
	"但四维从不回应。",
	"希望我们能再次相见。",
}
lang.tips_pressed_Y_to_shift = "按Y切换维度。"
lang.tips_left_and_right_to_move = "←→移动。"
lang.tips_yellow_means_danger = "黄颜色意味着危险。"


return lang