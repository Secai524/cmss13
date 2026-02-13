//UPP

/obj/item/mre_food_packet/upp
	icon = 'icons/obj/items/food/mre_food/upp.dmi'
	icon_state = null

/obj/item/reagent_container/food/snacks/mre_food/upp
	icon = 'icons/obj/items/food/mre_food/upp.dmi'

///SNACK

/obj/item/mre_food_packet/upp/snack
	name = "\improper IRP snack"
	desc = "一份IRP零食，一种营养小吃，可在休息时食用或搭配主菜。"
	icon_state = "upp_snack"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/upp/snack/driedfish,
		/obj/item/reagent_container/food/snacks/mre_food/upp/snack/driedfish/alt,
		/obj/item/reagent_container/food/snacks/mre_food/upp/snack/mashed_potato,
		/obj/item/reagent_container/food/snacks/mre_food/upp/snack/riceball,
	)

/obj/item/reagent_container/food/snacks/mre_food/upp/snack/driedfish
	name = "鳕鱼干片"
	icon_state = "driedfish"
	desc = "一片腌制风干的鳕鱼片，搭配冰镇啤酒的完美零食。"

/obj/item/reagent_container/food/snacks/mre_food/upp/snack/driedfish/Initialize()
	. = ..()
	reagents.add_reagent("fish", 4)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/upp/snack/driedfish/alt
	name = "塔兰鱼干"
	icon_state = "driedfish_2"
	desc = "一整条腌制风干的鲁特卢斯鱼，搭配冰镇啤酒的完美零食。"

/obj/item/reagent_container/food/snacks/mre_food/upp/snack/mashed_potato
	name = "土豆泥"
	icon_state = "土豆泥"
	desc = "非常柔软温和的配菜，小份量，旨在搭配其他食物。"

/obj/item/reagent_container/food/snacks/mre_food/upp/snack/mashed_potato/Initialize()
	. = ..()
	reagents.add_reagent("potato", 4)
	reagents.add_reagent("milk", 2)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/upp/snack/riceball
	name = "饭团"
	icon_state = "riceball"
	desc = "煮熟的米饭捏成的球状，带有轻微的黄油味，令人惊讶的是它不会散开。"

/obj/item/reagent_container/food/snacks/mre_food/upp/snack/riceball/Initialize()
	. = ..()
	reagents.add_reagent("rice", 4)
	reagents.add_reagent("sodiumchloride", 1)

///DESSERT

/obj/item/mre_food_packet/upp/dessert
	name = "\improper IRP dessert"
	desc = "一份IRP配餐。内含甜点，适合搭配茶或其他热饮食用。"
	icon_state = "upp_dessert"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/birdmilk,
		/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/toffees,
		/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/hematogen,
		/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/darkchocolate,
		/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/ricecandy,
	)

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/birdmilk
	name = "鸟乳糖"
	icon_state = "鸟乳糖"
	desc = "鸟乳糖，在东欧斯拉夫地区很受欢迎，是一种奶油棉花糖状的小块糖果，外层覆盖着巧克力。"

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/birdmilk/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 4)
	reagents.add_reagent("cream", 3)
	reagents.add_reagent("coco", 3)

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/toffees
	name = "toffees"
	icon_state = "toffees"
	desc = "一种由炼乳和糖焦化制成的硬糖。"

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/toffees/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 6)
	reagents.add_reagent("milk", 4)

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/hematogen
	name = "血宝糖棒"
	icon_state = "hematogen"
	desc = "一种糖果棒，其起源可追溯到苏联时期。据称这种糖棒具有促进血液再生和改善血液循环的特性，其成分包括：牛血、炼乳、蜂蜜和抗坏血酸。"

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/hematogen/Initialize()
	. = ..()
	reagents.add_reagent("iron", 8)
	reagents.add_reagent("sugar", 3)
	reagents.add_reagent("blood", 4)
	reagents.add_reagent("milk", 4)
	reagents.add_reagent("honey", 3)

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/darkchocolate
	name = "黑巧克力棒"
	icon_state = "dark chocolate"
	desc = "56%可可纯黑巧克力，风味浓郁，经典款式，与热饮及其他零食搭配良好。"

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/darkchocolate/Initialize()
	. = ..()
	reagents.add_reagent("coco", 8)
	reagents.add_reagent("sugar", 2)

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/ricecandy
	name = "巧克力米花糖"
	icon_state = "rice candies"
	desc = "多种米花糖，外层包裹白巧克力，外皮顺滑，内里酥脆。"

/obj/item/reagent_container/food/snacks/mre_food/upp/dessert/ricecandy/Initialize()
	. = ..()
	reagents.add_reagent("coco", 4)
	reagents.add_reagent("rice", 2)
