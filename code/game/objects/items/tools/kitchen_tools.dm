/* Kitchen tools
 * Contains:
 * Utensils
 * Spoons
 * Forks
 * Knives
 * Kitchen knives
 * Butcher's cleaver
 * Rolling Pins
 * Trays
 * Can openers
 */

/obj/item/tool/kitchen
	icon = 'icons/obj/items/kitchen_tools.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/kitchen_tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/kitchen_tools_righthand.dmi',
	)

/*
 * Utensils
 */
/obj/item/tool/kitchen/utensil
	force = 5
	w_class = SIZE_TINY
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	flags_atom = FPRINT|CONDUCT

	attack_verb = list("attacked", "stabbed", "poked")
	sharp = 0
	/// Descriptive string for currently loaded food object.
	var/loaded

/obj/item/tool/kitchen/utensil/Initialize()
	. = ..()
	if (prob(60))
		src.pixel_y = rand(0, 4)

	create_reagents(5)
	return

/obj/item/tool/kitchen/utensil/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M))
		return ..()

	if(user.a_intent != INTENT_HELP)
		return ..()

	if (reagents.total_volume > 0)
		var/fullness = M.nutrition + (M.reagents.get_reagent_amount("nutriment") * 25)
		if(issynth(M) || isyautja(M))
			fullness = 200 //Synths and yautja never get full
		if(fullness > NUTRITION_HIGH)
			to_chat(user, SPAN_WARNING("[user == M ? "You" : "They"] don't feel like eating more right now."))
			return
		reagents.set_source_mob(user)
		reagents.trans_to_ingest(M, reagents.total_volume)
		if(M == user)
			for(var/mob/O in viewers(M, null))
				O.show_message(SPAN_NOTICE("[user]从\the [src]中吃了一些[loaded]。"), SHOW_MESSAGE_VISIBLE)
				M.reagents.add_reagent("nutriment", 1)
		else
			for(var/mob/O in viewers(M, null))
				O.show_message(SPAN_NOTICE("[user]从\the [src]中喂给[M]一些[loaded]。"), SHOW_MESSAGE_VISIBLE)
				M.reagents.add_reagent("nutriment", 1)
		playsound(M.loc,'sound/items/eatfood.ogg', 15, 1)
		overlays.Cut()
		return
	else
		..()

/obj/item/tool/kitchen/utensil/fork
	name = "fork"
	desc = "这是一把叉子。确实很尖。"
	icon_state = "fork"
	item_state = "fork"

/obj/item/tool/kitchen/utensil/pfork
	name = "塑料叉"
	desc = "太好了，不用洗碗。"
	icon_state = "pfork"
	item_state = "pfork"

/obj/item/tool/kitchen/utensil/spoon
	name = "spoon"
	desc = "这是一把勺子。你可以在里面看到自己倒过来的脸。"
	icon_state = "spoon"
	item_state = "spoon"
	attack_verb = list("attacked", "poked")

/obj/item/tool/kitchen/utensil/pspoon
	name = "塑料勺"
	desc = "这是一把塑料勺。真没劲。"
	icon_state = "pspoon"
	item_state = "pspoon"
	attack_verb = list("attacked", "poked")

/obj/item/tool/kitchen/utensil/mre_spork
	name = "MRE叉勺"
	desc = "这是一把棕色的塑料叉勺。就其本身而言非常坚固，传说有被困陆战队员用它挖过战壕。"
	icon_state = "mre_spork"
	attack_verb = list("attacked", "poked")

/obj/item/tool/kitchen/utensil/mre_spork/fsr
	name = "FSR叉勺"
	desc = "这是一把棕色的塑料叉勺。就其本身而言非常坚固，传说有被困陆战队员用它挖过战壕。"

/*
 * Knives
 */
/obj/item/tool/kitchen/utensil/knife
	name = "knife"
	desc = "可以切开任何食物。"
	icon_state = "knife"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_righthand.dmi'
	)
	item_state = "knife"
	force = 10
	throwforce = 10
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1

/obj/item/tool/kitchen/utensil/knife/attack(target as mob, mob/living/user as mob)
	. = ..()
	if(.)
		playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1, 5)

/obj/item/tool/kitchen/utensil/pknife
	name = "塑料刀"
	desc = "最钝的刀刃。"
	icon_state = "pknife"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_righthand.dmi'
	)
	item_state = "pknife"
	force = 10
	throwforce = 10

/obj/item/tool/kitchen/utensil/pknife/attack(target as mob, mob/living/user as mob)
	. = ..()
	if(.)
		playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1, 5)

/*
 * Kitchen knives
 */
/obj/item/tool/kitchen/knife
	name = "厨刀"
	desc = "一把由SpaceCook公司制造的通用厨师刀。保证在未来几年内保持锋利。"
	icon_state = "knife"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_righthand.dmi'
	)
	flags_atom = FPRINT|CONDUCT
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1
	force = MELEE_FORCE_TIER_4
	w_class = SIZE_MEDIUM
	throwforce = 6
	throw_speed = SPEED_VERY_FAST
	throw_range = 6
	matter = list("metal" = 12000)

	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/*
 * Plastic Pizza Cutter
 */
/obj/item/tool/kitchen/pizzacutter
	name = "披萨刀"
	desc = "一种用于切割披萨的圆形刀片。这把有一个廉价的塑料手柄。"
	icon_state = "plasticpizzacutter"
	flags_atom = FPRINT|CONDUCT
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = TRUE
	force = 10
	w_class = SIZE_MEDIUM
	hitsound = 'sound/weapons/bladeslice.ogg'
	throwforce = 6
	throw_speed = SPEED_VERY_FAST
	throw_range = 6
	matter = list("metal" = 12000)

	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/*
 * Wood Pizza Cutter
 */
/obj/item/tool/kitchen/pizzacutter/wood
	desc = "一种用于切割披萨的圆形刀片。这把有一个正宗木制手柄。"
	icon_state = "woodpizzacutter"

/*
 * Holy Relic Pizza Cutter
 */
/obj/item/tool/kitchen/pizzacutter/holyrelic
	name = "\improper PIZZA TIME"
	desc = "在你面前的是一个逝去时代的圣物，那时伟大的披萨领主至高无上。你知道，要么是这样，要么它就是个该死的大号披萨刀。"
	icon_state = "holyrelicpizzacutter"
	force = MELEE_FORCE_VERY_STRONG

/*
 * Bucher's cleaver
 */
/obj/item/tool/kitchen/knife/butcher
	name = "屠夫砍刀"
	desc = "一个用于切碎肉块的大玩意儿。这包括小丑和小丑副产品。"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/kitchen_tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/kitchen_tools_righthand.dmi',
	)
	icon_state = "butch"
	flags_atom = FPRINT|CONDUCT
	force = MELEE_FORCE_NORMAL
	w_class = SIZE_SMALL
	throwforce = 8
	throw_speed = SPEED_VERY_FAST
	throw_range = 6
	matter = list("metal" = 12000)

	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1

/obj/item/tool/kitchen/knife/butcher/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	. = ..()
	if(.)
		playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1, 5)

/*
 * Rolling Pins
 */

/obj/item/tool/kitchen/rollingpin
	name = "擀面杖"
	desc = "用来敲晕酒保。"
	icon_state = "rolling_pin"
	force = 8
	throwforce = 10
	throw_speed = SPEED_FAST
	throw_range = 7
	w_class = SIZE_MEDIUM
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")

/obj/item/tool/kitchen/rollingpin/attack(mob/living/M as mob, mob/living/user as mob)
	var/obj/limb/affecting = user.zone_selected
	var/drowsy_threshold = 0

	drowsy_threshold = CLOTHING_ARMOR_MEDIUM - M.getarmor(affecting, ARMOR_MELEE)

	if(affecting == "head" && istype(M, /mob/living/carbon/) && !isxeno(M))
		for(var/mob/O in viewers(user, null))
			if(M != user)
				O.show_message(text(SPAN_DANGER("<B>[M] has been hit over the head with a [name] by [user]!</B>")), SHOW_MESSAGE_VISIBLE)
			else
				O.show_message(text(SPAN_DANGER("<B>[M] hit \himself with a [name] on the head!</B>")), SHOW_MESSAGE_VISIBLE)
		if(drowsy_threshold > 0)
			M.apply_effect(min(drowsy_threshold, 10) , DROWSY)

		M.apply_damage(force, BRUTE, affecting, sharp=0) //log and damage the custom hit
		user.attack_log += "\[[time_stamp()]\]<font color='red'> Attacked [key_name(M)] with [name] (INTENT: [uppertext(intent_text(user.a_intent))]) (DAMTYPE: [uppertext(damtype)])</font>"
		M.attack_log += "\[[time_stamp()]\]<font color='orange'> Attacked by  [key_name(user)] with [name] (INTENT: [uppertext(intent_text(user.a_intent))]) (DAMTYPE: [uppertext(damtype)])</font>"
		msg_admin_attack("[key_name(user)] attacked [key_name(M)] with [name] (INTENT: [uppertext(intent_text(user.a_intent))]) (DAMTYPE: [uppertext(damtype)]) in [get_area(src)] ([src.loc.x],[src.loc.y],[src.loc.z]).", src.loc.x, src.loc.y, src.loc.z)

	else //Regular attack text
		. = ..()

	return

/*
 * Trays - Agouri
 */
/obj/item/tool/kitchen/tray
	name = "tray"
	desc = "一个用来放置食物的金属托盘。"
	icon = 'icons/obj/items/kitchen_tools.dmi'
	icon_state = "tray"
	throwforce = 12
	throwforce = 10
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_MEDIUM
	flags_atom = FPRINT|CONDUCT
	matter = list("metal" = 3000)
	/// shield bash cooldown. based on world.time
	var/cooldown = 0

/obj/item/tool/kitchen/tray/attack(mob/living/carbon/M, mob/living/carbon/user)
	to_chat(user, SPAN_WARNING("你不小心用[src]砸到了自己！"))
	user.apply_effect(1, WEAKEN)
	user.take_limb_damage(2)

	playsound(M, 'sound/items/trayhit2.ogg', 25, 1) //sound playin'
	return //it always returns, but I feel like adding an extra return just for safety's sakes. EDIT; Oh well I won't :3

/obj/item/tool/kitchen/tray/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/tool/kitchen/rollingpin))
		if(cooldown < world.time - 25)
			user.visible_message(SPAN_WARNING("[user]用[W]猛击[src]！"))
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 25, 1)
			cooldown = world.time
	else
		..()

/*
 * Can opener
 */
/obj/item/tool/kitchen/can_opener //it has code connected to it in /obj/item/reagent_container/food/drinks/cans/attackby
	name = "开罐器"
	desc = "一个简单的开罐器，因其食物保存理念而在UPP中广受欢迎的工具。"
	icon = 'icons/obj/items/kitchen_tools.dmi'
	icon_state = "can_opener"
	w_class = SIZE_SMALL
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharp = IS_SHARP_ITEM_SIMPLE
	edge = 1
	force = MELEE_FORCE_TIER_2
	attack_verb = list("pinched", "nipped", "cut")

/obj/item/tool/kitchen/can_opener/compact
	name = "折叠开罐器"
	desc = "一个小巧紧凑的开罐器，可以折叠成安全易存放的形态，因其食物保存理念而在UPP中广受欢迎的工具。"
	icon_state = "can_opener_compact"
	w_class = SIZE_TINY
	var/active = 0
	hitsound = null
	force = 0
	edge = 0
	sharp = 0
	attack_verb = list("patted", "tapped")

/obj/item/tool/kitchen/can_opener/compact/attack_self(mob/user)
	..()

	active = !active
	if(active)
		to_chat(user, SPAN_NOTICE("你甩出了你的[src]。"))
		playsound(user, 'sound/weapons/flipblade.ogg', 15, 1)
		force = MELEE_FORCE_TIER_2
		edge = 1
		sharp = IS_SHARP_ITEM_SIMPLE
		hitsound = 'sound/weapons/bladeslice.ogg'
		icon_state += "_open"
		w_class = SIZE_SMALL
		attack_verb = list("pinched", "nipped", "cut")
	else
		to_chat(user, SPAN_NOTICE("[src]现在可以隐藏了。"))
		force = initial(force)
		edge = 0
		sharp = 0
		hitsound = initial(hitsound)
		icon_state = initial(icon_state)
		w_class = initial(w_class)
		attack_verb = initial(attack_verb)
		add_fingerprint(user)
