/obj/structure/curtain
	icon = 'icons/obj/structures/props/curtain.dmi'
	name = "curtain"
	icon_state = "green"
	layer = ABOVE_MOB_LAYER
	opacity = TRUE
	density = FALSE
	var/open = FALSE
	var/transparent = FALSE

/obj/structure/curtain/open/New()
	..()
	toggle()

/obj/structure/curtain/bullet_act(obj/projectile/P, def_zone)
	if(P.damage)
		visible_message(SPAN_WARNING("[P]撕毁了[src]！"))
		qdel(src)
	return 0

/obj/structure/curtain/attack_hand(mob/user)
	playsound(get_turf(loc), "rustle", 15, 1, 6)
	toggle()
	..()

/obj/structure/curtain/attack_alien(mob/living/carbon/xenomorph/M)
	M.animation_attack_on(src)
	M.visible_message(SPAN_DANGER("\The [M] slices [src] apart!"),
	SPAN_DANGER("You slice [src] apart!"), null, 5)
	qdel(src)
	return XENO_ATTACK_ACTION

/obj/structure/curtain/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable)
		return TAILSTAB_COOLDOWN_NONE
	xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴将[src]切碎！"),
	SPAN_DANGER("We slice [src] apart with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	qdel(src)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/curtain/proc/toggle()
	open = !open
	if(!transparent)
		opacity = !opacity
	if(open)
		icon_state = "[initial(icon_state)]-o"
		layer = OBJ_LAYER
	else
		icon_state = "[initial(icon_state)]"
		layer = ABOVE_MOB_LAYER

/obj/structure/curtain/shower
	name = "浴帘"
	color = "#ACD1E9"
	alpha = 200

/obj/structure/curtain/black
	name = "黑色帘子"
	color = "#222222"

/obj/structure/curtain/medical
	name = "塑料帘子"
	color = "#B8F5E3"
	alpha = 200

/obj/structure/curtain/open/shower
	name = "浴帘"
	icon_state = "shower"
	alpha = 200

/obj/structure/curtain/open/black
	name = "黑色帘子"
	color = "#222222"

/obj/structure/curtain/open/medical
	name = "塑料帘子"
	color = "#B8F5E3"
	alpha = 200

/obj/structure/curtain/red
	name = "红色帘子"
	icon_state = "red"

/obj/structure/curtain/leather
	name = "皮革帘子"
	icon_state = "leather_curtain"
	alpha = 200

/obj/structure/curtain/leather/alt
	name = "皮革帘子"
	icon_state = "leather_curtain_2"

/obj/structure/curtain/leather/alt_1
	name = "皮革帘子"
	icon_state = "leather_curtain_3"

/obj/structure/curtain/leather/alt_2
	name = "皮革帘子"
	icon_state = "leather_curtain_4"

// Colorable

/obj/structure/curtain/colorable
	name = "curtain"
	icon_state = "colorable"

/obj/structure/curtain/colorable_transparent
	name = "blinds"
	icon_state = "colorable_transparent"
	alpha = 200
	transparent = TRUE

// Open

/obj/structure/curtain/open/colorable
	name = "curtain"
	icon_state = "colorable"

/obj/structure/curtain/open/colorable_transparent
	name = "blinds"
	icon_state = "colorable_transparent"
	alpha = 200
	transparent = TRUE

/obj/structure/curtain/open/red
	name = "红色帘子"
	icon_state = "red"

/obj/structure/curtain/open/leather
	name = "皮革帘子"
	icon_state = "leather_curtain"
	alpha = 200

/obj/structure/curtain/open/leather/alt
	name = "皮革帘子"
	icon_state = "leather_curtain_2"

/obj/structure/curtain/open/leather/alt_1
	name = "皮革帘子"
	icon_state = "leather_curtain_3"

/obj/structure/curtain/open/leather/alt_2
	name = "皮革帘子"
	icon_state = "leather_curtain_4"

/obj/structure/curtain/Initialize()
	. = ..()
	if(transparent)
		set_opacity(0)
