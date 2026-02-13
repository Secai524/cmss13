//TWE

/obj/item/mre_food_packet/twe
	icon = 'icons/obj/items/food/mre_food/twe.dmi'
	icon_state = null

/obj/item/reagent_container/food/snacks/mre_food/twe
	icon = 'icons/obj/items/food/mre_food/twe.dmi'

///ENTREE

/obj/item/mre_food_packet/entree/twe
	name = "\improper ORP main dish"
	desc = "一份作战口粮包主菜组件。包含一道基于TWE美食精心烹制的豪华主菜，采用高科技方法保存。"
	icon = 'icons/obj/items/food/mre_food/twe.dmi'
	icon_state = "twe_entree"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/twe/entree/bacon,
		/obj/item/reagent_container/food/snacks/mre_food/twe/entree/tomatobeans,
		/obj/item/reagent_container/food/snacks/mre_food/twe/entree/fishnrice,
		/obj/item/reagent_container/food/snacks/mre_food/twe/entree/ricenoodles,
		/obj/item/reagent_container/food/snacks/mre_food/twe/entree/fishnchips,
	)

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/bacon
	name = "bacon"
	icon_state = "bacon"
	desc = "英式早餐的又一经典部分，培根煎得酥脆，与吐司搭配极佳。"

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/bacon/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/tomatobeans
	name = "番茄焗豆"
	icon_state = "番茄焗豆"
	desc = "英式早餐的经典部分，番茄酱焗豆，与吐司搭配极佳。"

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/tomatobeans/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 14)
	reagents.add_reagent("tomatojuice", 8)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/fishnrice
	name = "鱼配米饭"
	icon_state = "鱼配米饭"
	desc = "一道诞生于日本的菜肴，最初由在帝国亚洲地区缺乏土豆的联邦水手发明，他们发现可以用米饭代替。"

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/fishnrice/Initialize()
	. = ..()
	reagents.add_reagent("fish", 6)
	reagents.add_reagent("rice", 6)
	reagents.add_reagent("cornoil", 2)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/ricenoodles
	name = "米线拉面"
	icon_state = "rice noodles"
	desc = "一份日式米线拉面，加入了足量的辣酱，并带有微量的胡萝卜和青葱。"

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/ricenoodles/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 6)
	reagents.add_reagent("rice", 6)
	reagents.add_reagent("vegetable", 2)
	reagents.add_reagent("capsaicin", 4)
	reagents.add_reagent("hotsauce", 4)

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/fishnchips
	name = "炸鱼薯条"
	icon_state = "炸鱼薯条"
	desc = "一道英国经典，裹上面包屑油炸的鱼条，口感酥脆，吃完后手上全是油。"

/obj/item/reagent_container/food/snacks/mre_food/twe/entree/fishnchips/Initialize()
	. = ..()
	reagents.add_reagent("fish", 5)
	reagents.add_reagent("vegetable", 5)
	reagents.add_reagent("potato", 3)
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("cornoil", 2)
	reagents.add_reagent("sodiumchloride", 2)

///SIDE

/obj/item/mre_food_packet/twe/side
	name = "\improper ORP side dish"
	desc = "一份作战口粮包配菜组件。包含一份配菜，与主菜一同食用。"
	icon_state = "twe_side"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/nutpatty,
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/nigirisushi,
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/nutpatty,
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/tomatochips,
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/bean_stew,
		/obj/item/reagent_container/food/snacks/mre_food/twe/side/mushroom_soup,
	)

/obj/item/reagent_container/food/snacks/mre_food/twe/side/nutpatty
	name = "鹰嘴豆饼"
	icon_state = "nut patty"
	desc = "鹰嘴豆制成的素食肉饼，裹上面包屑油炸，不知为何让你想起了炸鱼条。"

/obj/item/reagent_container/food/snacks/mre_food/twe/side/nutpatty/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 2)
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("plantmatter", 2)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/twe/side/mushroom_soup
	name = "蘑菇汤"
	icon_state = "mushroom_soup"
	desc = "营养丰富的蔬菜汤，带有蘑菇风味，加热后能让你长时间保持温暖。"

/obj/item/reagent_container/food/snacks/mre_food/twe/side/mushroom_soup/Initialize()
	. = ..()
	reagents.add_reagent("mushroom", 3)
	reagents.add_reagent("vegetable", 3)
	reagents.add_reagent("water", 5)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/twe/side/bean_stew
	name = "炖豆子"
	icon_state = "bean_soup"
	desc = "营养丰富的番茄酱炖豆子，加热后能让你长时间保持温暖。"

/obj/item/reagent_container/food/snacks/mre_food/twe/side/bean_stew/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 6)
	reagents.add_reagent("water", 2)
	reagents.add_reagent("tomatojuice", 4)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/twe/side/nigirisushi
	name = "握寿司"
	icon_state = "握寿司"
	desc = "一片三文鱼置于饭团之上，以海苔条包裹，入口即化。"

/obj/item/reagent_container/food/snacks/mre_food/twe/side/nigirisushi/Initialize()
	. = ..()
	reagents.add_reagent("fish", 3)
	reagents.add_reagent("rice", 2)
	reagents.add_reagent("plantmatter", 1)
	reagents.add_reagent("soysauce", 1)

/obj/item/reagent_container/food/snacks/mre_food/twe/side/tomatochips
	name = "番茄薯片"
	icon_state = "番茄薯片"
	desc = "非常酥脆，带有一丝罗勒香气，与啤酒是绝配。"

/obj/item/reagent_container/food/snacks/mre_food/twe/side/tomatochips/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 6)
	reagents.add_reagent("tomatojuice", 4)
	reagents.add_reagent("blackpepper", 2)
	reagents.add_reagent("sodiumchloride", 2)

///SNACK

/obj/item/mre_food_packet/twe/snack
	name = "\improper ORP snack"
	desc = "作战口粮包的零食组件。内含一份轻食，以备你不太饿时食用。"
	icon_state = "twe_snack"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/twe/snack/cheese,
		/obj/item/reagent_container/food/snacks/mre_food/twe/snack/almond,
	)

/obj/item/reagent_container/food/snacks/mre_food/twe/snack/almond
	name = "almonds"
	icon_state = "almond"
	desc = "烤箱烘干的杏仁，富含维生素，风味浓郁，口感酥脆，是你一直渴望的奢侈享受。"

/obj/item/reagent_container/food/snacks/mre_food/twe/snack/almond/Initialize()
	. = ..()
	reagents.add_reagent("nuts", 4)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/twe/snack/cheese
	name = "脱水奶酪块"
	icon_state = "cheese"
	desc = "冻干切达奶酪块，非常干燥但风味浓缩，是很好的零食。"

/obj/item/reagent_container/food/snacks/mre_food/twe/snack/cheese/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("sodiumchloride", 1)

///DESSERT

/obj/item/mre_food_packet/twe/dessert
	name = "\improper ORP dessert"
	desc = "作战口粮包的配餐组件。内含一份甜点，应在主餐后食用（或者，如果你够叛逆，也可以在主餐前吃）。"
	icon_state = "twe_dessert"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/chocobar,
		/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinyapplepie,
		/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinycheesecake,
		/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinypancakes,
	)

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/chocobar
	name = "黑巧克力棒"
	icon_state = "tiny chocolate bar"
	desc = "56%可可含量的纯黑巧克力，风味浓郁，经典款式，与热饮搭配绝佳。"

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/chocobar/Initialize()
	. = ..()
	reagents.add_reagent("coco", 8)
	reagents.add_reagent("sugar", 2)

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinyapplepie
	name = "迷你苹果派"
	icon_state = "迷你苹果派"
	desc = "内含多汁的苹果片，带有肉桂风味。"

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinyapplepie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("fruit", 2)
	reagents.add_reagent("sugar", 1)

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinycheesecake
	name = "迷你芝士蛋糕"
	icon_state = "迷你芝士蛋糕"
	desc = "口感轻盈、甜度适中的芝士蛋糕，配有美味的香草蛋糕底。"

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinycheesecake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("milk", 2)

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinypancakes
	name = "迷你煎饼"
	icon_state = "迷你煎饼"
	desc = "黄油纸杯蛋糕，顶部淋有蜂蜜。"

/obj/item/reagent_container/food/snacks/mre_food/twe/dessert/tinypancakes/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("honey", 2)
	reagents.add_reagent("sugar", 1)

///PASTE TUBE

/obj/item/reagent_container/food/drinks/cans/tube
	name = "营养膏管"
	icon = 'icons/obj/items/food/mre_food/twe.dmi'
	icon_state = "paste1"
	desc = "太空食品。"
	open_sound = 'sound/effects/pillbottle.ogg'
	open_message = "You remove cap from the tube."
	volume = 15
	food_interactable = TRUE
	possible_transfer_amounts = list(1, 2, 3, 5)
	crushable = FALSE
	gulp_size = 5
	object_fluff = "tube"
	var/flavor = "paste_vegemite"

/obj/item/reagent_container/food/drinks/cans/tube/attack_self(mob/user)
	. = ..()
	update_icon()

/obj/item/reagent_container/food/drinks/cans/tube/Initialize()
	. = ..()
	update_icon()

/obj/item/reagent_container/food/drinks/cans/tube/on_reagent_change()
	. = ..()
	update_icon()

/obj/item/reagent_container/food/drinks/cans/tube/update_icon()
	overlays.Cut()
	if(open && reagents.total_volume)
		overlays += mutable_appearance(icon, flavor)

	if(!open)
		overlays += mutable_appearance(icon, "paste_cap")

	var/percent = floor((reagents.total_volume / volume) * 100)
	if(reagents && reagents.total_volume)
		switch(percent)
			if(1 to 32)
				icon_state = "paste3"
			if(33 to 65)
				icon_state = "paste2"
			if(66 to INFINITY)
				icon_state = "paste1"
	else
		icon_state = "paste3"

/obj/item/reagent_container/food/drinks/cans/tube/vegemite
	name = "作战口粮包涂抹酱管（维吉麦酱）"
	desc = "内含一种非常咸的食物酱，适合搭配三明治，但并非所有人都喜欢它的味道和外观。"

/obj/item/reagent_container/food/drinks/cans/tube/vegemite/Initialize()
	. = ..()
	reagents.add_reagent("vegemite", 20)

/obj/item/reagent_container/food/drinks/cans/tube/strawberry
	name = "ORP酱料管（草莓味）"
	desc = "内含草莓食物酱，适合搭配三明治。"
	flavor = "paste_strawberry"

/obj/item/reagent_container/food/drinks/cans/tube/strawberry/Initialize()
	. = ..()
	reagents.add_reagent("berryjuice", 15)
	reagents.add_reagent("sugar", 5)

/obj/item/reagent_container/food/drinks/cans/tube/blackberry
	name = "ORP酱料管（黑莓味）"
	desc = "内含黑莓食物酱，适合搭配三明治。"
	flavor = "paste_blackberry"

/obj/item/reagent_container/food/drinks/cans/tube/blackberry/Initialize()
	. = ..()
	reagents.add_reagent("berryjuice", 15)
	reagents.add_reagent("sugar", 5)

///LEMON DROP CANDY

/obj/item/reagent_container/food/snacks/lemondrop
	name = "柠檬滴糖"
	desc = "一种糖衣柠檬味酸甜硬糖，在TWE地区很受欢迎，糖果本身起源于英格兰。"
	icon_state = "lemondrop"
	icon = 'icons/obj/items/food/mre_food/twe.dmi'
	filling_color = "#e3f218"

/obj/item/reagent_container/food/snacks/lemondrop/Initialize()
	. = ..()
	reagents.add_reagent("lemonjuice", 3)
	reagents.add_reagent("sugar", 1)
