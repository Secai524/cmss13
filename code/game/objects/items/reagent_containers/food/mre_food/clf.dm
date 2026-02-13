//CLF

/obj/item/mre_food_packet/clf
	name = "\improper wrapped makeshift meal"
	desc = "一些家常菜或搜刮来的食物，你只是在能力范围内尽力而为。"
	icon_state = "clf_mealpack"
	no_packet_label = TRUE
	icon = 'icons/obj/items/food/mre_food/clf.dmi'
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/clf/meatpie,
		/obj/item/reagent_container/food/snacks/mre_food/clf/bananapie,
		/obj/item/reagent_container/food/snacks/mre_food/clf/cheesepizza,
		/obj/item/reagent_container/food/snacks/mre_food/clf/mushroompizza,
		/obj/item/reagent_container/food/snacks/mre_food/clf/vegetablepizza,
		/obj/item/reagent_container/food/snacks/mre_food/clf/meatpizza,
	)

/obj/item/reagent_container/food/snacks/mre_food/clf
	icon = 'icons/obj/items/food/mre_food/clf.dmi'

/obj/item/reagent_container/food/snacks/mre_food/clf/meatpie
	name = "包装好的肉馅饼"
	icon_state = "clf_meatpie"
	desc = "一个包装好的自制肉馅饼，充满了爱意。"

/obj/item/reagent_container/food/snacks/mre_food/clf/meatpie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("meatprotein", 20)
	reagents.add_reagent("sodiumchloride", 4)

/obj/item/reagent_container/food/snacks/mre_food/clf/bananapie
	name = "包装好的香蕉派"
	icon_state = "clf_pie"
	desc = "一个包装好的自制香蕉派，香甜绵密，出自某个有幽默感的人之手。"

/obj/item/reagent_container/food/snacks/mre_food/clf/bananapie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("banana", 16)
	reagents.add_reagent("cream", 5)
	reagents.add_reagent("sugar", 4)

/obj/item/reagent_container/food/snacks/mre_food/clf/cheesepizza
	name = "包装好的奶酪披萨"
	icon_state = "clf_cheesepizza"
	desc = "一份小份包装披萨，上面有多种不同的奶酪。"

/obj/item/reagent_container/food/snacks/mre_food/clf/cheesepizza/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("cheese", 16)
	reagents.add_reagent("sodiumchloride", 4)

/obj/item/reagent_container/food/snacks/mre_food/clf/mushroompizza
	name = "包装蘑菇披萨"
	icon_state = "clf_mushroompizza"
	desc = "一份小份包装披萨，由奶油酱汁和一些蘑菇片制成。"

/obj/item/reagent_container/food/snacks/mre_food/clf/mushroompizza/Initialize()
	. = ..()
	reagents.add_reagent("bread", 8)
	reagents.add_reagent("mushroom", 14)
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("sodiumchloride", 4)

/obj/item/reagent_container/food/snacks/mre_food/clf/vegetablepizza
	name = "包装蔬菜披萨"
	icon_state = "clf_vegetablepizza"
	desc = "一份小份包装披萨，素食友好，不过上面也有些奶酪。"

/obj/item/reagent_container/food/snacks/mre_food/clf/vegetablepizza/Initialize()
	. = ..()
	reagents.add_reagent("bread", 8)
	reagents.add_reagent("vegetable", 14)
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("tomatojuice", 6)
	reagents.add_reagent("sodiumchloride", 4)

/obj/item/reagent_container/food/snacks/mre_food/clf/meatpizza
	name = "包装肉食披萨"
	icon_state = "clf_meatpizza"
	desc = "一份小份包装披萨，上面有几片牛肉和培根。"

/obj/item/reagent_container/food/snacks/mre_food/clf/meatpizza/Initialize()
	. = ..()
	reagents.add_reagent("bread", 8)
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("tomatojuice", 6)
	reagents.add_reagent("sodiumchloride", 4)
