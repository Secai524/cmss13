/mob/living/simple_animal/small/spiderbot

	min_oxy = 0
	max_tox = 0
	max_co2 = 0
	minbodytemp = 0
	maxbodytemp = 500

	var/mob/living/silicon/ai/connected_ai = null
	var/obj/item/cell/cell = null
	var/obj/structure/machinery/camera/camera = null
	var/obj/item/device/mmi/mmi = null
	var/list/req_access = list(ACCESS_MARINE_RESEARCH) //Access needed to pop out the brain.

	name = "蜘蛛机器人"
	desc = "一个疾行的机械朋友！"
	icon = 'icons/mob/robots.dmi'
	icon_state = "spiderbot-chassis"
	icon_living = "spiderbot-chassis"
	icon_dead = "spiderbot-smashed"
	universal_speak = 1 //Temp until these are rewritten.

	wander = 0

	health = 10
	maxHealth = 10

	attacktext = "shocks"
	attacktext = "shocks"
	melee_damage_lower = 1
	melee_damage_upper = 3

	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"

	var/obj/item/held_item = null //Storage for single item they can hold.
	speed = -1 //Spiderbots gotta go fast.
	mob_size = MOB_SIZE_SMALL
	speak_emote = list("beeps","clicks","chirps")

/mob/living/simple_animal/small/spiderbot/attackby(obj/item/O as obj, mob/user as mob)

	if(istype(O, /obj/item/device/mmi))
		var/obj/item/device/mmi/B = O
		if(src.mmi) //There's already a brain in it.
			to_chat(user, SPAN_DANGER("[src]里已经有一个大脑了！"))
			return
		if(!B.brainmob)
			to_chat(user, SPAN_DANGER("把一个空的MMI塞进框架里没什么意义。"))
			return
		if(!B.brainmob.key)
			var/ghost_can_reenter = 0
			if(B.brainmob.mind)
				for(var/mob/dead/observer/G in GLOB.observer_list)
					if(G.can_reenter_corpse && G.mind == B.brainmob.mind)
						ghost_can_reenter = 1
						break
			if(!ghost_can_reenter)
				to_chat(user, SPAN_NOTICE("[O]完全没有反应；这么做没有意义。"))
				return

		if(B.brainmob.stat == DEAD)
			to_chat(user, SPAN_DANGER("[O]已经死了。把它塞进框架里没什么意义。"))
			return

		if(jobban_isbanned(B.brainmob, "Cyborg"))
			to_chat(user, SPAN_DANGER("[O]似乎不合适。"))
			return



		user.drop_inv_item_to_loc(O, src)
		to_chat(user, SPAN_NOTICE("你将[O]安装进了[src]！"))
		mmi = O
		transfer_personality(O)
		update_icon()
		return 1

	if (iswelder(O))
		if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
			return
		var/obj/item/tool/weldingtool/WT = O
		if (WT.remove_fuel(0))
			if(health < maxHealth)
				health += pick(1,1,1,2,2,3)
				if(health > maxHealth)
					health = maxHealth
				add_fingerprint(user)
				for(var/mob/W in viewers(user, null))
					W.show_message(text(SPAN_DANGER("[user] has spot-welded some of the damage to [src]!")), SHOW_MESSAGE_VISIBLE)
			else
				to_chat(user, SPAN_NOTICE("[src]完好无损！"))
		else
			to_chat(user, "需要更多焊枪燃料！")
			return
	else if(istype(O, /obj/item/card/id))
		if (!mmi)
			to_chat(user, SPAN_DANGER("没有理由刷卡——蜘蛛机器人没有大脑可以取出。"))
			return 0

		var/obj/item/card/id/id_card

		if(istype(O, /obj/item/card/id))
			id_card = O

		if(ACCESS_MARINE_RESEARCH in id_card.access)
			to_chat(user, SPAN_NOTICE("你刷了一下你的权限卡，将大脑从[src]中弹出。"))
			eject_brain()

			if(held_item)
				held_item.forceMove(src.loc)
				held_item = null

			return 1
		else
			to_chat(user, SPAN_DANGER("你刷了卡，但没有任何效果。"))
			return 0
	else
		if(O.force)
			var/damage = O.force
			if (O.damtype == HALLOSS)
				damage = 0
			apply_damage(damage, BRUTE)
			for(var/mob/M as anything in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M.show_message(SPAN_DANGER("[src]被[user]用\the [O]攻击了。"), SHOW_MESSAGE_VISIBLE)
		else
			to_chat(usr, SPAN_DANGER("这件武器无效，无法造成伤害。"))
			for(var/mob/M as anything in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M.show_message(SPAN_DANGER("[user]用\the [O]轻轻拍了拍[src]。"), SHOW_MESSAGE_VISIBLE)

/mob/living/simple_animal/small/spiderbot/proc/transfer_personality(obj/item/device/mmi/M as obj)
	src.mind = M.brainmob.mind
	src.mind.key = M.brainmob.key
	src.ckey = M.brainmob.ckey
	if(client)
		client.change_view(GLOB.world_view_size)
	src.name = "Spider-bot ([M.brainmob.name])"

/mob/living/simple_animal/small/spiderbot/proc/explode(cause = "exploding") //When emagged.
	for(var/mob/M as anything in viewers(src, null))
		if ((M.client && !( M.blinded )))
			M.show_message(SPAN_DANGER("[src]发出奇怪的颤音，嘶嘶作响，然后爆炸了。"), SHOW_MESSAGE_VISIBLE)
	explosion(get_turf(loc), -1, -1, 3, 5)
	eject_brain()
	death(cause)

/mob/living/simple_animal/small/spiderbot/proc/update_icon()
	if(mmi)
		if(istype(mmi,/obj/item/device/mmi))
			icon_state = "spiderbot-chassis-mmi"
			icon_living = "spiderbot-chassis-mmi"
	else
		icon_state = "spiderbot-chassis"
		icon_living = "spiderbot-chassis"

/mob/living/simple_animal/small/spiderbot/proc/eject_brain()
	if(mmi)
		var/turf/T = get_turf(loc)
		if(T)
			mmi.forceMove(T)
		if(mind)
			mind.transfer_to(mmi.brainmob)
		mmi = null
		src.name = "蜘蛛机器人"
		update_icon()

/mob/living/simple_animal/small/spiderbot/Destroy()
	eject_brain()
	. = ..()

/mob/living/simple_animal/small/spiderbot/New()

	camera = new /obj/structure/machinery/camera(src)
	camera.c_tag = "Spiderbot-[real_name]"
	camera.network = list("SS13")

	..()

/mob/living/simple_animal/small/spiderbot/death()

	GLOB.alive_mob_list -= src
	GLOB.dead_mob_list += src

	if(camera)
		camera.status = 0

	held_item.forceMove(src.loc)
	held_item = null

	robogibs(src.loc, viruses)
	qdel(src)

//Cannibalized from the parrot mob. ~Zuhayr
/mob/living/simple_animal/small/spiderbot/verb/drop_spider_held_item()
	set name = "Drop held item"
	set category = "Spiderbot"
	set desc = "Drop the item you're holding."

	if(stat)
		return

	if(!held_item)
		to_chat(usr, SPAN_DANGER("你没有任何东西可丢弃！"))
		return 0

	if(istype(held_item, /obj/item/explosive/grenade))
		visible_message(SPAN_DANGER("[src]发射了\the [held_item]！"), SPAN_DANGER("You launch \the [held_item]!"), "You hear a skittering noise and a thump!")
		var/obj/item/explosive/grenade/G = held_item
		G.forceMove(loc)
		G.prime()
		held_item = null
		return 1

	visible_message(SPAN_NOTICE("[src]丢下了\the [held_item]！"), SPAN_NOTICE("You drop \the [held_item]!"), "You hear a skittering noise and a soft thump.")

	held_item.forceMove(loc)
	held_item = null
	return 1


/mob/living/simple_animal/small/spiderbot/verb/get_item()
	set name = "Pick up item"
	set category = "Spiderbot"
	set desc = "Allows you to take a nearby small item."

	if(stat)
		return -1

	if(held_item)
		to_chat(src, SPAN_DANGER("你已经拿着\the [held_item]了"))
		return 1

	var/list/items = list()
	for(var/obj/item/I in view(1,src))
		if(I.loc != src && I.w_class <= SIZE_SMALL && I.Adjacent(src) )
			items.Add(I)

	var/obj/selection = tgui_input_list(usr, "选择物品。", "Pickup", items)

	if(selection)
		for(var/obj/item/I in view(1, src))
			if(selection == I)
				held_item = selection
				selection.forceMove(src)
				visible_message(SPAN_NOTICE("[src]捡起了\the [held_item]！"), SPAN_NOTICE("You grab \the [held_item]!"), "You hear a skittering noise and a clink.")
				return held_item
		to_chat(src, SPAN_DANGER("\The [selection] is too far away."))
		return 0

	to_chat(src, SPAN_DANGER("没有值得拿取的东西。"))
	return 0

/mob/living/simple_animal/small/spiderbot/get_examine_text(mob/user)
	. = ..()
	if(held_item)
		. += "It is carrying \a [held_item] [icon2html(held_item, user)]."
