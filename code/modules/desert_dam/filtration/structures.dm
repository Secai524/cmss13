/turf/open/floor/filtrationside
	name = "filtration"
	icon = 'icons/turf/floors/filtration.dmi'
	icon_state = "filtrationside"

/turf/open/floor/filtrationside/is_plasteel_floor()
	return FALSE

/turf/open/floor/filtrationside/southwest
	dir = SOUTHWEST

/turf/open/floor/filtrationside/north
	dir = NORTH

/turf/open/floor/filtrationside/east
	dir = EAST

/turf/open/floor/filtrationside/northeast
	dir = NORTHEAST

/turf/open/floor/filtrationside/southeast
	dir = SOUTHEAST

/turf/open/floor/filtrationside/west
	dir = WEST

/turf/open/floor/filtrationside/northwest
	dir = NORTHWEST

/turf/open/floor/plating/catwalk/rusted
	icon = 'icons/turf/floors/filtration.dmi'
	icon_state = "grate"

/turf/open/floor/plating/catwalk/rusted/ex_act()
	return

/turf/open/floor/coagulation
	name = "coagulation"
	icon = 'icons/turf/floors/coagulation.dmi'
	icon_state = null

/turf/open/floor/coagulation/is_plasteel_floor()
	return FALSE

/turf/open/floor/coagulation/icon0_0
	icon_state = "0,0"

/turf/open/floor/coagulation/icon0_4
	icon_state = "0,4"

/turf/open/floor/coagulation/icon0_5
	icon_state = "0,5"

/turf/open/floor/coagulation/icon0_8
	icon_state = "0,8"

/turf/open/floor/coagulation/icon1_1
	icon_state = "1,1"

/turf/open/floor/coagulation/icon1_7
	icon_state = "1,7"

/turf/open/floor/coagulation/icon2_0
	icon_state = "2,0"

/turf/open/floor/coagulation/icon4_8
	icon_state = "4,8"

/turf/open/floor/coagulation/icon5_8
	icon_state = "5,8"

/turf/open/floor/coagulation/icon6_8
	icon_state = "6,8"

/turf/open/floor/coagulation/icon6_8_2
	icon_state = "6,8-2"

/turf/open/floor/coagulation/icon7_0
	icon_state = "7,0"

/turf/open/floor/coagulation/icon7_1
	icon_state = "7,1"

/turf/open/floor/coagulation/icon7_7
	icon_state = "7,7"

/turf/open/floor/coagulation/icon7_7_2
	icon_state = "7,7-2"

/turf/open/floor/coagulation/icon7_8
	icon_state = "7,8"

/turf/open/floor/coagulation/icon7_8_2
	icon_state = "7,8-2"

/turf/open/floor/coagulation/icon8_0
	icon_state = "8,0"

/turf/open/floor/coagulation/icon8_3
	icon_state = "8,3"

/turf/open/floor/coagulation/icon8_4
	icon_state = "8,4"

/turf/open/floor/coagulation/icon8_6
	icon_state = "8,6"

/turf/open/floor/coagulation/icon8_7
	icon_state = "8,7"

/turf/open/floor/coagulation/icon8_7_2
	icon_state = "8,7-2"

/turf/open/floor/coagulation/icon8_8
	icon_state = "8,8"

/obj/structure/filtration/coagulation
	name = "coagulation"
	icon = 'icons/turf/floors/coagulation.dmi'



/obj/structure/filtration
	unslashable = TRUE
	unacidable = TRUE
/*
/obj/structure/filtration
	icon = 'icons/obj/filtration/96x96.dmi'
	bound_x = 96
	bound_y = 96
	density = TRUE


/obj/structure/prop/almayer/anti_air_cannon
	name = "\improper Anti-air Cannon"
	desc = "一门用于射击飞船的防空炮。它看起来坏了。"
	icon = 'icons/effects/128x128.dmi'
	icon_state = "anti_air_cannon"
	density = TRUE
	anchored = TRUE
	layer = LADDER_LAYER
	bound_width = 128
	bound_height = 64
	bound_y = 64
*/
/obj/structure/filtration
	name = "过滤机"

/obj/structure/filtration/machine_32x32
	icon = 'icons/turf/floors/32x32.dmi'
	name = "过滤通道"
	//bound_x = 96
	//bound_y = 96
	density = FALSE
	anchored = TRUE
	bound_width = 32
	bound_height = 32

/obj/structure/filtration/machine_32x32/indestructible
	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE

/obj/structure/filtration/machine_32x32/indestructible/ex_act(severity)
	return

/obj/structure/filtration/machine_32x64
	icon = 'icons/obj/structures/props/industrial/32x64.dmi'
	density = TRUE
	anchored = TRUE
	bound_width = 32
	bound_height = 64

/obj/structure/filtration/machine_32x64/indestructible
	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE

/obj/structure/filtration/machine_32x64/indestructible/ex_act(severity)
	return

/obj/structure/filtration/machine_96x96
	icon = 'icons/obj/structures/props/industrial/96x96.dmi'
	//bound_x = 96
	//bound_y = 96
	density = TRUE
	anchored = TRUE
	bound_width = 96
	bound_height = 96

/obj/structure/filtration/machine_96x96/indestructible
	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE

/obj/structure/filtration/machine_96x96/indestructible/ex_act(severity)
	return

/obj/structure/filtration/machine_64x96
	icon = 'icons/obj/structures/props/industrial/64x96.dmi'
	//bound_x = 96
	//bound_y = 96
	density = TRUE
	anchored = TRUE
	bound_width = 64
	bound_height = 96

/obj/structure/filtration/machine_64x96/indestructible
	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE

/obj/structure/filtration/machine_64x96/indestructible/ex_act(severity)
	return

/obj/structure/filtration/machine_64x128
	icon = 'icons/obj/structures/props/industrial/64x128.dmi'
	//bound_x = 96
	//bound_y = 96
	density = TRUE
	anchored = TRUE
	bound_width = 64
	bound_height = 128

/obj/structure/filtration/machine_64x128/indestructible
	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE

/obj/structure/filtration/machine_64x128/indestructible/ex_act(severity)
	return

/obj/structure/filtration/coagulation_arm
	name = "凝结臂"
	desc = "一个带有四面的轴，设计用于旋转以帮助过滤水。"
	density = TRUE
	icon = 'icons/obj/structures/props/industrial/coagulation_arm.dmi'
	icon_state = "arm"
	layer = ABOVE_MOB_LAYER + 0.1
	bound_width = 96
	bound_height = 96

/obj/structure/filtration/flacculation_arm
	name = "絮凝臂"
	desc = "一根安装在轴上的长金属过滤杆，用于旋转进行絮凝。"
	density = TRUE
	icon = 'icons/obj/structures/props/industrial/flacculation_arm.dmi'
	icon_state = "flacculation_arm"
	bound_height = 32
	bound_width = 128
	layer = ABOVE_MOB_LAYER + 0.1

/obj/structure/filtration/collector_pipes
	name = "集水管"
	desc = "一系列从河流中收集水并将其输送到工厂进行过滤的管道。"
	icon = 'icons/obj/structures/props/industrial/pipes.dmi'
	icon_state = "upper_1" //use instances to set the types.
	bound_height = 32
	bound_width = 64

/obj/structure/filtration/machine_96x96
	icon = 'icons/obj/structures/props/industrial/96x96.dmi'

/obj/structure/filtration/machine_96x96/distribution
	name = "废物分配系统"
	desc = "这台机器将净化过程中剩余的废物分离出来，以便排入太空、回收利用或用于研究。"
	icon_state = "distribution"

/obj/structure/filtration/machine_96x96/sedimentation
	name = "沉淀过滤器"
	desc = "一种专门设计用于捕获和去除水中沉积物（如沙子、淤泥、泥土和铁锈）的水过滤器，同时保留营养矿物质，确保每次都能获得清爽、干净的口感。"
	icon_state = "sedimentation"

/obj/structure/filtration/machine_96x96/filtration
	name = "水过滤系统"
	desc = "一种水过滤器，用于分离水中的有机和无机物质、有害废物以及腐蚀性酸，以便进行进一步处理。"
	icon_state = "filtration"

/obj/structure/filtration/machine_96x96/disinfection
	name = "消毒过滤器"
	desc = "一种专门设计用于分离水中微生物（如病毒和细菌）的水过滤器。"
	icon_state = "disinfection"
