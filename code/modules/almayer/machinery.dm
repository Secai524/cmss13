//-----USS Almayer Machinery file -----//
// Put any new machines in here before map is released and everything moved to their proper positions.

/obj/structure/machinery/prop/almayer
	name = "通用阿尔迈耶号道具"
	desc = "此内容不应可见，如在游戏回合中看到并附有位置信息，请通过AHELP报告'ART-P01'。"

/obj/structure/machinery/prop/almayer/hangar/dropship_part_fabricator

/obj/structure/machinery/prop/almayer/computer/PC
	name = "个人桌面终端"
	desc = "一台连接至舰船计算机网络的小型计算机。"
	icon_state = "terminal1"

/obj/structure/machinery/prop/almayer/computer
	name = "系统计算机"
	desc = "一台连接至舰船系统的小型计算机。"

	density = FALSE
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 20

	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "terminal"

/obj/structure/machinery/prop/almayer/computer/ex_act(severity)
	switch(severity)
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if (prob(25))
				set_broken()
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if (prob(25))
				deconstruct(FALSE)
				return
			if (prob(50))
				set_broken()
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)
			return
		else
			return

/obj/structure/machinery/prop/almayer/computer/proc/set_broken()
	stat |= BROKEN
	update_icon()

/obj/structure/machinery/prop/almayer/computer/update_icon()
	..()
	icon_state = initial(icon_state)
	if(stat & BROKEN)
		icon_state += "b"
	if(stat & NOPOWER)
		icon_state = initial(icon_state)
		icon_state += "0"

/obj/structure/machinery/prop/almayer/computer/NavCon
	name = "导航控制台"
	desc = "用于规划舰船航线和航向的导航控制台。由于AI负责所有远程导航计算，此控制台仅用于系统内航线修正和轨道机动。别碰它！"

	icon_state = "retro"

/obj/structure/machinery/prop/almayer/computer/NavCon2
	name = "导航控制台2"
	desc = "用于规划舰船航线和航向的导航控制台。由于AI负责所有远程导航计算，此控制台仅用于系统内航线修正和轨道机动。别碰它！"

	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "retro2"

/obj/structure/machinery/prop/almayer/CICmap
	name = "地图桌"
	desc = "一张显示当前行动地点地图的桌子。"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "maptable"
	anchored = TRUE
	use_power = USE_POWER_IDLE
	density = TRUE
	idle_power_usage = 2
	var/minimap_flag = MINIMAP_FLAG_USCM
	var/drawing = TRUE

/obj/structure/machinery/prop/almayer/CICmap/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/tacmap, has_drawing_tools=drawing, minimap_flag=minimap_flag, has_update=drawing, drawing=drawing)

/obj/structure/machinery/prop/almayer/CICmap/Destroy()
	return ..()

/obj/structure/machinery/prop/almayer/CICmap/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(interact_checks(user))
		return TRUE

	if(locate(/atom/movable/screen/minimap) in user.client.screen) //This seems like the most effective way to do this without some wacky code
		to_chat(user, SPAN_WARNING("您已打开一个小地图！"))
		return
	var/datum/component/tacmap/tacmap_component = GetComponent(/datum/component/tacmap)
	tacmap_component.show_tacmap(user)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_move), user)

///Returns true if something prevents the user from interacting with this. used mainly with the drawtable
/obj/structure/machinery/prop/almayer/CICmap/proc/interact_checks(mob/user)
	if(!user.client)
		return TRUE

/obj/structure/machinery/prop/almayer/CICmap/on_unset_interaction(mob/user)
	. = ..()
	var/datum/component/tacmap/tacmap_component = GetComponent(/datum/component/tacmap)
	tacmap_component.on_unset_interaction(user)

//Bugfix to handle cases for ghosts/observers that don't automatically close uis on move.
/obj/structure/machinery/prop/almayer/CICmap/proc/on_move(mob/source, oldloc)
	SIGNAL_HANDLER
	if(Adjacent(source))
		return
	on_unset_interaction(source)
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

/obj/structure/machinery/prop/almayer/CICmap/computer
	name = "地图终端"
	desc = "一台显示当前行动地点地图的终端。"
	icon = 'icons/obj/vehicles/interiors/arc.dmi'
	icon_state = "cicmap_computer"
	density = FALSE

/obj/structure/machinery/prop/almayer/CICmap/upp
	minimap_flag = MINIMAP_FLAG_UPP

/obj/structure/machinery/prop/almayer/CICmap/clf
	minimap_flag = MINIMAP_FLAG_CLF

/obj/structure/machinery/prop/almayer/CICmap/pmc
	minimap_flag = MINIMAP_FLAG_PMC

//Nonpower using props

/obj/structure/prop/almayer
	name = "通用阿尔迈耶号道具"
	desc = "此内容不应可见，如在游戏回合中看到并附有位置信息，请通过AHELP报告'ART-P02'。"
	density = TRUE
	anchored = TRUE

/obj/structure/prop/almayer/minigun_crate
	name = "30毫米弹药箱"
	desc = "一个装满30毫米子弹的板条箱，用于运输机的一种武器吊舱。移动它需要某种起重设备。"
	icon = 'icons/obj/structures/props/dropship/dropship_ammo.dmi'
	icon_state = "30mm_crate"

/obj/structure/prop/almayer/computers
	var/hacked = FALSE

/obj/structure/prop/almayer/computers/update_icon()
	. = ..()

	overlays.Cut()

	if(hacked)
		overlays += "+hacked"

/obj/structure/prop/almayer/computers/mission_planning_system
	name = "\improper MPS IV computer"
	desc = "任务规划系统IV型（MPS IV），是美国殖民地海军陆战队为运输机飞行员提供的任务规划与航图绘制增强系统。完全能够根据作战需求自定义飞行路线和装备配置。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "mps"

/obj/structure/prop/almayer/computers/mapping_computer
	name = "\improper CMPS II computer"
	desc = "通用地图生成系统II型，能够从卫星和舰船系统接收传感输入，以标准化方式为所有USCM飞行员生成行星地图。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "mapping_comp"

/obj/structure/prop/almayer/computers/sensor_computer1
	name = "传感器计算机"
	desc = "经过改装、作为舰船传感器计算机使用的IBM 10系列计算机。虽然有些过时，但仍能胜任其职责。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "sensor_comp1"

/obj/structure/prop/almayer/computers/sensor_computer2
	name = "传感器计算机"
	desc = "经过改装、作为舰船传感器计算机使用的IBM 10系列计算机。虽然有些过时，但仍能胜任其职责。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "sensor_comp2"

/obj/structure/prop/almayer/computers/sensor_computer3
	name = "传感器计算机"
	desc = "经过改装、作为舰船传感器计算机使用的IBM 10系列计算机。虽然有些过时，但仍能胜任其职责。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "sensor_comp3"

/obj/structure/prop/almayer/missile_tube
	name = "\improper Mk 33 ASAT launcher system"
	desc = "冷发射管，可发射数种导弹。最常见的是用于攻击卫星和其他航天器的ASAT-21‘击剑手IV型’导弹，以及用于对地攻击的BGM-227‘大锤’导弹。"
	icon = 'icons/obj/structures/props/almayer/almayer_props96.dmi'
	icon_state = "missiletubenorth"
	bound_width = 32
	bound_height = 96
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/almayer/particle_cannon
	name = "\improper 75cm/140 Mark 74 General Atomics railgun"
	desc = "马克74型轨道炮是太空武器的顶尖装备。能够以每秒24公里的速度发射直径达四分之三米的炮弹。它还能使用多种弹种，并可通过其新设计的供弹系统随时更换。"
	icon = 'icons/obj/structures/machinery/artillery.dmi'
	icon_state = "1"
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/almayer/particle_cannon/corsat
	name = "\improper CORSAT-PROTO-QUANTUM-CALCULATOR"
	desc = ""

/obj/structure/prop/almayer/name_stencil
	name = "USS 阿尔迈耶号"
	desc = "印在船体上的舰名。"
	icon = 'icons/obj/structures/props/almayer/almayer_props64.dmi'
	icon_state = "almayer0"
	density = FALSE //dunno who would walk on it, but you know.
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/almayer/hangar_stencil
	name = "floor"
	desc = "印在机库地板上的大号数字，用于标识是哪一架运输机。"
	icon = 'icons/obj/structures/props/almayer/almayer_props96.dmi'
	icon_state = "dropship1"
	density = FALSE
	layer = ABOVE_TURF_LAYER


/obj/structure/prop/almayer/cannon_cables
	name = "\improper Cannon cables"
	desc = "一些粗大的电缆。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "cannon_cables"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = LADDER_LAYER
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/almayer/cannon_cables/ex_act()
	return

/obj/structure/prop/almayer/cannon_cables/bullet_act()
	return


/obj/structure/prop/almayer/cannon_cable_connector
	name = "\improper Cannon cable connector"
	desc = "大型火炮电缆的连接器。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "cannon_cable_connector"
	density = TRUE
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/almayer/cannon_cable_connector/ex_act()
	return

/obj/structure/prop/almayer/cannon_cable_connector/bullet_act()
	return








//------- Cryobag Recycler -------//
// Wanted to put this in, but since we still have extra time until tomorrow and this is really simple thing. It just recycles opened cryobags to make it nice-r for medics.
// Also the lack of sleep makes me keep typing cyro instead of cryo. FFS ~Art

/obj/structure/machinery/cryobag_recycler
	name = "冷冻袋回收器"
	desc = "一个类似小型坟墓的结构。能够回收使用过并已开封的冷冻袋，重新填充内衬并安装新的密封件。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "recycler"

	density = TRUE
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 20

//What is this even doing? Why is it making a new item?
/obj/structure/machinery/cryobag_recycler/attackby(obj/item/W, mob/user) //Hope this works. Don't see why not.
	. = ..()
	if (istype(W, /obj/item))
		if(W.name == "使用过的静滞袋") //possiblity for abuse, but fairly low considering its near impossible to rename something without VV
			var/obj/item/bodybag/cryobag/R = new /obj/item/bodybag/cryobag //lets give them the bag considering having it unfolded would be a pain in the ass.
			R.add_fingerprint(user)
			user.temp_drop_inv_item(W)
			qdel(W)
			user.put_in_hands(R)
			return TRUE
	. = ..()

/obj/structure/closet/basketball
	name = "运动衣柜"
	desc = "这是一个用于存放运动服装的储物柜。"
	icon_state = "purple"
	icon_closed = "purple"
	icon_opened = "purple_open"

/obj/structure/closet/basketball/Initialize()
	. = ..()
	new /obj/item/clothing/under/shorts/grey(src)
	new /obj/item/clothing/under/shorts/black(src)
	new /obj/item/clothing/under/shorts/red(src)
	new /obj/item/clothing/under/shorts/blue(src)
	new /obj/item/clothing/under/shorts/green(src)
