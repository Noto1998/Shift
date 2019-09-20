local lang = {}

-- ui
function lang.ui_level_choice(Num, Name)   return "<\t第" .. Num .. "关 " .. Name .. "\t>"    end
lang.ui_key_start_and_move = "←→选择\tA开始"
lang.ui_key_reset = "select 重置"
lang.ui_key_music = "start ♫"
lang.ui_player_stuck = "玩家卡住"
lang.ui_level_finish = "关卡完成"
lang.ui_pressed_A_to_continue = "按A继续"

--level
lang.level_BlockLaser = "我来挡住"
lang.level_Contour = "等高线"
lang.level_Cross = "交叉"
lang.level_CrossTheRiver = "过河"
lang.level_DonkeyKong = "大金刚"
lang.level_Invisible = "隐形"
lang.level_OneShot = "一次机会"
lang.level_RockClimbing = "攀岩"
lang.level_Skull = "骷髅"
lang.level_SuperLaser = "不可能的任务"
lang.level_Tunnel = "隧道"
lang.level_Tutorial_Ball = "滚石"
lang.level_Tutorial_Move = "教学"
lang.level_Tutorial_Shift = "教学"
lang.level_Tutorial_Turret = "败者食尘"

--tips
lang.tips_use_arrows_to_move = "用方向键移动。"
lang.tips_touch_the_green_goal = "到达绿色终点。"
lang.tips_good_luck = "祝你好运。"
lang.tips_mayoiba_yabureru = "犹豫就会败北。"
lang.tips_save_us = "救救我们"
lang.tips_congratulations = "恭喜您通关游戏！"
lang.tips_find_us = "来找我们。"
lang.tips_fourD = {
	"恭喜你，你做到了。",
	"就像我们其他同胞那样。",
	"我们需要生存的方法。",
	"但四维从不回应。",
	"希望我们能再次相见。",
}
lang.tips_pressed_Y_to_shift = "按Y切换维度。"
lang.tips_left_and_right_to_move = "←→移动。"
lang.tips_yellow_is_dangerous = "黄色很危险。"


return lang