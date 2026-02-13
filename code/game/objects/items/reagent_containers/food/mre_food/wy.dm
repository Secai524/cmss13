//WY

/obj/item/mre_food_packet/wy
	icon = 'icons/obj/items/food/mre_food/wy.dmi'
	icon_state = null

/obj/item/reagent_container/food/snacks/mre_food/wy
	icon = 'icons/obj/items/food/mre_food/wy.dmi'

/obj/item/mre_food_packet/wy/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

///ENTREE

/obj/item/mre_food_packet/entree/wy
	name = "\improper CFR main dish"
	desc = "一份CFR主菜组件。包含一道精心准备、采用高科技方法保存的豪华主菜。"
	icon = 'icons/obj/items/food/mre_food/wy.dmi'
	icon_state = "pmc_entree"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/wy/entree/bakedfish,
		/obj/item/reagent_container/food/snacks/mre_food/wy/entree/smokyribs,
		/obj/item/reagent_container/food/snacks/mre_food/wy/entree/ham,
		/obj/item/reagent_container/food/snacks/mre_food/wy/entree/beefstake,
	)

/obj/item/mre_food_packet/entree/wy/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/bakedfish
	name = "烤三文鱼"
	icon_state = "baked fish"
	desc = "一份奶油烤野生三文鱼，含有你未来四天可能所需的足量维生素D3。"

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/bakedfish/Initialize()
	. = ..()
	reagents.add_reagent("fish", 14)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/smokyribs
	name = "烟熏肋排"
	icon_state = "烟熏肋排"
	desc = "一份烟熏到位的牛肋排，配以黑胡椒和苹果酱，多汁且富有嚼劲。"

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/smokyribs/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 13)
	reagents.add_reagent("blackpepper", 2)
	reagents.add_reagent("fruit", 1)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/ham
	name = "烤火腿"
	icon_state = "ham"
	desc = "五分熟的烤火腿，外层带胡椒味，肉质湿润，风味浓郁。"

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/ham/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("blackpepper", 2)
	reagents.add_reagent("blood", 1)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/beefstake
	name = "beefsteak"
	icon_state = "beefstake"
	desc = "七分熟的牛排，佐以橙汁酱和百里香。"

/obj/item/reagent_container/food/snacks/mre_food/wy/entree/beefstake/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("orangejuice", 3)
	reagents.add_reagent("sodiumchloride", 1)

///SIDE

/obj/item/mre_food_packet/wy/side
	name = "\improper CFR side dish"
	desc = "一份CFR配菜组件。包含一份与主菜搭配食用的配菜。"
	icon_state = "pmc_side"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cracker,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/risotto,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/onigiri,
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/nigirisushi,
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/tomatochips,
	)

///SNACK

/obj/item/mre_food_packet/wy/snack
	name = "\improper CFR snack"
	desc = "一份CFR甜点组件。包含一份甜点，用于主菜后食用（或者，如果你够叛逆，也可以在主菜前吃）。"
	icon_state = "pmc_snack"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/twe/snack/almond,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/peanuts,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/pretzels,
	)

///DESSERT

/obj/item/mre_food_packet/wy/dessert
	name = "\improper CFR dessert"
	desc = "一份CFR甜点组件。包含一份甜点，用于主菜后食用（或者，如果你够叛逆，也可以在主菜前吃）。"
	icon_state = "pmc_dessert"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/eclair,
		/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/strawberrycake,
		/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/cherrypie,
		/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/croissant,
		/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/whitecoco,
	)

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/eclair
	name = "eclair"
	icon_state = "eclair"
	desc = "一份精致的糕点，内馅是轻盈的香草味奶油，顶部覆盖着一层巧克力糖霜。"

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/eclair/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("coco", 1)
	reagents.add_reagent("sugar", 2)

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/strawberrycake
	name = "草莓蛋糕"
	icon_state = "草莓蛋糕"
	desc = "轻盈的香草蛋糕，外层是厚厚的草莓糖霜，内层是草莓夹心。"

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/strawberrycake/Initialize()
	. = ..()
	reagents.add_reagent("berryjuice", 5)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("sprinkles", 2)

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/cherrypie
	name = "樱桃派"
	icon_state = "樱桃派"
	desc = "一个外皮酥脆、内馅是柔软樱桃果冻的派。"

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/cherrypie/Initialize()
	. = ..()
	reagents.add_reagent("cherryjelly", 2)
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("sugar", 1)

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/croissant
	name = "巧克力可颂"
	icon_state = "croissant"
	desc = "一个酥脆的可颂，内馅是黑巧克力。"

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/croissant/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("coco", 3)
	reagents.add_reagent("sugar", 1)

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/whitecoco
	name = "白巧克力棒"
	icon_state = "白巧克力棒"
	desc = "一根白巧克力棒，内含杏仁和椰子碎。别让那些异端分子说它是假巧克力，享受它的人是你。"

/obj/item/reagent_container/food/snacks/mre_food/wy/dessert/whitecoco/Initialize()
	. = ..()
	reagents.add_reagent("coco", 3)
	reagents.add_reagent("milk", 2)
	reagents.add_reagent("nuts", 2)
	reagents.add_reagent("coconutmilk", 2)
	reagents.add_reagent("sugar", 1)

//WY GENERAL RATION

/obj/item/mre_food_packet/entree/wy_colonist
	name = "\improper W-Y brand ration main dish"
	desc = "这大概是其中最能吃的部分了，含有主要的营养成分。"
	icon = 'icons/obj/items/food/mre_food/wy.dmi'
	icon_state = "wy_main"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/porkribs,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchicken,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/chickentender,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/spaghettichunks,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchickenbreast,
	)

//WY EMERGENCY RATION

/obj/item/mre_food_packet/wy/cookie_brick
	name = "应急食品包（饼干块）"
	desc = "一块压缩饼干，专为在极端条件下长期储存而设计，但尝起来仍像一块压缩的黄油饼干。"
	icon_state = "cookie_brick"
	no_packet_label = TRUE
	food_list = list(/obj/item/reagent_container/food/snacks/mre_food/wy_emergency_cookie)

/obj/item/reagent_container/food/snacks/mre_food/wy_emergency_cookie
	name = "\improper W-Y brand emergency nutrition briquette"
	desc = "一块压缩饼干，专为在极端条件下长期储存而设计，但尝起来仍像一块压缩的黄油饼干。"
	icon = 'icons/obj/items/food/mre_food/wy.dmi'
	icon_state = "cookie_brick_open"

/obj/item/reagent_container/food/snacks/mre_food/wy_emergency_cookie/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 12)
	reagents.add_reagent("bread", 12)
	reagents.add_reagent("sugar", 4)
