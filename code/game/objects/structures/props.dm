/obj/structure/prop/tower
	name = "被摧毁的通讯塔"
	desc = "一座旧的公司通讯塔，曾用于在亚空间实体间传输通讯。看来这座塔有过更好的日子。"
	icon = 'icons/obj/structures/machinery/comm_tower.dmi'
	icon_state = "comm_tower_destroyed"
	unslashable = TRUE
	unacidable = TRUE
	density = TRUE
	layer = ABOVE_FLY_LAYER
	bound_height = 96

/obj/structure/prop/dam
	density = TRUE

/obj/structure/prop/dam/drill
	name = "矿用钻机"
	desc = "一台老旧的矿用钻机，似乎是用来采矿的。也可能用来钻孔。"
	icon = 'icons/obj/structures/props/industrial/drill.dmi'
	icon_state = "drill"
	bound_height = 96
	var/on = FALSE//if this is set to on by default, the drill will start on, doi

/obj/structure/prop/dam/drill/attackby(obj/item/W, mob/user)
	. = ..()
	if(isxeno(user))
		return
	else if (ishuman(user) && HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		on = !on
		visible_message("你用力扳动\the [src]的控制杆。钻机轰鸣着启动。" , "[user] wrenches the controls of \the [src]. The drill jumps to life.")

		update()

/obj/structure/prop/dam/drill/proc/update()
	icon_state = "thumper[on ? "-on" : ""]"
	if(on)
		set_light(3)
		playsound(src, 'sound/machines/turbine_on.ogg')
	else
		set_light(0)
		playsound(src, 'sound/machines/turbine_off.ogg')
	return

/obj/structure/prop/dam/drill/Initialize()
	. = ..()
	update()

/obj/structure/prop/dam/truck
	name = "truck"
	desc = "一辆旧卡车，看起来抛锚了。"
	icon = 'icons/obj/structures/props/vehicles/vehicles.dmi'
	icon_state = "truck"
	bound_height = 64
	bound_width = 64
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/dam/truck/damaged
	icon_state = "truck_damaged"

/obj/structure/prop/dam/truck/mining
	name = "矿用卡车"
	desc = "一辆老旧的矿用卡车，看起来抛锚了。"
	icon_state = "truck_mining"

/obj/structure/prop/dam/truck/cargo
	name = "货运卡车"
	desc = "一辆旧货运卡车，看起来抛锚了。"
	icon_state = "truck_cargo"

/obj/structure/prop/dam/van
	name = "van"
	desc = "一辆旧厢式货车，看起来抛锚了。"
	icon = 'icons/obj/structures/props/vehicles/vehicles.dmi'
	icon_state = "van"
	bound_height = 64
	bound_width = 64
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/dam/van/damaged
	icon_state = "van_damaged"

/obj/structure/prop/dam/crane
	name = "货物起重机"
	icon = 'icons/obj/structures/props/vehicles/vehicles.dmi'
	icon_state = "crane"
	bound_height = 64
	bound_width = 64
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/dam/crane/damaged
	icon_state = "crane_damaged"

/obj/structure/prop/dam/crane/cargo
	icon_state = "crane_cargo"

/obj/structure/prop/dam/torii
	name = "鸟居"
	desc = "一座传统的日式拱门，由木材制成，装饰着灯笼。"
	icon = 'icons/obj/structures/props/furniture/torii.dmi'
	icon_state = "torii"
	density = FALSE
	pixel_x = -16
	layer = MOB_LAYER+0.5
	var/lit = 0

/obj/structure/prop/dam/torii/New()
	..()
	Update()

/obj/structure/prop/dam/torii/proc/Update()
	underlays.Cut()
	underlays += "shadow[lit ? "-lit" : ""]"
	icon_state = "torii[lit ? "-lit" : ""]"
	if(lit)
		set_light(6)
	else
		set_light(0)
	return

/obj/structure/prop/dam/torii/attack_hand(mob/user as mob)
	..()
	if(lit)
		lit = !lit
		visible_message("[user]熄灭了[src]上的灯笼。",
			"You extinguish the fires on [src].")
		Update()
	return

/obj/structure/prop/dam/torii/attackby(obj/item/W, mob/user)
	var/L
	if(lit)
		return
	if(iswelder(W))
		var/obj/item/tool/weldingtool/WT = W
		if(WT.isOn())
			L = 1
	else if(istype(W, /obj/item/tool/lighter/zippo))
		var/obj/item/tool/lighter/zippo/Z = W
		if(Z.heat_source)
			L = 1
	else if(istype(W, /obj/item/device/flashlight/flare))
		var/obj/item/device/flashlight/flare/FL = W
		if(FL.heat_source)
			L = 1
	else if(istype(W, /obj/item/tool/lighter))
		var/obj/item/tool/lighter/G = W
		if(G.heat_source)
			L = 1
	else if(istype(W, /obj/item/tool/match))
		var/obj/item/tool/match/M = W
		if(M.heat_source)
			L = 1
	else if(istype(W, /obj/item/weapon/energy/sword))
		var/obj/item/weapon/energy/sword/S = W
		if(S.active)
			L = 1
	else if(istype(W, /obj/item/device/assembly/igniter))
		L = 1
	else if(istype(W, /obj/item/attachable/attached_gun/flamer))
		L = 1
	else if(istype(W, /obj/item/weapon/gun/flamer))
		var/obj/item/weapon/gun/flamer/F = W
		if(!(F.flags_gun_features & GUN_TRIGGER_SAFETY))
			L = 1
		else
			to_chat(user, SPAN_WARNING("先打开引火器！"))

	else if(isgun(W))
		var/obj/item/weapon/gun/G = W
		for(var/slot in G.attachments)
			if(istype(G.attachments[slot], /obj/item/attachable/attached_gun/flamer))
				L = 1
				break
	else if(istype(W, /obj/item/tool/surgery/cautery))
		L = 1
	else if(istype(W, /obj/item/clothing/mask/cigarette))
		var/obj/item/clothing/mask/cigarette/C = W
		if(C.item_state == C.icon_on)
			L = 1
	else if(istype(W, /obj/item/tool/candle))
		if(W.heat_source > 200)
			L = 1
	if(L)
		visible_message("[user]在鸟居上从一个灯笼到另一个灯笼，安静地点燃每个灯芯。")
		lit = TRUE
		Update()

/obj/structure/prop/dam/gravestone
	name = "墓碑"
	desc = "一座传统日式风格的墓碑。"
	icon = 'icons/obj/structures/props/props.dmi'
	icon_state = "gravestone1"

/obj/structure/prop/dam/gravestone/New()
	..()
	icon_state = "gravestone[rand(1,4)]"

/obj/structure/prop/dam/boulder
	name = "boulder"
	icon_state = "boulder1"
	desc = "一块大石头。它没在烹饪任何东西。"
	icon = 'icons/obj/structures/props/natural/vegetation/dam.dmi'

/obj/structure/prop/dam/boulder/boulder1
	icon_state = "boulder1"

/obj/structure/prop/dam/boulder/boulder2
	icon_state = "boulder2"

/obj/structure/prop/dam/boulder/boulder3
	icon_state = "boulder3"


/obj/structure/prop/dam/large_boulder
	name = "boulder"
	desc = "一块大石头。它没在烹饪任何东西。"
	icon = 'icons/obj/structures/props/natural/boulder_large.dmi'
	bound_height = 64
	bound_width = 64

/obj/structure/prop/dam/large_boulder/boulder1
	icon_state = "boulder_large1"

/obj/structure/prop/dam/large_boulder/boulder2
	icon_state = "boulder_large2"

/obj/structure/prop/dam/wide_boulder
	name = "boulder"
	desc = "一块大石头。它没在烹饪任何东西。"
	icon = 'icons/obj/structures/props/natural/boulder_wide.dmi'
	bound_height = 32
	bound_width = 64

/obj/structure/prop/dam/wide_boulder/boulder1
	icon_state = "boulder1"

//Use these to replace non-functional machinery 'props' around maps from bay12

/obj/structure/prop/server_equipment
	name = "服务器机架"
	desc = "一个装满硬盘、微型计算机和以太网电缆的机架。"
	icon = 'icons/obj/structures/props/server_equipment.dmi'
	icon_state = "rackframe"
	density = TRUE
	health = 150

/obj/structure/prop/server_equipment/broken
	name = "损坏的服务器机架"
	desc = "一个曾经装满硬盘、微型计算机和以太网电缆的机架。不过现在大部分都散落在地板上了。"
	icon_state = "rackframe_broken"
	health = 100

/obj/structure/prop/server_equipment/yutani_server
	name = "汤谷操作系统服务器箱"
	desc = "汤谷操作系统是公司使用的专有操作系统，用于运行其大部分服务器、银行和管理系统。2144年的一次代码泄露让一些业余黑客认为汤谷操作系统大致基于2017年发布的TempleOS。但公司已驳斥了这些说法。"
	icon_state = "yutani_server_on"

/obj/structure/prop/server_equipment/yutani_server/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/structure/prop/server_equipment/yutani_server/broken
	icon_state = "yutani_server_broken"

/obj/structure/prop/server_equipment/yutani_server/off
	icon_state = "yutani_server_off"

/obj/structure/prop/server_equipment/laptop
	name = "laptop"
	desc = "笔记本电脑、便携式电脑、卷盘式电脑，所有这些以及更多产品，尽在您当地的维兰德超市电子产品区！"
	icon_state = "laptop_off"
	density = FALSE

/obj/structure/prop/server_equipment/laptop/closed
	icon_state = "laptop_closed"

/obj/structure/prop/server_equipment/laptop/on
	icon_state = "laptop_on"
	desc = "屏幕卡在某种可怕的、花哨的绿色启动循环中。所有文字都是鲁索埃克语，这是一种在UA和UPP空间边界的一些韩国定居点产生的克里奥尔语。"

//biomass turbine

/obj/structure/prop/turbine //maybe turn this into an actual power generation device? Would be cool!
	name = "动力涡轮机"
	icon = 'icons/obj/structures/props/industrial/biomass_turbine.dmi'
	icon_state = "biomass_turbine"
	desc = "一个靠天知道什么东西运行的巨型涡轮机。或许懂行的人能把它启动。"
	density = TRUE
	breakable = FALSE
	explo_proof = TRUE
	unslashable = TRUE
	unacidable = TRUE
	var/on = FALSE
	bound_width = 32
	bound_height = 96

/obj/structure/prop/turbine/attackby(obj/item/W, mob/user)
	. = ..()
	if(isxeno(user))
		return
	else if (ishuman(user) && HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		on = !on
		visible_message("你撬动[src]上的控制阀。机器一阵颤动。" , "[user] pries at the control valve on [src]. The entire machine shudders.")

		Update()

/obj/structure/prop/turbine/proc/Update()
	icon_state = "biomass_turbine[on ? "-on" : ""]"
	if (on)
		set_light(3)
		playsound(src, 'sound/machines/turbine_on.ogg')
	else
		set_light(0)
		playsound(src, 'sound/machines/turbine_off.ogg')
	return

/obj/structure/prop/turbine/ex_act(severity, direction)
	return

/obj/structure/prop/turbine_extras
	name = "动力涡轮机支架"
	icon = 'icons/obj/structures/props/industrial/biomass_turbine.dmi'
	icon_state = "support_struts_r"
	desc = "管道，或者是通向那个大家伙涡轮机的支撑架，也可能是用来支撑它的。"
	density = FALSE
	breakable = FALSE
	explo_proof = TRUE
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/turbine_extras/border
	name = "动力涡轮机警示条纹"
	icon_state = "biomass_turbine_border"
	desc = "警示标记。保持安全距离，高压危险！"
	layer = 2.5

/obj/structure/prop/turbine_extras/left
	name = "动力涡轮机支架"
	icon_state = "support_struts_l"

/obj/structure/prop/turbine_extras/ex_act(severity, direction)
	return

//power transformer

/obj/structure/prop/power_transformer
	name = "电力变压器"
	icon = 'icons/obj/structures/props/industrial/power_transformer.dmi'
	icon_state = "transformer"
	bound_width = 64
	bound_height = 64
	desc = "一种无源电气元件，用于控制电力流向哪些电路以及流向何处。"

//cash registers

/obj/structure/prop/cash_register
	name = "数字收银机"
	desc = "一款西格森品牌的销售点系统，接受信用芯片……如果有人操作的话也收现金。传闻说它们和西格森工作乔用的是同一款逻辑板。你的财务状况正变得不稳定。"
	icon = 'icons/obj/structures/props/cash_register.dmi'
	icon_state = "cash_register"
	density = TRUE
	health = 50

/obj/structure/prop/cash_register/open
	icon_state = "cash_register_open"

/obj/structure/prop/cash_register/broken
	icon_state = "cash_register_broken"

/obj/structure/prop/cash_register/broken/open
	icon_state = "cash_register_broken_open"

/obj/structure/prop/cash_register/off
	icon_state = "cash_register_off"

/obj/structure/prop/cash_register/off/open
	icon_state = "cash_register_off_open"

/obj/structure/prop/structure_lattice //instance me by direction for color variants
	name = "结构框架"
	desc = "就像钢筋，不过是太空版的。"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "structure_lattice"
	density = TRUE //impassable by default

/obj/structure/prop/resin_prop
	name = "树脂覆盖的物体"
	desc = "好吧，现在它没用了。"
	icon = 'icons/obj/resin_objects.dmi'
	icon_state = "watertank"

//indestructible props
/obj/structure/prop/invuln
	name = "可实例化对象"
	desc = "这需要由程序员来定义。"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "structure_lattice"
	explo_proof = TRUE
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/invuln/ex_act(severity, direction)
	return

/obj/structure/prop/invuln/static_corpse

/obj/structure/prop/invuln/static_corpse/afric_zimmer
	name = "阿夫里克·齐默曼少校"
	desc = "阿夫里克·齐默曼少校的遗骸。他们的整个头部都不见了。有人该为此落泪。"
	icon = 'icons/obj/structures/props/64x64.dmi'
	icon_state = "afric_zimmerman"
	density = FALSE

/obj/structure/prop/invuln/lifeboat_hatch_placeholder
	density = FALSE
	name = "故障舱口"
	desc = "对付这个，光靠撬棍可不够。"
	icon = 'icons/obj/structures/machinery/bolt_target.dmi'
	icon_state = "closed"

/obj/structure/prop/invuln/lifeboat_hatch_placeholder/terminal
	icon = 'icons/obj/structures/machinery/bolt_terminal.dmi'
	icon_state = "closed"

/obj/structure/prop/invuln/dropship_parts //for TG shuttle system
	density = TRUE

/obj/structure/prop/invuln/dropship_parts/beforeShuttleMove() //moves content but leaves the turf behind (for cool space turf)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS
		. &= ~MOVE_TURF

/obj/structure/prop/invuln/dropship_parts/lifeboat
	name = "救生艇"
	icon_state = ""
	icon = 'icons/turf/lifeboat.dmi'

#define STATE_COMPLETE 0
#define STATE_FUEL 1
#define STATE_IGNITE 2

/obj/structure/prop/brazier
	name = "brazier"
	desc = "火盆内的火焰为手电和照明弹提供了相对微弱的光芒，但没有什么能替代与朋友围坐在壁炉旁的感觉。"
	icon = 'icons/obj/structures/bonfire.dmi'
	icon_state = "brazier"
	density = TRUE
	health = 150
	light_range = 6
	light_on = TRUE
	/// What obj this becomes when it gets to its next stage of construction / ignition
	var/frame_type
	/// What is used to progress to the next stage
	var/state = STATE_COMPLETE

/obj/structure/prop/brazier/Initialize()
	. = ..()

	if(!light_on)
		set_light(0)

/obj/structure/prop/brazier/get_examine_text(mob/user)
	. = ..()
	switch(state)
		if(STATE_FUEL)
			. += "[src] requires wood to be fueled."
		if(STATE_IGNITE)
			. += "[src] needs to be lit."

/obj/structure/prop/brazier/attackby(obj/item/hit_item, mob/user)
	switch(state)
		if(STATE_COMPLETE)
			return ..()
		if(STATE_FUEL)
			if(!istype(hit_item, /obj/item/stack/sheet/wood))
				return ..()
			var/obj/item/stack/sheet/wood/wooden_boards = hit_item
			if(!wooden_boards.use(5))
				to_chat(user, SPAN_WARNING("木材不足！"))
				return
			user.visible_message(SPAN_NOTICE("[user]用[hit_item]填满了[src]。"))
		if(STATE_IGNITE)
			if(!hit_item.heat_source)
				return ..()
			if(!do_after(user, 3 SECONDS, INTERRUPT_MOVED, BUSY_ICON_BUILD))
				return
			user.visible_message(SPAN_NOTICE("[user]用[hit_item]点燃了[src]。"))

	new frame_type(loc)
	qdel(src)

/obj/structure/prop/brazier/frame
	name = "空火盆"
	desc = "一个空火盆。"
	icon_state = "brazier_frame"
	light_on = FALSE
	frame_type = /obj/structure/prop/brazier/frame/full
	state = STATE_FUEL

/obj/structure/prop/brazier/frame/full
	name = "空置的满火盆"
	desc = "一个空火盆。但它又是满的。什么情况？？？用热源点燃它，比如焊枪。"
	icon_state = "brazier_frame_filled"
	frame_type = /obj/structure/prop/brazier
	state = STATE_IGNITE

/obj/structure/prop/brazier/torch
	name = "torch"
	desc = "这是一支火把。"
	icon_state = "torch"
	density = FALSE
	light_range = 5

/obj/structure/prop/brazier/frame/full/torch
	name = "未点燃的火把"
	desc = "这是一支火把，但没点燃。用热源点燃它，比如焊枪。"
	icon_state = "torch_frame"
	frame_type = /obj/structure/prop/brazier/torch

/obj/item/prop/torch_frame
	name = "未点燃的火把"
	icon = 'icons/obj/structures/bonfire.dmi'
	desc = "这是一支火把，但没点燃也没放置。点击墙壁来放置它。"
	icon_state = "torch_frame"

/obj/structure/prop/brazier/frame/full/campfire
	name = "未点燃的篝火"
	desc = "一圈石头围着一堆木头。要是能点燃就好了。"
	icon_state = "campfire"
	frame_type = /obj/structure/prop/brazier/campfire
	density = FALSE

/obj/structure/prop/brazier/frame/full/campfire/smolder
	name = "闷烧的篝火"
	desc = "一堆曾经点燃但已熄灭的篝火。你仍能看到余烬，并有烟雾从中升起。"
	state = STATE_FUEL
	frame_type = /obj/structure/prop/brazier/frame/full/campfire

/obj/structure/prop/brazier/campfire
	name = "campfire"
	desc = "一圈石头围着一堆燃烧的木头。火焰熊熊，你能听到噼啪声。你或许可以踩灭它。"
	icon = 'icons/obj/structures/bonfire.dmi'
	icon_state = "campfire_on"
	density = FALSE
	///How many tiles the heating and sound goes
	var/heating_range = 2
	/// time between sounds
	var/time_to_sound = 20
	/// Time for it to burn through fuel
	var/fuel_stage_time = 1 MINUTES
	/// How much fuel it has
	var/remaining_fuel = 5 //Maxes at 5, but burns one when made
	/// If the fire can be manually put out
	var/extinguishable = TRUE
	/// Make no noise
	var/quiet = FALSE

/obj/structure/prop/brazier/campfire/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	fuel_drain(TRUE)

/obj/structure/prop/brazier/campfire/get_examine_text(mob/user)
	. = ..()
	switch(remaining_fuel)
		if(4 to INFINITY)
			. += "The fire is roaring."
		if(2 to 3)
			. += "The fire is burning warm."
		if(-INFINITY to 1)
			. += "The embers of the fire barely burns."

/obj/structure/prop/brazier/campfire/process(delta_time)
	if(!isturf(loc))
		return

	for(var/mob/living/carbon/human/mob in range(heating_range, src))
		if(mob.bodytemperature < T20C)
			mob.bodytemperature += min(floor(T20C - mob.bodytemperature)*0.7, 25)
			mob.recalculate_move_delay = TRUE

	if(quiet)
		return
	time_to_sound -= delta_time
	if(time_to_sound <= 0)
		playsound(loc, 'sound/machines/firepit_ambience.ogg', 15, FALSE, heating_range)
		time_to_sound = initial(time_to_sound)

/obj/structure/prop/brazier/campfire/attack_hand(mob/user)
	. = ..()
	if(!extinguishable)
		to_chat(user, SPAN_WARNING("你无法熄灭[src]。"))
		return
	to_chat(user, SPAN_NOTICE("你开始熄灭[src]。"))
	while(remaining_fuel)
		if(user.action_busy || !do_after(user, 3 SECONDS, INTERRUPT_MOVED, BUSY_ICON_BUILD))
			return
		fuel_drain()
		to_chat(user, SPAN_NOTICE("你继续熄灭[src]。"))
	visible_message(SPAN_NOTICE("[user]熄灭了[src]。"))

/obj/structure/prop/brazier/campfire/attackby(obj/item/attacking_item, mob/user)
	if(!istype(attacking_item, /obj/item/stack/sheet/wood))
		to_chat(user, SPAN_NOTICE("你无法用[attacking_item]给[src]添加燃料。"))
		return
	var/obj/item/stack/sheet/wood/fuel = attacking_item
	if(remaining_fuel >= initial(remaining_fuel))
		to_chat(user, SPAN_NOTICE("你无法再给[src]添加更多燃料。"))
		return
	if(!fuel.use(1))
		to_chat(user, SPAN_NOTICE("你没有足够的[attacking_item]来给[src]添加燃料。"))
		return
	visible_message(SPAN_NOTICE("[user]用[fuel]给[src]添加了燃料。"))
	remaining_fuel++

/obj/structure/prop/brazier/campfire/attack_alien(mob/living/carbon/xenomorph/xeno)
	if(!extinguishable)
		to_chat(xeno, SPAN_WARNING("你无法熄灭[src]。"))
		return
	to_chat(xeno, SPAN_NOTICE("你开始熄灭[src]。"))
	while(remaining_fuel)
		if(xeno.action_busy || !do_after(xeno, 1 SECONDS, INTERRUPT_MOVED, BUSY_ICON_HOSTILE))
			return
		fuel_drain()
		to_chat(xeno, SPAN_NOTICE("你继续熄灭[src]。"))
	visible_message(SPAN_WARNING("[xeno]熄灭了[src]！"))

/obj/structure/prop/brazier/campfire/proc/fuel_drain(looping)
	remaining_fuel--
	if(!remaining_fuel)
		new /obj/structure/prop/brazier/frame/full/campfire/smolder(loc)
		qdel(src)
		return
	if(!looping || !fuel_stage_time)
		return
	addtimer(CALLBACK(src, PROC_REF(fuel_drain), TRUE), fuel_stage_time)

/obj/structure/prop/brazier/campfire/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

#undef STATE_COMPLETE
#undef STATE_FUEL
#undef STATE_IGNITE

//ICE COLONY PROPS
//Thematically look to Blackmesa's Xen levels. Generic science-y props n' stuff.

/obj/structure/prop/ice_colony
	name = "prop"
	desc = "呼叫程序员（或地图设计师）——你不该看到这个！"
	icon = 'icons/obj/structures/props/ice_colony/props.dmi'
	projectile_coverage = 10

/obj/structure/prop/ice_colony/soil_net
	name = "土壤网格"
	desc = "科学家使用这些悬挂的网格在地面上叠加一个坐标格网进行研究。"
	icon_state = "soil_grid"

/obj/structure/prop/ice_colony/ice_crystal
	name = "冰晶"
	desc = "这是一个巨大的冰晶。尽管季节温度变化剧烈，但使其保持冻结的化学过程，正是美国大阿根廷科学团队在这颗“雪球”上研究的内容。"
	icon_state = "ice_crystal"

/obj/structure/prop/ice_colony/ground_wire
	name = "地线"
	desc = "一小段黑色电线悬挂在两个标记柱之间。可能用于标记区域。"
	icon_state = "small_wire"

/obj/structure/prop/ice_colony/poly_kevlon_roll
	name = "塑料卷"
	desc = "一大卷用于临时庇护所建造的聚凯夫拉塑料。"
	icon_state = "kevlon_roll"
	anchored = FALSE

/obj/structure/prop/ice_colony/surveying_device
	name = "测量设备"
	desc = "一个安装在三角架上的小型激光测量工具和摄像头。采用醒目的安全黄色。"
	icon_state = "surveying_device"
	anchored = FALSE

/obj/structure/prop/ice_colony/surveying_device/measuring_device
	name = "测量装置"
	desc = "某种用来测量东西的小玩意儿。"
	icon_state = "measuring_device"

/obj/structure/prop/ice_colony/dense
	health = 75
	density = TRUE

/obj/structure/prop/ice_colony/dense/attack_alien(mob/living/carbon/xenomorph/xeno)
	if(xeno.a_intent == INTENT_HARM)
		if(unslashable)
			return
		xeno.animation_attack_on(src)
		playsound(loc, 'sound/effects/metalhit.ogg', 25, 1)
		xeno.visible_message(SPAN_DANGER("[xeno]将[src]切碎！"),
		SPAN_DANGER("We slice [src] apart!"), null, 5, CHAT_TYPE_XENO_COMBAT)
		deconstruct(FALSE)
		return XENO_ATTACK_ACTION
	else
		attack_hand(xeno)
		return XENO_NONCOMBAT_ACTION

/obj/structure/prop/ice_colony/dense/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	deconstruct(FALSE)
	xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
	SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/ice_colony/dense/ice_tray
	name = "冰板托盘"
	icon_state = "ice_tray"
	desc = "这是一个装满深色冰板的托盘。"

/obj/structure/prop/ice_colony/dense/planter_box
	icon_state = "planter_box_soil"
	name = "培育箱"
	desc = "一个根茎格栅半埋在培育箱里。"

/obj/structure/prop/ice_colony/dense/planter_box/hydro
	icon_state = "hydro_tray"
	name = "水培格栅"
	desc = "一个连接着两个浮动浮筒的根茎格栅。"

/obj/structure/prop/ice_colony/dense/planter_box/plated
	icon_state = "planter_box_empty"
	name = "板式培育箱"
	desc = "种植箱是空的。"

/obj/structure/prop/ice_colony/flamingo
	density = FALSE
	name = "草坪火烈鸟"
	desc = "用于装饰你的郊区草坪……或者你的冰雪殖民地。"
	icon_state = "flamingo"

/obj/structure/prop/ice_colony/flamingo/festive
	name = "节日草坪火烈鸟"
	desc = "用于在节日期间装饰你的郊区草坪……或者你的冰雪殖民地。虽然在这地方没人有地球日历。"
	icon_state = "flamingo_santa"

/obj/structure/prop/ice_colony/hula_girl //todo, animate based on dropship movement -Monkey
	name = "草裙舞女郎"
	desc = "显然，夏威夷曾经有过海滩。"
	icon = 'icons/obj/structures/props/ice_colony/Hula.dmi'
	icon_state = "Hula_Gal"

/obj/structure/prop/ice_colony/tiger_rug
	name = "虎皮地毯"
	desc = "一张相当俗气但令人印象深刻的虎皮地毯。把它运到边疆地带一定花了笔巨款。"
	icon = 'icons/obj/structures/props/ice_colony/Tiger_Rugs.dmi'
	icon_state = "Bengal" //instanceable, lots of variants!

//HOLIDAY THEMED BULLSHIT

/obj/structure/prop/holidays
	projectile_coverage = 0
	density = FALSE
	icon = 'icons/obj/structures/props/holiday_props.dmi'
	desc = "临时节日结构物的父对象。如果你看到这条信息，去找个地图编辑员，告诉他们搜索错误代码：蛋奶酒喝太多了"//hello future mapper. Next time use the sub types or instance the desc. Thanks -past mapper.
	layer = 4
	health = 50
	anchored = TRUE

/obj/structure/prop/holidays/string_lights
	name = "M1型节日彩灯串"
	desc = "这些标准配发的M1型‘节日彩灯串’在结构支架间悬挂，随着阿尔迈耶号引擎的输出频率……或是本地电网的节奏闪烁发光。你最好让布拉沃班的人帮你查查到底是哪个。你这该死的陆战队员。"
	icon_state = "string_lights"


/obj/structure/prop/holidays/string_lights/corner
	icon_state = "strings_lights_corner"

/obj/structure/prop/holidays/string_lights/cap
	icon_state = "string_lights_cap"

/obj/structure/prop/holidays/wreath
	name = "M1型节日针叶花环"
	desc = "2140年，圣路易斯湾地下栖息地的两个不同下层区域因使用真针叶制成的花环而烧毁（证据指向一起‘银翼杀手’事件，但当地警方否认此说法），此后便配发这种花环。它们由‘松木’香味的聚凯夫拉材料制成。据美国走廊区的士兵说，在SACO骚乱期间，抗议者曾将这些花环塞进枕套，制成抵御软尖弹药的简易护甲。"
	icon_state = "wreath"
/obj/structure/prop/vehicles
	name = "van"
	desc = "一辆旧厢式货车，看起来抛锚了。"
	icon = 'icons/obj/structures/props/vehicles/vehicles.dmi'
	icon_state = "van"
	bound_height = 64
	bound_width = 64
	unslashable = FALSE
	unacidable = FALSE

/obj/structure/prop/vehicles/crawler
	name = "殖民地履带车"
	desc = "这是一种用于恶劣环境的履带式爬行车。由轨道蓝国际公司提供；‘您在航空航天领域的朋友。’维兰德-汤谷的子公司。"
	icon_state = "crawler"
	density = TRUE

/obj/structure/prop/vehicles/tank/twe
	name = "\improper FV150 Shobo MKII"
	desc = "FV150 肖博 MKII 是一款战斗侦察履带车，官方文件缩写为 CVR(T)。它于2175年由维兰德-汤谷公司与总部位于土星的重型车辆制造商加拉尔公司联合开发。考虑到从MKI在澳大利亚战争中的表现吸取的教训，MKII进行了重大的结构改动，并于2178年投入生产。它配备一门双联30毫米机炮和一挺L56A2型10x28毫米同轴机枪，辅以170发30毫米弹药和1600发10x28毫米弹药的存储量。肖博的最高时速为60英里，但在标准部署中，弹药满载并考虑地形因素后，其速度通常保持在55英里/小时。"
	icon = 'icons/obj/vehicles/twe_tank.dmi'
	icon_state = "twe_tank"
	density = TRUE

//overhead prop sets

/obj/structure/prop/invuln/overhead
	layer = ABOVE_FLY_LAYER
	icon = 'icons/obj/structures/props/industrial/overhead_ducting.dmi'
	icon_state = "flammable_pipe_1"

/obj/structure/prop/invuln/overhead/flammable_pipe
	name = "致密燃料管线"
	desc = "很可能极其易燃。"
	density = TRUE

/obj/structure/prop/invuln/overhead/flammable_pipe/fly
	density = FALSE


/obj/structure/prop/static_tank
	name = "液体储罐"
	desc = "警告，内容物处于压力下！"
	icon = 'icons/obj/structures/props/industrial/generic_props.dmi'
	icon_state = "tank"
	density = TRUE

/obj/structure/prop/static_tank/fuel
	desc = "内含十烷托索-海波司帕迪醇。一种非挥发性液体燃料，尝起来像橙子。除了用于大气层火箭助推器外，基本没什么其他用处。"
	icon_state = "weldtank_old"

/obj/structure/prop/static_tank/water
	desc = "内含非饮用水。侧面的标签指示你在饮用前需煮沸。它闻起来隐约有点像阿尔迈耶号上的淋浴间。"
	icon_state = "watertank_old"

/obj/structure/prop/broken_arcade
	desc = "你无法看清屏幕后的东西，看起来半人半机械。"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "arcadeb"
	name = "灵异电话，游戏，电影：II"

//INVULNERABLE PROPS

/obj/structure/prop/invuln
	layer = ABOVE_MOB_LAYER
	density = TRUE
	icon = 'icons/obj/structures/props/ice_colony/props.dmi'
	icon_state = "ice_tray"

/obj/structure/prop/invuln/catwalk_support
	name = "支撑格栅"
	icon_state = "support_lattice"
	desc = "一组大型钢制支撑梁的中间部分。"
	density = FALSE

/obj/structure/prop/invuln/minecart_tracks
	name = "rails"
	icon_state = "rail"
	icon = 'icons/obj/structures/props/mining.dmi'
	density =  0
	desc = "矿车和轨道车辆在此行驶。"
	layer = 3

/obj/structure/prop/invuln/minecart_tracks/bumper
	name = "轨道缓冲器"
	icon_state = "rail_bumpers"
	desc = "这（通常）用于在线路末端阻止矿车和其他轨道车辆。"

/obj/structure/prop/invuln/dense
	density = TRUE

/obj/structure/prop/invuln/dense/catwalk_support
	name = "支撑格栅"
	icon_state = "support_lattice"
	desc = "一组大型钢制支撑梁的基座。"

/obj/structure/prop/invuln/dense/ice_tray
	name = "冰板托盘"
	icon_state = "ice_tray"
	desc = "这是一个装满深色冰板的托盘。"

/obj/structure/prop/invuln/ice_prefab
	name = "预制结构"
	desc = "该结构由金属支撑杆和坚固的聚凯夫拉塑料制成。这种材料衍生自UA防弹背心、USCM和UPP制服所用的材料。松散的墙壁随着每一阵风晃动。"
	icon = 'icons/obj/structures/props/ice_colony/fabs_tileset.dmi'
	icon_state = "fab"
	density = TRUE
	layer = 3
	bound_width = 32
	bound_height = 32

/obj/structure/prop/invuln/ice_prefab/trim
	layer = ABOVE_MOB_LAYER
	density = FALSE

/obj/structure/prop/invuln/ice_prefab/roof_greeble
	icon = 'icons/obj/structures/props/ice_colony/fabs_greebles.dmi'
	icon_state = "antenna"
	layer = ABOVE_MOB_LAYER
	desc = "风向袋、空调机组、太阳能板，哦，我的天！"
	density = FALSE


/obj/structure/prop/invuln/ice_prefab/standalone
	density = TRUE
	icon = 'icons/obj/structures/props/ice_colony/fabs_64.dmi'
	icon_state = "orange"//instance icons
	layer = 3
	bound_width = 64
	bound_height = 64

/obj/structure/prop/invuln/ice_prefab/standalone/trim
	icon_state = "orange_trim"//instance icons
	layer = ABOVE_MOB_LAYER
	density = FALSE

/obj/structure/prop/invuln/remote_console_pod
	name = "远程控制台舱"
	desc = "一种用于将远程操控设备投送至USCM作战区域的空投舱。"
	icon = 'icons/obj/structures/droppod_32x64.dmi'
	icon_state = "techpod_open"
	layer = DOOR_CLOSED_LAYER

/obj/structure/prop/invuln/overhead_pipe
	name = "架空管道段"
	desc = ""
	icon = 'icons/obj/pipes/pipes.dmi'
	icon_state = "intact-scrubbers"
	projectile_coverage = 0
	density = FALSE
	layer = RIPPLE_LAYER

/obj/structure/prop/invuln/overhead_pipe/Initialize(mapload)
	. = ..()
	desc = "This is a section of the pipe network that carries water (and less pleasant fluids) throughout the [is_mainship_level(z) ? copytext(MAIN_SHIP_NAME, 5) : "colony"]."

///Decorative fire.
/obj/structure/prop/invuln/fire
	name = "fire"
	desc = "这火一时半会儿灭不了。"
	color = "#FF7700"
	icon = 'icons/effects/fire.dmi'
	icon_state = "dynamic_2"
	layer = MOB_LAYER
	light_range = 3
	light_on = TRUE

/obj/structure/prop/invuln/fusion_reactor
	name = "\improper S-52 fusion reactor"
	desc = "一台威斯汀兰S-52聚变反应堆。消耗燃料电池并将其转化为能量。同时产生大量热量。"
	icon = 'icons/obj/structures/machinery/fusion_eng.dmi'
	icon_state = "off"

/obj/structure/prop/invuln/pipe_water
	name = "管道水"
	desc = ""
	icon = 'icons/obj/structures/props/watercloset.dmi'
	icon_state = "water"
	density = 0

/obj/structure/prop/invuln/pipe_water/Initialize(mapload)
	. = ..()
	desc = "The [is_mainship_level(z) ? copytext(MAIN_SHIP_NAME, 5) : "colony"] has sprung a leak!"

/obj/structure/prop/invuln/lattice_prop
	desc = "一个轻质支撑框架。"
	name = "lattice"
	icon = 'icons/obj/structures/props/smoothlattice.dmi'
	icon_state = "lattice0"
	density = FALSE
	layer = RIPPLE_LAYER

/obj/structure/prop/wooden_cross
	name = "木制十字架"
	desc = "一个木制墓碑。是因为有人亲手制作而更显尊重，还是因为它粗糙且形状不规则而显得不那么尊重？"
	icon = 'icons/obj/structures/props/furniture/crosses.dmi'
	icon_state = "cross1"
	density = FALSE
	health = 30
	var/inscription
	var/obj/item/helmet
	///This is for cross dogtags.
	var/tagged = FALSE
	///This is for cross engraving/writing.
	var/engraved = FALSE
	var/dogtag_name
	var/dogtag_blood
	var/dogtag_assign

/obj/structure/prop/wooden_cross/Destroy()
	if(helmet)
		helmet.forceMove(loc)
		helmet = null
	if(tagged)
		var/obj/item/dogtag/new_info_tag = new(loc)
		new_info_tag.fallen_names = list(dogtag_name)
		new_info_tag.fallen_assgns = list(dogtag_assign)
		new_info_tag.fallen_blood_types = list(dogtag_blood)
	return ..()

/obj/structure/prop/wooden_cross/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/dogtag))
		var/obj/item/dogtag/dog = W
		if(!tagged)
			tagged = TRUE
			user.visible_message(SPAN_NOTICE("[user]将[W]披在[src]上。"))
			dogtag_name = popleft(dog.fallen_names)
			dogtag_assign = popleft(dog.fallen_assgns)
			dogtag_blood = popleft(dog.fallen_blood_types)
			if(!(dogtag_name in GLOB.fallen_list_cross))
				GLOB.fallen_list_cross += dogtag_name
			update_icon()
			if(!length(dog.fallen_names))
				qdel(dog)
			else
				return
		else
			to_chat(user, SPAN_WARNING("[src]上已经有一个身份牌了！"))
			balloon_alert(user, "这里已经有身份牌了！")

	if(istype(W, /obj/item/clothing/head))
		if(helmet)
			to_chat(user, SPAN_WARNING("[helmet]已经放在[src]上了！"))
			return
		if(!user.drop_inv_item_to_loc(W, src))
			return
		helmet = W
		dir = SOUTH
		var/image/visual_overlay = W.get_mob_overlay(null, WEAR_HEAD)
		visual_overlay.pixel_y = -10 //Base image is positioned to go on a human's head.
		overlays += visual_overlay
		to_chat(user, SPAN_NOTICE("你将\the [W]放在\the [src]上。"))
		return

	if(user.a_intent == INTENT_HARM)
		. = ..()
		if(W.force && !(W.flags_item & NOBLUDGEON))
			playsound(src, 'sound/effects/woodhit.ogg', 25, 1)
			update_health(W.force)
		return

	if(W.sharp || W.edge || HAS_TRAIT(W, TRAIT_TOOL_PEN) || istype(W, /obj/item/tool/hand_labeler))
		var/action_msg
		var/time_multiplier
		if(W.sharp || W.edge)
			action_msg = "carve something into"
			time_multiplier = 3
		else
			action_msg = "write something on"
			time_multiplier = 2

		var/message = sanitize(input(user, "你要在[src]上写什么？", "Inscription"))
		if(!message)
			return
		user.visible_message(SPAN_NOTICE("[user]开始[action_msg][src]。"),
			SPAN_NOTICE("You begin to [action_msg] [src]."), null, 4)

		if(!do_after(user, length(message) * time_multiplier, INTERRUPT_ALL, BUSY_ICON_GENERIC))
			to_chat(user, SPAN_WARNING("你被打断了！"))
		else
			user.visible_message(SPAN_NOTICE("[user]使用\his [W.name]来[action_msg][src]。"),
				SPAN_NOTICE("You [action_msg] [src] with your [W.name]."), null, 4)
			if(inscription)
				inscription += "\n[message]"
			else
				inscription = message
				engraved = TRUE

/obj/structure/prop/wooden_cross/get_examine_text(mob/user)
	. = ..()
	. += (tagged ? "There's a dog tag draped around the cross. The dog tag reads, \"[dogtag_name] - [dogtag_assign] - [dogtag_blood]\"." : "There's no dog tag draped around the cross.")
	. += (engraved ? "There's something carved into it. It reads: \"[inscription]\"" : "There's nothing carved into it.")

/obj/structure/prop/wooden_cross/attack_hand(mob/user)
	if(helmet)
		helmet.forceMove(loc)
		user.put_in_hands(helmet)
		to_chat(user, SPAN_NOTICE("你将\the [helmet]从\the [src]上取下。"))
		helmet = null
		overlays.Cut()

/obj/structure/prop/wooden_cross/attack_alien(mob/living/carbon/xenomorph/M)
	M.animation_attack_on(src)
	update_health(rand(M.melee_damage_lower, M.melee_damage_upper))
	playsound(src, 'sound/effects/woodhit.ogg', 25, 1)
	if(health <= 0)
		M.visible_message(SPAN_DANGER("[M]将[src]切碎！"),
		SPAN_DANGER("You slice [src] apart!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		M.visible_message(SPAN_DANGER("[M]劈砍[src]！"),
		SPAN_DANGER("You slash [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	return XENO_ATTACK_ACTION

/obj/structure/prop/wooden_cross/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/wooden_cross/update_icon()
	if(tagged)
		overlays += mutable_appearance('icons/obj/structures/props/furniture/crosses.dmi', "cross_overlay")


/obj/structure/prop/invuln/rope
	name = "rope"
	desc = "一条牢固的绳索看起来像是有人可能曾在那片岩石上藏身。"
	icon = 'icons/obj/structures/props/dropship/dropship_equipment.dmi'
	icon_state = "rope"
	density = FALSE

/obj/structure/prop/pred_flight
	name = "猎手飞行控制台"
	desc = "由猎手设计的控制台，用于辅助飞行路径规划和导航。"
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'
	icon_state = "overwatch"
	density = TRUE

/obj/structure/prop/invuln/joey
	name = "工作乔伊"
	desc = "一个从深库存中被一队陆战队员在上次上岸休假后取出的、已失效的西格森品牌工作乔。有人试图将这个清洁用合成人改装成简陋的酒保，但收效甚微。"
	icon = 'icons/obj/structures/props/props.dmi'
	icon_state = "joey"
	unslashable = FALSE
	wrenchable = FALSE
	/// converted into minutes when used to determine cooldown timer between quips
	var/quip_delay_minimum = 5
	/// delay between Quips. Slightly randomized with quip_delay_minimum plus a random number
	COOLDOWN_DECLARE(quip_delay)
	/// delay between attack voicelines. Short but done for anti-spam
	COOLDOWN_DECLARE(damage_delay)
	/// list of quip emotes, taken from Working Joe
	var/static/list/quips = list(
		/datum/emote/living/carbon/human/synthetic/working_joe/damage/alwaysknow_damaged,
		/datum/emote/living/carbon/human/synthetic/working_joe/quip/not_liking,
		/datum/emote/living/carbon/human/synthetic/working_joe/greeting/how_can_i_help,
		/datum/emote/living/carbon/human/synthetic/working_joe/farewell/day_never_done,
		/datum/emote/living/carbon/human/synthetic/working_joe/farewell/required_by_apollo,
		/datum/emote/living/carbon/human/synthetic/working_joe/warning/safety_breach
	)
	/// list of voicelines to use when damaged
	var/static/list/damaged = list(
		/datum/emote/living/carbon/human/synthetic/working_joe/damage/damage,
		/datum/emote/living/carbon/human/synthetic/working_joe/damage/that_stings,
		/datum/emote/living/carbon/human/synthetic/working_joe/damage/irresponsible,
		/datum/emote/living/carbon/human/synthetic/working_joe/damage/this_is_futile,
		/datum/emote/living/carbon/human/synthetic/working_joe/warning/hysterical,
		/datum/emote/living/carbon/human/synthetic/working_joe/warning/patience
	)

/obj/structure/prop/invuln/joey/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/prop/invuln/joey/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/prop/invuln/joey/process()
	//check if quip_delay cooldown finished. If so, random chance it says a line
	if(COOLDOWN_FINISHED(src, quip_delay) && prob(10))
		emote(pick(quips))
		var/delay = rand(3) + quip_delay_minimum
		COOLDOWN_START(src, quip_delay, delay MINUTES)

// Advert your eyes.
/obj/structure/prop/invuln/joey/attackby(obj/item/W, mob/user)
	attacked()
	return ..()

/obj/structure/prop/invuln/joey/bullet_act(obj/projectile/P)
	attacked()
	return ..()

/// A terrible way of handling being hit. If signals would work it should be used.
/obj/structure/prop/invuln/joey/proc/attacked()
	if(COOLDOWN_FINISHED(src, damage_delay) && prob(25))
		emote(pick(damaged))
		COOLDOWN_START(src, damage_delay, 8 SECONDS)

/// SAY THE LINE JOE
/obj/structure/prop/invuln/joey/proc/emote(datum/emote/living/carbon/human/synthetic/working_joe/emote)
	if (!emote)
		return FALSE

	for(var/mob/mob in hearers(src, null))
		mob.show_message("<span class='game say'><span class='name'>[src]</span>说，\"[initial(emote.say_message)]\"</span>", SHOW_MESSAGE_AUDIBLE)

	var/list/viewers = get_mobs_in_view(7, src)
	for(var/mob/current_mob in viewers)
		if(!(current_mob.client?.prefs.toggles_langchat & LANGCHAT_SEE_EMOTES))
			viewers -= current_mob
	langchat_speech(initial(emote.say_message), viewers, GLOB.all_languages, skip_language_check = TRUE)

	if(initial(emote.sound))
		playsound(loc, initial(emote.sound), 50, FALSE)
	return TRUE

// Body Bag Pile

/obj/structure/prop/body_bag_pile
	name = "尸袋堆"
	desc = "一堆随意堆放的尸袋，景象阴森。"
	icon = 'icons/obj/structures/props/64x64_bodybag_pile.dmi'
	icon_state = "bodybag_pile"
	bound_height = 64
	bound_width = 64
	density = TRUE
	layer = BIG_XENO_LAYER

/obj/structure/prop/body_bag_pile/charred
	name = "烧焦的尸袋堆"
	desc = "一堆阴森的裹尸袋杂乱地堆成小山，表面因高温而焦黑起泡。里面的东西已经部分烧毁。"
	icon = 'icons/obj/structures/props/64x64_bodybag_pile.dmi'
	icon_state = "bodybag_pile"
	bound_height = 64
	bound_width = 64
	density = TRUE
	dir = 4
	layer = BIG_XENO_LAYER

/obj/effect/decal/large_stain
	name = "大片污渍"
	desc = FALSE
	icon = 'icons/obj/structures/props/64x64_bodybag_pile.dmi'
	icon_state = "large_stain"
	layer = TURF_LAYER
	plane = FLOOR_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
