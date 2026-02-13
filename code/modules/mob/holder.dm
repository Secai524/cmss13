//Helper object for picking dionaea (and other creatures) up.
/obj/item/holder
	name = "holder"
	desc = "你不应该看到这个。"
	icon = 'icons/mob/animal.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/critters.dmi',
		WEAR_L_EAR = 'icons/mob/humans/onmob/clothing/critters_shoulder.dmi',
		WEAR_R_EAR = 'icons/mob/humans/onmob/clothing/critters_shoulder.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/critters_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/critters_righthand.dmi'
	)
	flags_equip_slot = SLOT_HEAD

/obj/item/holder/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/holder/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/holder/process()

	if(istype(loc,/turf) || !(length(contents)))

		for(var/mob/M in contents)

			var/atom/movable/mob_container
			mob_container = M
			mob_container.forceMove(get_turf(src))
			M.reset_view()

		qdel(src)

/obj/item/holder/attackby(obj/item/W as obj, mob/user as mob)
	for(var/mob/M in src.contents)
		M.attackby(W,user)

/obj/item/holder/proc/show_message(message, m_type)
	for(var/mob/living/M in contents)
		M.show_message(message,m_type)

/obj/item/holder/get_examine_text(mob/user)
	. = list()
	. += "[icon2html(src, user)] That's \a [src]."
	if(desc)
		. += desc
	if(desc_lore)
		. += SPAN_NOTICE("This has an <a href='byond://?src=\ref[src];desc_lore=1'>extended lore description</a>.")


//Mob procs and vars for scooping up
/mob/living/var/holder_type

/mob/living/proc/get_scooped(mob/living/carbon/grabber)
	if(!holder_type)
		return
	if(isxeno(grabber))
		to_chat(grabber, SPAN_WARNING("你放过了[src]。它无法成为宿主，所以没有利用价值。"))
		return
	if(locate(/obj/item/explosive/plastic) in contents)
		to_chat(grabber, SPAN_WARNING("你放过了[src]。它上面有未引爆的炸药！"))
		return

	var/obj/item/holder/mob_holder = new holder_type(loc)
	forceMove(mob_holder)
	mob_holder.name = name
	mob_holder.desc = desc
	mob_holder.gender = gender
	mob_holder.attack_hand(grabber)

	to_chat(grabber, "你抱起了[src]。")
	to_chat(src, "[grabber]把你抱了起来。")
	grabber.status_flags |= PASSEMOTES
	return

//Mob specific holders.

/obj/item/holder/cat
	name = "cat"
	desc = "一只家养宠物猫。有收养船员的倾向。"
	icon_state = "cat2_rest"
	item_state = "cat2"
	item_state_slots = list(WEAR_HEAD = "cat2")

/obj/item/holder/cat/kitten
	name = "kitten"
	desc = "好可爱啊。"
	icon_state = "kitten_rest"

/obj/item/holder/cat/Jones
	name = "\improper Jones"
	desc = "一只来历不明的、坚韧的老流浪猫。"

/obj/item/holder/cat/blackcat
	name = "黑猫"
	desc = "一只猫，现在是黑色的！"
	icon_state = "cat_rest"
	item_state = "cat"
	item_state_slots = list(WEAR_HEAD = "cat")

/obj/item/holder/cat/blackcat/Runtime
	name = "\improper Runtime"
	desc = "它的毛皮看起来和摸起来都像天鹅绒，尾巴偶尔会颤抖。"

/obj/item/holder/mouse
	name = "mouse"
	desc = "这是一只小老鼠。"
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_white"
	w_class = SIZE_TINY
	flags_equip_slot = SLOT_HEAD|SLOT_EAR

/obj/item/holder/mouse/white
	icon_state = "mouse_white"

/obj/item/holder/mouse/gray
	icon_state = "mouse_gray"

/obj/item/holder/mouse/brown
	icon_state = "mouse_brown"

/obj/item/holder/mouse/white/Doc
	name = "博士"
	desc = "阿尔迈耶号的高级研究员。喜欢：奶酪、实验、爆炸。"

/obj/item/holder/mouse/brown/Tom
	name = "汤姆"
	desc = "猫杰瑞对此并不觉得有趣。"

/obj/item/holder/corgi
	name = "corgi"
	desc = "这是一只柯基犬。"
	icon_state = "corgi"

/obj/item/holder/corgi/Ian
	name = "伊恩"

/obj/item/holder/corgi/Lisa
	name = "伊恩"
	icon_state = "lisa"

/obj/item/holder/corgi/puppy
	name = "puppy"
	icon_state = "puppy"
	item_state_slots = list(WEAR_HEAD = "puppy")

// Rat

/obj/item/holder/rat
	name = "rat"
	desc = "这是一只大老鼠。"
	icon = 'icons/mob/animal.dmi'
	icon_state = "rat_gray"
	w_class = SIZE_TINY
	flags_equip_slot = SLOT_EAR

/obj/item/holder/rat/white
	icon_state = "rat_white"

/obj/item/holder/rat/gray
	icon_state = "rat_gray"

/obj/item/holder/rat/brown
	icon_state = "rat_brown"

/obj/item/holder/rat/black
	icon_state = "rat_black"


/obj/item/holder/rat/white/Milky
	name = "米尔基"
	desc = "一只从维兰德-汤谷研究设施逃出的实验鼠。希望它没有携带什么基因工程疾病之类的……"

/obj/item/holder/rat/brown/Old_Timmy
	name = "老提米"
	desc = "一只从殖民地旧时代遗留下来的、看起来年迈的老鼠。"

/obj/item/holder/rat/pet
	name = "宠物鼠"
	desc = "这是某人的宠物鼠。我想知道它为什么会在这里。"

/obj/item/holder/rat/pet/marvin
	name = "马文"
	desc = "一只光滑、保养良好的老鼠，脖子上戴着一个小项圈，它一定有主人。作为啮齿动物，它看起来异常干净卫生。"
	icon_state = "rat_black"

/obj/item/holder/rat/pet/ikit
	name = "伊基特"
	desc = "一只白化病老鼠，脖子上戴着一个小项圈，它一定有主人。希望它没有携带什么基因工程疾病之类的……"
	icon_state = "rat_white"
