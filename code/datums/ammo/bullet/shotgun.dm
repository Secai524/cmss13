/*
//======
					Shotgun Ammo
//======
*/

/datum/ammo/bullet/shotgun
	headshot_state = HEADSHOT_OVERLAY_HEAVY

/datum/ammo/bullet/shotgun/setup_faction_clash_values()
	. = ..()
	accuracy = accuracy * 2 + 85 //we revert accuracy reduction that is applied on other bullets shotguns are accurate but already have short range only


/datum/ammo/bullet/shotgun/slug
	name = "霰弹枪独头弹"
	handful_state = "slug_shell"

	accurate_range = 8
	max_range = 8
	damage = 70
	penetration = ARMOR_PENETRATION_TIER_4
	accuracy = HIT_ACCURACY_TIER_3
	damage_armor_punch = 2
	handful_state = "slug_shell"

/datum/ammo/bullet/shotgun/slug/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 6)

/datum/ammo/bullet/shotgun/slug/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("突如其来的冲击让你感到震撼并行动迟缓！"))
		target.KnockDown(0.5) // If you ask me the KD should be left out, but players like their visual cues
		target.Stun(0.5)
		target.apply_effect(1, SUPERSLOW)
		target.apply_effect(3, SLOW)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.apply_effect(1, SUPERSLOW)
			living_mob.apply_effect(2, SLOW)
			to_chat(living_mob, SPAN_HIGHDANGER("冲击让你失去平衡！"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/slug/es7
	name = "静电实心独头弹"
	icon_state = "bullet_iff"
	handful_state = "es7_slug"
	sound_miss = "energy_miss"
	sound_bounce = "energy_bounce"
	hit_effect_color = "#00aeff"
	sound_override = 'sound/weapons/gun_es7lethal.ogg'
	damage = 60
	penetration = ARMOR_PENETRATION_TIER_8
	accuracy = HIT_ACCURACY_TIER_5

/datum/ammo/bullet/shotgun/beanbag
	name = "豆袋弹"
	headshot_state = HEADSHOT_OVERLAY_LIGHT //It's not meant to kill people... but if you put it in your mouth, it will.
	handful_state = "beanbag_slug"
	icon_state = "beanbag"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_IGNORE_RESIST
	sound_override = 'sound/weapons/gun_shotgun_riot.ogg'

	max_range = 12
	shrapnel_chance = 0
	damage = 0
	stamina_damage = 45
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_3
	handful_state = "beanbag_slug"

/datum/ammo/bullet/shotgun/beanbag/on_hit_mob(mob/M, obj/projectile/P)
	if(!M || M == P.firer)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		shake_camera(H, 2, 1)

/datum/ammo/bullet/shotgun/beanbag/es7
	name = "静电冲击弹"
	headshot_state = HEADSHOT_OVERLAY_LIGHT //Electric version of the bean bag.
	handful_state = "shock_slug"
	icon_state = "cm_laser"
	sound_override = 'sound/weapons/gun_es7.ogg'
	flags_ammo_behavior = AMMO_ENERGY|AMMO_IGNORE_RESIST
	sound_hit = "energy_hit"
	sound_miss = "energy_miss"
	sound_bounce = "energy_bounce"
	max_range = 12
	shrapnel_chance = 0
	damage = 0
	stamina_damage = 50
	hit_effect_color = "#00aeff"
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_4
	handful_state = "shock_slug"

/datum/ammo/bullet/shotgun/beanbag/es7/on_hit_mob(mob/mobs, obj/projectile/P)
	if(!isyautja(mobs) && !isxeno(mobs))
		mobs.emote("pain")
		mobs.sway_jitter(2,1)

	if(ishuman(mobs))
		var/mob/living/carbon/human/humanus = mobs
		humanus.disable_special_items() // Disables scout cloak
		humanus.make_jittery(40)

/datum/ammo/bullet/shotgun/incendiary
	name = "燃烧独头弹"
	handful_state = "incendiary_slug"
	damage_type = BURN
	flags_ammo_behavior = AMMO_BALLISTIC

	accuracy = HIT_ACCURACY_TIER_2
	max_range = 12
	damage = 55
	penetration= ARMOR_PENETRATION_TIER_1
	handful_state = "incendiary_slug"

/datum/ammo/bullet/shotgun/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shotgun/incendiary/on_hit_mob(mob/M,obj/projectile/P)
	burst(get_turf(M),P,damage_type)
	knockback(M,P)

/datum/ammo/bullet/shotgun/incendiary/on_hit_obj(obj/O,obj/projectile/P)
	burst(get_turf(P),P,damage_type)

/datum/ammo/bullet/shotgun/incendiary/on_hit_turf(turf/T,obj/projectile/P)
	burst(get_turf(T),P,damage_type)


/datum/ammo/bullet/shotgun/flechette
	name = "箭弹"
	icon_state = "flechette"
	handful_state = "flechette_shell"
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/flechette_spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	max_range = 12
	damage = 30
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_7
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	handful_state = "flechette_shell"
	multiple_handful_name = TRUE

/datum/ammo/bullet/shotgun/flechette/setup_faction_clash_values()
	. = ..()
	damage *= 0.7

/datum/ammo/bullet/shotgun/flechette_spread
	name = "附加箭弹"
	icon_state = "flechette"

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	max_range = 12
	damage = 30
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_7
	scatter = SCATTER_AMOUNT_TIER_5

/datum/ammo/bullet/shotgun/flechette_spread/setup_faction_clash_values()
	. = ..()
	damage *= 0.7

/datum/ammo/bullet/shotgun/buckshot
	name = "鹿弹"
	icon_state = "buckshot"
	handful_state = "buckshot_shell"
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_5
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_5
	accurate_range = 4
	max_range = 4
	damage = 65
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_1
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	shell_speed = AMMO_SPEED_TIER_2
	damage_armor_punch = 0
	pen_armor_punch = 0
	handful_state = "buckshot_shell"
	multiple_handful_name = TRUE

/datum/ammo/bullet/shotgun/buckshot/incendiary
	name = "燃烧鹿弹"
	handful_state = "incen_buckshot"
	handful_type = /obj/item/ammo_magazine/handful/shotgun/buckshot/incendiary

/datum/ammo/bullet/shotgun/buckshot/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shotgun/buckshot/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M,P)

//buckshot variant only used by the masterkey shotgun attachment.
/datum/ammo/bullet/shotgun/buckshot/masterkey
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/spread/masterkey

	damage = 55

/datum/ammo/bullet/shotgun/buckshot/masterkey/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M,P,1)

/datum/ammo/bullet/shotgun/spread
	name = "附加鹿弹"
	icon_state = "buckshot"

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 4
	max_range = 6
	damage = 65
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_1
	shell_speed = AMMO_SPEED_TIER_2
	scatter = SCATTER_AMOUNT_TIER_1
	damage_armor_punch = 0
	pen_armor_punch = 0

/datum/ammo/bullet/shotgun/spread/masterkey
	damage = 20

/*
					8 GAUGE SHOTGUN AMMO
*/

/datum/ammo/bullet/shotgun/heavy/buckshot
	name = "重型鹿弹"
	icon_state = "buckshot"
	handful_state = "heavy_buckshot"
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/heavy/buckshot/spread
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	accurate_range = 3
	max_range = 3
	damage = 75
	penetration = 0
	shell_speed = AMMO_SPEED_TIER_2
	damage_armor_punch = 0
	pen_armor_punch = 0

/datum/ammo/bullet/shotgun/heavy/buckshot/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M,P)

/datum/ammo/bullet/shotgun/heavy/buckshot/spread
	name = "附加重型鹿弹"
	max_range = 4
	scatter = SCATTER_AMOUNT_TIER_1
	bonus_projectiles_amount = 0

//basically the same
/datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath
	name = "龙息弹"
	handful_state = "heavy_dragonsbreath"
	multiple_handful_name = TRUE
	damage_type = BURN
	damage = 60
	accurate_range = 3
	max_range = 4
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath/spread

/datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath/spread
	name = "附加龙息弹"
	bonus_projectiles_amount = 0
	accurate_range = 4
	max_range = 5 //make use of the ablaze property
	shell_speed = AMMO_SPEED_TIER_4 // so they hit before the main shell stuns


/datum/ammo/bullet/shotgun/heavy/slug
	name = "重型霰弹枪独头弹"
	handful_state = "heavy_slug"

	accurate_range = 7
	max_range = 8
	damage = 90 //ouch.
	penetration = ARMOR_PENETRATION_TIER_6
	damage_armor_punch = 2

/datum/ammo/bullet/shotgun/heavy/slug/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 7)

/datum/ammo/bullet/shotgun/heavy/slug/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("突如其来的冲击让你感到震撼并行动迟缓！"))
		target.KnockDown(0.5) // If you ask me the KD should be left out, but players like their visual cues
		target.Stun(0.5)
		target.apply_effect(2, SUPERSLOW)
		target.apply_effect(5, SLOW)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.apply_effect(1, SUPERSLOW)
			living_mob.apply_effect(2, SLOW)
			to_chat(living_mob, SPAN_HIGHDANGER("冲击让你失去平衡！"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/heavy/beanbag
	name = "重型豆袋弹"
	icon_state = "beanbag"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	handful_state = "heavy_beanbag"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_IGNORE_RESIST
	sound_override = 'sound/weapons/gun_shotgun_riot.ogg'

	max_range = 7
	shrapnel_chance = 0
	damage = 0
	stamina_damage = 100
	accuracy = HIT_ACCURACY_TIER_2
	shell_speed = AMMO_SPEED_TIER_2

/datum/ammo/bullet/shotgun/heavy/beanbag/on_hit_mob(mob/M, obj/projectile/P)
	if(!M || M == P.firer)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		shake_camera(H, 2, 1)

/datum/ammo/bullet/shotgun/heavy/flechette
	name = "重型箭弹"
	icon_state = "flechette"
	handful_state = "heavy_flechette"
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/heavy/flechette_spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_3
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_3
	max_range = 12
	damage = 45
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_2

/datum/ammo/bullet/shotgun/heavy/flechette/setup_faction_clash_values()
	. = ..()
	damage *= 0.7

/datum/ammo/bullet/shotgun/heavy/flechette_spread
	name = "附加重型箭弹"
	icon_state = "flechette"
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	max_range = 12
	damage = 45
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	scatter = SCATTER_AMOUNT_TIER_4

/datum/ammo/bullet/shotgun/heavy/flechette_spread/setup_faction_clash_values()
	. = ..()
	damage *= 0.7

/*
					16 GAUGE SHOTGUN AMMO
*/

/datum/ammo/bullet/shotgun/light/breaching
	name = "轻型破门弹"
	icon_state = "flechette"
	handful_state = "breaching_shell"
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/light/breaching/spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	damage = 55
	max_range = 5
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	penetration = ARMOR_PENETRATION_TIER_1

/datum/ammo/bullet/shotgun/light/breaching/spread
	name = "额外轻型破门破片"
	bonus_projectiles_amount = 0
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	scatter = SCATTER_AMOUNT_TIER_3
	damage = 10

/datum/ammo/bullet/shotgun/light/rubber
	name = "橡胶鹿弹弹壳"
	icon_state = "buckshot"
	handful_state = "rubbershot_shell"
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/light/rubber/spread
	sound_override = 'sound/weapons/gun_shotgun_riot.ogg'
	headshot_state = HEADSHOT_OVERLAY_LIGHT  //It's not meant to kill people... but if you put it in your mouth, it will.
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_2
	max_range = 5
	shrapnel_chance = 0
	damage = 0
	stamina_damage = 35
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	penetration = ARMOR_PENETRATION_TIER_1

/datum/ammo/bullet/shotgun/light/rubber/spread
	name = "额外橡胶鹿弹"
	bonus_projectiles_amount = 0
	scatter = SCATTER_AMOUNT_TIER_3
	stamina_damage = 10


//Enormous shell for Van Bandolier's superheavy double-barreled hunting gun.
/datum/ammo/bullet/shotgun/twobore
	name = "双径子弹"
	icon_state = "autocannon"
	handful_state = "twobore"

	accurate_range = 8 //Big low-velocity projectile; this is for blasting dangerous game at close range.
	max_range = 14 //At this range, it's lost all its damage anyway.
	damage = 300 //Hits like a buckshot PB.
	penetration = ARMOR_PENETRATION_TIER_3
	damage_falloff = DAMAGE_FALLOFF_TIER_1 * 3 //It has a lot of energy, but the 26mm bullet drops off fast.
	effective_range_max = EFFECTIVE_RANGE_MAX_TIER_2 //Full damage up to this distance, then falloff for each tile beyond.
	var/hit_messages = list()

/datum/ammo/bullet/shotgun/twobore/on_hit_mob(mob/living/M, obj/projectile/P)
	var/mob/shooter = P.firer
	if(shooter && ismob(shooter) && HAS_TRAIT(shooter, TRAIT_TWOBORE_TRAINING) && M.stat != DEAD && prob(40)) //Death is handled by periodic life() checks so this should have a chance to fire on a killshot.
		if(!length(hit_messages)) //Pick and remove lines, refill on exhaustion.
			hit_messages = list("Got you!", "Aha!", "正中靶心！", "It's curtains for you, Sonny Jim!", "Your head will look fantastic on my wall!", "I have you now!", "You miserable coward! Come and fight me like a man!", "Tally ho!")
		var/message = pick_n_take(hit_messages)
		shooter.say(message)

	if(P.distance_travelled > 8)
		knockback(M, P, 12)

	else if(!M || M == P.firer || M.body_position == LYING_DOWN) //These checks are included in knockback and would be redundant above.
		return

	shake_camera(M, 3, 4)
	M.KnockDown(2) // If you ask me the KD should be left out, but players like their visual cues
	M.Stun(2)
	M.apply_effect(4, SLOW)
	if(iscarbonsizexeno(M))
		to_chat(M, SPAN_XENODANGER("冲击力将你击倒在地！"))
	else //This will hammer a Yautja as hard as a human.
		to_chat(M, SPAN_HIGHDANGER("冲击力将你击倒在地！"))

	step(M, get_dir(P.firer, M))

/datum/ammo/bullet/shotgun/twobore/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("突如其来的冲击让你感到震撼并行动迟缓！"))
		target.KnockDown(0.5) // If you ask me the KD should be left out, but players like their visual cues
		target.Stun(0.5)
		target.apply_effect(2, SUPERSLOW)
		target.apply_effect(5, SLOW)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.apply_effect(1, SUPERSLOW)
			living_mob.apply_effect(2, SLOW)
			to_chat(living_mob, SPAN_HIGHDANGER("冲击让你失去平衡！"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)
