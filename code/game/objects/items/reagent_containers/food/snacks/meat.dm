/obj/item/reagent_container/food/snacks/meat
	name = "meat"
	desc = "一块肉排。"
	icon_state = "meat"
	icon = 'icons/obj/items/food/meat.dmi'
	health = 180
	filling_color = "#FF1C1C"
	bitesize = 3
	var/cutlet_type = /obj/item/reagent_container/food/snacks/rawcutlet

/obj/item/reagent_container/food/snacks/meat/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 3)
	name = made_from_player + name

/obj/item/reagent_container/food/snacks/meat/attackby(obj/item/W as obj, mob/user as mob)
	if(W.sharp == IS_SHARP_ITEM_ACCURATE || W.sharp == IS_SHARP_ITEM_BIG)
		var/turf/T = get_turf(src)
		var/cutlet_amt = roll(1,4)
		for(var/i in 1 to cutlet_amt)
			new cutlet_type(T)
		to_chat(user, "你将肉切成片。")
		playsound(loc, 'sound/effects/blobattack.ogg', 25, 1)
		qdel(src)
	else
		..()

/obj/item/reagent_container/food/snacks/meat/synthmeat
	name = "合成肉"
	desc = "一块合成的肉排。"

/// Meat made from synthetics. Slightly toxic
/obj/item/reagent_container/food/snacks/meat/synthmeat/synthflesh
	name = "合成肉"
	desc = "一块人造的、无机的‘肉’，类似人肉。可能来自合成人。"
	icon_state = "synthmeat"
	filling_color = "#ffffff"

/obj/item/reagent_container/food/snacks/meat/synthmeat/synthetic/Initialize()
	. = ..()
	reagents.add_reagent("pacid", 1.5)

/obj/item/reagent_container/food/snacks/meat/human
	name = "人肉"
	desc = "一块给食人族准备的肉。"

/obj/item/reagent_container/food/snacks/meat/monkey
	//same as plain meat

/obj/item/reagent_container/food/snacks/meat/corgi
	name = "柯基肉"
	desc = "尝起来...嗯，你知道的..."

/obj/item/reagent_container/food/snacks/meat/xenomeat
	name = "meat"
	desc = "一块气味刺鼻的肉。"
	icon_state = "xenomeat"
	filling_color = "#43DE18"

/obj/item/reagent_container/food/snacks/meat/xenomeat/Initialize()
	. = ..()
	reagents.add_reagent("xenoblood", 6)
	src.bitesize = 6

/obj/item/reagent_container/food/snacks/meat/xenomeat/processed
	desc = "一块气味刺鼻的肉。这块已经过处理，去除了酸液。"

/obj/item/reagent_container/food/snacks/meat/xenomeat/processed/Initialize()
	. = ..()
	reagents.remove_reagent("xenoblood", 6)

//fishable atoms meat
// todo: rewrite this into a procgen'ed item when gutting fish? May be incompatible with recipe code if done that way and not hardcoded.
/obj/item/reagent_container/food/snacks/meat/fish
	name = "鱼肉"
	desc = "来自鱼的肉。"
	icon_state = "fishfillet"
	icon = 'icons/obj/items/food/fish.dmi'

/obj/item/reagent_container/food/snacks/meat/fish/crab
	name = "蟹肉"
	desc = "美味的蟹肉。"
	icon_state = "crab_meat"

/obj/item/reagent_container/food/snacks/meat/fish/crab/shelled
	name = "蟹肉"
	desc = "美味的蟹肉，还连着些许蟹壳。"
	icon_state = "crab_meat_2"

/obj/item/reagent_container/food/snacks/meat/fish/squid
	name = "鱿鱼肉"
	desc = "嗯，炸鱿鱼圈。"
	icon_state = "squid_meat"


/obj/item/reagent_container/food/snacks/meat/fish/squid/alt
	name = "袜状鱿鱼肉"
	desc = "来自鱿鱼或类似生物的粉红色软肉。你又不是海洋生物学家。"
	icon_state = "squid_meat_2"

/obj/item/reagent_container/food/snacks/meat/fish/bass
	name = "鲈鱼肉"
	desc = "大块的烹饪用鱼肉！"
	icon_state = "bass_meat"

/obj/item/reagent_container/food/snacks/meat/fish/bluegill
	name = "蓝鳃太阳鱼肉"
	desc = "适合煎炸的小肉条！"
	icon_state = "bluegill_meat"

/obj/item/reagent_container/food/snacks/meat/fish/salmon

	name = "三文鱼肉"
	desc = "被认为是鱼肉的‘高级’部位！"
	icon_state = "salmon_meat"

/obj/item/reagent_container/food/snacks/meat/fish/white_perch

	name = "白鲈鱼肉"
	desc = "入侵鱼类的肉，油腻腻的.."
	icon_state = "white_perch_meat"
