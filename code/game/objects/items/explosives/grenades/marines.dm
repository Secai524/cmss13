
/*
//================================================
				Blast Grenades
//================================================
*/

#define GRENADE_FIRE_RESISTANCE_MIN 10
#define GRENADE_FIRE_RESISTANCE_MAX 40

/obj/item/explosive/grenade/high_explosive
	name = "\improper M40 HEDP grenade"
	desc = "高爆双用途手榴弹。一种小型但威力惊人的爆炸手榴弹，正与M40 HEFA一同逐步取代M15高爆手榴弹。可装入M92榴弹发射器或手投。"
	icon_state = "grenade"
	det_time = 40
	item_state = "grenade_hedp"
	dangerous = TRUE
	underslug_launchable = TRUE
	var/explosion_power = 100
	var/explosion_falloff = 25
	var/shrapnel_count = 0
	var/shrapnel_type = /datum/ammo/bullet/shrapnel
	var/fire_resistance = 30 //to prevent highly controlled massive explosions
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL

/obj/item/explosive/grenade/high_explosive/New()
	..()

	fire_resistance = rand(GRENADE_FIRE_RESISTANCE_MIN, GRENADE_FIRE_RESISTANCE_MAX)

/obj/item/explosive/grenade/high_explosive/prime()
	set waitfor = 0
	if(shrapnel_count)
		create_shrapnel(loc, shrapnel_count, , ,shrapnel_type, cause_data)
	apply_explosion_overlay()
	cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, null, cause_data)
	qdel(src)


/obj/item/explosive/grenade/high_explosive/proc/apply_explosion_overlay()
	var/obj/effect/overlay/O = new /obj/effect/overlay(loc)
	O.name = "grenade"
	O.icon = 'icons/effects/explosion.dmi'
	flick("grenade", O)
	QDEL_IN(O, 7)

/obj/item/explosive/grenade/high_explosive/flamer_fire_act(damage, flame_cause_data)
	fire_resistance--
	if(fire_resistance<=0)
		cause_data = flame_cause_data
		prime()

/obj/item/explosive/grenade/high_explosive/super
	name = "\improper M40/2 HEDP grenade"
	desc = "高爆双用途手榴弹。一种小型但威力惊人的爆炸手榴弹，正与M40 HEFA一同逐步取代M15高爆手榴弹。此版本威力更强。"
	icon_state = "m40_2"
	item_state = "grenade_hedp2"
	explosion_power = 150
	explosion_falloff = 40

/obj/item/explosive/grenade/high_explosive/pmc
	name = "\improper M12 blast grenade"
	desc = "为私人安保公司生产的高爆手榴弹。拉环后约3秒爆炸。"
	icon_state = "grenade_pmc"
	item_state = "grenade_ex"
	underslug_launchable = FALSE
	explosion_power = 200
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL_HALF

/obj/item/explosive/grenade/high_explosive/stick
	name = "\improper Webley Mk15 stick grenade"
	desc = "殖民地生产的爆炸手榴弹，通常采用老旧的设计和图纸。拉环后3秒爆炸。"
	icon_state = "grenade_stick"
	item_state = "grenade_stick"
	force = 10
	w_class = SIZE_SMALL
	throwforce = 15
	throw_speed = SPEED_FAST
	throw_range = 7
	underslug_launchable = FALSE
	explosion_power = 100
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR


/*
//================================================
				Fragmentation Grenades
//================================================
*/
/obj/item/explosive/grenade/high_explosive/frag
	name = "\improper M40 HEFA grenade"
	desc = "高爆破片反人员手榴弹。一种小型但威力惊人的破片手榴弹，正与M40 HEDP一同逐步取代M15破片手榴弹。可装入M92榴弹发射器或手投。"
	icon_state = "grenade_hefa"
	item_state = "grenade_hefa"
	explosion_power = 40
	shrapnel_count = 48
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/high_explosive/frag/toy
	AUTOWIKI_SKIP(TRUE)

	name = "玩具HEFA手榴弹"
	desc = "高爆破片反人员手榴弹。一种小型但威力惊人的破片手榴弹，正与M40 HEDP一同逐步取代M15破片手榴弹。可装入M92榴弹发射器或手投。等等，侧面的标签显示这是个玩具，搞什么鬼？"
	explosion_power = 0
	shrapnel_type = /datum/ammo/bullet/shrapnel/rubber
	antigrief_protection = FALSE


/obj/item/explosive/grenade/high_explosive/m15
	name = "\improper M15 fragmentation grenade"
	desc = "一款过时的USCM破片手榴弹。在USCM服役数十年后，老旧的M15破片手榴弹正逐渐被稍安全的M40系列手榴弹取代。设定为4秒后起爆。"
	icon_state = "grenade_ex"
	item_state = "grenade_ex"
	throw_speed = SPEED_FAST
	throw_range = 6
	underslug_launchable = FALSE
	explosion_power = 120
	shrapnel_count = 48
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR



/obj/item/explosive/grenade/high_explosive/upp
	name = "\improper Type 6 shrapnel grenade"
	desc = "UPP部队中常见的破片手榴弹。设计用于爆炸产生破片，撕裂敌人身体。拉环后3秒爆炸。"
	icon_state = "grenade_upp"
	item_state = "grenade_upp"
	throw_speed = SPEED_FAST
	throw_range = 6
	underslug_launchable = FALSE
	explosion_power = 60
	shrapnel_count = 56
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/*
//================================================
				Airburst Grenades
//================================================
*/
// M74 are the launcher-only variant. Flag with hand_throwable = FALSE.
/obj/item/explosive/grenade/high_explosive/airburst
	name = "\improper M74 AGM-F 40mm Grenade"
	desc = "M74 - 空爆榴弹 - 破片型。此榴弹必须用榴弹发射器发射，到达目标后引爆。它会在前方锥形区域内散布锋利的破片，撕裂血肉与护甲。散布模式针对大型目标优化。直接命中时存在过度穿透问题。"
	icon_state = "grenade_m74_airburst_f"
	item_state = "grenade_m74_airburst_f_active"
	explosion_power = 0
	explosion_falloff = 25
	shrapnel_count = 16
	det_time = 0 // Unused, because we don't use prime.
	hand_throwable = FALSE
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR
	shrapnel_type = /datum/ammo/bullet/shrapnel/jagged
	var/direct_hit_shrapnel = 5
	var/dispersion_angle = 40

/obj/item/explosive/grenade/high_explosive/airburst/prime()
// We don't prime, we use launch_impact.

/obj/item/explosive/grenade/high_explosive/airburst/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		if(ismob(hit_atom))
			var/mob/M = hit_atom
			create_shrapnel(loc, min(direct_hit_shrapnel, shrapnel_count), last_move_dir , dispersion_angle ,shrapnel_type, cause_data, FALSE, 100)
			M.apply_effect(3.0, SUPERSLOW)
			shrapnel_count -= direct_hit_shrapnel
		if(shrapnel_count)
			create_shrapnel(loc, shrapnel_count, last_move_dir , dispersion_angle ,shrapnel_type, cause_data, FALSE, 0)
			sleep(2) //so that mobs are not knocked down before being hit by shrapnel. shrapnel might also be getting deleted by explosions?
		apply_explosion_overlay()
		if(explosion_power)
			cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, last_move_dir, cause_data)
		qdel(src)

/obj/item/explosive/grenade/high_explosive/airburst/hornet_shell
	name = "\improper M74 AGM-H 40mm Hornet Shell"
	desc = "功能与标准AGM-F 40mm榴弹相同，区别在于它不爆炸产生破片，而是射出带全息瞄准的.22lr子弹。相当于远程的霰弹。"
	icon_state = "grenade_hornet"
	item_state = "grenade_hornet_active"
	shrapnel_count = 15
	shrapnel_type = /datum/ammo/bullet/shrapnel/hornet_rounds
	direct_hit_shrapnel = 5
	dispersion_angle = 25//tight cone

/obj/item/explosive/grenade/high_explosive/airburst/starshell
	name = "\improper M74 AGM-S Star Shell"
	desc = "功能与标准AGM-F 40mm榴弹相同，区别在于它不爆炸产生破片，而是爆开燃烧的磷光剂照亮区域。"
	icon_state = "grenade_starshell"
	item_state = "grenade_starshell_active"
	shrapnel_count = 8
	shrapnel_type = /datum/ammo/flare/starshell
	direct_hit_shrapnel = 5
	dispersion_angle = 360 //beeg circle

/*
//================================================
				M203 Grenades
//================================================
*/

/obj/item/explosive/grenade/incendiary/impact
	name = "\improper 40mm incendiary grenade"
	desc = "这是一枚40mm榴弹，设计用于榴弹发射器发射并碰炸起爆。此枚标记为燃烧榴弹，注意防火。"
	icon_state = "grenade_40mm_inc"
	det_time = 0
	item_state = "grenade_fire"
	hand_throwable = FALSE
	dangerous = TRUE
	underslug_launchable = TRUE
	flame_level = BURN_TIME_TIER_2
	burn_level = BURN_LEVEL_TIER_3
	flameshape = FLAMESHAPE_DEFAULT
	radius = 2
	fire_type = FIRE_VARIANT_DEFAULT

/obj/item/explosive/grenade/incendiary/impact/prime()
	return

/obj/item/explosive/grenade/incendiary/impact/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	var/turf/hit_turf = null
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom))
		hit_turf = hit_atom
		if(hit_turf.density && !rebounding)
			detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		var/angle = dir2angle(last_move_dir)
		var/turf/target = locate(x + sin(angle)*radius, y + cos(angle)*radius, z)
		if(target)
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, target)
		else
			//Not stellar, but if we can't find a direction, fall back to HIDP behaviour.
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, FLAMESHAPE_DEFAULT, target)
		playsound(src, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)
		qdel(src)

/obj/item/explosive/grenade/high_explosive/impact //omega hell killer grenade of doom from hell
	name = "\improper 40mm HE grenade"
	desc = "这是一枚40mm榴弹，设计用于榴弹发射器发射并碰炸起爆。此枚标记为高爆榴弹，注意火力。"
	icon_state = "grenade_40mm_he"
	item_state = "grenade_hedp"
	det_time = 0
	hand_throwable = FALSE
	dangerous = TRUE
	underslug_launchable = TRUE
	explosion_power = 100 //hedp
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/high_explosive/impact/prime()
// We don't prime, we use launch_impact.

/obj/item/explosive/grenade/high_explosive/impact/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		if(explosion_power)
			cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, last_move_dir, cause_data)
		qdel(src)

/obj/item/explosive/grenade/high_explosive/airburst/buckshot
	name = "\improper 40mm Buckshot Shell"
	desc = "榴弹发射器的经典弹药，这是一枚装有霰弹的40mm炮弹；非常危险，注意你的火力。"
	icon_state = "grenade_40mm_buckshot"
	item_state = "grenade_hornet_active"
	shrapnel_count = 10
	shrapnel_type = /datum/ammo/bullet/shotgun/spread
	direct_hit_shrapnel = 5
	dispersion_angle = 35//big

/*
//================================================
				Incendiary Grenades
//================================================
*/

/obj/item/explosive/grenade/incendiary
	name = "\improper M40 HIDP incendiary grenade"
	desc = "M40 HIDP是一种小型但威力惊人的燃烧手榴弹，旨在用持久的B型凝固汽油弹扰乱敌方机动性。设定为4秒后起爆。"
	icon_state = "grenade_fire"
	det_time = 40
	item_state = "grenade_fire"
	flags_equip_slot = SLOT_WAIST
	dangerous = TRUE
	underslug_launchable = TRUE
	var/flame_level = BURN_TIME_TIER_5 + 5 //Type B standard, 50 base + 5 from chemfire code.
	var/burn_level = BURN_LEVEL_TIER_2
	var/flameshape = FLAMESHAPE_DEFAULT
	var/radius = 2
	var/fire_type = FIRE_VARIANT_TYPE_B //Armor Shredding Greenfire

/obj/item/explosive/grenade/incendiary/prime()
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, null, fire_type)
	playsound(src.loc, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)
	qdel(src)

/proc/flame_radius(datum/cause_data/cause_data, radius = 1, turf/T, flame_level = 20, burn_level = 30, flameshape = FLAMESHAPE_DEFAULT, target, fire_type = FIRE_VARIANT_DEFAULT)
	//This proc is used to generate automatically-colored fires from manually adjusted item variables.
	//It parses them as parameters and sets color automatically based on Intensity, then sends an edited reagent to the standard flame code.
	//By default, this generates a napalm fire with a radius of 1, flame_level of 20 per UT (prev 14 as greenfire), burn_level of 30 per UT (prev 15 as greenfire), in a diamond shape.
	if(!istype(T))
		return
	var/datum/reagent/R = new /datum/reagent/napalm/ut()
	if(burn_level >= BURN_LEVEL_TIER_7)
		R = new /datum/reagent/napalm/blue()
	else if(burn_level <= BURN_LEVEL_TIER_2)
		R = new /datum/reagent/napalm/green()

	R.durationfire = flame_level
	R.intensityfire = burn_level
	R.rangefire = radius

	new /obj/flamer_fire(T, cause_data, R, R.rangefire, null, flameshape, target, , , fire_type)

/obj/item/explosive/grenade/incendiary/molotov
	name = "\improper improvised firebomb"
	desc = "一种强效的简易燃烧弹，混合了一撮火药。廉价、高效，在密闭空间内致命。常见于叛军和恐怖分子手中。很难预测它会在几秒后爆炸，务必小心。很可能在你面前就炸了。"
	icon_state = "molotov"
	item_state = "molotov"
	arm_sound = 'sound/items/Welder2.ogg'
	underslug_launchable = FALSE
	fire_type = FIRE_VARIANT_DEFAULT

/obj/item/explosive/grenade/incendiary/molotov/New(loc, custom_burn_level)
	det_time = rand(10,40) //Adds some risk to using this thing.
	if(custom_burn_level)
		burn_level = custom_burn_level
	..(loc)

/obj/item/explosive/grenade/incendiary/molotov/prime()
	playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 35, 1, 4)
	..()

/*
//================================================
				Airburst Incendiary Grenades
//================================================
*/
// M74 are the launcher-only variant. Flag with hand_throwable = FALSE.
/obj/item/explosive/grenade/incendiary/airburst
	name = "\improper M74 AGM-I 40mm Grenade"
	desc = "M74 - 空爆榴弹 - 燃烧型。此榴弹必须用榴弹发射器发射，到达目标后引爆。它会在前方小区域内散布一片持续燃烧的锥形火焰。榴弹扭曲的碎片在飞散时也可能引燃。"
	icon_state = "grenade_m74_airburst_i"
	item_state = "grenade_m74_airburst_i_active"
	det_time = 0 // Unused, because we don't use prime.
	hand_throwable = FALSE
	flame_level = 15
	burn_level = 20
	flameshape = FLAMESHAPE_TRIANGLE
	radius = 2
	var/shrapnel_count = 5
	var/shrapnel_type = /datum/ammo/bullet/shrapnel/incendiary

/obj/item/explosive/grenade/incendiary/airburst/prime()

/obj/item/explosive/grenade/incendiary/airburst/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	var/turf/hit_turf = null
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom))
		hit_turf = hit_atom
		if(hit_turf.density && !rebounding)
			detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		var/angle = dir2angle(last_move_dir)
		var/turf/target = locate(src.loc.x + sin(angle)*radius, src.loc.y + cos(angle)*radius, src.loc.z)
		if(shrapnel_count)
			create_shrapnel(loc, shrapnel_count, last_move_dir , 30 ,shrapnel_type, cause_data, FALSE, 0)
		if(target)
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, target)
		else
			//Not stellar, but if we can't find a direction, fall back to HIDP behaviour.
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, FLAMESHAPE_DEFAULT, target)
		playsound(src.loc, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)
		qdel(src)

/*
//================================================
				Smoke Grenades
//================================================
*/

/obj/item/explosive/grenade/smokebomb
	name = "\improper M40 HSDP smoke grenade"
	desc = "M40 HSDP是一种小型但威力强大的烟雾弹。基于与M40 HEDP相同的平台。设定为2秒后起爆。"
	icon_state = "grenade_smoke"
	det_time = 20
	item_state = "grenade_smoke"
	underslug_launchable = TRUE
	harmful = FALSE
	antigrief_protection = FALSE
	var/datum/effect_system/smoke_spread/bad/smoke
	var/smoke_radius = 3

/obj/item/explosive/grenade/smokebomb/New()
	..()
	smoke = new /datum/effect_system/smoke_spread/bad
	smoke.attach(src)

/obj/item/explosive/grenade/smokebomb/Destroy()
	QDEL_NULL(smoke)
	return ..()

/obj/item/explosive/grenade/smokebomb/prime()
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(smoke_radius, 0, get_turf(src), null, 6)
	smoke.start()
	qdel(src)

/obj/item/explosive/grenade/phosphorus
	name = "\improper M40 CCDP grenade"
	desc = "M40 CCDP是一种小型但威力强大的化合物手榴弹，效果与WPDP类似。有传言说CCDP实际上释放的不是白磷，而是维兰德实验室开发的某种其他化学品。"
	icon_state = "grenade_chem"
	det_time = 20
	item_state = "grenade_phos"
	underslug_launchable = TRUE
	var/datum/effect_system/smoke_spread/phosphorus/smoke
	dangerous = TRUE
	harmful = TRUE
	var/smoke_radius = 3

/obj/item/explosive/grenade/phosphorus/Destroy()
	QDEL_NULL(smoke)
	return ..()

/obj/item/explosive/grenade/phosphorus/weak
	name = "\improper M40 WPDP grenade"
	icon_state = "grenade_phos"
	desc = "M40 WPDP是一种小型但威力强大的磷光手榴弹。设定为2秒后引爆。"

/obj/item/explosive/grenade/phosphorus/Initialize()
	. = ..()
	smoke = new /datum/effect_system/smoke_spread/phosphorus
	smoke.attach(src)

/obj/item/explosive/grenade/phosphorus/weak/Initialize()
	. = ..()
	smoke = new /datum/effect_system/smoke_spread/phosphorus/weak
	smoke.attach(src)

/obj/item/explosive/grenade/phosphorus/prime()
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(smoke_radius, 0, get_turf(src))
	smoke.start()
	qdel(src)

/obj/item/explosive/grenade/phosphorus/upp
	name = "\improper Type 8 WP grenade"
	desc = "一种在UPP部队中发现的有毒气体手榴弹。设计用于向目标泼洒白磷。拉环后2秒爆炸。"
	icon_state = "grenade_upp_wp"
	item_state = "grenade_upp_wp"

/obj/item/explosive/grenade/phosphorus/clf
	name = "\improper improvised phosphorus bomb"
	desc = "一种简易版气体手榴弹，设计用于向目标泼洒白磷。拉环后2秒爆炸。"
	icon_state = "grenade_phos_clf"
	item_state = "grenade_phos_clf"

/obj/item/explosive/grenade/sebb
	name = "\improper G2 Electroshock grenade"
	desc = "This is a G2 Electroshock Grenade. Produced by Armat Battlefield Systems, it's sometimes referred to as the Sonic Electric Ball Breaker, \
		after a rash of incidents where the intense 1.2 gV sonic payload caused... rupturing. \
		A bounding landmine mode is available for this weapon which activates a small drill to self-bury itself when planted. Simply plant it at your feet and walk away."
	icon_state = "grenade_sebb"
	item_state = "grenade_sebb"
	det_time = 3 SECONDS
	underslug_launchable = TRUE
	/// Maximum range of effect
	var/range = 5
	/// Maximum possible damage before falloff.
	var/damage = 110
	/// Factor to multiply the effect range has on damage.
	var/falloff_dam_reduction_mult = 20
	/// Post falloff calc damage is divided by this to get xeno slowdown
	var/xeno_slowdown_numerator = 11
	/// Post falloff calc damage is multiplied by this to get human stamina damage
	var/human_stam_dam_factor = 0.5

/obj/item/explosive/grenade/sebb/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/explosive/grenade/sebb/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("To put into mine mode, plant at feet.")

/obj/item/explosive/grenade/sebb/afterattack(atom/target, mob/user, proximity)
	var/turf/user_turf = get_turf(user)
	if(active)
		return

	if(!isturf(target))
		return

	if(user.action_busy)
		return

	if(target != get_turf(user))
		return

	if(locate(/obj/item/explosive/mine) in get_turf(src))
		to_chat(user, SPAN_WARNING("这个位置已经有一枚地雷了！"))
		return

	if(antigrief_protection && user.faction == FACTION_MARINE && explosive_antigrief_check(src, user))
		to_chat(user, SPAN_WARNING("\The [name]'s safe-area accident inhibitor prevents you from planting!"))
		msg_admin_niche("[key_name(user)] attempted to plant \a [name] in [get_area(src)] [ADMIN_JMP(src.loc)]")
		return

	if(ishuman(user))
		var/mob/living/carbon/human/human = user
		if(!human.allow_gun_usage)
			to_chat(user, SPAN_WARNING("你的程序设定禁止你使用这个！"))
			return
		if(MODE_HAS_MODIFIER(/datum/gamemode_modifier/ceasefire))
			to_chat(user, SPAN_WARNING("你那样做会破坏停火协议！"))
			return

	if(user_turf && (user_turf.density || locate(/obj/structure/fence) in user_turf))
		to_chat(user, SPAN_WARNING("你不能在这里布设地雷。"))
		return

	if(Adjacent(/obj/item/explosive/mine)) // bit more strict on this than normal mines
		to_chat(user, SPAN_WARNING("离另一枚地雷太近了！找个不那么显眼的地方布置。"))
		return

	user.visible_message(SPAN_NOTICE("[user]开始部署[src]。"),
		SPAN_NOTICE("You switch [src] into landmine mode and start placing it..."))
	playsound(user.loc, 'sound/effects/thud.ogg', 40)
	if(!do_after(user, 5 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		to_chat(user, SPAN_NOTICE("你停止了布置。"))
		return

	user.visible_message(SPAN_NOTICE("[user]完成了[src]的布设。"),
		SPAN_NOTICE("You finish deploying [src]."))
	var/obj/item/explosive/mine/sebb/planted = new /obj/item/explosive/mine/sebb(get_turf(user))
	planted.activate_sensors()
	planted.iff_signal = user.faction // assuring IFF is set
	planted.pixel_x += rand(-5, 5)
	planted.pixel_y += rand(-5, 5)
	qdel(src)

/obj/item/explosive/grenade/sebb/activate()
	..()
	var/beeplen = 6 // Actual length of the sound rounded up to nearest decisecond
	var/soundtime = det_time - beeplen
	if(det_time < beeplen) // just play sound if detonation shorter than the sound
		playsound(loc, 'sound/effects/sebb_explode.ogg', 90, 0, 10)
	else
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), loc, 'sound/effects/sebb_beep.ogg', 60, 0, 10), soundtime)



/obj/item/explosive/grenade/sebb/prime()
	var/datum/effect_system/spark_spread/sparka = new
	var/turf/sebb_turf = get_turf(src)
	var/list/full_range = oview(range, src) // Fill a list of stuff in the range so we won't have to spam oview
	new /obj/effect/overlay/temp/sebb(sebb_turf)

	playsound(src.loc, 'sound/effects/sebb_explode.ogg', 90, 0, 10)

	for(var/obj/structure/machinery/defenses/sentry/sentry_stun in full_range)
		sentry_stun.sentry_range = 0 // Temporarily "disable" the sentry by killing its range then setting it back.
		new /obj/effect/overlay/temp/elec_arc(get_turf(sentry_stun))  // sprites are meh but we need visual indication that the sentry was messed up
		addtimer(VARSET_CALLBACK(sentry_stun, sentry_range, initial(sentry_stun.sentry_range)), 5 SECONDS) // assure to set it back
		sentry_stun.visible_message(SPAN_DANGER("[src]的屏幕因电击而剧烈闪烁！"))
		sentry_stun.visible_message(SPAN_DANGER("[src]说道：\"ERROR: Fire control system resetting due to critical voltage fluctuation!\""))
		sparka.set_up(1, 1, sentry_stun)
		sparka.start()

	for(var/turf/turf in full_range)
		if(prob(8))
			var/datum/effect_system/spark_spread/sparkTurf = new //using a different spike system because the spark system doesn't like when you reuse it for different things
			sparkTurf.set_up(1, 1, turf)
			sparkTurf.start()
		if(prob(10))
			new /obj/effect/overlay/temp/emp_sparks(turf)

	for(var/mob/living/carbon/mob in full_range) // no legacy mob support

		var/mob_dist = get_dist(src, mob) // Distance from mob

		/**
		 * Damage equation: damage - (mob distance * falloff_dam_reduction_mult)
		 * Example: A marine is 3 tiles out, the distance (3) is multiplied by falloff_dam_reduction_mult to get falloff.
		 * The raw damage is minused by falloff to get actual damage
		*/

		var/falloff = mob_dist * falloff_dam_reduction_mult
		var/damage_applied = damage - falloff // Final damage applied after falloff calc
		sparka.set_up(1, 1, mob)
		sparka.start()
		shake_camera(mob, 1, 1)
		if(ishuman(mob))
			var/mob/living/carbon/human/shocked_human = mob
			if(isspeciessynth(shocked_human)) // Massive overvoltage to ungrounded robots is pretty bad
				shocked_human.Stun(1 + (damage_applied/40))
				damage_applied *= 1.5
				new /obj/effect/overlay/temp/elec_arc(get_turf(shocked_human))
				to_chat(mob, SPAN_HIGHDANGER("你的所有系统都因主总线被[damage_applied*2]伏特电压过载而卡死。"))
				mob.visible_message(SPAN_WARNING("[mob]因电击而抽搐僵直。"))
			shocked_human.take_overall_armored_damage(damage_applied, ARMOR_ENERGY, BURN, 90) // 90% chance to be on additional limbs
			shocked_human.make_dizzy(damage_applied)
			mob.apply_stamina_damage(damage_applied*human_stam_dam_factor) // Stamina damage
			shocked_human.emote("pain")
		else //nonhuman damage + slow
			mob.apply_damage(damage_applied, BURN)
			if((mob_dist < (range-3))) // 2 tiles around small superslow
				mob.Superslow(2)
			mob.Slow(damage_applied/xeno_slowdown_numerator)
			if(iswydroid(mob))
				mob.emote("pain")

		if(mob_dist < 1) // Range based stuff, standing ontop of the equivalent of a canned lighting bolt should mess you up.
			mob.Superslow(3) // Note that humans will likely be in stamcrit so it's always worse for them when ontop of it and we can just balancing it on xenos.
			mob.eye_blurry = damage_applied/4
			mob.Daze(1)
		else if((mob_dist < (range-1)) && (mob.mob_size < MOB_SIZE_XENO_VERY_SMALL)) // Flicker stun humans that are closer to the grenade and larvas too.
			mob.apply_effect(1 + (damage_applied/100),WEAKEN) // 1 + damage/100
			mob.eye_blurry = damage_applied/8

		else
			to_chat(mob, SPAN_HIGHDANGER("一股强大的电流贯穿你的全身，使你完全僵直！"))


		new /obj/effect/overlay/temp/emp_sparks(mob)
		mob.make_jittery(damage_applied*2)
	empulse(src, 1, 2, cause_data?.resolve_mob()) // mini EMP
	qdel(src)


/obj/item/explosive/grenade/sebb/primed
	desc = "一枚G2电击手榴弹，看起来它相当愤怒！哦，该死！"
	det_time = 7 // 0.7 seconds to blow up. We want them to get caught if they go through.

/obj/item/explosive/grenade/sebb/primed/Initialize()
	. = ..()
	src.visible_message(SPAN_HIGHDANGER("[src]从地面钻了出来！"))
	activate()

/obj/effect/overlay/temp/sebb
	icon = 'icons/effects/sebb.dmi'
	icon_state = "sebb_explode"
	layer = ABOVE_LIGHTING_PLANE
	pixel_x = -175 // We need these offsets to force center the sprite because BYOND is dumb
	pixel_y = -175
	appearance_flags = RESET_COLOR

/*
//================================================
			Nerve Gas Grenades
//================================================
*/
/obj/item/explosive/grenade/nerve_gas
	name = "\improper CN20 canister grenade"
	desc = "一种装有致命神经毒气的罐式手榴弹。设定为4秒后引爆。"
	icon_state = "flashbang2"//temp icon
	det_time = 40
	item_state = "grenade_phos_clf"//temp icon
	underslug_launchable = FALSE
	harmful = TRUE
	antigrief_protection = TRUE
	/// The nerve gas datum
	var/datum/effect_system/smoke_spread/cn20/nerve_gas
	/// The typepath of the nerve gas
	var/nerve_gas_type = /datum/effect_system/smoke_spread/cn20
	/// The radius the gas will reach
	var/nerve_gas_radius = 2

/obj/item/explosive/grenade/nerve_gas/Initialize(mapload, ...)
	. = ..()
	nerve_gas = new nerve_gas_type
	nerve_gas.attach(src)

/obj/item/explosive/grenade/nerve_gas/Destroy()
	QDEL_NULL(nerve_gas)
	return ..()

/obj/item/explosive/grenade/nerve_gas/prime()
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	nerve_gas.set_up(nerve_gas_radius, 0, get_turf(src), null, 6)
	nerve_gas.start()
	qdel(src)

/obj/item/explosive/grenade/nerve_gas/xeno
	name = "\improper CN20-X canister grenade"
	nerve_gas_type = /datum/effect_system/smoke_spread/cn20/xeno

/*
//================================================
			Airburst Smoke Grenades
//================================================
*/

/obj/item/explosive/grenade/smokebomb/airburst
	name = "\improper M74 AGM-S 40mm Grenade"
	desc = "M74 - 空爆榴弹弹药 - 烟雾型。此榴弹必须用榴弹发射器发射，到达目的地后引爆。引爆时，瞬间混合其外壳内的多种化学物质以形成烟雾云。"
	icon_state = "grenade_m74_airburst_s"
	item_state = "grenade_m74_airburst_s_active"
	det_time = 0 // Unused, because we don't use prime.
	hand_throwable = FALSE
	smoke_radius = 2

/obj/item/explosive/grenade/smokebomb/airburst/New()
	..()
	smoke = new /datum/effect_system/smoke_spread/bad
	smoke.attach(src)


/obj/item/explosive/grenade/smokebomb/airburst/prime()
// We don't prime, we use launch_impact.

/obj/item/explosive/grenade/smokebomb/airburst/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	var/turf/hit_turf = null
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom))
		hit_turf = hit_atom
		if(hit_turf.density && !rebounding)
			detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
		smoke.set_up(radius = smoke_radius, c = 0, loca = get_turf(src), direct = null, smoke_time = 6)
		smoke.start()
		qdel(src)

/*
//================================================
				Baton Slugs
//================================================
*/

/obj/item/explosive/grenade/slug
	name = "独头弹"
	desc = "它实际上并不会爆炸。真有意思。"
	icon_state = "chemg"
	hand_throwable = FALSE
	var/impact_damage = 10
	var/impact_sound = 'sound/weapons/baton_slug_impact.ogg'
	var/slowdown_time = 2
	var/knockout_time = 0.1
	var/dazed_time = 0.5
	var/inactive_icon = "chemg"
	var/throw_max = 3 //What is the max range the baton can push/fling someone
	var/throw_min = 1 //what is the min range the baton can push/fling
	var/ram_distance = 2 //How far can the baton bounce after impacting a mob, Also how many times it can bounce
	has_arm_sound = FALSE
	throwforce = 10
	antigrief_protection = FALSE

/obj/item/explosive/grenade/slug/prime()
	active = 0
	overlays.Cut()
	icon_state = initial(icon_state)
	w_class = initial(w_class)
	throwforce = initial(throwforce)
	throw_max = initial(throw_max)
	throw_min = initial(throw_min)
	ram_distance = initial(ram_distance)

/obj/item/explosive/grenade/slug/launch_impact(atom/hit_atom)
	if(!active)
		return
	if(ismob(hit_atom))
		impact_mob(hit_atom)
		ram_distance -- //for max pinballing.
	icon_state = inactive_icon

/obj/item/explosive/grenade/slug/proc/impact_mob(mob/living/smacked)
	var/direction = Get_Angle(src, smacked)
	var/target_turf = get_angle_target_turf(src,direction, throw_max)
	var/fling = rand(throw_min, throw_max) //WEEEEEEEEEEEEEEEEEEEE What is going to be put into throw_atom
	var/random_tile = 0 //random tile for bounce

	playsound(smacked.loc, impact_sound, 75, 1)
	smacked.apply_damage(impact_damage, BRUTE)
	smacked.attack_log += "\[[time_stamp()]\] [src], fired by [fingerprintslast], struck [key_name(smacked)]."

	random_tile = get_random_turf_in_range(src,ram_distance,ram_distance) //getting random tile for bounce
	src.throw_atom(random_tile,ram_distance,SPEED_FAST,src,TRUE,NORMAL_LAUNCH,NO_FLAGS) //time for a little trolling

	if(isyautja(smacked)|| issynth(smacked))
		smacked.apply_effect(slowdown_time * 0.5, SLOW)
		smacked.apply_effect(dazed_time * 0.5, DAZE)

	if(smacked.mob_size >= MOB_SIZE_BIG)//big xenos not KO'ed
		smacked.apply_effect(slowdown_time * 1.2, SLOW)//They are slowed more :trol:
		smacked.apply_effect(dazed_time * 1.2, DAZE)
		return

	smacked.apply_effect(knockout_time, WEAKEN)//but little xenos and humans are
	smacked.throw_atom(target_turf, fling, SPEED_AVERAGE, smacked, TRUE)
	smacked.apply_effect(slowdown_time, SLOW)
	smacked.apply_effect(dazed_time, DAZE)
	return

/obj/item/explosive/grenade/slug/baton
	name = "\improper HIRR baton slug"
	desc = "作为M15橡胶弹的同类，HIRR防暴独头弹因弹托壳内推进剂装填过量而从军队和民事警察部队中召回。现在它被用作与人类（有时是非人类）部队交战时的一种非致命选项。历史上，HIRR在阿卡图鲁斯冲突期间极其受欢迎，因为人们发现其冲击力能可靠地通过将阿卡图鲁斯抵抗力量的肋骨击入肺部而使其丧失行动能力。"
	icon_state = "baton_slug"
	item_state = "baton_slug"
	inactive_icon = "baton_slug"
	antigrief_protection = FALSE
	impact_damage = 15
	slowdown_time = 2
	knockout_time = 0.8
	dazed_time = 1.7

/obj/item/explosive/grenade/slug/baton/Initialize()
	. = ..()
	setDir(NORTH) //so they're oriented properly in our inventory


/*
//================================================
					Other
//================================================
*/

/obj/item/explosive/grenade/high_explosive/training
	name = "M07训练手榴弹"
	desc = "M40 HEDP的无害可重复使用版本，用于训练。可装入M92发射器或用手投掷。"
	icon_state = "training_grenade"
	item_state = "grenade_training"
	dangerous = FALSE
	harmful = FALSE
	antigrief_protection = FALSE

/obj/item/explosive/grenade/high_explosive/training/prime()
	spawn(0)
		playsound(loc, 'sound/items/detector.ogg', 80, 0, 7)
		active = 0 //so we can reuse it
		overlays.Cut()
		icon_state = initial(icon_state)
		det_time = initial(det_time) //these can be modified when fired by UGL
		throw_range = initial(throw_range)
		w_class = initial(w_class)

/obj/item/explosive/grenade/high_explosive/training/flamer_fire_act()
	return


/obj/item/explosive/grenade/high_explosive/m15/rubber
	name = "\improper M15 rubber pellet grenade"
	desc = "一种相对无害的M15手榴弹版本，设计用于防暴控制和战斗演习。"
	icon_state = "rubber_grenade"
	item_state = "rubber_grenade"
	explosion_power = 0
	shrapnel_type = /datum/ammo/bullet/shrapnel/rubber
	antigrief_protection = FALSE

/// Baton slugs
/obj/item/explosive/grenade/baton
	name = "\improper HIRR baton slug"
	desc = "作为M15橡胶弹的同类，HIRR防暴独头弹因弹托壳内推进剂装填过量而从军队和民事警察部队中召回。现在它被用作与人类（有时是非人类）部队交战时的一种非致命选项。历史上，HIRR在阿卡图鲁斯冲突期间极其受欢迎，因为人们发现其冲击力能可靠地通过将阿卡图鲁斯抵抗力量的肋骨击入肺部而使其丧失行动能力。"
	icon_state = "baton_slug"
	item_state = "rubber_grenade"
	hand_throwable = FALSE
	antigrief_protection = FALSE


/obj/item/explosive/grenade/baton/flamer_fire_act()
	return

/obj/item/explosive/grenade/high_explosive/holy_hand_grenade
	AUTOWIKI_SKIP(TRUE)

	name = "\improper Holy Hand Grenade of Antioch"
	desc = "圣阿提拉高举着手榴弹，说道：\"O LORD, bless this Thy hand grenade that with it Thou mayest blow Thine enemies to tiny bits, in Thy mercy.\" And the LORD did grin and the people did feast upon the lambs and sloths and carp and anchovies... And the LORD spake, saying, \"First shalt thou take out the Holy Pin, then shalt thou count to three, no more, no less. Three shall be the number thou shalt count, and the number of the counting shall be three. Four shalt thou not count, neither count thou two, excepting that thou then proceed to three. Five is right out. Once the number three, being the third number, be reached, then lobbest thou thy Holy Hand Grenade of Antioch towards thy foe, who, being naughty in My sight, shall snuff it.\""
	icon_state = "grenade_antioch"
	item_state = "grenade_antioch"
	throw_speed = SPEED_VERY_FAST
	throw_range = 10
	underslug_launchable = FALSE
	explosion_power = 300
	det_time = 50
	unacidable = TRUE
	arm_sound = 'sound/voice/holy_chorus.ogg'//https://www.youtube.com/watch?v=hNV5sPZFuGg
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/metal_foam
	name = "\improper M40 MFHS grenade"
	desc = "一种金属泡沫船体密封手榴弹，最初用于紧急维修，但后来在战场上发现了其他实际用途。基于与M40 HEDP相同的平台。引信时间为2秒。"
	icon_state = "grenade_metal_foam"
	item_state = "grenade_metal_foam"
	det_time = 20
	underslug_launchable = TRUE
	harmful = FALSE
	var/foam_metal_type = FOAM_METAL_TYPE_IRON

/obj/item/explosive/grenade/metal_foam/prime()
	var/datum/effect_system/foam_spread/s = new()
	s.set_up(12, get_turf(src), metal_foam = foam_metal_type) //12 amt = 2 tiles radius (5 tile length diamond)
	s.start()
	qdel(src)

// abstract grenades used for hijack explosions

/obj/item/explosive/grenade/high_explosive/bursting_pipe
	AUTOWIKI_SKIP(TRUE)

	name = "爆裂管道"
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/item/explosive/grenade/incendiary/bursting_pipe
	AUTOWIKI_SKIP(TRUE)

	name = "爆裂管道"
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	flame_level = BURN_TIME_TIER_3
	burn_level = BURN_LEVEL_TIER_3
	radius = 2
	fire_type = FIRE_VARIANT_DEFAULT

//Royal marine grenades

/obj/item/explosive/grenade/high_explosive/rmc
	name = "\improper R2175/A HEDP grenade"
	desc = "高爆双用途。一种小型但威力惊人的爆炸手榴弹，最近已加入RMC的武器库。"
	icon_state = "rmc_grenade"
	item_state = "grenade_hedp"
	explosion_power = 130
	explosion_falloff = 30

/obj/item/explosive/grenade/incendiary/rmc
	name = "\improper R2175/B HIDP grenade"
	desc = "R2175/B HIDP是一种小型但威力惊人的燃烧手榴弹，设计用于通过快速生效的猛烈火焰迅速清空区域。设定为4秒后引爆。"
	icon_state = "rmc_grenade_fire"
	item_state = "grenade_fire"
	flame_level = BURN_TIME_TIER_1
	burn_level = BURN_LEVEL_TIER_8
	radius = 3
	fire_type = FIRE_VARIANT_DEFAULT

/obj/item/explosive/grenade/nerve_gas/xeno/rmc
	name = "\improper R2175/CN20 grenade"
	desc = "一枚装有致命神经毒气的小型手榴弹。通常能使目标长时间昏迷，足以让RMCs将其解决。你仿佛听见教官在你脑海深处咆哮，提到了防毒面具什么的。设定在3.5秒后引爆。"
	icon_state = "rmc_grenade_gas"
	det_time = 35
	item_state = "grenade_smoke"//temp icon
	underslug_launchable = TRUE
