/*
Mineral Sheets
	Contains:
		- Sandstone
		- Runed Sandstone
		- Diamond
		- Uranium
		- Phoron
		- Gold
		- Silver
		- Enriched Uranium
		- Platinum
		- Metallic Hydrogen
		- Tritium
		- Osmium
*/

GLOBAL_LIST_INIT(sandstone_recipes, list ( \
	new/datum/stack_recipe("pile of dirt", /obj/structure/machinery/portable_atmospherics/hydroponics/soil, 3, time = 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("sandstone door", /obj/structure/mineral_door/sandstone, 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("砂岩墙", /turf/closed/wall/mineral/sandstone, 5, time = 50, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_ENGI, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("砂岩地板", /turf/open/floor/sandstone/runed, 1, on_floor = 1), \
	new/datum/stack_recipe("sandstone handrail (crenellations)", /obj/structure/barricade/handrail/sandstone, 2, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_TRAINED, min_time = 1 SECONDS), \
	new/datum/stack_recipe("sandstone handrail (flat)", /obj/structure/barricade/handrail/sandstone/b, 2, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_TRAINED, min_time = 1 SECONDS), \
	new/datum/stack_recipe("dark sandstone handrail (cren.)", /obj/structure/barricade/handrail/sandstone/dark, 2, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_TRAINED, min_time = 1 SECONDS), \
	new/datum/stack_recipe("dark sandstone handrail (flat)", /obj/structure/barricade/handrail/sandstone/b/dark, 2, time = 2 SECONDS, one_per_turf = ONE_TYPE_PER_BORDER, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_TRAINED, min_time = 1 SECONDS),
	))

GLOBAL_LIST_INIT(runedsandstone_recipes, list ( \
	new/datum/stack_recipe("temple door", /obj/structure/machinery/door/airlock/sandstone/runed, 15, time = 10, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("dark temple door", /obj/structure/machinery/door/airlock/sandstone/runed/dark, 15, time = 10, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe_list("temple walls",list( \
		new/datum/stack_recipe("temple wall", /turf/closed/wall/mineral/sandstone/runed, 5, time = 50, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
		new/datum/stack_recipe("runed temple wall", /turf/closed/wall/mineral/sandstone/runed/decor, 5, time = 50, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
		new/datum/stack_recipe("dark engraved wall", /turf/closed/wall/cult, 5, time = 50, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
		), 5), \
	new/datum/stack_recipe_list("temple floors",list( \
		new/datum/stack_recipe("tan floor", /turf/open/floor/sandstone/runed, 1, on_floor = 1), \
		new/datum/stack_recipe("雕花地板", /turf/open/floor/sandstone/cult, 1, on_floor = 1), \
		new/datum/stack_recipe("dark red floor", /turf/open/floor/sandstone/red, 1, on_floor = 1), \
		new/datum/stack_recipe("sun runed floor", /turf/open/floor/sandstone/red2, 1, on_floor = 1), \
		new/datum/stack_recipe("square runed floor", /turf/open/floor/sandstone/red3, 1, on_floor = 1), \
		), 1), \
	new/datum/stack_recipe("brazier frame", /obj/structure/prop/brazier/frame, 5, time = 5 SECONDS, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("wall torch frame", /obj/item/prop/torch_frame, 2, time = 2 SECONDS, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("异形座椅", /obj/structure/bed/chair/comfy/yautja, 2, time = 2 SECONDS, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("alien bed", /obj/structure/bed/alien/yautja, 3, time = 3 SECONDS, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("tan statue", /obj/structure/showcase/yautja, 10, time = 30, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("grey statue", /obj/structure/showcase/yautja/alt, 10, time = 30, skill_req = SKILL_ANTAG, skill_lvl = SKILL_ANTAG_HUNTER, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	))

GLOBAL_LIST_INIT(silver_recipes, list ( \
	new/datum/stack_recipe("silver door", /obj/structure/mineral_door/silver, 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("silver beaker", /obj/item/reagent_container/glass/beaker/catalyst/silver, 3, time = 30, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_TRAINED), \
	))

GLOBAL_LIST_INIT(diamond_recipes, list ( \
	new/datum/stack_recipe("diamond door", /obj/structure/mineral_door/transparent/diamond, 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	))

GLOBAL_LIST_INIT(uranium_recipes, list ( \
	new/datum/stack_recipe("uranium door", /obj/structure/mineral_door/uranium, 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	))

GLOBAL_LIST_INIT(gold_recipes, list ( \
	new/datum/stack_recipe("golden door", /obj/structure/mineral_door/gold, 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	))

GLOBAL_LIST_INIT(phoron_recipes, list ( \
	new/datum/stack_recipe("phoron door", /obj/structure/mineral_door/transparent/phoron, 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	))

GLOBAL_LIST_INIT(plastic_recipes, list ( \
	new/datum/stack_recipe("塑料箱", /obj/structure/closet/crate/plastic, 10, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("塑料烟灰缸", /obj/item/ashtray/plastic, 2, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	new/datum/stack_recipe("塑料叉", /obj/item/tool/kitchen/utensil/pfork, 1, on_floor = 1), \
	new/datum/stack_recipe("塑料勺", /obj/item/tool/kitchen/utensil/pspoon, 1, on_floor = 1), \
	new/datum/stack_recipe("塑料刀", /obj/item/tool/kitchen/utensil/pknife, 1, on_floor = 1), \
	))

GLOBAL_LIST_INIT(iron_recipes, list ( \
	new/datum/stack_recipe("iron door", /obj/structure/mineral_door/iron, 20, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1), \
	null, \
))

/obj/item/stack/sheet/mineral
	force = 5
	throwforce = 5
	w_class = SIZE_MEDIUM
	throw_speed = SPEED_VERY_FAST
	throw_range = 3
	black_market_value = 5

/obj/item/stack/sheet/mineral/Initialize()
	. = ..()
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4

/obj/item/stack/sheet/mineral/iron
	name = "iron"
	desc = "铁是一种过渡金属，也是太空中最基本的建筑材料。它在室温下呈固态，易于塑形，且储量巨大。"
	singular_name = "iron sheet"
	icon_state = "sheet-silver"

	sheettype = "iron"
	color = "#333333"
	perunit = 3750
	stack_id = "iron"

/obj/item/stack/sheet/mineral/iron/Initialize()
	. = ..()
	recipes = GLOB.iron_recipes

/obj/item/stack/sheet/mineral/sandstone
	name = "砂岩砖"
	desc = "砂岩是沙子胶结而成的石头。它是原始文明的常见建筑材料，但用来砌墙也足够坚固。"
	singular_name = "砂岩砖"
	icon_state = "sheet-sandstone"
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	amount_sprites = TRUE
	sheettype = "sandstone"
	stack_id = "sandstone"

/obj/item/stack/sheet/mineral/sandstone/Initialize()
	. = ..()
	recipes = GLOB.sandstone_recipes

/obj/item/stack/sheet/mineral/sandstone/large_stack
	amount = STACK_50

/obj/item/stack/sheet/mineral/sandstone/runed
	name = "符文砂岩砖"
	desc = "砂岩是沙子胶结而成的石头。它是原始文明的常见建筑材料，但用来砌墙也足够坚固。这块砖上蚀刻着奇怪的符文。"
	singular_name = "符文砂岩砖"
	icon_state = "sheet-runedsandstone"
	amount_sprites = FALSE
	black_market_value = 15

/obj/item/stack/sheet/mineral/sandstone/runed/large_stack
	amount = STACK_50

/obj/item/stack/sheet/mineral/sandstone/runed/Initialize()
	. = ..()
	recipes = GLOB.runedsandstone_recipes

/obj/item/stack/sheet/mineral/sandstone/runed/attack_self(mob/user) // yautja is real?????? no way
	if(!isyautja(user))
		return

	..()

/obj/item/stack/sheet/mineral/diamond
	name = "diamond"
	desc = "钻石是经过高压高温处理、形成金刚石立方晶格的碳。尽管如今已能人工制造，它仍因其外观和硬度而备受推崇。"
	singular_name = "diamond gem"
	icon_state = "sheet-diamond"

	perunit = 3750
	sheettype = "diamond"
	stack_id = "diamond"
	black_market_value = 30


/obj/item/stack/sheet/mineral/diamond/Initialize()
	. = ..()
	recipes = GLOB.diamond_recipes

/obj/item/stack/sheet/mineral/uranium
	name = "uranium"
	desc = "铀是锕系的一种放射性金属。因其可作为裂变型反应堆的燃料以及聚变炸弹的起爆剂而具有重要价值。"
	singular_name = "uranium rod"
	icon_state = "sheet-uranium"

	perunit = 2000
	sheettype = "uranium"
	stack_id = "uranium"
	black_market_value = 30

/obj/item/stack/sheet/mineral/uranium/Initialize()
	. = ..()
	recipes = GLOB.uranium_recipes

/obj/item/stack/sheet/mineral/uranium/small_stack
	amount = STACK_10

/obj/item/stack/sheet/mineral/phoron
	name = "固态福隆"
	desc = "福隆是一种具有奇特性质的极稀有矿物，常用于尖端研究。考虑到其具有相当的毒性和易燃性，仅将其稳定成固态形式就已足够困难。"
	singular_name = "phoron ingot"
	icon_state = "sheet-phoron"

	perunit = 2000
	sheettype = "phoron"
	stack_id = "phoron"
	black_market_value = 10

/obj/item/stack/sheet/mineral/phoron/small_stack
	amount = STACK_10

/obj/item/stack/sheet/mineral/phoron/medium_stack
	amount = STACK_30

/obj/item/stack/sheet/mineral/plastic
	name = "塑料"
	desc = "塑料是一种合成聚合物，由有机和无机成分制成，质地柔韧且轻便。可用于制造多种物品。"
	singular_name = "plastic sheet"
	icon_state = "sheet-plastic"
	item_state = "sheet-plastic"
	matter = list("plastic" = 2000)
	amount_sprites = TRUE
	perunit = 2000
	stack_id = "plastic"
	black_market_value = 0

/obj/item/stack/sheet/mineral/plastic/Initialize()
	. = ..()
	recipes = GLOB.plastic_recipes

/obj/item/stack/sheet/mineral/plastic/small_stack
	amount = STACK_10

/obj/item/stack/sheet/mineral/plastic/cyborg
	name = "塑料板"
	desc = "塑料是一种合成聚合物，由有机和无机成分制成，质地柔韧且轻便。可用于制造多种物品。"
	singular_name = "plastic sheet"
	icon_state = "sheet-plastic"
	item_state = "sheet-plastic"
	perunit = 2000

/obj/item/stack/sheet/mineral/gold
	name = "gold"
	desc = "金是一种过渡金属。作为一种相对稀有的金属，以其色泽、光泽、化学和电学特性而闻名，在装饰、工程和科学领域都有广泛应用。"
	singular_name = "gold ingot"
	icon_state = "sheet-gold"

	perunit = 2000
	sheettype = "gold"
	stack_id = "gold"
	black_market_value = 30

/obj/item/stack/sheet/mineral/gold/Initialize()
	. = ..()
	recipes = GLOB.gold_recipes

/obj/item/stack/sheet/mineral/gold/small_stack
	amount = STACK_5

/obj/item/stack/sheet/mineral/silver
	name = "silver"
	desc = "银是一种过渡金属。以其同名银灰色而闻名。在装饰上作为黄金的廉价替代品，在工程上则因其无与伦比的导电性、导热性和反射性而被使用。"
	singular_name = "silver ingot"
	icon_state = "sheet-silver"

	perunit = 2000
	sheettype = "silver"
	stack_id = "silver"
	black_market_value = 25

/obj/item/stack/sheet/mineral/silver/Initialize()
	. = ..()
	recipes = GLOB.silver_recipes

/obj/item/stack/sheet/mineral/silver/small_stack
	amount = STACK_10

/obj/item/stack/sheet/mineral/enruranium
	name = "浓缩铀"
	desc = "浓缩铀棒由约3%至5%的U-235与普通U-238混合制成。虽然远未达到武器级，但已足够用于裂变引擎。"
	singular_name = "enriched uranium rod"
	icon_state = "sheet-enruranium"

	perunit = 1000
	stack_id = "enuranium"

//Valuable resource, cargo can now actually sell it.
/obj/item/stack/sheet/mineral/platinum
	name = "platinum"
	desc = "铂是一种过渡金属。相对稀有且美观，因其装饰价值和作为催化剂的化学性质而被使用。也用于制造电极。"
	singular_name = "platinum ingot"
	icon_state = "sheet-platinum"

	sheettype = "platinum"
	perunit = 2000
	stack_id = "platinum"
	black_market_value = 35


/obj/item/stack/sheet/mineral/lead
	name = "lead"
	desc = "铅是一种重金属。密度很大，但在固态时柔软且具有延展性。虽然摄入有毒，但铅板被用作墙体屏蔽材料以抵御辐射，并吸收声音和振动。"
	singular_name = "lead brick"
	icon_state = "sheet-lead"

	sheettype = "lead"
	perunit = 2000
	stack_id = "lead"
	black_market_value = 35

//Extremely valuable to Research.
/obj/item/stack/sheet/mineral/mhydrogen
	name = "金属氢"
	desc = "金属氢是普通氢在接近固态的状态下，经巨大压力形成的锭块。制造和稳定此类锭块的确切程序仍是商业机密。"
	singular_name = "hydrogen ingot"
	icon_state = "sheet-mythril"

	sheettype = "mhydrogen"
	perunit = 2000
	stack_id = "mhydrogen"

//Fuel for MRSPACMAN generator.
/obj/item/stack/sheet/mineral/tritium
	name = "tritium"
	desc = "氚是氢的一种同位素，H-3，在巨大压力下形成的锭块。制造和稳定这种锭块的确切程序仍是商业机密。"
	singular_name = "tritium ingot"
	icon_state = "sheet-silver"
	sheettype = "tritium"

	color = "#777777"
	perunit = 2000
	stack_id = "tritium"
	black_market_value = 35

/obj/item/stack/sheet/mineral/osmium
	name = "osmium"
	desc = "锇是一种过渡金属。人类已知密度最高的天然元素，以其极高的硬度和耐用性而闻名，并因此被使用。"
	singular_name = "osmium ingot"
	icon_state = "sheet-silver"
	sheettype = "osmium"

	color = "#9999FF"
	perunit = 2000
	stack_id = "osmium"
	black_market_value = 35

/obj/item/stack/sheet/mineral/chitin
	name = "chitin"
	desc = "几丁质是节肢动物——例如昆虫或甲壳类——外骨骼的构成单元。这张薄片尤其来自外星生物。"
	singular_name = "chitin brick"
	icon_state = "sheet-chitin"

	sheettype = "chitin"
	perunit = 2000
	stack_id = "chitin"
	black_market_value = 35
