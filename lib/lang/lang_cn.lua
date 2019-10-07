local lang = {}

-- ui
function lang.ui_level_choice(Num, Name)   return "<\t第" .. Num .. "关 " .. Name .. "\t>"    end
lang.ui_key_start_and_move = "←→ 选择\tA 开始"
lang.ui_key_keyTips = "X 按键说明"
lang.ui_player_stuck = "玩家卡住"
lang.ui_level_finish = "关卡完成！"
lang.ui_key_continue = "A 继续"
lang.io_key_doc = "B 阅读文档"
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

-- level
lang.level_BlockLaser		= "我来挡住"
lang.level_Contour			= "等高线"
lang.level_Cross			= "十字架"
lang.level_CrossTheRiver	= "过河"
lang.level_DonkeyKong		= "大金刚"
lang.level_Invisible		= "隐形"
lang.level_OneShot			= "一次机会"
lang.level_RockClimbing		= "攀岩"
lang.level_Skull			= "骷髅"
lang.level_StandStraight	= "站直"
lang.level_SuperLaser		= "不可能的任务"
lang.level_Tunnel			= "隧道"
lang.level_Tutorial_Ball	= "滚石"
lang.level_Tutorial_Move	= "教学"
lang.level_Tutorial_MoveCuboid = "速度的活"
lang.level_Tutorial_Shift	= "教学"
lang.level_Tutorial_Laser	= "败者食尘"

-- tips
lang.tips_use_arrows_to_move = "方向键 移动。"
lang.tips_touch_the_green_goal = "到达绿色终点。"
lang.tips_wait_not_teach_yet = "等一下，我还没教你这招呢！"
lang.tips_mayoiba_yabureru = "犹豫就会败北。"
lang.tips_save_us = "救救我们"
lang.tips_congratulations = "恭喜您通关游戏！"
lang.tips_where_is_it = "它去哪了？"
lang.tips_pressed_Y_to_shift = "Y 切换维度。"
lang.tips_left_and_right_to_move = "←→ 移动。"
lang.tips_yellow_means_danger = "黄颜色意味着危险。"
lang.tips_fourD = {
	"恭喜你，你做到了。",
	"就像我们其他同胞那样。",
	"我们需要生存的方法。",
	"但四维从不回应。",
	"希望我们能再次相见。",
}
lang.tips_conPolygon = {
	"哦，你到了，恭喜你。",
	"一个没有边的图形，",
	"居然能让你们这么臣服。",
	"而我们，只是略显独特，",
	"就被你们驱逐。",
	"好了，该迎接你的结局了。",
	"就像你的同胞一样。"
}
lang.tips_polygon = {
	"一切都是凹多边形策划的。
	凹多边形的目的是诱骗剩下的多边形，吞噬掉。
	我们打开了潘多拉魔盒。
	我们在三维没有厚度，
	但我们已经找到解决方案了，
	只要我们在一起。
	如果你准备好了，按下y。"
}

-- doc
lang.docList = {
	"你好，你可以叫我圆形。\n\n你可能很困惑。\n别担心，我会慢慢解释。\n这会是个漫长的故事。",
	"虽然我们现在分为三个势力，\n但在很久很久以前，\n所有形状都生活在一起。\n\n直到有一天，发生了一场袭击。",
	"很多圆形在袭击中丧生了。\n多边形和圆形暗自较劲了很久,\n我们当然先怀疑你们了。\n事后才发现，\n你们也对此毫不知情。",
	"你知道的，多边形并不团结。\n多边形中的大多数是凸多边形，\n一直看不起那些异类——\n凹多边形。\n他们不被国民接受，受到排挤。",
	"现在我们知道了，\n就是凹多边形策划了袭击。\n但诡异的是，\n我们一直找不到他们——\n仿佛他们隐形了。",
	"举个例子，假设一种，\n生活在1维的生物——\n对他们来说，世界是一条线。\n\n在他们旁边再画一条线，\n他们也无法察觉。",
	"对我们来说，世界是一个面。\n假设我们挑一个已知的维度，\n再加一个看不见的维度，\n在我们旁边再画另一个面呢？\n是的，这就是他们的秘诀。",
	"他们发明了一种仪器——\n就是屏幕左上角那个东西，\n姑且称为维度遥控器吧。\n它能从3个维度中挑选2个维度，\n所以他们可以躲进另一个面里。",
	"后来，大家都掌握了这项技术。\n三维有三个维度，\n两两组合后，可以构成3个面。\n所以我们分成了三派，\n凸多边形、凹多边形、圆形。",
	"我们三方和平生活了很长时间。\n只是有个问题——\n我们从来没遇到过三维生物。\n而随着探索，我们发现，\n三维世界里遍布着绿色物体。",
	"触碰绿色物体时，\n就进入一个新的世界。\n左上角虽然看着没变化——\n都怪负责美术的多边形偷懒，\n但研究发现，\n三个维度每次都不一样。",
	"经过研究，我们意识到，\n这是某种更高级的维度遥控器。\n但不再是3维中挑选2维，\n\n而是n维中挑选3维。\n会是三维生物的产物吗？\n不清楚。",
	"后来我们又发现了黄色物体，\n触碰后，时间发生了重置。\n空间恢复成了刚进入时的状态。\n同样，不知道是谁留下的，\n只能感叹他们高超的科技水平。",
	"实际上，你设备上的start键，\n就绑着一小块黄色物体。\n我们还觉得挺方便的。\n但是渐渐出现了问题——\n不同的三维空间里，\n时间开始不同步了。",
	"不过问题不大，\n我，智慧的圆，\n会解决一切问题。\n来找我吧。",
	-- finish
	"还有多边形在这个频道上吗？\n我们被入侵了！别相信圆！\n\n圆并不是损失惨重，\n圆全灭了！",
	-- SuperLaser
	"我们回不去了。\n就像两只秒表，想要同步它们，\n你需要能同时观察它们。\n我们打开了潘多拉魔盒。"
}
-- for test
--lang.docList[1] = lang.docList[18]

return lang