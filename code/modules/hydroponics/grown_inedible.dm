// **********************
// Other harvested materials from plants (that are not food)
// **********************

/obj/item/grown // Grown things that are not edible
	name = "grown_weapon"
	icon = 'icons/obj/items/harvest.dmi'
	var/plantname
	var/potency = 1

/obj/item/grown/Initialize()
	. = ..()

	create_reagents(50)

	// Fill the object up with the appropriate reagents.
	if(!isnull(plantname))
		var/datum/seed/S = GLOB.seed_types[plantname]
		if(!S || !S.chems)
			return

		potency = S.potency

		for(var/rid in S.chems)
			var/list/reagent_data = S.chems[rid]
			var/rtotal = reagent_data[1]
			if(length(reagent_data) > 1 && potency > 0)
				rtotal += floor(potency/reagent_data[2])
			reagents.add_reagent(rid,max(1,rtotal))

/obj/item/grown/log
	name = "towercap"
	name = "塔冠原木"
	desc = "它比糟糕要好，它是好的！"
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "logs"
	force = 5
	flags_atom = NO_FLAGS
	throwforce = 5
	w_class = SIZE_MEDIUM
	throw_speed = SPEED_VERY_FAST
	throw_range = 3

	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")

/obj/item/grown/log/attackby(obj/item/W as obj, mob/user as mob)
	if(W.sharp == IS_SHARP_ITEM_BIG)
		user.show_message(SPAN_NOTICE("你用\the [src]制作了木板！"), SHOW_MESSAGE_VISIBLE)
		for(var/i=0,i<2,i++)
			var/obj/item/stack/sheet/wood/NG = new (user.loc)
			for (var/obj/item/stack/sheet/wood/G in user.loc)
				if(G==NG)
					continue
				if(G.amount>=G.max_amount)
					continue
				G.attackby(NG, user)
				to_chat(usr, "你将新成型的木材添加到木堆中。现在共有[NG.amount]块木板。")
		qdel(src)
		return

/obj/item/grown/sunflower // FLOWER POWER!
	plantname = "sunflowers"
	name = "sunflower"
	desc = "真漂亮！要是你踩坏了这些，某个家伙可能会把你打死。"
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "sunflower"
	damtype = "fire"
	force = 0
	flags_atom = NO_FLAGS
	throwforce = 1
	w_class = SIZE_TINY
	throw_speed = SPEED_FAST
	throw_range = 3

/obj/item/grown/sunflower/attack(mob/M as mob, mob/user as mob)
	to_chat(M, "<font color='green'><b> [user]用向日葵打了你！</font><font color='yellow'><b>鲜花之力<b></font>")
	to_chat(user, "<font color='green'> 你的向日葵的</font><font color='yellow'><b>鲜花之力</b></font><font color='green'>击中了[M]</font>")

/obj/item/corncob
	name = "玉米芯"
	desc = "昔日餐食的纪念品。"
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "corncob"
	item_state = "corncob"
	w_class = SIZE_SMALL
	throwforce = 0
	throw_speed = SPEED_VERY_FAST
	throw_range = 20

/obj/item/corncob/attackby(obj/item/W as obj, mob/user as mob)
	if(W.sharp == IS_SHARP_ITEM_ACCURATE)
		to_chat(user, SPAN_NOTICE("你用[W]将玉米芯加工成了一支烟斗！"))
		new /obj/item/clothing/mask/cigarette/pipe/cobpipe (user.loc)
		qdel(src)
	else
		return ..()
