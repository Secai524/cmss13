/obj/item/ashtray
	icon = 'icons/obj/items/smoking/ashtray.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_righthand.dmi'
	)

	var/max_butts = 0
	var/empty_desc = ""
	var/icon_empty = ""
	var/icon_half = ""
	var/icon_full = ""
	var/icon_broken = ""

/obj/item/ashtray/attackby(obj/item/W as obj, mob/user as mob)
	if (health < 1)
		return
	if (istype(W,/obj/item/trash/cigbutt) || istype(W,/obj/item/clothing/mask/cigarette) || istype(W, /obj/item/tool/match))
		if (length(contents) >= max_butts)
			to_chat(user, "这个烟灰缸满了。")
			return
		var/drop = TRUE

		if (istype(W,/obj/item/clothing/mask/cigarette))
			var/obj/item/clothing/mask/cigarette/cig = W
			if(cig.type_butt)
				if(cig.heat_source)
					user.visible_message("[user]在\the [src]里捻灭了\the [cig]。", "You crush \the [cig] in \the [src], putting it out.")
					var/obj/item/butt = cig.go_out(user, TRUE)
					butt.forceMove(src)
					drop = FALSE
				else if (cig.heat_source == 0)
					to_chat(user, "你把\the [cig]放进\the [src]，甚至都没抽。为什么这么做？")
			else
				drop = FALSE
				var/obj/item/clothing/mask/cigarette/pipe/P = W
				if(P.ash)
					user.visible_message("[user]将\the [P]里的烟灰倒进\the [src]。", "You empty the ash out of \the [P] into \the [src].")
					P.ash = FALSE
				else
					to_chat(user, "\the [P]里没有烟灰。")

		if(drop)
			user.visible_message("[user]将\the [W]放进\the [src]。", "You place \the [W] into \the [src].")
			user.drop_inv_item_to_loc(W, src)
		user.update_inv_l_hand(0)
		user.update_inv_r_hand()
		add_fingerprint(user)
		if (length(contents) == max_butts)
			icon_state = icon_full
			desc = empty_desc + " It's stuffed full."
		else if (length(contents) > max_butts/2)
			icon_state = icon_half
			desc = empty_desc + " It's half-filled."
	else
		health = max(0,health - W.force)
		to_chat(user, "你用[W]击打[src]。")
		if (health < 1)
			die()
	return

/obj/item/ashtray/launch_impact(atom/hit_atom)
	if (health > 0)
		health = max(0,health - 3)
		if (health < 1)
			die()
			return
		if (length(contents))
			src.visible_message(SPAN_DANGER("[src]猛地撞上[hit_atom]，里面的东西洒了出来！"))
		for (var/obj/item/clothing/mask/cigarette/O in contents)
			O.forceMove(src.loc)
		icon_state = icon_empty
	return ..()

/obj/item/ashtray/proc/die()
	src.visible_message(SPAN_DANGER("[src]碎裂了，里面的东西洒了出来！"))
	for (var/obj/item/clothing/mask/cigarette/O in contents)
		O.forceMove(src.loc)
	icon_state = icon_broken

/obj/item/ashtray/plastic
	name = "塑料烟灰缸"
	desc = "廉价的塑料烟灰缸。"
	icon_state = "ashtray_bl"
	icon_empty = "ashtray_bl"
	icon_half  = "ashtray_half_bl"
	icon_full  = "ashtray_full_bl"
	icon_broken  = "ashtray_bork_bl"
	max_butts = 14
	health = 24
	matter = list("metal" = 30,"glass" = 30)
	empty_desc = "廉价的塑料烟灰缸。"
	throwforce = 3

/obj/item/ashtray/plastic/die()
	..()
	name = "塑料碎片"
	desc = "沾着烟灰的塑料碎片。"
	return


/obj/item/ashtray/bronze
	name = "青铜烟灰缸"
	desc = "巨大的青铜烟灰缸。"
	icon_state = "ashtray_br"
	icon_empty = "ashtray_br"
	icon_half  = "ashtray_half_br"
	icon_full  = "ashtray_full_br"
	icon_broken  = "ashtray_bork_br"
	max_butts = 10
	health = 72
	matter = list("metal" = 80)
	empty_desc = "巨大的青铜烟灰缸。"
	throwforce = 10

/obj/item/ashtray/bronze/die()
	..()
	name = "青铜碎片"
	desc = "沾着烟灰的青铜碎片。"
	return


/obj/item/ashtray/glass
	name = "玻璃烟灰缸"
	desc = "玻璃烟灰缸。看起来很脆弱。"
	icon_state = "ashtray_gl"
	icon_empty = "ashtray_gl"
	icon_half  = "ashtray_half_gl"
	icon_full  = "ashtray_full_gl"
	icon_broken  = "ashtray_bork_gl"
	max_butts = 12
	health = 12
	matter = list("glass" = 60)
	empty_desc = "玻璃烟灰缸。看起来很脆弱。"
	throwforce = 6

/obj/item/ashtray/glass/die()
	..()
	name = "玻璃碎片"
	desc = "沾着烟灰的玻璃碎片。"
	playsound(src, "glassbreak", 25, 1)
	return
