local lang = {}

-- ui
function lang.ui_level_choice(Num, Name)	return "<\tレベル" .. Num .. " " .. Name .. "\t>"	end
lang.ui_key_start_and_move = "←→ 選ぶ\tA 開始"
lang.ui_key_keyTips = "X ボタンの説明"
lang.ui_player_stuck = "player stuck"
lang.ui_level_finish = "ミッション完了！"
lang.ui_key_continue = "A 続ける"
lang.io_key_doc = "B ドキュメントを読む"
lang.ui_key_credits = "Y credits"
lang.ui_key_keyTipsList = {
	"\t方向のボタン - 移動\t\t",
	"\tY - 次元のスイッチ\t\t",
	"\tStart - 再起動\t\t",
	"\tSelect - 音楽のスイッチ\t\t",
	"\tB(ホールド) - メインメニューに戻る\t\t"
}
lang.ui_credits = {
	"企画|レベル\tYaolaotou",
	"プログラム|アート|音楽|レベル\tNoto",
	"翻訳|特別感谢\tHannibal",
}

-- level
lang.level_BlockLaser		= "私は受け止めます"
lang.level_Contour			= "等高線"
lang.level_Cross			= "十字架"
lang.level_CrossTheRiver	= "川を渡る"
lang.level_DonkeyKong		= "ゴリラ"
lang.level_Invisible		= "身を忍ぶ"
lang.level_OneShot			= "一回の機会"
lang.level_RockClimbing		= "岩を攀じる"
lang.level_Skull			= "どくろ"
lang.level_StandStraight	= "立つ"
lang.level_SuperLaser		= "不可能な任務"
lang.level_Tunnel			= "トンネル"
lang.level_Tutorial_Ball	= "転がの石"
lang.level_Tutorial_Move	= "教学"
lang.level_Tutorial_MoveCuboid = "ちょっと速くしてください"
lang.level_Tutorial_Shift	= "教学"
lang.level_Tutorial_Laser	= "Bit The Dust"

-- tips
lang.tips_use_arrows_to_move = "方向のボタン 移動。"
lang.tips_touch_the_green_goal = "緑のゴールに到着する。"
lang.tips_wait_not_teach_yet = "ちょっと待ってください，まだあなたにそのやり方を教えていません！"
lang.tips_mayoiba_yabureru = "迷えば 破れる。"
lang.tips_save_us = "助けてください"
lang.tips_congratulations = "Congratulations！"
lang.tips_where_is_it = "where_is_it？"
lang.tips_pressed_Y_to_shift = "Y 次元のスイッチ。"
lang.tips_left_and_right_to_move = "←→ 移動。"
lang.tips_yellow_means_danger = "Yellow means danger."

lang.tips_fourD = {}
lang.tips_conPolygon = {}
lang.tips_polygon = {}

-- doc
lang.docList = {}

return lang