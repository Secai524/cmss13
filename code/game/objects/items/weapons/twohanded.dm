	/*##################################################################
	Much improved now. Leaving the overall item procs here since they're
	easier to find that way. Theoretically any item may be twohanded,
	but only these items and guns benefit from it. ~N
	####################################################################*/

/obj/item/weapon/twohanded
	var/force_wielded = 0
	var/wieldsound = null
	var/unwieldsound = null
	force = MELEE_FORCE_NORMAL
	force_wielded = MELEE_FORCE_VERY_STRONG
	flags_item = TWOHANDED

	shield_type = SHIELD_DIRECTIONAL_TWOHANDS
	shield_chance = SHIELD_CHANCE_MED

/obj/item/weapon/twohanded/update_icon()
	return

/obj/item/weapon/twohanded/mob_can_equip(mob/user)
	unwield(user)
	return ..()

/obj/item/weapon/twohanded/dropped(mob/user)
	..()
	unwield(user)

/obj/item/proc/wield(mob/user)
	if( !(flags_item & TWOHANDED) || flags_item & WIELDED )
		return

	var/obj/item/I = user.get_inactive_hand()
	if(I)
		user.drop_inv_item_on_ground(I)

	if(ishuman(user))
		var/check_hand = user.r_hand == src ? "l_hand" : "r_hand"
		var/mob/living/carbon/human/wielder = user
		var/obj/limb/hand = wielder.get_limb(check_hand)
		if( !istype(hand) || !hand.is_usable() )
			to_chat(user, SPAN_WARNING("你的另一只手无法握住[src]！"))
			return

	flags_item    ^= WIELDED
	place_offhand(user, name)
	name    += " (Wielded)"
	item_state += "_w"
	return 1

/obj/item/proc/unwield(mob/user)
	if( (flags_item|TWOHANDED|WIELDED) != flags_item)
		return FALSE//Have to be actually a twohander and wielded.
	flags_item ^= WIELDED
	SEND_SIGNAL(src, COMSIG_ITEM_UNWIELD, user)
	name = copytext(name,1,-10)
	item_state  = copytext(item_state,1,-2)
	remove_offhand(user)
	return TRUE

/obj/item/proc/place_offhand(mob/user,item_name)
	to_chat(user, SPAN_NOTICE("你用双手抓住了[item_name]。"))
	user.recalculate_move_delay = TRUE
	var/obj/item/weapon/twohanded/offhand/offhand = new /obj/item/weapon/twohanded/offhand(user)
	offhand.name = "[item_name] - offhand"
	offhand.desc = "Your second grip on the [item_name]."
	offhand.flags_item |= WIELDED
	offhand.force_wielded = 0 // no reason for these things to deal the same damage as the parent when they shouldnt be used for attacks anyway
	offhand.force = 0 // ditto
	user.put_in_inactive_hand(offhand)
	user.update_inv_l_hand(0)
	user.update_inv_r_hand()

/obj/item/proc/remove_offhand(mob/user)
	to_chat(user, SPAN_NOTICE("你现在正用一只手提着[name]。"))
	user.recalculate_move_delay = TRUE
	var/obj/item/weapon/twohanded/offhand/offhand = user.get_inactive_hand()
	if(istype(offhand))
		offhand.unwield(user)
	user.update_inv_l_hand(0)
	user.update_inv_r_hand()

/obj/item/weapon/twohanded/wield(mob/user)
	. = ..()
	if(!.)
		return
	user.recalculate_move_delay = TRUE
	if(wieldsound)
		playsound(user, wieldsound, 15, 1)
	force = force_wielded

/obj/item/weapon/twohanded/unwield(mob/user)
	. = ..()
	if(!.)
		return
	user.recalculate_move_delay = TRUE
	if(unwieldsound)
		playsound(user, unwieldsound, 15, 1)
	force = initial(force)

/obj/item/weapon/twohanded/attack_self(mob/user)
	..()
	if(ismonkey(user))
		to_chat(user, SPAN_WARNING("它太重了，你无法完全挥舞！"))
		return

	if(flags_item & WIELDED)
		unwield(user)
	else wield(user)

///////////OFFHAND///////////////
/obj/item/weapon/twohanded/offhand
	w_class = SIZE_HUGE
	icon_state = "offhand"
	icon = 'icons/mob/hud/human_midnight.dmi'
	name = "offhand"
	flags_item = DELONDROP|TWOHANDED|WIELDED|CANTSTRIP

	shield_type = SHIELD_NONE
	shield_chance = SHIELD_CHANCE_NONE

/obj/item/weapon/twohanded/offhand/unwield(mob/user)
	if(flags_item & WIELDED)
		flags_item &= ~WIELDED
		user.temp_drop_inv_item(src)
		qdel(src)

/obj/item/weapon/twohanded/offhand/wield()
	qdel(src) //This shouldn't even happen.

/obj/item/weapon/twohanded/offhand/dropped(mob/user)
	..()
	//This hand should be holding the main weapon. If everything worked correctly, it should not be wielded.
	//If it is, looks like we got our hand torn off or something.
	if(!QDESTROYING(src))
		var/obj/item/main_hand = user.get_active_hand()
		if(main_hand)
			main_hand.unwield(user)

/*
 * Fireaxe
 */
/obj/item/weapon/twohanded/fireaxe
	name = "消防斧"
	desc = "这真是疯子的武器。谁会想到用斧头来对抗火焰？"
	icon_state = "fireaxe"
	item_state = "fireaxe"
	icon = 'icons/obj/items/weapons/melee/axes.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/melee_weapons.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/axes_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/axes_righthand.dmi'
	)
	sharp = IS_SHARP_ITEM_BIG
	edge = 1
	w_class = SIZE_LARGE
	flags_equip_slot = SLOT_BACK
	flags_atom = FPRINT|QUICK_DRAWABLE|CONDUCT
	flags_item = TWOHANDED
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	shield_flags = CAN_SHIELD_BASH

/obj/item/weapon/twohanded/fireaxe/wield(mob/user)
	. = ..()
	if(!.)
		return
	pry_capable = IS_PRY_CAPABLE_SIMPLE

/obj/item/weapon/twohanded/fireaxe/unwield(mob/user)
	. = ..()
	if(!.)
		return
	pry_capable = 0

/obj/item/weapon/twohanded/fireaxe/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity)
		return
	..()
	if(A && (flags_item & WIELDED) && istype(A,/obj/structure/grille)) //destroys grilles in one hit
		qdel(A)

/obj/item/weapon/twohanded/sledgehammer
	name = "sledgehammer"
	desc = "一根杆子末端的大金属块。粉碎一切！"
	icon_state = "sledgehammer"
	item_state = "sledgehammer"
	icon = 'icons/obj/items/weapons/melee/hammers.dmi'
	sharp = null
	edge = 0
	w_class = SIZE_LARGE
	flags_equip_slot = SLOT_BACK
	flags_atom = FPRINT|QUICK_DRAWABLE|CONDUCT
	flags_item = TWOHANDED
	attack_verb = list("smashed", "beaten", "slammed", "struck", "smashed", "battered", "cracked")

//The following is copypasta and not the sledge being a child of the fireaxe due to the fire axe being able to crowbar airlocks
/obj/item/weapon/twohanded/sledgehammer/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity)
		return
	..()
	if(A && (flags_item & WIELDED) && istype(A,/obj/structure/grille)) //destroys grilles in one hit
		qdel(A)

/*
 * Double-Bladed Energy Swords - Cheridan
 */
/obj/item/weapon/twohanded/dualsaber
	name = "双刃能量剑"
	desc = "小心轻放。"
	icon_state = "dualsaber"
	item_state = "dualsaber"
	icon = 'icons/obj/items/weapons/melee/energy.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/energy_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/energy_righthand.dmi'
	)
	force = 3
	throwforce = 5
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_SMALL
	force_wielded = 75
	wieldsound = 'sound/weapons/saberon.ogg'
	unwieldsound = 'sound/weapons/saberoff.ogg'
	flags_atom = FPRINT|QUICK_DRAWABLE|NOBLOODY
	flags_item = UNBLOCKABLE|TWOHANDED

	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharp = IS_SHARP_ITEM_BIG
	edge = 1

	shield_type = SHIELD_ABSOLUTE_TWOHANDS
	shield_chance = SHIELD_CHANCE_VHIGH

/obj/item/weapon/twohanded/dualsaber/attack(target as mob, mob/living/user as mob)
	..()
	if((flags_item & WIELDED) && prob(50))
		spawn(0)
			for(var/i in list(1,2,4,8,4,2,1,2,4,8,4,2))
				user.setDir(i)
				sleep(1)

/obj/item/weapon/twohanded/dualsaber/wield(mob/user)
	. = ..()
	if(!.)
		return
	icon_state += "_w"

/obj/item/weapon/twohanded/dualsaber/unwield(mob/user)
	. = ..()
	if(!.)
		return
	icon_state = copytext(icon_state,1,-2)

/obj/item/weapon/twohanded/spear
	name = "spear"
	desc = "一把仓促制造但依然致命的古代设计武器。"
	icon_state = "spearglass"
	item_state = "spearglass"
	icon = 'icons/obj/items/weapons/melee/spears.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/spears_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/spears_righthand.dmi',
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/melee_weapons.dmi'
	)
	w_class = SIZE_LARGE
	flags_equip_slot = SLOT_BACK
	throwforce = 35
	throw_speed = SPEED_VERY_FAST
	edge = 1
	sharp = IS_SHARP_ITEM_SIMPLE
	flags_item = TWOHANDED
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "stabbed", "jabbed", "torn", "gored")
	shield_chance = SHIELD_CHANCE_LOW

/obj/item/weapon/twohanded/lungemine
	name = "突刺地雷"
	icon_state = "lungemine"
	item_state = "lungemine"
	icon = 'icons/obj/items/weapons/melee/spears.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/spears_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/spears_righthand.dmi'
	)
	desc = "一个粗糙但外形庞大、令人生畏的聚能装药爆炸物，固定在杆子末端。使用它时，必须用双手牢牢抓住，并将聚能装药的尖刺刺入目标。由此产生的爆炸直接发生在使用者面前，这显然不是设计者关心的问题。一把真正的英雄武器。"
	force = MELEE_FORCE_WEAK
	force_wielded = 1
	attack_verb = list("whacked")
	hitsound = "swing_hit"
	shield_chance = SHIELD_CHANCE_NONE
	shield_type = SHIELD_NONE

	var/detonating = FALSE
	var/gib_user = TRUE
	var/wielded_attack_verb = list("charged")
	var/wielded_hitsound = null
	var/unwielded_attack_verb = list("whacked")
	var/unwielded_hitsound = "swing_hit"

	/// This controls how strong the explosion will be on the lunge mine. Higher is better.
	var/detonation_force = 150

/obj/item/weapon/twohanded/lungemine/wield(mob/user)
	. = ..()
	if(!.)
		return
	attack_verb = wielded_attack_verb
	hitsound = wielded_hitsound

/obj/item/weapon/twohanded/lungemine/unwield(mob/user)
	. = ..()
	if(!.)
		return
	attack_verb = unwielded_attack_verb
	hitsound = unwielded_hitsound

/obj/item/weapon/twohanded/lungemine/attack(mob/living/M, mob/living/user)
	. = ..()
	detonate_check(M, user)

/obj/item/weapon/twohanded/lungemine/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		detonate_check(target, user)

/obj/item/weapon/twohanded/lungemine/proc/detonate_check(atom/target, mob/user)
	if(detonating) //don't detonate twice
		return

	if(!(flags_item & WIELDED)) //must be wielded to detonate
		return

	if(!istype(target))
		return

	if(!target.density && !istype(target, /mob))
		return

	if(target == user)
		return

	detonating = TRUE
	playsound(user, 'sound/items/Wirecutter.ogg', 50, 1)

	addtimer(CALLBACK(src, PROC_REF(lungemine_detonate), target, user), 0.3 SECONDS)

/obj/item/weapon/twohanded/lungemine/proc/lungemine_detonate(atom/target, mob/user)
	var/turf/epicenter = get_turf(target)
	cell_explosion(epicenter, detonation_force, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data(initial(name), user))
	if(gib_user)
		user.gib()
	qdel(src)

/obj/item/weapon/twohanded/lungemine/damaged
	name = "损坏的突刺地雷"
	desc = "一个粗糙但外形庞大、令人生畏的聚能装药爆炸物，固定在杆子末端。使用它时，必须用双手牢牢抓住，并将聚能装药的尖刺刺入目标。由此产生的爆炸直接发生在使用者面前，这显然不是设计者关心的问题。一把真正的英雄武器。这个看起来损坏得很严重，你甚至可能不应该把它从地上捡起来。"
	detonation_force = 50
	gib_user = FALSE

/obj/item/weapon/twohanded/breacher
	name = "\improper D2 Breaching Hammer"
	desc = "这是B5破门锤的轻量版本，这种破坏性工具在挥动时能产生足够的力量，可以相对轻松地摧毁墙壁。它几乎可以击穿任何东西，威力巨大，并且与它的前身不同，大多数成年人类都可以挥舞它。"
	icon = 'icons/obj/items/weapons/melee/hammers.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_righthand.dmi',
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/melee_weapons.dmi'
	)
	icon_state = "d2_breacher"
	item_state = "d2_breacher"
	force = MELEE_FORCE_NORMAL
	force_wielded = MELEE_FORCE_NORMAL
	w_class = SIZE_LARGE
	flags_item = TWOHANDED
	flags_equip_slot = SLOT_BACK
	attack_verb = list("pulverized", "smashed", "thwacked", "crushed", "hammered", "wrecked")
	var/really_heavy = FALSE

/obj/item/weapon/twohanded/breacher/synth
	name = "\improper B5 Breaching Hammer"
	desc = "这把重达100磅的怪物大锤由实心碳化钨制成，挥动时能产生足够的力量，可以轻松摧毁墙壁。它可以击穿钢铁和混凝土，威力巨大，并且任何非超人类都完全无法使用。"
	icon_state = "syn_breacher"
	item_state = "syn_breacher"
	force_wielded = MELEE_FORCE_VERY_STRONG
	really_heavy = TRUE
	shield_chance = SHIELD_CHANCE_MEDHIGH
	var/move_delay_addition = 1.5

/obj/item/weapon/twohanded/breacher/synth/pickup(mob/user)
	. = ..()
	if(!(HAS_TRAIT(user, TRAIT_SUPER_STRONG)))
		to_chat(user, SPAN_HIGHDANGER("你勉强将[src]抬到膝盖以上。这东西对你来说可能毫无用处。"))
		user.apply_effect(3, EYE_BLUR)
		RegisterSignal(user, COMSIG_HUMAN_POST_MOVE_DELAY, PROC_REF(handle_movedelay))

		return

/obj/item/weapon/twohanded/breacher/synth/proc/handle_movedelay(mob/living/M, list/movedata)
	SIGNAL_HANDLER
	movedata["move_delay"] += move_delay_addition

/obj/item/weapon/twohanded/breacher/synth/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_HUMAN_POST_MOVE_DELAY)

/obj/item/weapon/twohanded/breacher/synth/attack(target as mob, mob/living/user as mob)
	if(!HAS_TRAIT(user, TRAIT_SUPER_STRONG))
		to_chat(user, SPAN_WARNING("\The [src] is too heavy for you to use as a weapon!"))
		return
	. = ..()
