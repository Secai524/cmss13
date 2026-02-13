//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/item/implantcase
	name = "玻璃盒"
	desc = "一个装有植入物的盒子。"
	icon = 'icons/obj/items/syringe.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "implantcase-0"
	item_state = "implantcase"
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_TINY
	var/obj/item/implant/imp = null

/obj/item/implantcase/proc/update()
	if (imp)
		icon_state = "implantcase-[imp.implant_color]"
	else
		icon_state = "implantcase-0"
	return

/obj/item/implantcase/attackby(obj/item/I as obj, mob/user as mob)
	..()
	if (HAS_TRAIT(I, TRAIT_TOOL_PEN))
		var/t = stripped_input(user, "你希望标签是什么？", text("[]", src.name), null)
		if (user.get_active_hand() != I)
			return
		if((!in_range(src, usr) && src.loc != user))
			return
		if(t)
			src.name = text("Glass Case - '[]'", t)
		else
			src.name = "玻璃盒"
	else if(istype(I, /obj/item/reagent_container/syringe))
		if(!src.imp)
			return
		if(!src.imp.allow_reagents)
			return
		if(src.imp.reagents.total_volume >= src.imp.reagents.maximum_volume)
			to_chat(user, SPAN_DANGER("[src]已满。"))
		else
			spawn(5)
				I.reagents.trans_to(src.imp, 5)
				to_chat(user, SPAN_NOTICE("你注射了5单位溶液。注射器现在含有 [I.reagents.total_volume] 单位。"))
	else if (istype(I, /obj/item/implanter))
		var/obj/item/implanter/M = I
		if (M.imp)
			if ((src.imp || M.imp.implanted))
				return
			M.imp.forceMove(src)
			src.imp = M.imp
			M.imp = null
			src.update()
			M.update()
		else
			if (src.imp)
				if (M.imp)
					return
				src.imp.forceMove(M)
				M.imp = src.imp
				src.imp = null
				update()
			M.update()
	return


/obj/item/implantcase/tracking
	name = "玻璃盒 - '追踪'"
	desc = "一个装有追踪植入物的盒子。"
	icon_state = "implantcase-b"

/obj/item/implantcase/tracking/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/tracking( src )

/obj/item/implantcase/explosive
	name = "玻璃盒 - '爆炸'"
	desc = "一个装有爆炸植入物的盒子。"
	icon_state = "implantcase-r"

/obj/item/implantcase/explosive/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/explosive( src )


/obj/item/implantcase/chem
	name = "玻璃盒 - '化学'"
	desc = "一个装有化学植入物的盒子。"
	icon_state = "implantcase-b"

/obj/item/implantcase/chem/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/chem( src )

/obj/item/implantcase/loyalty
	name = "玻璃盒 - '维-汤'"
	desc = "一个装有维-汤植入物的盒子。"
	icon_state = "implantcase-r"

/obj/item/implantcase/loyalty/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/loyalty( src )

/obj/item/implantcase/death_alarm
	name = "玻璃盒 - '死亡警报'"
	desc = "一个装有死亡警报植入物的盒子。"
	icon_state = "implantcase-b"

/obj/item/implantcase/death_alarm/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/death_alarm( src )

/obj/item/implantcase/freedom
	name = "玻璃盒 - '自由'"
	desc = "一个装有自由植入物的盒子。"
	icon_state = "implantcase-r"

/obj/item/implantcase/freedom/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/freedom( src )

/obj/item/implantcase/adrenalin
	name = "玻璃盒 - '肾上腺素'"
	desc = "一个装有肾上腺素植入物的盒子。"
	icon_state = "implantcase-b"

/obj/item/implantcase/adrenalin/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/adrenalin( src )

/obj/item/implantcase/dexplosive
	name = "玻璃盒 - '爆炸'"
	desc = "一个装有爆炸物的盒子。"
	icon_state = "implantcase-r"

/obj/item/implantcase/dexplosive/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/dexplosive( src )


/obj/item/implantcase/health
	name = "玻璃盒 - '健康'"
	desc = "一个装有健康追踪植入物的盒子。"
	icon_state = "implantcase-b"

/obj/item/implantcase/health/Initialize(mapload, ...)
	. = ..()
	imp = new /obj/item/implant/health( src )
