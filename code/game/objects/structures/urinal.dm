/obj/structure/urinal
	name = "urinal"
	desc = "HU-452，一个实验性小便器。"
	icon = 'icons/obj/structures/props/watercloset.dmi'
	icon_state = "urinal"
	density = FALSE
	anchored = TRUE

/obj/structure/urinal/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/grab))
		if(isxeno(user))
			return
		var/obj/item/grab/G = I
		if(isliving(G.grabbed_thing))
			var/mob/living/GM = G.grabbed_thing
			if(user.grab_level > GRAB_PASSIVE)
				if(!GM.loc == get_turf(src))
					to_chat(user, SPAN_NOTICE("[GM.name]需要在小便器上。"))
					return
				user.visible_message(SPAN_DANGER("[user]将[GM.name]猛撞进[src]！"), SPAN_NOTICE("You slam [GM.name] into [src]!"))
				GM.apply_damage(8, BRUTE)
			else
				to_chat(user, SPAN_NOTICE("你需要握得更紧。"))
