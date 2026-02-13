/* Glass stack types
 * Contains:
 * Glass sheets
 * Reinforced glass sheets
 * Phoron Glass Sheets
 * Reinforced Phoron Glass Sheets (AKA Holy fuck strong windows)
 * Glass shards - TODO: Move this into code/game/object/item/weapons
 */

GLOBAL_LIST_INIT_TYPED(glass_recipes, /datum/stack_recipe, list ( \
	new/datum/stack_recipe("One directional window", 	/obj/structure/window, 1, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
	new/datum/stack_recipe("Full window", 				/obj/structure/window/full, 4, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
))

GLOBAL_LIST_INIT_TYPED(glass_reinforced_recipes, /datum/stack_recipe, list ( \
	new/datum/stack_recipe("One directional window", 	/obj/structure/window/reinforced, 1, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
	new/datum/stack_recipe("Full window", 				/obj/structure/window/reinforced/full, 4, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
	new/datum/stack_recipe("Windoor", 					/obj/structure/windoor_assembly, 5, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
))

//What the point of phoron glass anyway? Sprites are broken for one dir window

GLOBAL_LIST_INIT_TYPED(phoronrglass_recipes, /datum/stack_recipe, list ( \
	new/datum/stack_recipe("One directional window", 	/obj/structure/window/phoronreinforced, 1, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
	new/datum/stack_recipe("Full window", 				/obj/structure/window/phoronreinforced/full, 4, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
))

GLOBAL_LIST_INIT_TYPED(phoronglass_recipes, /datum/stack_recipe, list ( \
	new/datum/stack_recipe("One directional window", 	/obj/structure/window/phoronbasic, 1, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
	new/datum/stack_recipe("Full window", 				/obj/structure/window/phoronbasic/full, 4, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, min_time = 1 SECONDS), \
))

/*
 * Glass sheets
 */
/obj/item/stack/sheet/glass
	name = "glass"
	desc = "玻璃是一种非晶态固体，由硅酸盐制成，这是沙子的主要成分。它因其透明度而受到重视，尽管抗损伤能力不强。"
	singular_name = "glass sheet"
	icon_state = "sheet-glass"
	matter = list("glass" = 3750)

	stack_id = "glass sheet"
	var/created_window = /obj/structure/window
	var/is_reinforced = FALSE

/obj/item/stack/sheet/glass/Initialize(mapload, amount)
	. = ..()
	recipes = GLOB.glass_recipes

/obj/item/stack/sheet/glass/small_stack
	amount = STACK_10

/obj/item/stack/sheet/glass/medium_stack
	amount = STACK_25

/obj/item/stack/sheet/glass/large_stack
	amount = STACK_50

/obj/item/stack/sheet/glass/cyborg
	matter = null

/obj/item/stack/sheet/glass/attackby(obj/item/W, mob/user)
	if(!is_reinforced)
		if(istype(W,/obj/item/stack/cable_coil))
			var/obj/item/stack/cable_coil/CC = W
			if (get_amount() < 1 || CC.get_amount() < 5)
				to_chat(user, SPAN_WARNING("你需要五段线圈和一张玻璃来制作缠线玻璃。"))
				return

			CC.use(5)
			new /obj/item/stack/light_w(user.loc, 1)
			use(1)
			to_chat(user, SPAN_NOTICE("你将电线连接到[name]上。"))
			return
		else if(istype(W, /obj/item/stack/rods))
			var/obj/item/stack/rods/V  = W
			if (V.get_amount() < 1 || get_amount() < 1)
				to_chat(user, SPAN_WARNING("你需要一根杆子和一张玻璃来制作强化玻璃。"))
				return

			var/obj/item/stack/sheet/glass/reinforced/RG = new (user.loc)
			RG.add_fingerprint(user)
			RG.add_to_stacks(user)
			var/obj/item/stack/sheet/glass/G = src
			src = null
			var/replace = (user.get_inactive_hand()==G)
			V.use(1)
			G.use(1)
			if (!G && replace)
				user.put_in_hands(RG)
			return

	..()

/*
 * Reinforced glass sheets
 */
/obj/item/stack/sheet/glass/reinforced
	name = "强化玻璃"
	desc = "强化玻璃由普通硅酸盐玻璃方块层叠在金属杆矩阵上制成。这种玻璃更能抵抗直接冲击，即使它可能会破裂。"
	singular_name = "reinforced glass sheet"
	icon_state = "sheet-rglass"
	stack_id = "reinf glass sheet"

	matter = list("metal" = 1875,"glass" = 3750)

	created_window = /obj/structure/window/reinforced
	is_reinforced = TRUE

/obj/item/stack/sheet/glass/reinforced/Initialize(mapload, amount)
	. = ..()

	recipes = GLOB.glass_reinforced_recipes

/obj/item/stack/sheet/glass/reinforced/medium_stack
	amount = 25

/obj/item/stack/sheet/glass/reinforced/large_stack
	amount = 50


/obj/item/stack/sheet/glass/reinforced/cyborg
	matter = null

/*
 * Phoron Glass sheets
 */
/obj/item/stack/sheet/glass/phoronglass
	name = "福隆玻璃"
	desc = "福隆玻璃是一种硅酸盐-福隆合金制成的非晶态固体。它像玻璃一样透明，尽管明显带有粉红色调，并且非常抗损伤和耐热。"
	singular_name = "phoron glass sheet"
	icon_state = "sheet-phoronglass"
	matter = list("glass" = 7500)

	created_window = /obj/structure/window/phoronbasic
	is_reinforced = TRUE

/obj/item/stack/sheet/glass/phoronglass/Initialize(mapload, amount)
	. = ..()

	recipes = GLOB.phoronglass_recipes

/obj/item/stack/sheet/glass/phoronglass/attackby(obj/item/W, mob/user)
	..()
	if( istype(W, /obj/item/stack/rods) )
		var/obj/item/stack/rods/V  = W
		var/obj/item/stack/sheet/glass/phoronrglass/RG = new (user.loc)
		RG.add_fingerprint(user)
		RG.add_to_stacks(user)
		V.use(1)
		var/obj/item/stack/sheet/glass/G = src
		src = null
		var/replace = (user.get_inactive_hand()==G)
		G.use(1)
		if (!G && !RG && replace)
			user.put_in_hands(RG)
	else
		return ..()

/*
 * Reinforced phoron glass sheets
 */
/obj/item/stack/sheet/glass/phoronrglass
	name = "强化福隆玻璃"
	desc = "强化型福玻斯玻璃由硅酸盐-福玻斯合金玻璃方块层叠在金属棒矩阵上制成。它对物理冲击和高温都具有惊人的抵抗力。"
	singular_name = "reinforced phoron glass sheet"
	icon_state = "sheet-phoronrglass"
	matter = list("glass" = 7500,"metal" = 1875)
	created_window = /obj/structure/window/phoronreinforced
	is_reinforced = TRUE


/obj/item/stack/sheet/glass/phoronrglass/Initialize(mapload, amount)
	. = ..()

	recipes = GLOB.phoronrglass_recipes
