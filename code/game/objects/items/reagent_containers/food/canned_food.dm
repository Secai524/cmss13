/obj/item/reagent_container/food/drinks/cans/food
	name = "罐头食品"
	desc = "一个食品罐头。"
	icon_state = ""
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/canned_food_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/canned_food_righthand.dmi'
	)
	needs_can_opener = TRUE
	crushable = FALSE
	open_sound = 'sound/items/can_opened.ogg'
	open_message = "You open the can with a metal clank!"
	consume_sound = 'sound/items/eatfood.ogg'
	object_fluff = "can"
	has_open_icon = TRUE
	delete_on_empty = TRUE

/obj/item/reagent_container/food/drinks/cans/food/upp
	icon = 'icons/obj/items/food/mre_food/upp.dmi'

/obj/item/reagent_container/food/drinks/cans/food/upp/meat
	name = "牛肉罐头"
	desc = "罐装优质100%牛肉。至于具体是牛的哪个部位，有待商榷。"
	icon_state = "Canned_meat"
	volume = 20

/obj/item/reagent_container/food/drinks/cans/food/upp/meat/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/food/upp/stew
	name = "炖菜罐头"
	desc = "罐装炖菜，内含胡萝卜、番茄、蘑菇、肉、豆子以及天知道还有什么，加热后是一顿美餐。"
	icon_state = "Canned_stew"
	volume = 30

/obj/item/reagent_container/food/drinks/cans/food/upp/stew/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 6)
	reagents.add_reagent("meatprotein", 6)
	reagents.add_reagent("mushroom", 3)
	reagents.add_reagent("tomatojuice", 5)
	reagents.add_reagent("water", 5)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/food/upp/speck
	name = "腌猪油罐头"
	desc = "罐装腌制熟猪油，亦称烟熏肥肉。常涂抹于面包上，或直接食用。"
	icon_state = "Canned_speck"
	food_interactable = TRUE
	volume = 20

/obj/item/reagent_container/food/drinks/cans/food/upp/speck/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("sodiumchloride", 5)

/obj/item/reagent_container/food/drinks/cans/food/upp/soup
	name = "汤罐头"
	desc = "罐装汤，内含牛肉高汤、土豆、豌豆以及天知道还有什么，加热后是一顿美餐。"
	icon_state = "Canned_stew"
	consume_sound = 'sound/items/drink.ogg'
	volume = 25

/obj/item/reagent_container/food/drinks/cans/food/upp/soup/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 6)
	reagents.add_reagent("meatprotein", 2)
	reagents.add_reagent("potato", 6)
	reagents.add_reagent("water", 5)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/food/upp/rice
	name = "米饭牛肉罐头"
	desc = "罐装米饭配牛肉粒。"
	icon_state = "Canned_rice"
	needs_can_opener = FALSE
	volume = 10

/obj/item/reagent_container/food/drinks/cans/food/upp/rice/Initialize()
	. = ..()
	reagents.add_reagent("rice", 6)
	reagents.add_reagent("meatprotein", 2)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/food/upp/buckwheat
	name = "荞麦猪肉罐头"
	desc = "罐装荞麦粥配猪肉粒。俗话说得好，吃荞麦，身体壮！"
	icon_state = "Canned_buckwheat"
	needs_can_opener = FALSE
	volume = 10

/obj/item/reagent_container/food/drinks/cans/food/upp/buckwheat/Initialize()
	. = ..()
	reagents.add_reagent("buckwheat", 6)
	reagents.add_reagent("meatprotein", 2)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/food/upp/pasta
	name = "海军意面罐头"
	desc = "这道菜起源于一艘起义的俄罗斯无畏舰，本身是意面配肉末。"
	icon_state = "Canned_pasta"
	needs_can_opener = FALSE
	volume = 10

/obj/item/reagent_container/food/drinks/cans/food/upp/pasta/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 6)
	reagents.add_reagent("meatprotein", 2)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/food/upp/vegetables
	name = "蔬菜罐头"
	desc = "混合了玉米、茄子、番茄、大蒜、洋葱，可能还有其他东西的熟食拼盘。"
	icon_state = "Canned_vegetables"
	needs_can_opener = FALSE
	volume = 10

/obj/item/reagent_container/food/drinks/cans/food/upp/vegetables/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 6)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/food/upp/condensed_milk
	name = "炼乳罐头"
	desc = "加糖保存的罐装牛奶，可直接食用、加入饮品或用作配料。"
	icon_state = "Canned_condensed_milk"
	food_interactable = TRUE
	volume = 30

/obj/item/reagent_container/food/drinks/cans/food/upp/condensed_milk/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 15)
	reagents.add_reagent("milk", 15)

/obj/item/reagent_container/food/drinks/cans/food/upp/condensed_boiled_milk
	name = "焦糖炼乳罐头"
	desc = "加糖保存的罐装焦糖炼乳，可直接食用、加入饮品或用作配料。"
	icon_state = "Canned_boiled_condensed_milk"
	food_interactable = TRUE
	volume = 30

/obj/item/reagent_container/food/drinks/cans/food/upp/condensed_boiled_milk/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 20)
	reagents.add_reagent("milk", 10)
