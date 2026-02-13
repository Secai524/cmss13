//**********************Marine Gear**************************/

//MARINE COMBAT LIGHT

/obj/item/device/flashlight/combat
	name = "战斗手电筒"
	desc = "一种设计用于手持或安装在步枪上的手电筒，灯泡性能优于普通手电筒。"
	icon_state = "combat_flashlight"
	item_state = ""
	light_range = 6 //Pretty luminous, but still a flashlight that fits in a pocket

//MARINE SNIPER TARPS

/obj/item/bodybag/tarp
	name = "\improper V1 thermal-dampening tarp (folded)"
	desc = "USCM狙击手携带的伪装布。正确使用时，狙击手躺在布下几乎与周围环境无法区分。该布采用热信号抑制编织技术，可隐藏穿戴者的热信号、光学伪装并抑制气味。"
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "jungletarp_folded"
	w_class = SIZE_MEDIUM
	unfolded_path = /obj/structure/closet/bodybag/tarp
	unacidable = TRUE

/obj/item/bodybag/tarp/snow
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "snowtarp_folded"
	unfolded_path = /obj/structure/closet/bodybag/tarp/snow

/obj/item/bodybag/tarp/reactive
	name = "\improper V2 reactive thermal tarp (folded)"
	desc = "部分USCM步兵携带的伪装布。这种升级版伪装布在部署后能近乎完美地融入环境，前提是它能正确收集数据。该布能够隐藏穿戴者的热信号。"
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "reactivetarp_folded"
	unfolded_path = /obj/structure/closet/bodybag/tarp/reactive

/obj/item/bodybag/tarp/reactive/scout
	name = "\improper V3 reactive thermal tarp (folded)"
	desc = "V2型热信号伪装布的更紧凑改进版，主要用于运输阵亡或受伤的陆战队员。其伪装技术比早期型号更先进，伪装程度更高、速度更快，但需要特殊训练才能使用。"
	icon_state = "scouttarp_folded"
	w_class = SIZE_SMALL
	unfolded_path = /obj/structure/closet/bodybag/tarp/reactive/scout

/obj/structure/closet/bodybag/tarp
	name = "\improper V1 thermal-dampening tarp"
	bag_name = "\improper V1 thermal-dampening tarp"
	desc = "USCM狙击手携带的伪装布。正确使用时，狙击手躺在布下几乎与周围环境无法区分。该布采用热信号抑制编织技术，可隐藏穿戴者的热信号、光学伪装并抑制气味。"
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "jungletarp_closed"
	icon_closed = "jungletarp_closed"
	icon_opened = "jungletarp_open"
	open_sound = 'sound/effects/vegetation_walk_1.ogg'
	close_sound = 'sound/effects/vegetation_walk_2.ogg'
	item_path = /obj/item/bodybag/tarp
	anchored = FALSE
	var/uncloak_time = 3 //in SECONDS, this is how long it takes for the tarp to become fully visible again once it's opened from an invisible state
	var/cloak_time = 15 //ditto for cloaking
	var/closed_alpha = 60 //how much ALPHA the tarp has once it's fully cloaked.
	var/can_store_dead = FALSE
	var/is_animating = FALSE
	var/first_open = TRUE
	exit_stun = 1
	/// used to implement a delay before tarp can be entered again after opened (anti-exploit)
	COOLDOWN_DECLARE(toggle_delay)

/obj/structure/closet/bodybag/tarp/snow
	icon_state = "snowtarp_closed"
	icon_closed = "snowtarp_closed"
	icon_opened = "snowtarp_open"
	item_path = /obj/item/bodybag/tarp/snow

/obj/structure/closet/bodybag/tarp/reactive
	name = "\improper V2 reactive thermal tarp"
	bag_name = "\improper V2 reactive thermal tarp"
	desc = "部分USCM步兵携带的伪装布。这种升级版伪装布在部署后能近乎完美地融入环境，前提是它能正确收集数据。该布能够隐藏穿戴者的热信号。"
	icon_state = "reactivetarp_closed"
	icon_closed = "reactivetarp_closed"
	icon_opened = "reactivetarp_open"
	open_sound = 'sound/effects/vegetation_walk_1.ogg'
	close_sound = 'sound/effects/vegetation_walk_2.ogg'

	item_path = /obj/item/bodybag/tarp/reactive
	anchored = FALSE

/obj/structure/closet/bodybag/tarp/reactive/scout
	name = "\improper V3 reactive thermal tarp (folded)"
	bag_name = "\improper V3 reactive thermal tarp"
	desc = "V2型热信号伪装布的更紧凑改进版，主要用于运输阵亡或受伤的陆战队员。其伪装技术比早期型号更先进，伪装程度更高、速度更快，但需要特殊训练才能使用。\n手持使用或点击你相邻的地板来部署它，然后再次点击以收起，收起时会自动启动伪装。再次点击可打开并解除伪装。如果丢失，右键点击检查你周围的格子内容以找到它。"
	icon_state = "scouttarp_closed"
	icon_closed = "scouttarp_closed"
	icon_opened = "scouttarp_open"
	item_path = /obj/item/bodybag/tarp/reactive/scout
	cloak_time = 5
	closed_alpha = 10 //same as scout cloak alpha
	exit_stun = 1
	can_store_dead = TRUE

/obj/structure/closet/bodybag/tarp/reactive/scout/close(mob/user)
	if(!skillcheck(usr, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL) && usr.skills.get_skill_level(SKILL_SPEC_WEAPONS) != SKILL_SPEC_SCOUT)
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return
	. = ..()

/obj/structure/closet/bodybag/tarp/store_mobs(stored_units)//same as stasis bag proc
	var/list/mobs_can_store = list()
	for(var/mob/living/carbon/human/H in loc)
		if(H.buckled)
			continue
		if(H.stat == DEAD && !can_store_dead) // dead, nope
			continue
		mobs_can_store += H
	var/mob/living/carbon/human/mob_to_store
	if(length(mobs_can_store))
		mob_to_store = pick(mobs_can_store)
		mob_to_store.forceMove(src)
		mob_to_store.unset_interaction()
		stored_units += mob_size
	return stored_units

/obj/structure/closet/bodybag/tarp/proc/handle_cloaking()
	if(opened) //if we are OPENING the bag. It checks for opened because the handle_cloaking proc triggers AFTER the parent open() is called
		if(first_open) //if this is the first time we are opening it (ie not animated because the open proc is being triggered by putting it on the ground)
			alpha = 255
			first_open = FALSE
			return
		if(is_animating) //if it's not fully cloaked we don't want to do the whole animation from a fully cloaked state.
			alpha = 255
			is_animating = FALSE
			return
		else //not animating and not the first time we're opening it, therefore play the full animation from a fully cloaked state
			is_animating = TRUE
			animate(src, alpha = 255, time = uncloak_time SECONDS, easing = QUAD_EASING)
			spawn(uncloak_time SECONDS)
				is_animating = FALSE
				return
	else //if we are CLOSING the bag, animate as usual.
		is_animating = TRUE
		animate(src, alpha = closed_alpha, time = cloak_time SECONDS, easing = QUAD_EASING)
		spawn(cloak_time SECONDS)
			is_animating = FALSE //animation finished
			return

/obj/structure/closet/bodybag/tarp/open(mob/user, force)
	COOLDOWN_START(src, toggle_delay, 3 SECONDS) //3 seconds must pass before tarp can be closed
	. = ..()
	handle_cloaking()

/obj/structure/closet/bodybag/tarp/close(mob/user)
	if(!COOLDOWN_FINISHED(src, toggle_delay))
		to_chat(user, SPAN_WARNING("现在收起[src]还为时过早！"))
		return FALSE
	. = ..()
	handle_cloaking()

/obj/structure/broken_apc
	name = "\improper M577 armored personnel carrier"
	desc = "一个大型的装甲巨兽，能够运送陆战队员。\n这一个已经失去功能，停在那里。"
	anchored = TRUE
	opacity = TRUE
	density = TRUE
	icon = 'icons/obj/apc.dmi'
	icon_state = "apc"

/obj/item/reagent_container/food/snacks/protein_pack
	name = "不新鲜的USCM蛋白棒"
	desc = "你见过的最假的蛋白棒，覆盖着一层代用巧克力。制作这些的粉末是乳清替代品的替代品的替代品。"
	icon_state = "yummers"
	icon = 'icons/obj/items/food/mre_food/uscm.dmi'
	filling_color = "#ED1169"
	w_class = SIZE_TINY

/obj/item/reagent_container/food/snacks/protein_pack/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 8)
	bitesize = 4


/obj/item/reagent_container/food/snacks/mre_pack
	name = "\improper generic MRE pack"
	//trash = /obj/item/trash/USCMtray
	icon = 'icons/obj/items/food/trays.dmi'
	trash = null
	w_class = SIZE_SMALL

/obj/item/reagent_container/food/snacks/mre_pack/meal1
	name = "\improper USCM Prepared Meal (cornbread)"
	desc = "一盘标准的USCM食物。盘子里装着不新鲜的玉米面包、番茄酱和一些绿色糊状物。"
	icon_state = "MREa"
	filling_color = "#ED1169"

/obj/item/reagent_container/food/snacks/mre_pack/meal1/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal2
	name = "\improper USCM Prepared Meal (pork)"
	desc = "一盘标准的USCM食物。盘子里装着半生不熟的猪肉、糊状的玉米和一些水汪汪的土豆泥。"
	icon_state = "MREb"

/obj/item/reagent_container/food/snacks/mre_pack/meal2/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 2

/obj/item/reagent_container/food/snacks/mre_pack/meal3
	name = "\improper USCM Prepared Meal (pasta)"
	desc = "一盘标准的USCM食物。盘子里装着煮过头的意大利面、水浸的胡萝卜和两根薯条。"
	icon_state = "MREc"

/obj/item/reagent_container/food/snacks/mre_pack/meal3/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal4
	name = "\improper USCM Prepared Meal (pizza)"
	desc = "一盘标准的USCM食物。盘子里装着冷披萨、湿漉漉的青豆和一个糟糕的鸡蛋。除了披萨，吃点别的吧，肥仔。"
	icon_state = "MREd"

/obj/item/reagent_container/food/snacks/mre_pack/meal4/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 8)
	bitesize = 1

/obj/item/reagent_container/food/snacks/mre_pack/meal5
	name = "\improper USCM Prepared Meal (chicken)"
	desc = "一盘标准的USCM食物。盘子里装着湿乎乎的鸡肉、干巴巴的米饭和一块略显忧郁的西兰花。"
	icon_state = "MREe"

/obj/item/reagent_container/food/snacks/mre_pack/meal5/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal6
	name = "\improper USCM Prepared Meal (tofu)"
	desc = "USCM不供应豆腐，你这个吸草的嬉皮士。这面旗子标志着你的失败。"
	icon_state = "MREf"

/obj/item/reagent_container/food/snacks/mre_pack/meal6/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 2)
	bitesize = 1

/obj/item/reagent_container/food/snacks/mre_pack/xmas1
	name = "\improper USCM M25 'X-MAS' Meal: Sugar Cookies"
	desc = "USCM M25糖曲奇餐旨在给陆战队员带来圣诞的欢乐。但令上级军官困惑的是，为了节省成本，仅仅将蛋白棒制作成带有代用巧克力碎片的曲奇形状，并用人工色素水代替预期的牛奶，这一措施并未得到大多数陆战队员的认可。"
	icon_state = "mreCookies"
	black_market_value = 10

/obj/item/reagent_container/food/snacks/mre_pack/xmas1/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)
	reagents.add_reagent("sugar", 9)
	bitesize = 8

/obj/item/reagent_container/food/snacks/mre_pack/xmas2
	name = "\improper USCM M25 'X-MAS' Meal: Gingerbread Cookies"
	desc = "USCM M25姜饼曲奇餐旨在为陆战队员提供方便廉价的姜饼曲奇，以替代因费用上涨和基础节日庆祝课程成功率低得可笑而取消的年度姜饼制作课程。然而，由于成本节约措施，这些曲奇很少能激发快乐或节日气氛。"
	icon_state = "mreGingerbread"
	black_market_value = 10

/obj/item/reagent_container/food/snacks/mre_pack/xmas2/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)
	reagents.add_reagent("sugar", 9)
	bitesize = 8

/obj/item/reagent_container/food/snacks/mre_pack/xmas3
	name = "\improper USCM M25 'X-MAS' Meal: Fruitcake"
	desc = "USCM M25水果蛋糕餐是军官委员会设计的第三种餐食，作为M25项目的一部分；这体现在面包和葡萄干水果的糟糕硬度和酸味上。可以逻辑推断，提供这种选择的人比格林奇和吝啬鬼加起来还要糟糕，设计和准备这种水果蛋糕的人也一样。"
	icon_state = "mreFruitcake"
	black_market_value = 10

/obj/item/reagent_container/food/snacks/mre_pack/xmas3/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)
	reagents.add_reagent("sugar", 9)
	bitesize = 8

/obj/item/storage/box/pizza
	name = "食物配送箱"
	desc = "一个太空时代的食物储存设备，能够保持食物格外新鲜。实际上，它只是个盒子。"

/obj/item/storage/box/pizza/Initialize()
	. = ..()
	pixel_y = rand(-3,3)
	pixel_x = rand(-3,3)
	new /obj/item/reagent_container/food/snacks/donkpocket(src)
	new /obj/item/reagent_container/food/snacks/donkpocket(src)
	var/randsnack
	for(var/i = 1 to 3)
		randsnack = rand(0,5)
		switch(randsnack)
			if(0)
				new /obj/item/reagent_container/food/snacks/fries(src)
			if(1)
				new /obj/item/reagent_container/food/snacks/cheesyfries(src)
			if(2)
				new /obj/item/reagent_container/food/snacks/bigbiteburger(src)
			if(4)
				new /obj/item/reagent_container/food/snacks/taco(src)
			if(5)
				new /obj/item/reagent_container/food/snacks/hotdog(src)

/obj/item/paper/janitor
	name = "皱巴巴的纸"
	icon_state = "scrap"
	info = "In loving memory of Cub Johnson."

/obj/item/device/overwatch_camera
	name = "M5摄像装备"
	desc = "一个摄像头及相关头戴设备，旨在让陆战队指挥官能看到其部队所见。该设备的一个更坚固版本已集成到所有标准USCM战斗头盔中。"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	icon_state = "cam_gear_off"
	item_icons = list(
		WEAR_L_EAR = 'icons/mob/humans/onmob/clothing/ears.dmi',
		WEAR_R_EAR = 'icons/mob/humans/onmob/clothing/ears.dmi',
	)
	item_state_slots = list(
		WEAR_L_EAR = "cam_gear",
		WEAR_R_EAR = "cam_gear",
	)
	flags_equip_slot = SLOT_EAR
	var/obj/structure/machinery/camera/camera

/obj/item/device/overwatch_camera/Initialize(mapload, ...)
	. = ..()
	camera = new /obj/structure/machinery/camera/overwatch(src)
	AddComponent(/datum/component/overwatch_console_control)

/obj/item/device/overwatch_camera/Destroy()
	QDEL_NULL(camera)
	return ..()

/obj/item/device/overwatch_camera/equipped(mob/living/carbon/human/mob, slot)
	if(camera)
		camera.c_tag = mob.name
		camera.status = TRUE
		icon_state = "cam_gear_on"
		update_icon()
	..()

/obj/item/device/overwatch_camera/unequipped(mob/user, slot)
	. = ..()
	if(camera)
		camera.status = FALSE
		icon_state = "cam_gear_off"
		update_icon()

/obj/item/device/overwatch_camera/dropped(mob/user)
	if(camera)
		camera.c_tag = "未知"
	..()

/obj/item/device/overwatch_camera/hear_talk(mob/living/sourcemob, message, verb, datum/language/language, italics)
	SEND_SIGNAL(src, COMSIG_BROADCAST_HEAR_TALK, sourcemob, message, verb, language, italics, loc == sourcemob)

/obj/item/device/overwatch_camera/see_emote(mob/living/sourcemob, emote, audible)
	SEND_SIGNAL(src, COMSIG_BROADCAST_SEE_EMOTE, sourcemob, emote, audible, loc == sourcemob && audible)
