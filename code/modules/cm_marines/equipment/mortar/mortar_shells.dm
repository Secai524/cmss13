/obj/item/mortar_shell
	name = "\improper 80mm mortar shell"
	desc = "一枚未标记的80毫米迫击炮弹，可能是个弹壳。"
	icon = 'icons/obj/structures/mortar.dmi'
	icon_state = "mortar_ammo_cas"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	w_class = SIZE_HUGE
	flags_atom = FPRINT|CONDUCT
	var/datum/cause_data/cause_data
	ground_offset_x = 7
	ground_offset_y = 6
	/// is it currently on fire and about to explode?
	var/burning = FALSE


/obj/item/mortar_shell/Destroy()
	. = ..()
	cause_data = null

/obj/item/mortar_shell/proc/detonate(turf/T)
	forceMove(T)

/obj/item/mortar_shell/proc/deploy_camera(turf/T)
	var/obj/structure/machinery/camera/mortar/old_cam = locate() in T
	if(old_cam)
		qdel(old_cam)
	new /obj/structure/machinery/camera/mortar(T)

/obj/item/mortar_shell/he
	name = "\improper 80mm high explosive mortar shell"
	desc = "一枚80毫米迫击炮弹，装有高爆炸药。"
	icon_state = "mortar_ammo_he"
	item_state = "mortar_ammo_he"

/obj/item/mortar_shell/he/detonate(turf/T)
	explosion(T, 0, 3, 5, 7, explosion_cause_data = cause_data)

/obj/item/mortar_shell/frag
	name = "\improper 80mm fragmentation mortar shell"
	desc = "一枚80毫米迫击炮弹，装有破片杀伤炸药。"
	icon_state = "mortar_ammo_frag"
	item_state = "mortar_ammo_frag"

/obj/item/mortar_shell/frag/detonate(turf/T)
	create_shrapnel(T, 60, cause_data = cause_data, shrapnel_type = /datum/ammo/bullet/shrapnel/breaching)
	sleep(2)
	cell_explosion(T, 60, 20, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, cause_data)

/obj/item/mortar_shell/incendiary
	name = "\improper 80mm incendiary mortar shell"
	desc = "一枚80毫米迫击炮弹，装有B型凝固汽油炸药。非常适合远距离区域封锁。"
	icon_state = "mortar_ammo_inc"
	item_state = "mortar_ammo_inc"
	var/radius = 5
	var/flame_level = BURN_TIME_TIER_5 + 5 //Type B standard, 50 base + 5 from chemfire code.
	var/burn_level = BURN_LEVEL_TIER_2
	var/flameshape = FLAMESHAPE_DEFAULT
	var/fire_type = FIRE_VARIANT_TYPE_B //Armor Shredding Greenfire

/obj/item/mortar_shell/incendiary/detonate(turf/T)
	flame_radius(cause_data, radius, T, flame_level, burn_level, flameshape, null, fire_type)
	playsound(T, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)

/obj/item/mortar_shell/flare
	name = "\improper 80mm flare/camera mortar shell"
	desc = "一枚80毫米迫击炮弹，装有照明弹/摄像头组合装置，并附有降落伞。"
	icon_state = "mortar_ammo_flr"
	item_state = "mortar_ammo_flr"

/obj/item/mortar_shell/flare/detonate(turf/T)
	new /obj/item/device/flashlight/flare/on/illumination(T)
	playsound(T, 'sound/weapons/gun_flare.ogg', 50, 1, 4)
	deploy_camera(T)

/obj/item/mortar_shell/custom
	name = "\improper 80mm custom mortar shell"
	desc = "一枚80毫米迫击炮弹。"
	icon_state = "mortar_ammo_custom"
	item_state = "mortar_ammo_custom_locked"
	matter = list("metal" = 18750) //5 sheets
	var/obj/item/explosive/warhead/mortar/warhead
	var/obj/item/reagent_container/glass/fuel
	var/fuel_requirement = 60
	var/fuel_type = "hydrogen"
	var/locked = FALSE

/obj/item/mortar_shell/custom/get_examine_text(mob/user)
	. = ..()
	if(fuel)
		. += SPAN_NOTICE("Contains fuel.")
	if(warhead)
		. += SPAN_NOTICE("Contains a warhead[warhead.has_camera ? " with integrated camera drone." : ""].")

/obj/item/mortar_shell/custom/detonate(turf/T)
	if(fuel)
		var/fuel_amount = fuel.reagents.get_reagent_amount(fuel_type)
		if(fuel_amount >= fuel_requirement)
			forceMove(T)
			if(warhead?.has_camera)
				deploy_camera(T)
	if(warhead && locked && warhead.detonator)
		warhead.cause_data = cause_data
		warhead.prime()

/obj/item/mortar_shell/custom/attack_self(mob/user)
	..()

	if(locked)
		return

	if(warhead)
		user.put_in_hands(warhead)
		warhead = null
	else if(fuel)
		user.put_in_hands(fuel)
		fuel = null
	icon_state = initial(icon_state)

/obj/item/mortar_shell/custom/attackby(obj/item/W as obj, mob/user)
	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		to_chat(user, SPAN_WARNING("你不知道如何摆弄[name]。"))
		return
	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER))
		if(!warhead)
			to_chat(user, SPAN_NOTICE("[name]必须装有弹头才能这么做！"))
			return
		if(locked)
			to_chat(user, SPAN_NOTICE("你解锁了[name]。"))
			icon_state = initial(icon_state) +"_unlocked"
		else
			to_chat(user, SPAN_NOTICE("你锁上了[name]。"))
			if(fuel && fuel.reagents.get_reagent_amount(fuel_type) >= fuel_requirement)
				icon_state = initial(icon_state) +"_locked"
			else
				icon_state = initial(icon_state) +"_no_fuel"
		locked = !locked
		playsound(loc, 'sound/items/Screwdriver.ogg', 25, 0, 6)
		return
	else if(istype(W,/obj/item/reagent_container/glass) && !locked)
		if(fuel)
			to_chat(user, SPAN_DANGER("[name]已经装有燃料容器了！"))
			return
		else
			user.temp_drop_inv_item(W)
			W.forceMove(src)
			fuel = W
			to_chat(user, SPAN_DANGER("你将[W]装入[name]。"))
			playsound(loc, 'sound/items/Screwdriver2.ogg', 25, 0, 6)
	else if(istype(W,/obj/item/explosive/warhead/mortar) && !locked)
		if(warhead)
			to_chat(user, SPAN_DANGER("[name]已经装有弹头了！"))
			return
		var/obj/item/explosive/warhead/mortar/det = W
		if(det.assembly_stage < ASSEMBLY_LOCKED)
			to_chat(user, SPAN_DANGER("[W]未固定！"))
			return
		user.temp_drop_inv_item(W)
		W.forceMove(src)
		warhead = W
		to_chat(user, SPAN_DANGER("你将[W]装入[name]。"))
		icon_state = initial(icon_state) +"_unlocked"
		playsound(loc, 'sound/items/Screwdriver2.ogg', 25, 0, 6)

/obj/item/mortar_shell/ex_act(severity, explosion_direction)
	if(!burning)
		return ..()

/obj/item/mortar_shell/attack_hand(mob/user)
	if(burning)
		to_chat(user, SPAN_DANGER("[src]着火了，可能会爆炸！"))
		return
	return ..()

/obj/item/mortar_shell/flamer_fire_act(dam, datum/cause_data/flame_cause_data)
	addtimer(VARSET_CALLBACK(src, burning, FALSE), 5 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_DELETE_ME)

	if(burning)
		return
	burning = TRUE
	cause_data = create_cause_data("Burning Mortar Shell", flame_cause_data.resolve_mob(), src)
	handle_fire(cause_data)

/obj/item/mortar_shell/proc/can_explode()
	return TRUE

/obj/item/mortar_shell/custom/can_explode()
	for(var/obj/item/reagent_container/glass/container in warhead?.containers)
		for(var/datum/reagent/reagent in container?.reagents?.reagent_list)
			if(reagent.explosive)
				return TRUE

	return FALSE

/obj/item/mortar_shell/flare/can_explode()
	return FALSE

/obj/item/mortar_shell/proc/handle_fire(cause_data)
	if(can_explode())
		visible_message(SPAN_WARNING("[src]着火并开始走火！要爆炸了！"))
		anchored = TRUE // don't want other explosions launching it elsewhere
		var/datum/effect_system/spark_spread/sparks = new()
		sparks.set_up(n = 10, loca = loc)
		sparks.start()
		new /obj/effect/warning/explosive(loc, 5 SECONDS)

		addtimer(CALLBACK(src, PROC_REF(explode), cause_data), 5 SECONDS)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), (src)), 5.5 SECONDS)


/obj/item/mortar_shell/proc/explode(flame_cause_data)
	cell_explosion(src, 100, 25, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, flame_cause_data)

/obj/structure/closet/crate/secure/mortar_ammo
	name = "\improper M402 mortar ammo crate"
	desc = "一个装有各种有效载荷的实弹迫击炮弹的板条箱。请勿掉落。远离火源。"
	icon = 'icons/obj/structures/mortar.dmi'
	icon_state = "secure_locked_mortar"
	icon_opened = "secure_open_mortar"
	icon_locked = "secure_locked_mortar"
	icon_unlocked = "secure_unlocked_mortar"
	req_one_access = list(ACCESS_MARINE_OT, ACCESS_MARINE_CARGO, ACCESS_MARINE_ENGPREP)

/obj/structure/closet/crate/secure/mortar_ammo/full/Initialize()
	. = ..()
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/flare(src)
	new /obj/item/mortar_shell/flare(src)
	new /obj/item/mortar_shell/flare(src)
	new /obj/item/mortar_shell/flare(src)

/obj/structure/closet/crate/secure/mortar_ammo/mortar_kit
	name = "\improper M402 mortar kit"
	desc = "一个装有迫击炮基础套装和一些炮弹的板条箱，供工程师入门使用。"
	var/jtac_key_type = /obj/item/device/encryptionkey/jtac

/obj/structure/closet/crate/secure/mortar_ammo/mortar_kit/Initialize()
	. = ..()
	new /obj/item/mortar_kit(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/flare(src)
	new /obj/item/mortar_shell/flare(src)
	new /obj/item/mortar_shell/flare(src)
	new /obj/item/device/encryptionkey/engi(src)
	new /obj/item/device/encryptionkey/engi(src)
	new jtac_key_type(src)
	new jtac_key_type(src)
	new /obj/item/device/binoculars/range(src)
	new /obj/item/device/binoculars/range(src)

/obj/structure/closet/crate/secure/mortar_ammo/mortar_kit/hvh
	jtac_key_type = /obj/item/device/encryptionkey/upp/engi

/obj/structure/closet/crate/secure/mortar_ammo/mortar_kit/hvh/pmc
	jtac_key_type = /obj/item/device/encryptionkey/pmc/engi

/obj/structure/closet/crate/secure/mortar_ammo/mortar_kit/hvh/clf
	jtac_key_type = /obj/item/device/encryptionkey/clf/engi
