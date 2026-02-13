/obj/item/device/vulture_spotter_scope
	name = "\improper M707 spotter scope"
	desc = "一个瞄准镜，当安装在三角架上时，可协助M707的射手进行目标捕获。"
	icon_state = "vulture_scope"
	item_state = "electronic"
	icon = 'icons/obj/items/binoculars.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_righthand.dmi',
	)
	flags_atom = FPRINT|CONDUCT
	unacidable = TRUE
	explo_proof = TRUE
	/// A weakref to the corresponding rifle
	var/datum/weakref/bound_rifle

/obj/item/device/vulture_spotter_scope/Initialize(mapload, datum/weakref/rifle)
	. = ..()
	if(rifle)
		bound_rifle = rifle

/obj/item/device/vulture_spotter_scope/attack_self(mob/user)
	. = ..()
	to_chat(user, SPAN_WARNING("[src]需要安装在三角架上才能使用！"))

/obj/item/device/vulture_spotter_scope/skillless

/obj/item/device/vulture_spotter_tripod
	name = "\improper M707 spotter tripod"
	desc = "一个三角架，用于稳定M707反器材步枪的观测瞄准镜。"
	icon_state = "vulture_tripod"
	item_state = "electronic"
	icon = 'icons/obj/items/binoculars.dmi'
	flags_atom = FPRINT|CONDUCT
	unacidable = TRUE
	explo_proof = TRUE

/obj/item/device/vulture_spotter_tripod/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("[src] can be set down by <b>using in-hand</b>.")

/obj/item/device/vulture_spotter_tripod/attack_self(mob/user)
	. = ..()
	user.balloon_alert(user, "架设三角架")
	if(!do_after(user, 1.5 SECONDS, target = user))
		return

	new /obj/structure/vulture_spotter_tripod(get_turf(user))
	qdel(src)
