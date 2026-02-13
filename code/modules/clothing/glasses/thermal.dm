
// thermal goggles

/obj/item/clothing/glasses/thermal
	name = "光学热成像扫描仪"
	desc = "眼镜形态的热成像仪。"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)
	icon_state = "thermal"
	item_state = "glasses"
	gender = NEUTER
	toggleable = TRUE
	vision_flags = SEE_MOBS
	lighting_alpha = LIGHTING_PLANE_ALPHA_SOMEWHAT_INVISIBLE
	darkness_view = 12
	invisa_view = 2
	eye_protection = EYE_PROTECTION_NEGATIVE
	deactive_state = "goggles_off"
	fullscreen_vision = /atom/movable/screen/fullscreen/thermal
	var/blinds_on_emp = TRUE

/obj/item/clothing/glasses/thermal/emp_act(severity)
	. = ..()
	if(blinds_on_emp)
		if(istype(src.loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/M = src.loc
			to_chat(M, SPAN_WARNING("光学热成像扫描仪过载，使你暂时失明！"))
			if(M.glasses == src)
				M.SetEyeBlind(3)
				M.EyeBlur(5)
				if(!(M.disabilities & NEARSIGHTED))
					M.disabilities |= NEARSIGHTED
					spawn(100)
						M.disabilities &= ~NEARSIGHTED


/obj/item/clothing/glasses/thermal/syndi //These are now a traitor item, concealed as mesons. -Pete
	name = "光学介子扫描仪"
	desc = "用于透视墙壁、地板及任何物体。"
	icon = 'icons/obj/items/clothing/glasses/huds.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/huds.dmi',
	)
	icon_state = "meson"
	deactive_state = "degoggles"
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/thermal/syndi/bug_b_gone
	name = "除虫热成像护目镜"
	desc = "满足你所有的猎虫需求！"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)
	icon_state = "rwelding-g"
	deactive_state = "rwelding-gup"
	gender = PLURAL

/obj/item/clothing/glasses/thermal/syndi/kutjevo
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	icon_state = "kutjevo_goggles"
	deactive_state = "kutjevo_goggles"
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)

/obj/item/clothing/glasses/thermal/monocle
	name = "热成像单片镜"
	desc = "一个单片热成像镜。"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
	)
	icon_state = "thermoncle"
	flags_atom = null //doesn't protect eyes because it's a monocle, duh
	toggleable = FALSE
	flags_armor_protection = 0

/obj/item/clothing/glasses/thermal/eyepatch
	name = "光学热成像眼罩"
	desc = "内置热成像光学的眼罩。"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
	)
	icon_state = "eyepatch"
	item_state = "eyepatch"
	toggleable = FALSE
	flags_armor_protection = 0

/obj/item/clothing/glasses/thermal/empproof
	desc = "眼镜形态的热成像仪。此型号防电磁脉冲。"
	blinds_on_emp = FALSE
