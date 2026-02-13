/datum/resin_construction
	var/name
	var/desc
	var/construction_name // The name used in messages (to replace old resin2text proc)
	var/cost
	var/build_time = 2 SECONDS
	var/pass_hivenumber = TRUE

	var/build_overlay_icon
	var/build_animation_effect

	var/range_between_constructions
	var/build_path
	var/build_path_thick
	var/max_per_xeno = RESIN_CONSTRUCTION_NO_MAX

	var/thick_hiveweed = FALSE // if this is set, the thick variants will only work on hiveweeds
	var/can_build_on_doors = TRUE // if it can be built on a tile with an open door or not

	/// Whether this construction gets more expensive the more saturated the area is
	var/scaling_cost = FALSE

/datum/resin_construction/proc/can_build_here(turf/T, mob/living/carbon/xenomorph/X)
	var/mob/living/carbon/xenomorph/blocker = locate() in T
	if(blocker && blocker != X && blocker.stat != DEAD)
		to_chat(X, SPAN_WARNING("[blocker]挡在路上，无法完成！"))
		return FALSE

	if(!istype(T))
		return FALSE

	if(T.is_weedable < FULLY_WEEDABLE)
		var/has_node = FALSE
		for(var/obj/effect/alien/resin/design/node in T)
			has_node = TRUE
			break

		if(!has_node)
			to_chat(X, SPAN_WARNING("没有设计节点，你无法在此处进行建造。"))
			return FALSE

		if(!check_for_wall_or_door())
			to_chat(X, SPAN_WARNING("此地形不适合分泌其他树脂，此节点上只能建造墙壁和门。"))
			return FALSE

	var/area/AR = get_area(T)
	if(isnull(AR) || !(AR.is_resin_allowed))
		if(!AR || AR.flags_area & AREA_UNWEEDABLE)
			to_chat(X, SPAN_XENOWARNING("此区域不适合建立巢穴！"))
			return
		to_chat(X, SPAN_XENOWARNING("现在将巢穴扩张至此还为时过早。"))
		return FALSE

	if(!(AR.resin_construction_allowed)) //disable resin walls not weed, in special circumstances EG. Stairs and Dropship turfs
		to_chat(X, SPAN_WARNING("你感觉到此地不适合扩张巢穴。"))
		return FALSE

	var/obj/effect/alien/weeds/alien_weeds = locate() in T
	if(!alien_weeds)
		to_chat(X, SPAN_WARNING("你只能在菌毯上塑形。在开始建造前先找些树脂！"))
		return FALSE

	if(alien_weeds?.block_structures >= BLOCK_ALL_STRUCTURES)
		to_chat(X, SPAN_WARNING("\The [alien_weeds] block the construction of any structures!"))
		return FALSE

	var/obj/vehicle/V = locate() in T
	if(V)
		to_chat(X, SPAN_WARNING("你无法在\the [V]下方建造！"))
		return FALSE

	if(alien_weeds.linked_hive.hivenumber != X.hivenumber)
		to_chat(X, SPAN_WARNING("这些菌毯不属于你的巢穴！"))
		return FALSE

	if(istype(T, /turf/closed/wall)) // Can't build in walls with no density
		to_chat(X, SPAN_WARNING("该区域过于不稳定，无法支撑建筑。"))
		return FALSE

	if(!X.check_alien_construction(T, check_doors = !can_build_on_doors))
		return FALSE

	if(range_between_constructions)
		for(var/i in long_range(range_between_constructions, T))
			var/atom/A = i
			if(A.type == build_path)
				to_chat(X, SPAN_WARNING("这离另一个同类结构太近了！"))
				return FALSE

	return TRUE

/datum/resin_construction/proc/check_for_wall_or_door()
	return FALSE

/datum/resin_construction/proc/build(turf/T, hivenumber, builder)
	return

/datum/resin_construction/proc/check_thick_build(turf/build_turf, hivenumber, mob/living/carbon/xenomorph/builder)
	var/can_build_thick = TRUE
	if(thick_hiveweed)
		var/obj/effect/alien/weeds/weeds = locate() in build_turf
		if(!weeds || weeds.hivenumber != hivenumber || weeds.weed_strength < WEED_LEVEL_HIVE)
			can_build_thick = FALSE

	if(build_path_thick && (can_build_thick || (SEND_SIGNAL(builder, COMSIG_XENO_THICK_RESIN_BYPASS) & COMPONENT_THICK_BYPASS)))
		return TRUE
	return FALSE

// Subtype encompassing all resin constructions that are of type /obj
/datum/resin_construction/resin_obj/build(turf/build_turf, hivenumber, mob/living/carbon/xenomorph/builder)
	var/path = check_thick_build(build_turf, hivenumber, builder) ? build_path_thick : build_path
	if(pass_hivenumber)
		return new path(build_turf, hivenumber, builder)
	return new path(build_turf)

// Subtype encompassing all resin constructions that are of type /turf
/datum/resin_construction/resin_turf/build(turf/build_turf, hivenumber, mob/living/carbon/xenomorph/builder)
	var/path = check_thick_build(build_turf, hivenumber, builder) ? build_path_thick : build_path

	build_turf.PlaceOnTop(path)

	var/turf/closed/wall/resin/resin_wall = build_turf
	if (istype(resin_wall) && pass_hivenumber)
		resin_wall.hivenumber = hivenumber
		resin_wall.set_resin_builder(builder)
		set_hive_data(resin_wall, hivenumber)

	return build_turf

// Resin Walls
/datum/resin_construction/resin_turf/wall
	name = "树脂墙"
	desc = "一面树脂墙，能够阻挡通道。"
	construction_name = "树脂墙"
	cost = XENO_RESIN_WALL_COST
	scaling_cost = TRUE

	build_path = /turf/closed/wall/resin
	build_animation_effect = /obj/effect/resin_construct/weak

/datum/resin_construction/resin_turf/wall/check_for_wall_or_door()
	return TRUE

/datum/resin_construction/resin_turf/wall/thick
	name = "厚树脂墙"
	desc = "一面厚树脂墙，比普通墙壁更坚固。"
	construction_name = "厚树脂墙"
	cost = XENO_RESIN_WALL_THICK_COST
	scaling_cost = TRUE

	build_path = /turf/closed/wall/resin/thick
	build_animation_effect = /obj/effect/resin_construct/thick

/datum/resin_construction/resin_turf/wall/queen
	name = "女王树脂墙"
	desc = "一面树脂墙，能够阻挡通道。建造类型取决于菌毯。"
	construction_name = "queen resin wall"
	cost = XENO_RESIN_WALL_QUEEN_COST
	scaling_cost = TRUE

	build_path = /turf/closed/wall/resin
	build_path_thick = /turf/closed/wall/resin/thick
	thick_hiveweed = TRUE
	build_animation_effect = /obj/effect/resin_construct/weak

/datum/resin_construction/resin_turf/wall/reflective
	name = "反射树脂墙"
	desc = "一面反射树脂墙，能将任何射弹反射回射击者。"
	construction_name = "reflective resin wall"
	cost = XENO_RESIN_WALL_REFLECT_COST
	max_per_xeno = 5

	build_path = /turf/closed/wall/resin/reflective

// Resin Membrane
/datum/resin_construction/resin_turf/membrane
	name = "树脂膜"
	desc = "可以看穿的树脂膜。"
	construction_name = "树脂膜"
	cost = XENO_RESIN_MEMBRANE_COST
	scaling_cost = TRUE

	build_path = /turf/closed/wall/resin/membrane
	build_animation_effect = /obj/effect/resin_construct/transparent/weak

/datum/resin_construction/resin_turf/membrane/queen
	name = "女王树脂膜"
	desc = "可以看穿的树脂膜。建造类型取决于菌毯。"
	construction_name = "queen resin membrane"
	cost = XENO_RESIN_MEMBRANE_QUEEN_COST
	scaling_cost = TRUE

	build_path = /turf/closed/wall/resin/membrane
	build_path_thick = /turf/closed/wall/resin/membrane/thick
	thick_hiveweed = TRUE
	build_animation_effect = /obj/effect/resin_construct/transparent/weak

/datum/resin_construction/resin_turf/membrane/thick
	name = "厚树脂膜"
	desc = "坚固且可以看穿的树脂膜。"
	construction_name = "厚树脂膜"
	cost = XENO_RESIN_MEMBRANE_THICK_COST
	scaling_cost = TRUE

	build_path = /turf/closed/wall/resin/membrane/thick
	build_animation_effect = /obj/effect/resin_construct/transparent/thick

// Resin Doors
/datum/resin_construction/resin_obj/door
	name = "树脂门"
	desc = "一扇只有姐妹才能通过的树脂门。"
	construction_name = "树脂门"
	cost = XENO_RESIN_DOOR_COST
	scaling_cost = TRUE

	build_path = /obj/structure/mineral_door/resin
	build_animation_effect = /obj/effect/resin_construct/door

/datum/resin_construction/resin_obj/door/can_build_here(turf/T, mob/living/carbon/xenomorph/X)
	if (!..())
		return FALSE

	var/wall_support = FALSE
	for(var/D in GLOB.cardinals)
		var/turf/CT = get_step(T, D)
		if(CT)
			if(CT.density)
				wall_support = TRUE
				break
			else if(locate(/obj/structure/mineral_door/resin) in CT)
				wall_support = TRUE
				break

	if(!wall_support)
		to_chat(X, SPAN_WARNING("树脂门需要紧邻墙壁或其他树脂门才能竖立。"))
		return FALSE

	return TRUE

/datum/resin_construction/resin_obj/door/check_for_wall_or_door()
	return TRUE

/datum/resin_construction/resin_obj/door/queen
	name = "女王树脂门"
	desc = "只有姐妹才能通过的树脂门。建造类型取决于菌毯。"
	construction_name = "queen resin door"
	cost = XENO_RESIN_DOOR_QUEEN_COST
	scaling_cost = TRUE

	build_path = /obj/structure/mineral_door/resin
	build_path_thick = /obj/structure/mineral_door/resin/thick
	thick_hiveweed = TRUE
	build_animation_effect = /obj/effect/resin_construct/door

/datum/resin_construction/resin_obj/door/thick
	name = "厚重树脂门"
	desc = "一扇更耐用的厚重树脂门，只有姐妹才能通过。"
	construction_name = "厚重树脂门"
	cost = XENO_RESIN_DOOR_THICK_COST
	scaling_cost = TRUE

	build_path = /obj/structure/mineral_door/resin/thick
	build_animation_effect = /obj/effect/resin_construct/thickdoor

// Sticky Resin
/datum/resin_construction/resin_obj/sticky_resin
	name = "粘性树脂"
	desc = "当高大宿主走过时会使其减速的树脂。"
	construction_name = "粘性树脂"
	cost = XENO_RESIN_STICKY_COST
	build_time = 1 SECONDS

	build_path = /obj/effect/alien/resin/sticky

// Fast Resin
/datum/resin_construction/resin_obj/fast_resin
	name = "迅捷树脂"
	desc = "当其他姐妹走过时会使其加速的树脂。"
	construction_name = "快速树脂"
	cost = XENO_RESIN_FAST_COST
	build_time = 1 SECONDS

	build_path = /obj/effect/alien/resin/sticky/fast

/datum/resin_construction/resin_obj/resin_spike
	name = "树脂尖刺"
	desc = "当高大宿主走过时会对其造成伤害的树脂。"
	construction_name = "树脂尖刺"
	cost = XENO_RESIN_SPIKE_COST
	max_per_xeno = 15

	build_path = /obj/effect/alien/resin/spike

/datum/resin_construction/resin_obj/acid_pillar
	name = "酸液立柱"
	desc = "一座高大的绿色立柱，能够同时攻击多个目标。喷射弱酸。"
	construction_name = "酸液柱"
	cost = XENO_RESIN_ACID_PILLAR_COST
	max_per_xeno = 1

	build_overlay_icon = /obj/effect/warning/alien/weak

	build_path = /obj/effect/alien/resin/acid_pillar
	build_time = 12 SECONDS

	range_between_constructions = 5

/datum/resin_construction/resin_obj/shield_dispenser
	name = "护盾立柱"
	desc = "一座高大的奇异立柱，能为交互者提供护盾。有较长的冷却时间。"
	construction_name = "护盾柱"
	cost = XENO_RESIN_SHIELD_PILLAR_COST
	max_per_xeno = 1

	build_path = /obj/effect/alien/resin/shield_pillar
	build_time = 12 SECONDS

/datum/resin_construction/resin_obj/shield_dispenser/New()
	. = ..()
	var/obj/effect/alien/resin/shield_pillar/SP = build_path
	range_between_constructions = initial(SP.range)*2

/datum/resin_construction/resin_obj/grenade
	name = "树脂酸液手榴弹"
	desc = "一枚酸液手榴弹。"
	construction_name = "酸液手榴弹"
	cost = XENO_RESIN_ACID_GRENADE_COST
	max_per_xeno = 1

	build_path = /obj/item/explosive/grenade/alien/acid
	build_time = 6 SECONDS

//CHRISTMAS

/datum/resin_construction/resin_obj/festivizer
	name = "圣诞欢庆器"
	desc = "圣诞快乐！用这个击中任何东西，创造最欢乐的节日气氛！"
	construction_name = "christmas festivizer"
	max_per_xeno = 5
	build_path = /obj/item/toy/festivizer/xeno
	build_time = 2 SECONDS

/datum/resin_construction/resin_obj/movable
	construction_name = "树脂墙"

	max_per_xeno = 7
	cost = XENO_RESIN_WALL_MOVABLE_COST
	build_time = 3 SECONDS

/datum/resin_construction/resin_obj/movable/wall
	name = "可移动树脂墙"
	desc = "一堵可以移动到任何相邻格子的树脂墙，前提是那里有菌毯。"
	construction_name = "树脂墙"
	build_path = /obj/structure/alien/movable_wall

/datum/resin_construction/resin_obj/movable/membrane
	name = "可移动树脂薄膜"
	desc = "一层可以移动到任何相邻格子的树脂薄膜，前提是那里有菌毯。"
	construction_name = "树脂墙"
	build_path = /obj/structure/alien/movable_wall/membrane

/datum/resin_construction/resin_obj/movable/thick_wall
	name = "可移动厚重树脂墙"
	desc = "一堵可以移动到任何相邻格子的厚重树脂墙，前提是那里有菌毯。"
	construction_name = "厚树脂墙"
	build_path = /obj/structure/alien/movable_wall/thick

/datum/resin_construction/resin_obj/movable/thick_membrane
	name = "可移动厚重薄膜墙"
	desc = "一层可以移动到任何相邻格子的厚重树脂薄膜，前提是那里有菌毯。"
	construction_name = "厚树脂膜"
	build_path = /obj/structure/alien/movable_wall/membrane/thick

// Remote Weed Nodes for originally coded for Resin Whisperers
/datum/resin_construction/resin_obj/resin_node
	name = "菌毯节点"
	desc = "引导能量以扩散我们的影响。"
	construction_name = "菌毯节点"
	cost = (XENO_RESIN_MEMBRANE_THICK_COST * 2) // 3x the cost of a thick membrane. At the time of coding that is 95*2 = 190

	build_path = /obj/effect/alien/weeds/node
	build_overlay_icon = /obj/effect/warning/alien/weak
