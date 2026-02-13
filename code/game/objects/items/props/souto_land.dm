//souto land props

/obj/structure/prop/souto_land
	name = "placeholder"
	desc = "欢迎来到索托之地！这个道具不应该被使用，所以请提交Gitlab并通知地图绘制员！"
	icon = 'icons/obj/structures/souto_land.dmi'
	density = FALSE
	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE //can't destroy these
	flags_atom = NOINTERACT

/obj/structure/prop/souto_land/ex_act(severity, direction)
	return

/obj/structure/prop/souto_land/streamer
	name = "橙色彩带"
	gender = PLURAL
	desc = "它们轻柔地飘动着。令人心酸。"
	icon_state = "streamers"
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/souto_land/pole
	name = "彩带杆"
	desc = "它将彩带连接到彩带上。"
	icon_state = "post"
	layer = ABOVE_MOB_LAYER


