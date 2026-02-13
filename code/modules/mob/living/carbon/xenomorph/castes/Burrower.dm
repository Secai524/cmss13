//burrower is COMBAT support
/datum/caste_datum/burrower
	caste_type = XENO_CASTE_BURROWER
	tier = 2

	melee_damage_lower = XENO_DAMAGE_TIER_2
	melee_damage_upper = XENO_DAMAGE_TIER_3
	melee_vehicle_damage = XENO_DAMAGE_TIER_3
	max_health = XENO_HEALTH_TIER_6
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_6
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_4
	armor_deflection = XENO_ARMOR_TIER_2
	evasion = XENO_EVASION_NONE
	speed = XENO_SPEED_TIER_4

	deevolves_to = list(XENO_CASTE_DRONE)
	caste_desc = "A digger and trapper."
	fire_immunity = FIRE_IMMUNITY_BURROWER
	acid_level = 2
	weed_level = WEED_LEVEL_STANDARD
	evolution_allowed = FALSE

	behavior_delegate_type = /datum/behavior_delegate/burrower_base

	tackle_min = 3
	tackle_max = 5
	tackle_chance = 40
	tacklestrength_min = 4
	tacklestrength_max = 5

	burrow_cooldown = 2 SECONDS
	tunnel_cooldown = 7 SECONDS

	minimum_evolve_time = 7 MINUTES

	minimap_icon = "burrower"

/mob/living/carbon/xenomorph/burrower
	caste_type = XENO_CASTE_BURROWER
	name = XENO_CASTE_BURROWER
	desc = "一只肌肉发达、长着利爪的外星生物。"
	icon = 'icons/mob/xenos/castes/tier_2/burrower.dmi'
	icon_size = 64
	icon_state = "Burrower Walking"
	layer = MOB_LAYER
	plasma_stored = 100
	plasma_types = list(PLASMA_PURPLE)
	pixel_x = -12
	old_x = -12
	xenonid_pixel_x = -16
	base_pixel_x = 0
	base_pixel_y = -20
	tier = 2
	organ_value = 1500

	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/release_haul,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/activable/tail_stab,
		/datum/action/xeno_action/activable/corrosive_acid,
		/datum/action/xeno_action/activable/place_construction,
		/datum/action/xeno_action/onclick/build_tunnel,
		/datum/action/xeno_action/onclick/plant_weeds, //first macro
		/datum/action/xeno_action/onclick/place_trap, //second macro
		/datum/action/xeno_action/activable/burrow, //third macro
		/datum/action/xeno_action/onclick/tremor, //fourth macro
		/datum/action/xeno_action/active_toggle/toggle_meson_vision,
		)

	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
		/mob/living/carbon/xenomorph/proc/rename_tunnel,
		/mob/living/carbon/xenomorph/proc/set_hugger_reserve_for_morpher,
	)

	icon_xeno = 'icons/mob/xenos/castes/tier_2/burrower.dmi'
	icon_xenonid = 'icons/mob/xenonids/castes/tier_2/burrower.dmi'

	weed_food_icon = 'icons/mob/xenos/weeds_64x64.dmi'
	weed_food_states = list("Burrower_1","Burrower_2","Burrower_3")
	weed_food_states_flipped = list("Burrower_1","Burrower_2","Burrower_3")

	skull = /obj/item/skull/burrower
	pelt = /obj/item/pelt/burrower

/mob/living/carbon/xenomorph/burrower/ex_act(severity, direction, datum/cause_data/cause_data, pierce=0, enviro=FALSE)
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		return
	..()

/mob/living/carbon/xenomorph/burrower/attack_hand()
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		return
	..()

/mob/living/carbon/xenomorph/burrower/attackby()
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		return
	. = ..()

/mob/living/carbon/xenomorph/burrower/get_projectile_hit_chance()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		return 0

/datum/behavior_delegate/burrower_base
	name = "基础掘地者行为代理"


//Burrower Abilities
/mob/living/carbon/xenomorph/proc/burrow()
	if(!check_state())
		return

	if(used_burrow || tunnel || is_ventcrawling || action_busy)
		return

	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return

	var/area/current_area = get_area(current_turf)
	if(current_area.flags_area & AREA_NOBURROW)
		to_chat(src, SPAN_XENOWARNING("此处无法掘地。"))
		return

	if(istype(current_turf, /turf/open/floor/almayer/research/containment) || istype(current_turf, /turf/closed/wall/almayer/research/containment))
		to_chat(src, SPAN_XENOWARNING("我们无法逃离这个牢房！"))
		return

	if(clone) //Prevents burrowing on stairs
		to_chat(src, SPAN_XENOWARNING("我们无法在此处掘地！"))
		return

	if(caste_type && GLOB.xeno_datum_list[caste_type])
		caste = GLOB.xeno_datum_list[caste_type]

	used_burrow = TRUE

	to_chat(src, SPAN_XENOWARNING("我们开始向地下掘进。"))
	if(!do_after(src, 1.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
		addtimer(CALLBACK(src, PROC_REF(do_burrow_cooldown)), (caste ? caste.burrow_cooldown : 5 SECONDS))
		return
	// TODO Make immune to all damage here.
	to_chat(src, SPAN_XENOWARNING("我们掘入了地下。"))
	QDEL_NULL(observed_atom)
	invisibility = 101
	alpha = 100
	anchored = TRUE

	var/mob/living/carbon/human/hauled = hauled_mob?.resolve()

	if(hauled)
		hauled.forceMove(src)

	add_traits(list(TRAIT_ABILITY_BURROWED, TRAIT_UNDENSE, TRAIT_IMMOBILIZED), TRAIT_SOURCE_ABILITY("掘地"))
	playsound(src.loc, 'sound/effects/burrowing_b.ogg', 25)
	update_icons()
	addtimer(CALLBACK(src, PROC_REF(do_burrow_cooldown)), (caste ? caste.burrow_cooldown : 5 SECONDS))
	burrow_timer = world.time + 90 // How long we can be burrowed
	process_burrow()

/mob/living/carbon/xenomorph/proc/process_burrow()
	if(!HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		return
	if(world.time > burrow_timer && !tunnel)
		burrow_off()
	if(observed_xeno)
		overwatch(observed_xeno, TRUE)
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		addtimer(CALLBACK(src, PROC_REF(process_burrow)), 1 SECONDS)

/mob/living/carbon/xenomorph/proc/burrow_off()
	if(caste_type && GLOB.xeno_datum_list[caste_type])
		caste = GLOB.xeno_datum_list[caste_type]
	to_chat(src, SPAN_NOTICE("你重新浮出地面。"))
	remove_traits(list(TRAIT_ABILITY_BURROWED, TRAIT_UNDENSE, TRAIT_IMMOBILIZED), TRAIT_SOURCE_ABILITY("掘地"))
	invisibility = FALSE
	alpha = initial(alpha)
	anchored = FALSE

	var/mob/living/carbon/human/hauled = hauled_mob?.resolve()
	if(hauled)
		hauled.forceMove(loc)

	playsound(loc, 'sound/effects/burrowoff.ogg', 25)
	for(var/mob/living/carbon/mob in loc)
		if(!can_not_harm(mob))
			mob.apply_effect(1.5, WEAKEN)

	addtimer(CALLBACK(src, PROC_REF(do_burrow_cooldown)), (caste ? caste.burrow_cooldown : 5 SECONDS))
	update_icons()

/mob/living/carbon/xenomorph/proc/do_burrow_cooldown()
	used_burrow = FALSE
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		to_chat(src, SPAN_NOTICE("我们现在可以破土而出。"))
	for(var/X in actions)
		var/datum/action/act = X
		act.update_button_icon()


/mob/living/carbon/xenomorph/proc/tunnel(turf/target)
	if(!check_state())
		return

	if(!HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		to_chat(src, SPAN_NOTICE("我们必须处于潜地状态才能这么做。"))
		return

	if(tunnel)
		tunnel = FALSE
		to_chat(src, SPAN_NOTICE("我们停止挖掘隧道。"))
		used_tunnel = TRUE
		addtimer(CALLBACK(src, PROC_REF(do_tunnel_cooldown)), (caste ? caste.tunnel_cooldown : 5 SECONDS))
		return

	if(used_tunnel)
		to_chat(src, SPAN_NOTICE("我们必须等待一段时间才能这么做。"))
		return

	if(!target)
		to_chat(src, SPAN_NOTICE("我们无法在那里挖掘隧道！"))
		return

	if(target.density)
		to_chat(src, SPAN_XENOWARNING("我们无法挖穿实心墙壁！"))
		return

	if(istype(target, /turf/open/space))
		to_chat(src, SPAN_XENOWARNING("我们挖的是隧道，不是虫洞！"))
		return

	if(clone) //Prevents tunnels in Z transition areas
		to_chat(src, SPAN_XENOWARNING("我们挖的是隧道，不是虫洞！"))
		return

	var/area/area_to_get = get_area(target)
	if(area_to_get.flags_area & AREA_NOBURROW || get_dist(src, target) > 15)
		to_chat(src, SPAN_XENOWARNING("那边没有挖掘隧道的路径。"))
		return

	for(var/obj/objects_in_turf in target.contents)
		if(objects_in_turf.density)
			if(objects_in_turf.flags_atom & ON_BORDER)
				continue
			to_chat(src, SPAN_WARNING("那里有坚固的东西阻挡我们钻出地面。"))
			return

	if(!target || target.density)
		to_chat(src, SPAN_NOTICE("我们无法挖掘到那里！"))
	tunnel = TRUE
	to_chat(src, SPAN_NOTICE("我们开始挖掘隧道！"))
	var/target_distance = max(get_dist(src, target), 1) // Min distance of 1 is to prevent stunlocking
	tunnel_timer = (target_distance*10) + world.time
	process_tunnel(target)


/mob/living/carbon/xenomorph/proc/process_tunnel(turf/target)
	if(!tunnel)
		return

	if(world.time > tunnel_timer)
		tunnel = FALSE
		do_tunnel(target)
	if(tunnel && target)
		addtimer(CALLBACK(src, PROC_REF(process_tunnel), target), 1 SECONDS)

/mob/living/carbon/xenomorph/proc/do_tunnel(turf/target)
	to_chat(src, SPAN_NOTICE("我们向目的地挖掘隧道。"))
	anchored = FALSE
	forceMove(target)
	burrow_off()

/mob/living/carbon/xenomorph/proc/do_tunnel_cooldown()
	used_tunnel = FALSE
	to_chat(src, SPAN_NOTICE("我们现在可以在潜地状态下挖掘隧道了。"))
	for(var/X in actions)
		var/datum/action/act = X
		act.update_button_icon()

/mob/living/carbon/xenomorph/proc/rename_tunnel(obj/structure/tunnel/tunnel_target in oview(1))
	set name = "Rename Tunnel"
	set desc = "Rename the tunnel."
	set category = null

	if(!istype(tunnel_target))
		return

	var/new_name = strip_html(input("Change the description of the tunnel:", "隧道描述") as text|null)
	new_name = replace_non_alphanumeric_plus(new_name)
	if(new_name)
		new_name = "[new_name] ([get_area_name(tunnel_target)])"
		log_admin("[key_name(src)] has renamed the tunnel \"[tunnel_target.tunnel_desc]\" as \"[new_name]\".")
		msg_admin_niche("[src]/([key_name(src)]) has renamed the tunnel \"[tunnel_target.tunnel_desc]\" as \"[new_name]\".")
		tunnel_target.tunnel_desc = "[new_name]"
	return


/datum/action/xeno_action/onclick/tremor/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/burrower_tremor = owner

	if(HAS_TRAIT(burrower_tremor, TRAIT_ABILITY_BURROWED))
		to_chat(burrower_tremor, SPAN_XENOWARNING("我们必须在地面上才能执行此操作。"))
		return

	if(burrower_tremor.is_ventcrawling)
		to_chat(burrower_tremor, SPAN_XENOWARNING("我们必须在地面上才能执行此操作。"))
		return

	if(!action_cooldown_check())
		return

	if(!burrower_tremor.check_state())
		return

	if(!check_and_use_plasma_owner())
		return

	playsound(burrower_tremor, 'sound/effects/alien_footstep_charge3.ogg', 75, 0)
	to_chat(burrower_tremor, SPAN_XENOWARNING("我们钻入地下，引发震动。"))
	burrower_tremor.create_stomp()


	for(var/mob/living/carbon/carbon_target in range(7, burrower_tremor))
		to_chat(carbon_target, SPAN_WARNING("地面在你脚下震动，你挣扎着保持站立！"))
		shake_camera(carbon_target, 2, 3)
		if(get_dist(burrower_tremor, carbon_target) <= 3 && !burrower_tremor.can_not_harm(carbon_target))
			if(carbon_target.mob_size >= MOB_SIZE_BIG)
				carbon_target.apply_effect(1, SLOW)
			else
				carbon_target.apply_effect(1, WEAKEN)
			to_chat(carbon_target, SPAN_WARNING("剧烈的震动让你脚下不稳！"))

	apply_cooldown()
	return ..()

/datum/action/xeno_action/onclick/build_tunnel/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/xenomorph = owner
	if(!xenomorph.check_state())
		return

	if(xenomorph.action_busy)
		to_chat(xenomorph, SPAN_XENOWARNING("我们应该先完成手头的事再挖掘。"))
		return

	var/turf/turf = xenomorph.loc
	if(!istype(turf)) //logic
		to_chat(xenomorph, SPAN_XENOWARNING("我们无法从那里做到。"))
		return

	var/area/current_area = get_area(turf)
	if(!turf.can_dig_xeno_tunnel() || !is_ground_level(turf.z) || current_area.flags_area & AREA_NOTUNNEL)
		to_chat(xenomorph, SPAN_XENOWARNING("我们四处刨挖，但似乎无法挖穿那种地面。"))
		return

	if(locate(/obj/structure/tunnel) in xenomorph.loc)
		to_chat(xenomorph, SPAN_XENOWARNING("这里已经有一条隧道了。"))
		return

	if(locate(/obj/structure/machinery/sentry_holder/landing_zone) in xenomorph.loc)
		to_chat(xenomorph, SPAN_XENOWARNING("有这个物体挡着，我们无法挖掘隧道。"))
		return

	if(xenomorph.tunnel_delay)
		to_chat(xenomorph, SPAN_XENOWARNING("我们还没准备好再次挖掘隧道。"))
		return

	if(xenomorph.get_active_hand())
		to_chat(xenomorph, SPAN_XENOWARNING("我们需要一只空闲的爪子！"))
		return

	if(!xenomorph.check_plasma(plasma_cost))
		return

	var/area/AR = get_area(turf)

	if(isnull(AR) || !(AR.is_resin_allowed))
		if(!AR || AR.flags_area & AREA_UNWEEDABLE)
			to_chat(xenomorph, SPAN_XENOWARNING("此区域不适合建立巢穴！"))
			return
		to_chat(xenomorph, SPAN_XENOWARNING("现在将巢穴扩张至此还为时过早。"))
		return

	xenomorph.visible_message(SPAN_XENONOTICE("[xenomorph]开始挖掘一个隧道入口。"),
	SPAN_XENONOTICE("We begin digging out a tunnel entrance."), null, 5)
	if(!do_after(xenomorph, 10 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		to_chat(xenomorph, SPAN_WARNING("我们停止挖掘，隧道坍塌了。"))
		return
	if(!xenomorph.check_plasma(plasma_cost))
		return
	xenomorph.visible_message(SPAN_XENONOTICE("\The [xenomorph] digs out a tunnel entrance."),
	SPAN_XENONOTICE("We dig out an entrance to the tunnel network."), null, 5)

	var/obj/structure/tunnel/tunnelobj = new(turf, xenomorph.hivenumber)
	xenomorph.tunnel_delay = 1
	addtimer(CALLBACK(src, PROC_REF(cooldown_end)), 4 MINUTES)
	var/msg = strip_html(input("Add a description to the tunnel:", "隧道描述") as text|null)
	msg = replace_non_alphanumeric_plus(msg)
	var/description
	if(msg)
		description = msg
		msg = "[msg] ([get_area_name(tunnelobj)])"
		log_admin("[key_name(xenomorph)] has named a new tunnel \"[msg]\".")
		msg_admin_niche("[xenomorph]/([key_name(xenomorph)]) has named a new tunnel \"[msg]\".")
		tunnelobj.tunnel_desc = "[msg]"

	if(xenomorph.hive.living_xeno_queen || xenomorph.hive.allow_no_queen_actions)
		for(var/mob/living/carbon/xenomorph/target_for_message as anything in xenomorph.hive.totalXenos)
			var/overwatch_target = XENO_OVERWATCH_TARGET_HREF
			var/overwatch_src = XENO_OVERWATCH_SRC_HREF
			to_chat(target_for_message, SPAN_XENOANNOUNCE("巢穴：一条新隧道[description ? " ([description])" : ""] has been created by [xenomorph] (<a href='byond://?src=\ref[target_for_message];[overwatch_target]=\ref[xenomorph];[overwatch_src]=\ref[target_for_message]'>watch</a>) at <b>[get_area_name(tunnelobj)]</b>."))

	xenomorph.use_plasma(plasma_cost)
	to_chat(xenomorph, SPAN_NOTICE("我们将在4分钟后准备好挖掘一条新隧道。"))
	playsound(xenomorph.loc, 'sound/weapons/pierce.ogg', 25, 1)
	apply_cooldown()

	return ..()


/datum/action/xeno_action/onclick/build_tunnel/proc/cooldown_end()
	var/mob/living/carbon/xenomorph/xenomorph = owner
	to_chat(xenomorph, SPAN_NOTICE("我们已准备好再次挖掘隧道。"))
	xenomorph.tunnel_delay = 0

/mob/living/carbon/xenomorph/burrower/try_fill_trap(obj/effect/alien/resin/trap/target)
	. = ..()
	if(.)
		target.set_state(RESIN_TRAP_ACID3)
