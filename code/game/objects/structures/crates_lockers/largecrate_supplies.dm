/*SPAWNING LANDMARKS*/
//Check below to see what the crates contain, these landmarks will spawn in a bunch of crates at once, to make it easy to spawn in supplies.
/obj/effect/landmark/supplyspawner
	name = "补给生成器"
	var/list/supply = list()

/obj/effect/landmark/supplyspawner/New()
	..()
	if(/turf/open in range(1))
		var/list/T = list()
		for(var/turf/open/O in range(1))
			T += O
		if(length(supply))
			for(var/s in supply)
				var/amount = supply[s]
				for(var/i = 1, i <= amount, i++)
					new s (pick(T))
		sleep(-1)
	qdel(src)


/obj/effect/landmark/supplyspawner/weapons
	name = "武器补给"
	supply = list(
		/obj/structure/largecrate/supply/weapons/m41a = 2,
		/obj/structure/largecrate/supply/weapons/shotgun = 2,
		/obj/structure/largecrate/supply/weapons/m39 = 2,
		/obj/structure/largecrate/supply/weapons/pistols = 2,
		/obj/structure/largecrate/supply/weapons/flamers = 2,
		/obj/structure/largecrate/supply/weapons/hpr = 2,
		/obj/structure/closet/crate/secure/mortar_ammo/mortar_kit = 1,
		/obj/structure/largecrate/supply/explosives/mines = 2,
		/obj/structure/largecrate/supply/explosives/grenades = 2,
	)

/obj/effect/landmark/supplyspawner/ammo
	name = "弹药补给"
	supply = list(
		/obj/structure/largecrate/supply/ammo/m41a = 4,
		/obj/structure/largecrate/supply/ammo/m41a_box = 4,
		/obj/structure/largecrate/supply/ammo/shotgun = 4,
		/obj/structure/largecrate/supply/ammo/m39 = 4,
		/obj/structure/largecrate/supply/ammo/pistol = 4,
	)

/obj/effect/landmark/supplyspawner/engineering
	name = "工程补给"
	supply = list(
		/obj/structure/largecrate/supply/supplies/metal = 5,
		/obj/structure/largecrate/supply/supplies/plasteel = 3,
		/obj/structure/largecrate/supply/supplies/sandbags = 5,
		/obj/structure/largecrate/supply/generator = 1,
		/obj/structure/largecrate/supply/floodlights = 2,
		/obj/structure/largecrate/supply/supplies/flares = 3,
		/obj/structure/largecrate/supply/powerloader = 1,
		/obj/structure/largecrate/machine/recycler = 2,
	)

/obj/effect/landmark/supplyspawner/turrets
	name = "防御炮台补给"
	supply = list(
		/obj/structure/largecrate/supply/weapons/m56d = 2,
		/obj/structure/largecrate/supply/ammo/sentry = 1,
		/obj/structure/largecrate/supply/ammo/m56d = 1,
	)

/obj/effect/landmark/supplyspawner/food
	name = "食物箱补给"
	supply = list(/obj/structure/largecrate/supply/supplies/mre = 3, /obj/structure/largecrate/supply/supplies/water = 2)

/obj/effect/landmark/supplyspawner/medical
	name = "医疗补给"
	supply = list(
		/obj/structure/largecrate/supply/medicine/medkits = 2,
		/obj/structure/largecrate/supply/medicine/blood = 2,
		/obj/structure/largecrate/supply/medicine/iv = 2,
		/obj/structure/largecrate/supply/medicine/medivend = 2,
		/obj/structure/largecrate/machine/autodoc = 3,
		/obj/structure/largecrate/machine/bodyscanner = 1,
		/obj/structure/largecrate/machine/sleeper = 2,
		/obj/structure/largecrate/supply/medicine/optable = 1,
		/obj/structure/largecrate/supply/supplies/tables_racks = 1,
	)
/*NEW SUPPLY CRATES*/
//Lotsocrates for lotsosupplies for events, meaning less setup time.
//Wooden crates and not metal ones so we don't have a ton of metal crates laying around
//SHOULD contain everything needed for events. Should.

/obj/structure/largecrate/supply
	name = "补给箱"
	var/list/supplies = list()

/obj/structure/largecrate/supply/Initialize()
	. = ..()
	if(length(supplies))
		for(var/s in supplies)
			var/amount = supplies[s]
			for(var/i = 1, i <= amount, i++)
				new s (src)

/obj/structure/largecrate/supply/weapons
	name = "武器箱"
	icon_state = "chest"
	parts_type = /obj/item/stack/sheet/metal
	unpacking_sound = 'sound/effects/metalhit.ogg'

/obj/structure/largecrate/supply/weapons/m41a
	name = "\improper M41A pulse rifle weapons chest (x10)"
	desc = "一个武器箱，内含十支M41A步枪。"
	supplies = list(/obj/item/weapon/gun/rifle/m41a = 10)

/obj/structure/largecrate/supply/weapons/shotgun
	name = "\improper M37A2 pump action shotgun weapons chest (x10)"
	desc = "一个武器箱，内含十支M37A2泵动式霰弹枪。"
	supplies = list(/obj/item/weapon/gun/shotgun/pump/m37a = 10)

/obj/structure/largecrate/supply/weapons/m39
	name = "\improper M39 sub machinegun weapons chest (x8)"
	desc = "一个武器箱，内含八支M39冲锋枪。"
	supplies = list(/obj/item/weapon/gun/smg/m39 = 8)

/obj/structure/largecrate/supply/weapons/pistols
	name = "副武器箱 (x20)"
	desc = "一个武器箱，内含八支M44左轮手枪和十二支M4A3制式手枪。"
	supplies = list(/obj/item/weapon/gun/revolver/m44 = 6, /obj/item/weapon/gun/pistol/m4a3 = 12)

/obj/structure/largecrate/supply/weapons/flamers
	name = "\improper M240A1 incinerator weapons chest (x4)"
	desc = "一个武器箱，内含四套M240A1焚烧器。"
	supplies = list(/obj/item/weapon/gun/flamer/m240 = 4)

/obj/structure/largecrate/supply/weapons/hpr
	name = "\improper M41AE2 heavy pulse rifle weapons chest (x2)"
	desc = "一个武器箱，内含两支M41AE2重型脉冲步枪。"
	supplies = list(/obj/item/weapon/gun/rifle/lmg = 2)

/obj/structure/largecrate/supply/weapons/m56d
	name = "\improper M56D mounted smartgun chest (x2)"
	desc = "一个补给箱，内含两挺盒装的M56D架设式智能枪。"
	supplies = list(/obj/item/storage/box/m56d_hmg = 2)



/obj/structure/largecrate/supply/ammo
	name = "弹药箱"
	icon_state = "case"

/obj/structure/largecrate/supply/ammo/m41a
	name = "\improper M41A magazine case (x20)"
	desc = "一个弹药箱，内含20个M41A弹匣。"
	supplies = list(/obj/item/ammo_magazine/rifle = 20)

/obj/structure/largecrate/supply/ammo/m41a/half
	name = "\improper M41A magazine case (x10)"
	desc = "一个弹药箱，内含10个M41A弹匣。"
	supplies = list(/obj/item/ammo_magazine/rifle = 10)

/obj/structure/largecrate/supply/ammo/m41a_box
	name = "\improper M41A ammunition box case (x4)"
	desc = "一个弹药箱，内含四盒M41A 600发弹药。"
	supplies = list(/obj/item/ammo_box/rounds = 4)

/obj/structure/largecrate/supply/ammo/shotgun
	name = "12号口径弹药箱 (x20)"
	desc = "一个弹药箱，内含八盒独头弹、八盒鹿弹和四盒箭形弹。"
	supplies = list(/obj/item/ammo_magazine/shotgun/slugs = 8, /obj/item/ammo_magazine/shotgun/buckshot = 8, /obj/item/ammo_magazine/shotgun/flechette = 4)

/obj/structure/largecrate/supply/ammo/m39
	name = "\improper M39 HV magazine case (x16)"
	desc = "一个弹药箱，内含十六个M39高速弹匣。"
	supplies = list(/obj/item/ammo_magazine/smg/m39 = 16)

/obj/structure/largecrate/supply/ammo/m39/half
	name = "\improper M39 HV magazine case (x8)"
	desc = "一个弹药箱，内含八个M39高速弹匣。"
	supplies = list(/obj/item/ammo_magazine/smg/m39 = 8)

/obj/structure/largecrate/supply/ammo/pistol
	name = "副武器弹药箱 (x40)"
	desc = "一个弹药箱，内含十六个M44快速装弹器和二十四个M4A3弹匣。"
	supplies = list(/obj/item/ammo_magazine/revolver = 16, /obj/item/ammo_magazine/pistol = 24)

/obj/structure/largecrate/supply/ammo/pistol/half
	name = "副武器弹药箱 (x20)"
	desc = "一个弹药箱，内含八个M44快速装弹器和十二个M4A3弹匣。"
	supplies = list(/obj/item/ammo_magazine/revolver = 8, /obj/item/ammo_magazine/pistol = 12)

/obj/structure/largecrate/supply/ammo/sentry
	name = "\improper UA 571-C ammunition drum case (x6)"
	desc = "一个弹药箱，内含六个UA 571-C哨戒炮弹药鼓。"
	supplies = list(/obj/item/ammo_magazine/sentry = 6)

/obj/structure/largecrate/supply/ammo/m56d
	name = "\improper M56D ammunition drum case (x6)"
	desc = "一个弹药箱，内含六个M56D弹药鼓。"
	supplies = list(/obj/item/ammo_magazine/m56d = 6)



/obj/structure/largecrate/supply/explosives
	name = "爆炸物补给箱"
	desc = "一个装有爆炸物的箱子。"
	icon_state = "case_double"

/obj/structure/largecrate/supply/explosives/mines
	name = "\improper M20 claymore case (x25)"
	desc = "一个箱子，内含五盒M20“阔剑”地雷，每盒五枚。"
	supplies = list(/obj/item/storage/box/explosive_mines = 5)

/obj/structure/largecrate/supply/explosives/grenades
	name = "\improper M40 HDEP grenade case (x50)"
	desc = "一个装有2盒二十五发装M40 HDEP手榴弹的箱子。"
	supplies = list(/obj/item/storage/box/nade_box = 2)

/obj/structure/largecrate/supply/explosives/mortar_he
	name = "80毫米高爆迫击炮弹箱 (x25)"
	desc = "一个装有二十五发80毫米高爆迫击炮弹的箱子。"
	supplies = list(/obj/item/mortar_shell/he = 25)

/obj/structure/largecrate/supply/explosives/mortar_incend
	name = "80毫米燃烧迫击炮弹箱 (x25)"
	desc = "一个装有二十五发80毫米燃烧迫击炮弹的箱子。"
	supplies = list(/obj/item/mortar_shell/incendiary = 25)

/obj/structure/largecrate/supply/explosives/mortar_flare
	name = "80毫米照明迫击炮弹箱 (x25)"
	desc = "一个装有二十五发80毫米照明迫击炮弹的箱子。"
	supplies = list(/obj/item/mortar_shell/flare = 25)

/obj/structure/largecrate/supply/explosives/mortar_frag
	name = "80毫米破片迫击炮弹箱 (x25)"
	desc = "一个装有二十五发80毫米破片迫击炮弹的箱子。"
	supplies = list(/obj/item/mortar_shell/frag = 25)


/obj/structure/largecrate/supply/supplies
	name = "补给箱"
	icon_state = "secure_crate"

/obj/structure/largecrate/supply/supplies/flares
	name = "照明弹补给箱 (x200)"
	desc = "一个装有2箱照明弹的补给箱。"
	supplies = list(/obj/item/ammo_box/magazine/misc/flares = 2)

/obj/structure/largecrate/supply/supplies/metal
	name = "金属板补给箱 (x200)"
	desc = "一个装有四堆五十张金属板的补给箱。"
	supplies = list(/obj/item/stack/sheet/metal/large_stack = 4)

/obj/structure/largecrate/supply/supplies/plasteel
	name = "塑钢补给箱 (x60)"
	desc = "一个装有2堆30张塑钢板的补给箱。"
	supplies = list(/obj/item/stack/sheet/plasteel/medium_stack = 2)

/obj/structure/largecrate/supply/supplies/sandbags
	name = "沙袋补给箱 (x100)"
	desc = "一个装有四堆二十五个沙袋的补给箱。"
	supplies = list(/obj/item/stack/sandbags/large_stack = 4)

/obj/structure/largecrate/supply/supplies/tables_racks
	name = "存储解决方案箱 (x10, x10)"
	desc = "一个装有十个桌子部件和十个架子部件的箱子，用于快速搭建存储设施。"
	supplies = list(/obj/item/frame/table = 10, /obj/item/frame/rack = 10)

/obj/structure/largecrate/supply/supplies/mre
	name = "\improper USCM MRE crate (x60)"
	desc = "一个装有六十包USCM单兵即食口粮的补给箱。"
	supplies = list(/obj/item/ammo_box/magazine/misc/mre = 5)

/obj/structure/largecrate/supply/supplies/mre/wy
	name = "\improper W-Y brand rations crate (x60)"
	desc = "一个装有六十包维兰德-汤谷品牌口粮包的补给箱。"
	supplies = list(/obj/item/ammo_box/magazine/misc/mre/wy = 5)

/obj/structure/largecrate/supply/supplies/mre/twe
	name = "\improper TWE ORP rations crate (x60)"
	desc = "一个装有六十包TWE ORP口粮包的补给箱。"
	supplies = list(/obj/item/ammo_box/magazine/misc/mre/twe = 5)

/obj/structure/largecrate/supply/supplies/wy_emergency_food
	name = "\improper WY emergency nutrition briquettes crate (x100)"
	desc = "一个装有一百块维兰德-汤谷应急营养块的补给箱。"
	supplies = list(/obj/item/ammo_box/magazine/misc/mre/emergency = 5)

/obj/structure/largecrate/supply/supplies/water
	name = "\improper WY Bottled Water crate (x50)"
	desc = "一个装有五十瓶维兰德-汤谷瓶装泉水的箱子。"
	supplies = list(/obj/item/reagent_container/food/drinks/cans/waterbottle = 50)

/obj/structure/largecrate/supply/powerloader
	name = "\improper Caterpillar P-5000 Work Loader crate"
	desc = "一个装有一台折叠但已完全组装好的卡特彼勒P-5000工程装载机及其快速培训手册的箱子。"
	supplies = list(
		/obj/vehicle/powerloader = 1,
		/obj/item/pamphlet/skill/powerloader = 1,
	)

/obj/structure/largecrate/supply/floodlights
	name = "探照灯箱（x4）"
	desc = "一个装有四盏探照灯的板条箱。"
	supplies = list(/obj/structure/machinery/floodlight = 4)

/obj/structure/largecrate/supply/generator
	name = "\improper P.A.C.M.A.N. crate"
	desc = "一个装有P.A.C.M.A.N.发电机、一些燃料和一些电缆线圈的板条箱，用于启动和运行你的电力系统。"
	supplies = list(/obj/structure/machinery/power/power_generator/port_gen/pacman = 1, /obj/item/stack/sheet/mineral/phoron/medium_stack = 1, /obj/item/stack/cable_coil/yellow = 3)

/obj/structure/largecrate/supply/medicine
	name = "医疗箱"
	desc = "一个装有医疗用品的板条箱。"
	icon_state = "chest_white"
	parts_type = /obj/item/stack/sheet/metal
	unpacking_sound = 'sound/effects/metalhit.ogg'

/obj/structure/largecrate/supply/medicine/medkits
	name = "急救补给箱（x20）"
	desc = "一个医疗补给箱，内含六个高级、三个标准、三个烧伤、两个毒素、两个氧气和两个辐射急救包。"
	supplies = list(
		/obj/item/storage/firstaid/regular = 3,
		/obj/item/storage/firstaid/fire = 3,
		/obj/item/storage/firstaid/adv = 6,
		/obj/item/storage/firstaid/toxin = 2,
		/obj/item/storage/firstaid/o2 = 2,
		/obj/item/storage/firstaid/rad = 2,
	)

/obj/structure/largecrate/supply/medicine/blood
	name = "血液补给箱（x12）"
	desc = "一个医疗补给箱，内含十二袋O-型血。"
	supplies = list(/obj/item/reagent_container/blood/OMinus = 12)

/obj/structure/largecrate/supply/medicine/iv
	name = "\improper IV stand crate (x3)"
	desc = "一个医疗补给箱，内含三个静脉滴注器。"
	supplies = list(/obj/structure/machinery/iv_drip = 3)

/obj/structure/largecrate/supply/medicine/optable
	name = "医疗手术箱（x1）"
	desc = "一个装有手术台、两罐麻醉剂、一个手术套件、一些麻醉注射器和一些太空清洁剂的板条箱。"
	supplies = list(/obj/structure/machinery/optable = 1, /obj/item/storage/surgical_tray = 1, /obj/item/tank/anesthetic = 2, /obj/item/reagent_container/spray/cleaner = 1)

/obj/structure/largecrate/supply/medicine/medivend
	name = "\improper Wey-Med Plus crate (x1)"
	desc = "一个装有一台维兰德Plus医疗贩卖机的板条箱。"
	supplies = list(/obj/structure/machinery/cm_vending/sorted/medical = 1)


/obj/structure/largecrate/machine
	name = "机器箱"
	desc = "一个装有预组装机器的板条箱。"
	icon_state = "secure_crate_strapped"
	var/dir_needed = EAST //If set to anything but 0, will check that space before spawning in.
	var/unmovable = 1 //If set to 1, then on examine, the user will see a warning that states the contents cannot be moved after opened.

/obj/structure/largecrate/machine/get_examine_text(mob/user)
	. = ..()
	if(unmovable)
		. += SPAN_DANGER("!!WARNING!! CONTENTS OF CRATE UNABLE TO BE MOVED ONCE UNPACKAGED!")

/obj/structure/largecrate/machine/unpack(forced)
	if(parts_type)
		new parts_type(loc, 2)
	playsound(src, unpacking_sound, 35)
	qdel(src)

/obj/structure/largecrate/machine/attackby(obj/item/W as obj, mob/user as mob)
	if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		if(turf_blocked_check())
			to_chat(user, SPAN_WARNING("你需要一个开阔空间[dir_needed ? " to the [dir2text(dir_needed)] of the crate" : ""] in order to unpack \the [src]."))
			return
		if(alert(user, "你确定要在这里打开\the [src]吗？", "确认", "Yes", "No") != "Yes")
			return

		user.visible_message(SPAN_NOTICE("[user]撬开了\the [src]。"), SPAN_NOTICE("You pry open \the [src]."))
		unpack()
	else
		return attack_hand(user)

/obj/structure/largecrate/machine/proc/turf_blocked_check()
	var/turf/T
	var/turf_blocked = FALSE
	if(dir_needed)
		T = get_step(src, dir_needed)
		if(T.density)
			turf_blocked = TRUE
		else
			for(var/atom/movable/AM in T.contents)
				if(AM.density)
					turf_blocked = TRUE
					break
	else
		T = get_turf(loc)
		if(T.density) //I can totally imagine marines getting this crate on dense turf somehow
			turf_blocked = TRUE
		else
			for(var/atom/movable/AM in T.contents)
				if(AM.density)
					turf_blocked = TRUE
					break
	return turf_blocked

/obj/structure/largecrate/machine/recycler
	name = "回收机箱（x1）"
	desc = "一个装有一台回收机的板条箱，用于处理垃圾。"
	dir_needed = 0

/obj/structure/largecrate/machine/recycler/unpack()
	var/turf/T = get_turf(loc)
	if(!istype(T, /turf/open))
		return FALSE

	if(parts_type)
		new parts_type(loc, 2)
	playsound(src, unpacking_sound, 35)

	new /obj/structure/machinery/wo_recycler(loc)

	qdel(src)
	return TRUE

/obj/structure/largecrate/machine/autodoc
	name = "自动医生机箱（x1）"
	desc = "一个装有一台自动医疗机的板条箱。"

/obj/structure/largecrate/machine/autodoc/unpack()
	var/turf/T = get_turf(loc)
	if(!istype(T, /turf/open))
		return FALSE

	if(parts_type)
		new parts_type(loc, 2)
	playsound(src, unpacking_sound, 35)

	var/obj/structure/machinery/medical_pod/autodoc/unskilled/E = new (T)
	var/obj/structure/machinery/autodoc_console/C = new (get_step(T, dir_needed))
	E.connected = C
	C.connected = E

	qdel(src)
	return TRUE

/obj/structure/largecrate/machine/bodyscanner
	name = "身体扫描仪机箱（x1）"
	desc = "一个装有一台医疗身体扫描仪的板条箱。"

/obj/structure/largecrate/machine/bodyscanner/unpack()
	var/turf/T = get_turf(loc)
	if(!istype(T, /turf/open))
		return FALSE

	if(parts_type)
		new parts_type(loc, 2)
	playsound(src, unpacking_sound, 35)

	var/obj/structure/machinery/medical_pod/bodyscanner/E = new (T)
	var/obj/structure/machinery/body_scanconsole/C = new (get_step(T, dir_needed))
	C.connected = E

	qdel(src)
	return TRUE

/obj/structure/largecrate/machine/sleeper
	name = "医疗休眠舱机箱（x1）"
	desc = "一个装有一台医疗休眠舱的板条箱。"

/obj/structure/largecrate/machine/sleeper/unpack()
	var/turf/T = get_turf(loc)
	if(!istype(T, /turf/open))
		return FALSE

	if(parts_type)
		new parts_type(loc, 2)
	playsound(src, unpacking_sound, 35)

	var/obj/structure/machinery/medical_pod/sleeper/E = new (T)
	var/obj/structure/machinery/sleep_console/C = new (get_step(T, dir_needed))
	E.connected = C
	C.connected = E

	qdel(src)
	return TRUE

// Empty

/obj/structure/largecrate/empty/secure
	name = "安全补给箱"
	desc = "一个安全的板条箱。"
	icon_state = "secure_crate_strapped"
	var/strapped = TRUE

/obj/structure/largecrate/empty/secure/attackby(obj/item/W as obj, mob/user as mob)
	if (!strapped)
		..()
		return

	if (!W.sharp)
		to_chat(user, SPAN_NOTICE("你需要锋利的东西来割断绑带。"))
		return

	to_chat(user, SPAN_NOTICE("你开始割断[src]的绑带..."))

	if (do_after(user, 1.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
		to_chat(user, SPAN_NOTICE("你割断了绑带。"))
		icon_state = "secure_crate"
		strapped = FALSE

/obj/structure/largecrate/empty/case
	name = "存储箱"
	desc = "一个黑色存储箱。"
	icon_state = "case"

/obj/structure/largecrate/empty/case/double
	name = "cases"
	desc = "一摞黑色存储箱。"
	icon_state = "case_double"

/obj/structure/largecrate/empty/case/double/unpack()
	if(parts_type)
		new parts_type(loc, 2)
	for(var/obj/thing in contents)
		thing.forceMove(loc)
	new /obj/structure/largecrate/empty/case(loc)
	playsound(src, unpacking_sound, 35)
	qdel(src)

//----------------------------------------------------//
