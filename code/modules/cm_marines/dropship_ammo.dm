


/// Dropship weaponry ammunition
/obj/structure/ship_ammo
	icon = 'icons/obj/structures/props/dropship/dropship_ammo.dmi'
	density = TRUE
	anchored = TRUE
	throwpass = TRUE
	climbable = TRUE
	/// Delay between firing steps
	var/fire_mission_delay = 4
	/// Time to impact in deciseconds
	var/travelling_time = 100
	/// Type of dropship equipment that accepts this type of ammo.
	var/obj/structure/dropship_equipment/equipment_type
	/// Ammunition count remaining
	var/ammo_count
	/// Maximal ammunition count
	var/max_ammo_count
	/// What to call the ammo in the ammo transferring message
	var/ammo_name = "round"
	var/ammo_id
	/// Whether the ammo inside this magazine can be transferred to another magazine.
	var/transferable_ammo = FALSE
	/// How many tiles the ammo can deviate from the laser target
	var/accuracy_range = 3
	/// Sound played mere seconds before impact
	var/warning_sound = 'sound/effects/rocketpod_fire.ogg'
	/// Volume of the sound played before impact
	var/warning_sound_volume = 70
	/// Ammunition expended each time this is fired
	var/ammo_used_per_firing = 1
	/// Maximum deviation allowed when the ammo is not longer guided by a laser
	var/max_inaccuracy = 6
	/// Cost to build in the fabricator, zero means unbuildable
	var/point_cost
	/// Mob that fired this ammunition (the pilot pressing the trigger)
	var/mob/source_mob
	var/combat_equipment = TRUE
	var/faction_exclusive //if this ammo is obtainable only by certain faction

/obj/structure/ship_ammo/update_icon()
	. = ..()

	var/ammo_stage = ammo_count / ammo_used_per_firing
	icon_state = "[initial(icon_state)]_[ammo_stage]"

	if (ammo_count == max_ammo_count)
		icon_state = initial(icon_state)

/obj/structure/ship_ammo/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/ship_ammo/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴猛击 [src]！"),
		SPAN_DANGER("We smash [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/ship_ammo/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/powerloader_clamp))
		var/obj/item/powerloader_clamp/PC = I
		if(!PC.linked_powerloader)
			qdel(PC)
			return FALSE
		if(PC.loaded)
			if(istype(PC.loaded, /obj/structure/ship_ammo))
				var/obj/structure/ship_ammo/SA = PC.loaded
				SA.transfer_ammo(src, user)
				return FALSE
		else
			if(ammo_count < 1)
				to_chat(user, SPAN_WARNING("\The [src] has ran out of ammo, so you discard it!"))
				qdel(src)
				return FALSE

			if(ammo_name == "rocket")
				PC.grab_object(user, src, "ds_rocket", 'sound/machines/hydraulics_1.ogg')
			else
				PC.grab_object(user, src, "ds_ammo", 'sound/machines/hydraulics_1.ogg')
			update_icon()
			return FALSE
	else
		. = ..()


/obj/structure/ship_ammo/get_examine_text(mob/user)
	. = ..()
	. += "Moving this will require some sort of lifter."

//what to show to the user that examines the weapon we're loaded on.
/obj/structure/ship_ammo/proc/show_loaded_desc(mob/user)
	return "It's loaded with \a [src]."

/obj/structure/ship_ammo/proc/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	return

/obj/structure/ship_ammo/proc/can_fire_at(turf/impact, mob/user)
	return TRUE

/obj/structure/ship_ammo/proc/transfer_ammo(obj/structure/ship_ammo/target, mob/user)
	if(type != target.type)
		to_chat(user, SPAN_NOTICE("\The [src] and \the [target] use incompatible types of ammunition!"))
		return
	if(!transferable_ammo)
		to_chat(user, SPAN_NOTICE("\The [src] doesn't support [ammo_name] transfer!"))
		return
	var/obj/item/powerloader_clamp/PC
	if(istype(loc, /obj/item/powerloader_clamp))
		PC = loc
	if(ammo_count < 1)
		if(PC)
			PC.loaded = null
			PC.update_icon()
		to_chat(user, SPAN_WARNING("\The [src] has ran out of ammo, so you discard it!"))
		forceMove(get_turf(loc))
		qdel(src)
	if(target.ammo_count >= target.max_ammo_count)
		to_chat(user, SPAN_WARNING("\The [target] is fully loaded!"))
		return

	var/transf_amt = min(target.max_ammo_count - target.ammo_count, ammo_count)
	target.ammo_count += transf_amt
	ammo_count -= transf_amt
	playsound(loc, 'sound/machines/hydraulics_1.ogg', 40, 1)
	to_chat(user, SPAN_NOTICE("你将 [transf_amt] 发 [ammo_name] 转移到了 \the [target]。"))
	src?.update_icon()
	target.update_icon()
	if(ammo_count < 1)
		if(PC)
			PC.loaded = null
			PC.update_icon()
		to_chat(user, SPAN_WARNING("\The [src] has ran out of ammo, so you discard it!"))
		forceMove(get_turf(loc))
		qdel(src)
	else
		if(PC)
			if(ammo_name == "rocket")
				PC.update_icon("ds_rocket")
			else
				PC.update_icon("ds_ammo")


//30mm gun

/obj/structure/ship_ammo/heavygun
	name = "\improper PGU-100 Multi-Purpose 30mm ammo crate"
	icon_state = "30mm_crate"
	desc = "一个装满PGU-100型30毫米多用途弹药的板条箱，设计用于穿透轻型（非加固）结构，并撕裂步兵、IAV、LAV、IMV和MRAP。适用于大面积区域，用于对付4级及以上的异形虫类侵扰，也符合允许用于应对4级及以上叛乱的火力配置。然而，它缺乏穿甲能力，为此需要30毫米反坦克弹药。可装入GAU-21型30毫米机炮。"
	equipment_type = /obj/structure/dropship_equipment/weapon/heavygun
	ammo_count = 400
	max_ammo_count = 400
	transferable_ammo = TRUE
	ammo_used_per_firing = 40
	point_cost = 275
	fire_mission_delay = 2
	var/bullet_spread_range = 3 //how far from the real impact turf can bullets land
	var/shrapnel_type = /datum/ammo/bullet/shrapnel/gau //For siming 30mm bullet impacts.
	var/directhit_damage = 105 //how much damage is to be inflicted to a mob, this is here so that we can hit resting mobs.
	var/penetration = 10 //AP value pretty much

/obj/structure/ship_ammo/heavygun/get_examine_text(mob/user)
	. = ..()
	. += "It has [ammo_count] round\s."

/obj/structure/ship_ammo/heavygun/show_loaded_desc(mob/user)
	if(ammo_count)
		return "It's loaded with \a [src] containing [ammo_count] round\s."
	else
		return "It's loaded with an empty [name]."

/obj/structure/ship_ammo/heavygun/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	set waitfor = 0
	var/list/turf_list = RANGE_TURFS(bullet_spread_range, impact)
	var/soundplaycooldown = 0
	var/debriscooldown = 0

	for(var/i = 1 to ammo_used_per_firing)
		sleep(1)
		var/turf/impact_tile = pick(turf_list)
		var/datum/cause_data/cause_data = create_cause_data(fired_from.name, source_mob)
		impact_tile.ex_act(EXPLOSION_THRESHOLD_VLOW, pick(GLOB.alldirs), cause_data)
		create_shrapnel(impact_tile,1,0,0,shrapnel_type,cause_data,FALSE,100) //simulates a bullet
		for(var/atom/movable/explosion_effect in impact_tile)
			if(iscarbon(explosion_effect))
				var/mob/living/carbon/bullet_effect = explosion_effect
				explosion_effect.ex_act(EXPLOSION_THRESHOLD_VLOW, null, cause_data)
				bullet_effect.apply_armoured_damage(directhit_damage,ARMOR_BULLET,BRUTE,null,penetration)
			else
				explosion_effect.ex_act(EXPLOSION_THRESHOLD_VLOW)
		new /obj/effect/particle_effect/expl_particles(impact_tile)
		if(!soundplaycooldown) //so we don't play the same sound 20 times very fast.
			playsound(impact_tile, 'sound/effects/gauimpact.ogg',40,1,20)
			soundplaycooldown = 3
		soundplaycooldown--
		if(!debriscooldown)
			impact_tile.ceiling_debris_check(1)
			debriscooldown = 6
		debriscooldown--
	sleep(11) //speed of sound simulation
	playsound(impact, 'sound/effects/gau.ogg',100,1,60)


/obj/structure/ship_ammo/heavygun/antitank
	name = "\improper PGU-105 30mm Anti-tank ammo crate"
	icon_state = "30mm_crate_hv"
	desc = "一个装满PGU-105型专用30毫米APFSDS钛钨合金穿甲弹的板条箱，用于在近距离空中支援中对抗同级及近同级装甲运兵车、步兵战车和主战坦克。设计为从GAU-21发射时，可穿透相当于1350毫米均质轧制钢装甲。但对软目标的效力则低得多，此种情况下建议使用30毫米普通弹。警告：若运输机未以所需速度拉起，弹药脱落的弹托花瓣可能造成伤害。请查阅手册第3574页，可在任何阿玛特商店订购。可装入GAU-21型30毫米机炮。"
	travelling_time = 60
	point_cost = 325
	shrapnel_type = /datum/ammo/bullet/shrapnel/gau/at
	directhit_damage = 80 //how much damage is to be inflicted to a mob, this is here so that we can hit resting mobs.
	penetration = 40 //AP value pretty much

//laser battery

/obj/structure/ship_ammo/laser_battery
	name = "\improper BTU-17/LW Hi-Cap Laser Battery"
	icon_state = "laser_battery"
	desc = "一种高容量激光电池，用于为激光束武器供能。可装入LWU-6B型激光炮。"
	travelling_time = 10
	ammo_count = 100
	max_ammo_count = 100
	equipment_type = /obj/structure/dropship_equipment/weapon/laser_beam_gun
	ammo_name = "charge"
	transferable_ammo = TRUE
	accuracy_range = 1
	ammo_used_per_firing = 10
	max_inaccuracy = 1
	warning_sound = 'sound/effects/nightvision.ogg'
	point_cost = 200
	fire_mission_delay = 4 //very good but long cooldown


/obj/structure/ship_ammo/laser_battery/get_examine_text(mob/user)
	. = ..()
	. += "It's at [floor(100*ammo_count/max_ammo_count)]% charge."


/obj/structure/ship_ammo/laser_battery/show_loaded_desc(mob/user)
	if(ammo_count)
		return "It's loaded with \a [src] at [floor(100*ammo_count/max_ammo_count)]% charge."
	else
		return "It's loaded with an empty [name]."


/obj/structure/ship_ammo/laser_battery/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	set waitfor = 0
	var/list/turf_list = RANGE_TURFS(3, impact) //This is its area of effect
	playsound(impact, 'sound/effects/pred_vision.ogg', 20, 1)
	for(var/i=1 to 16) //This is how many tiles within that area of effect will be randomly ignited
		var/turf/U = pick(turf_list)
		turf_list -= U
		fire_spread_recur(U, create_cause_data(fired_from.name, source_mob), 1, null, 5, 75, "#EE6515")//Very, very intense, but goes out very quick

	if(!ammo_count && !QDELETED(src))
		qdel(src) //deleted after last laser beam is fired and impact the ground.


//Rockets

/obj/structure/ship_ammo/rocket
	name = "抽象火箭"
	icon_state = "single"
	icon = 'icons/obj/structures/props/dropship/dropship_ammo64.dmi'
	equipment_type = /obj/structure/dropship_equipment/weapon/rocket_pod
	ammo_count = 1
	max_ammo_count = 1
	ammo_name = "rocket"
	ammo_id = ""
	bound_width = 64
	bound_height = 32
	travelling_time = 60 //faster than 30mm rounds
	max_inaccuracy = 5
	point_cost = 0
	fire_mission_delay = 4

/obj/structure/ship_ammo/rocket/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	qdel(src)

//this one is air-to-air only
/obj/structure/ship_ammo/rocket/widowmaker
	name = "\improper AIM-224B 'Widowmaker'"
	desc = "AIM-224B导弹是对最新空对空导弹技术的改装。因其制导战斗部的改进使其无法被干扰，从而获得高击杀率，被众多运输机飞行员昵称为“寡妇制造者”。不适用于地面轰炸，但其高速度使其能快速抵达目标。这一枚因运输机弹药短缺而被改装为自由落体炸弹。可装入LAU-444型导弹发射器。"
	icon_state = "single"
	travelling_time = 30 //not powerful, but reaches target fast
	ammo_id = ""
	point_cost = 300

/obj/structure/ship_ammo/rocket/widowmaker/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	impact.ceiling_debris_check(3)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(cell_explosion), impact, 300, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data(initial(name), source_mob)), 0.5 SECONDS) //Your standard HE splash damage rocket. Good damage, good range, good speed, it's an all rounder
	QDEL_IN(src, 0.5 SECONDS)

/obj/structure/ship_ammo/rocket/banshee
	name = "\improper AGM-227 'Banshee'"
	desc = "AGM-227导弹是升级后的运输机舰队对抗任何机动或装甲地面目标的主力。因其在击中目标前突然发出的哀嚎而获得“报丧女妖”的绰号。适用于清除大面积区域。可装入LAU-444型导弹发射器。"
	icon_state = "banshee"
	ammo_id = "b"
	point_cost = 300

/obj/structure/ship_ammo/rocket/banshee/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	impact.ceiling_debris_check(3)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(cell_explosion), impact, 175, 20, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data(initial(name), source_mob)), 0.5 SECONDS) //Small explosive power with a small fall off for a big explosion range
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(fire_spread), impact, create_cause_data(initial(name), source_mob), 4, 15, 50, "#00b8ff"), 0.5 SECONDS) //Very intense but the fire doesn't last very long
	QDEL_IN(src, 0.5 SECONDS)

/obj/structure/ship_ammo/rocket/keeper
	name = "\improper GBU-67 'Keeper II'"
	desc = "GBU-67“守护者II型”是最新一代激光制导武器，其技术可追溯至20世纪。其昵称“守护者”是“维和者”的简称，源于开发其制导系统的项目及其在维和冲突中的各种用途。其有效载荷旨在摧毁装甲目标。可装入LAU-444型导弹发射器。"
	icon_state = "paveway"
	travelling_time = 20 //A fast payload due to its very tight blast zone
	ammo_id = "k"
	point_cost = 300

/obj/structure/ship_ammo/rocket/keeper/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	impact.ceiling_debris_check(3)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(cell_explosion), impact, 450, 100, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, create_cause_data(initial(name), source_mob)), 0.5 SECONDS) //Insane fall off combined with insane damage makes the Keeper useful for single targets, but very bad against multiple.
	QDEL_IN(src, 0.5 SECONDS)

/obj/structure/ship_ammo/rocket/harpoon
	name = "\improper AGM-184 'Harpoon II'"
	desc = "AGM-184鱼叉II型是一种反舰导弹，设计用于以低爆炸威力的巨大冲击波有效击沉敌舰。这一枚经过改装，可使用地面信号，可视为常规弹药的廉价替代品。可装入LAU-444型导弹发射器。"
	icon_state = "harpoon"
	ammo_id = "s"
	travelling_time = 50
	point_cost = 200
	fire_mission_delay = 4

/obj/structure/ship_ammo/rocket/harpoon/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	impact.ceiling_debris_check(3)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(cell_explosion), impact, 150, 16, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data(initial(name), source_mob)), 0.5 SECONDS)
	QDEL_IN(src, 0.5 SECONDS)

/obj/structure/ship_ammo/rocket/napalm
	name = "\improper AGM-99 '凝固汽油'"
	desc = "AGM-99“凝固汽油弹”是一种燃烧导弹，用于将特定目标区域长时间变成巨大的火球。可装入LAU-444型导弹发射器。"
	icon_state = "napalm"
	ammo_id = "n"
	point_cost = 500
	fire_mission_delay = 0 //0 means unusable

/obj/structure/ship_ammo/rocket/napalm/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	impact.ceiling_debris_check(3)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(cell_explosion), impact, 200, 25, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data(initial(name), source_mob)), 0.5 SECONDS)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(fire_spread), impact, create_cause_data(initial(name), source_mob), 6, 60, 30, "#EE6515"), 0.5 SECONDS) //Color changed into napalm's color to better convey how intense the fire actually is.
	QDEL_IN(src, 0.5 SECONDS)

/obj/structure/ship_ammo/rocket/thermobaric
	name = "\improper BLU-200 'Dragon's Breath'"
	desc = "BLU-200'龙息'是一种温压燃料空气炸弹。雾化的燃料混合物在点燃时会产生真空，对路径上的目标造成严重伤害。可装入LAU-444制导导弹发射器。"
	icon_state = "fatty"
	ammo_id = "f"
	travelling_time = 50
	point_cost = 300

/obj/structure/ship_ammo/rocket/thermobaric/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	impact.ceiling_debris_check(3)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(fire_spread), impact, create_cause_data(initial(name), source_mob), 4, 25, 50, "#c96500"), 0.5 SECONDS) //Very intense but the fire doesn't last very long
	for(var/mob/living/carbon/victim in orange(5, impact))
		victim.throw_atom(impact, 3, 15, src, TRUE) // Implosion throws affected towards center of vacuum
	QDEL_IN(src, 0.5 SECONDS)


//minirockets

/obj/structure/ship_ammo/minirocket
	name = "\improper AGR-59 'Mini-Mike'"
	desc = "AGR-59'迷你迈克'微型火箭是一种廉价高效的远程倾泻怒火的手段。虽然火箭缺乏制导组件，但其弹药数量弥补了这一不足。可装入LAU-229火箭巢。"
	icon_state = "minirocket"
	equipment_type = /obj/structure/dropship_equipment/weapon/minirocket_pod
	ammo_count = 6
	max_ammo_count = 6
	ammo_name = "minirocket"
	travelling_time = 80 //faster than 30mm cannon, slower than real rockets
	transferable_ammo = TRUE
	point_cost = 300
	fire_mission_delay = 3 //high cooldown

/obj/structure/ship_ammo/minirocket/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	impact.ceiling_debris_check(2)
	spawn(5)
		cell_explosion(impact, 200, 44, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data(initial(name), source_mob))
		var/datum/effect_system/expl_particles/P = new/datum/effect_system/expl_particles()
		P.set_up(4, 0, impact)
		P.start()
		spawn(5)
			var/datum/effect_system/smoke_spread/S = new/datum/effect_system/smoke_spread()
			S.set_up(1,0,impact,null)
			S.start()
		if(!ammo_count && loc)
			qdel(src) //deleted after last minirocket is fired and impact the ground.

/obj/structure/ship_ammo/minirocket/show_loaded_desc(mob/user)
	if(ammo_count)
		return "It's loaded with \a [src] containing [ammo_count] minirocket\s."

/obj/structure/ship_ammo/minirocket/get_examine_text(mob/user)
	. = ..()
	. += "It has [ammo_count] minirocket\s."


/obj/structure/ship_ammo/minirocket/incendiary
	name = "\improper AGR-59-I 'Mini-Mike'"
	desc = "AGR-59-I'迷你迈克'燃烧微型火箭是一种廉价高效的远程倾泻怒火并点燃目标的手段！虽然火箭缺乏制导组件，但其弹药数量弥补了这一不足。可装入LAU-229火箭巢。"
	icon_state = "minirocket_inc"
	point_cost = 500
	fire_mission_delay = 3 //high cooldown

/obj/structure/ship_ammo/minirocket/incendiary/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	..()
	spawn(5)
		fire_spread(impact, create_cause_data(initial(name), source_mob), 3, 25, 20, "#EE6515")

/obj/structure/ship_ammo/sentry
	name = "\improper A/C-49-P Air Deployable Sentry"
	desc = "一种全向哨戒炮，能够防御一个区域免受轻装甲敌对目标的入侵。可装入LAG-14内置哨戒炮发射器。"
	icon_state = "launchable_sentry"
	equipment_type = /obj/structure/dropship_equipment/weapon/launch_bay
	ammo_count = 1
	max_ammo_count = 1
	ammo_name = "area denial sentry"
	travelling_time = 0 // handled by droppod
	point_cost = 800 //handled by printer
	accuracy_range = 0 // pinpoint
	max_inaccuracy = 0
	/// Special structures it needs to break with drop pod
	var/list/breakable_structures = list(/obj/structure/barricade, /obj/structure/surface/table)

/obj/structure/ship_ammo/sentry/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	var/obj/structure/droppod/equipment/sentry/droppod = new(impact, /obj/structure/machinery/defenses/sentry/launchable, source_mob)
	droppod.special_structures_to_damage = breakable_structures
	droppod.special_structure_damage = 500
	droppod.drop_time = 5 SECONDS
	droppod.launch(impact)
	qdel(src)

/obj/structure/ship_ammo/sentry/can_fire_at(turf/impact, mob/user)
	for(var/obj/structure/machinery/defenses/def in range(4, impact))
		to_chat(user, SPAN_WARNING("选定的投放点距离另一个已部署的防御设施太近！"))
		return FALSE
	if(istype(impact, /turf/closed))
		to_chat(user, SPAN_WARNING("选定的投放点是垂直墙壁！"))
		return FALSE
	return TRUE
