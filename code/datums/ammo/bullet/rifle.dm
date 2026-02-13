/*
//======
					Rifle Ammo
//======
*/

/datum/ammo/bullet/rifle
	name = "步枪子弹"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM

	damage = 40
	penetration = ARMOR_PENETRATION_TIER_1
	accurate_range = 16
	accuracy = HIT_ACCURACY_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	shell_speed = AMMO_SPEED_TIER_6
	effective_range_max = 7
	damage_falloff = DAMAGE_FALLOFF_TIER_7
	max_range = 24 //So S8 users don't have their bullets magically disappaer at 22 tiles (S8 can see 24 tiles)

/datum/ammo/bullet/rifle/holo_target
	name = "全息瞄准步枪子弹"
	damage = 30
	/// inflicts this many holo stacks per bullet hit
	var/holo_stacks = 10
	/// modifies the default cap limit of 100 by this amount
	var/bonus_damage_cap_increase = 0
	/// multiplies the default drain of 5 holo stacks per second by this amount
	var/stack_loss_multiplier = 1

/datum/ammo/bullet/rifle/holo_target/on_hit_mob(mob/hit_mob, obj/projectile/bullet)
	. = ..()
	hit_mob.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time, bonus_damage_cap_increase, stack_loss_multiplier)

/datum/ammo/bullet/rifle/holo_target/hunting
	name = "全息瞄准狩猎子弹"
	damage = 25
	holo_stacks = 15

/datum/ammo/bullet/rifle/explosive
	name = "爆炸步枪子弹"

	damage = 25
	accurate_range = 22
	accuracy = 0
	shell_speed = AMMO_SPEED_TIER_4
	damage_falloff = DAMAGE_FALLOFF_TIER_9

/datum/ammo/bullet/rifle/explosive/on_hit_mob(mob/M, obj/projectile/P)
	cell_explosion(get_turf(M), 80, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, P.dir, P.weapon_cause_data)

/datum/ammo/bullet/rifle/explosive/on_hit_obj(obj/O, obj/projectile/P)
	cell_explosion(get_turf(O), 80, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, P.dir, P.weapon_cause_data)

/datum/ammo/bullet/rifle/explosive/on_hit_turf(turf/T, obj/projectile/P)
	if(T.density)
		cell_explosion(T, 80, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, P.dir, P.weapon_cause_data)

/datum/ammo/bullet/rifle/ap
	name = "穿甲步枪子弹"

	damage = 30
	penetration = ARMOR_PENETRATION_TIER_8

// Basically AP but better. Focused at taking out armour temporarily
/datum/ammo/bullet/rifle/ap/toxin
	name = "毒剂步枪子弹"
	var/acid_per_hit = 7
	var/organic_damage_mult = 3

/datum/ammo/bullet/rifle/ap/toxin/on_hit_mob(mob/M, obj/projectile/P)
	. = ..()
	M.AddComponent(/datum/component/status_effect/toxic_buildup, acid_per_hit)

/datum/ammo/bullet/rifle/ap/toxin/on_hit_turf(turf/T, obj/projectile/P)
	. = ..()
	if(T.turf_flags & TURF_ORGANIC)
		P.damage *= organic_damage_mult

/datum/ammo/bullet/rifle/ap/toxin/on_hit_obj(obj/O, obj/projectile/P)
	. = ..()
	if(O.flags_obj & OBJ_ORGANIC)
		P.damage *= organic_damage_mult


/datum/ammo/bullet/rifle/ap/penetrating
	name = "穿墙步枪子弹"
	shrapnel_chance = 0

	damage = 35
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/ap/penetrating/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/rifle/le
	name = "破甲步枪子弹"

	damage = 20
	penetration = ARMOR_PENETRATION_TIER_4
	pen_armor_punch = 5

/datum/ammo/bullet/rifle/heap
	name = "高爆穿甲步枪子弹"

	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 55//big damage, doesn't actually blow up because thats stupid.
	penetration = ARMOR_PENETRATION_TIER_8

/datum/ammo/bullet/rifle/rubber
	name = "橡胶步枪子弹"
	sound_override = 'sound/weapons/gun_c99.ogg'

	damage = 0
	stamina_damage = 15
	shrapnel_chance = 0

/datum/ammo/bullet/rifle/incendiary
	name = "燃烧步枪子弹"
	damage_type = BURN
	shrapnel_chance = 0
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 30
	shell_speed = AMMO_SPEED_TIER_4
	accuracy = -HIT_ACCURACY_TIER_2
	damage_falloff = DAMAGE_FALLOFF_TIER_10

/datum/ammo/bullet/rifle/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/rifle/m4ra
	name = "A19高速子弹"
	shrapnel_chance = 0
	damage_falloff = 0
	flags_ammo_behavior = AMMO_BALLISTIC
	accurate_range_min = 4

	damage = 55
	scatter = -SCATTER_AMOUNT_TIER_8
	penetration= ARMOR_PENETRATION_TIER_7
	shell_speed = AMMO_SPEED_TIER_6

/datum/ammo/bullet/rifle/m4ra/incendiary
	name = "A19高速燃烧子弹"
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 40
	accuracy = HIT_ACCURACY_TIER_4
	scatter = -SCATTER_AMOUNT_TIER_8
	penetration= ARMOR_PENETRATION_TIER_5
	shell_speed = AMMO_SPEED_TIER_6

/datum/ammo/bullet/rifle/m4ra/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/rifle/m4ra/impact
	name = "A19高速冲击子弹"
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 40
	accuracy = -HIT_ACCURACY_TIER_2
	scatter = -SCATTER_AMOUNT_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	shell_speed = AMMO_SPEED_TIER_6

/datum/ammo/bullet/rifle/m4ra/impact/on_hit_mob(mob/M, obj/projectile/P)
	knockback(M, P, 32) // Can knockback basically at max range max range is 24 tiles...

/datum/ammo/bullet/rifle/m4ra/impact/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("突如其来的冲击让你感到震撼并行动迟缓！"))
		target.KnockDown(0.5-fired_projectile.distance_travelled/100) // purely for visual effect, noone actually cares
		target.Stun(0.5-fired_projectile.distance_travelled/100)
		target.apply_effect(2-fired_projectile.distance_travelled/20, SUPERSLOW)
		target.apply_effect(5-fired_projectile.distance_travelled/10, SLOW)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.apply_effect(1, SUPERSLOW)
			living_mob.apply_effect(2, SLOW)
			to_chat(living_mob, SPAN_HIGHDANGER("冲击让你失去平衡！"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/rifle/mar40
	name = "重型步枪子弹"

	damage = 55

/datum/ammo/bullet/rifle/type71
	name = "重型步枪子弹"

	damage = 55
	penetration = ARMOR_PENETRATION_TIER_3

/datum/ammo/bullet/rifle/type71/setup_faction_clash_values()
	if(penetration <= ARMOR_PENETRATION_TIER_3) //so we only reduce AP of normal ammo here
		penetration = ARMOR_PENETRATION_TIER_1
	. = ..()

/datum/ammo/bullet/rifle/type71/ap
	name = "重型穿甲步枪子弹"

	damage = 40
	penetration = ARMOR_PENETRATION_TIER_10


/datum/ammo/bullet/rifle/type71/heap
	name = "重型高爆穿甲步枪子弹"

	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 65
	penetration = ARMOR_PENETRATION_TIER_10


//TWE Calibers\\

/datum/ammo/bullet/rifle/l23
	name = "8.88毫米步枪弹"

	damage = 50
	penetration = ARMOR_PENETRATION_TIER_2

/datum/ammo/bullet/rifle/l23/ap
	name = "8.88毫米穿甲步枪弹"

	damage = 40
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/l23/heap
	name = "8.88毫米高爆穿甲步枪弹"

	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 65
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/l23/incendiary
	name = "燃烧步枪子弹"
	damage_type = BURN
	shrapnel_chance = 0
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 40
	shell_speed = AMMO_SPEED_TIER_4
	accuracy = -HIT_ACCURACY_TIER_2
	damage_falloff = DAMAGE_FALLOFF_TIER_10

/datum/ammo/bullet/rifle/l23/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/rifle/l23/ap/toxin
	name = "毒剂步枪子弹"
	var/acid_per_hit = 7
	var/organic_damage_mult = 3

/datum/ammo/bullet/rifle/l23/ap/toxin/on_hit_mob(mob/M, obj/projectile/P)
	. = ..()
	M.AddComponent(/datum/component/status_effect/toxic_buildup, acid_per_hit)

/datum/ammo/bullet/rifle/l23/ap/toxin/on_hit_turf(turf/T, obj/projectile/P)
	. = ..()
	if(T.turf_flags & TURF_ORGANIC)
		P.damage *= organic_damage_mult

/datum/ammo/bullet/rifle/l23/ap/toxin/on_hit_obj(obj/O, obj/projectile/P)
	. = ..()
	if(O.flags_obj & OBJ_ORGANIC)
		P.damage *= organic_damage_mult

/datum/ammo/bullet/rifle/l23/rubber
	name = "8.88毫米橡胶步枪弹"
	sound_override = 'sound/weapons/gun_c99.ogg'

	damage = 0
	stamina_damage = 22
	shrapnel_chance = 0

/datum/ammo/bullet/rifle/l64

	name = "8.88x51毫米碎甲弹"

	damage = 40
	penetration = ARMOR_PENETRATION_TIER_1

/datum/ammo/bullet/rifle/l64/ap
	name = "8.88x51毫米穿甲碎甲弹"

	damage = 30
	penetration = ARMOR_PENETRATION_TIER_8
