/obj/structure/window
	name = "window"
	desc = "一扇玻璃窗。它看起来又薄又脆弱。随便敲几下就能把它打碎。"
	icon = 'icons/turf/walls/windows.dmi'
	icon_state = "window"
	density = TRUE
	anchored = TRUE
	layer = WINDOW_LAYER
	flags_atom = ON_BORDER|FPRINT
	health = 15
	var/state = 2
	var/reinf = 0
	var/basestate = "window"
	var/shardtype = /obj/item/shard
	var/windowknock_cooldown = 0
	var/static_frame = 0 //True/false. If true, can't move the window
	var/junction = 0 //Because everything is terrible, I'm making this a window-level var
	var/not_damageable = 0
	var/not_deconstructable = 0
	var/legacy_full = FALSE //for old fulltile windows

	minimap_color = MINIMAP_FENCE

///fixes up layering on northern and southern windows, breaks fulltile windows, those shouldn't be used in the first place regardless.
/obj/structure/window/Initialize()
	. = ..()
	update_icon()

	if(shardtype)
		LAZYADD(debris, shardtype)

	if(reinf)
		LAZYADD(debris, /obj/item/stack/rods)

	if(is_full_window())
		LAZYADD(debris, shardtype)
		update_nearby_icons()

/obj/structure/window/Destroy(force)
	density = FALSE
	if(is_full_window())
		update_nearby_icons()
	. = ..()

/obj/structure/window/setDir(newdir)
	. = ..()
	update_icon()

/obj/structure/window/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_HIGH_OVER_ONLY|PASS_GLASS

/obj/structure/window/proc/set_constructed_window(start_dir)
	state = 0
	anchored = FALSE

	if(start_dir)
		setDir(start_dir)

	if(is_full_window())
		update_nearby_icons()

	update_icon()


/obj/structure/window/update_icon(loc, direction)
	if(QDELETED(src))
		return
	if(flags_atom & ON_BORDER)
		if(direction)
			setDir(direction)
		switch(dir)
			if(NORTH)
				layer = BELOW_TABLE_LAYER
			if(SOUTH)
				layer = ABOVE_MOB_LAYER
			else
				layer = initial(layer)
	else if(legacy_full)
		junction = 0
		if(anchored)
			var/turf/TU
			for(var/dirn in GLOB.cardinals)
				TU = get_step(src, dirn)
				var/obj/structure/window/W = locate() in TU
				if(W && W.anchored && W.density && W.legacy_full) //Only counts anchored, non-destroyed, legacy full-tile windows.
					junction |= dirn
		icon_state = "[basestate][junction]"
	..()

/obj/structure/window/Move()
	var/ini_dir = dir
	. = ..()
	setDir(ini_dir)


/**
 * Creates debris like shards and rods. This also includes the window frame for explosions.
 * If an user is passed, it will create a "user smashes through the window" message. causing_atom is the item that hit this.
 */
/obj/structure/window/proc/healthcheck(make_hit_sound = TRUE, make_shatter_sound = TRUE, create_debris = TRUE, mob/user, atom/movable/causing_atom)
	if(not_damageable)
		if(make_hit_sound) //We'll still make the noise for immersion's sake
			playsound(loc, 'sound/effects/Glasshit.ogg', 25, 1)
		return
	if(health <= 0)
		if(user && istype(user))
			user.count_niche_stat(STATISTICS_NICHE_DESTRUCTION_WINDOWS, 1)
			SEND_SIGNAL(user, COMSIG_MOB_DESTROY_WINDOW, src)
			visible_message(SPAN_WARNING("[user]砸碎了[src][causing_atom ? " with [causing_atom]!" : "!"]"),
			SPAN_WARNING("[src] breaks!"), 7)
			if(is_mainship_level(z))
				SSclues.create_print(get_turf(user), user, "A small glass piece is found on the fingerprint.")
		if(make_shatter_sound)
			playsound(src, "windowshatter", 50, 1)
		shatter_window(create_debris)
	else
		if(make_hit_sound)
			playsound(loc, 'sound/effects/Glasshit.ogg', 25, 1)

/obj/structure/window/bullet_act(obj/projectile/bullet)
	//Tasers and the like should not damage windows.
	var/ammo_flags = bullet.ammo.flags_ammo_behavior | bullet.projectile_override_flags
	if(bullet.ammo.damage_type == HALLOSS || bullet.damage <= 0 || ammo_flags == AMMO_ENERGY)
		return FALSE

	if(!not_damageable) //Impossible to destroy
		health -= bullet.damage
	..()
	healthcheck(user = bullet.firer, causing_atom = bullet)
	return TRUE

/obj/structure/window/ex_act(severity, explosion_direction, datum/cause_data/cause_data)
	if(not_damageable) //Impossible to destroy
		return

	health -= severity * EXPLOSION_DAMAGE_MULTIPLIER_WINDOW

	var/mob/M = cause_data?.resolve_mob()
	if(health > 0)
		healthcheck(FALSE, TRUE, user = M)
		return

	if(health >= -2000)
		var/location = get_turf(src)
		playsound(src, "windowshatter", 50, 1)
		create_shrapnel(location, rand(1,5), explosion_direction, shrapnel_type = /datum/ammo/bullet/shrapnel/light/glass, cause_data = cause_data)

	if(M)
		M.count_niche_stat(STATISTICS_NICHE_DESTRUCTION_WINDOWS, 1)
		SEND_SIGNAL(M, COMSIG_MOB_WINDOW_EXPLODED, src)

	handle_debris(severity, explosion_direction)
	deconstruct(FALSE)
	return

/obj/structure/window/get_explosion_resistance(direction)
	if(not_damageable)
		return 1000000

	if(flags_atom & ON_BORDER)
		if( direction == turn(dir, 90) || direction == turn(dir, -90) )
			return 0

	return health/EXPLOSION_DAMAGE_MULTIPLIER_WINDOW

/obj/structure/window/hitby(atom/movable/AM)
	..()
	visible_message(SPAN_DANGER("[src]被[AM]击中了。"))
	var/tforce = 0
	if(ismob(AM))
		tforce = 40
	else if(isobj(AM))
		var/obj/item/I = AM
		tforce = I.throwforce
	if(reinf)
		tforce *= 0.25
	if(!not_damageable) //Impossible to destroy
		health = max(0, health - tforce)
		if(health <= 7 && !reinf && !static_frame)
			anchored = FALSE
			update_nearby_icons()
			step(src, get_dir(AM, src))
	healthcheck(user = AM.launch_metadata?.thrower)

/obj/structure/window/attack_hand(mob/user as mob)
	if(user.a_intent == INTENT_HARM && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.species.can_shred(H))
			attack_generic(H, 25)
			return

		if(windowknock_cooldown > world.time)
			return

		playsound(loc, 'sound/effects/glassbash.ogg', 25, 1)
		user.visible_message(SPAN_WARNING("[user]猛撞向[src]！"),
		SPAN_WARNING("You bang against [src]!"),
		SPAN_WARNING("You hear a banging sound."))
		windowknock_cooldown = world.time + 100
	else
		if(windowknock_cooldown > world.time)
			return
		playsound(loc, 'sound/effects/glassknock.ogg', 15, 1)
		user.visible_message(SPAN_NOTICE("[user]敲了敲[src]。"),
		SPAN_NOTICE("You knock on [src]."),
		SPAN_NOTICE("You hear a knocking sound."))
		windowknock_cooldown = world.time + 100

//Used by attack_animal
/obj/structure/window/proc/attack_generic(mob/living/user, damage = 0)
	if(!not_damageable) //Impossible to destroy
		health -= damage
	user.animation_attack_on(src)
	user.visible_message(SPAN_DANGER("[user]撞上了[src]！"))
	healthcheck(1, 1, 1, user)

/obj/structure/window/attack_animal(mob/user as mob)
	if(!isanimal(user))
		return
	var/mob/living/simple_animal/M = user
	if(M.melee_damage_upper <= 0)
		return
	attack_generic(M, M.melee_damage_upper)

/obj/structure/window/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/grab) && get_dist(src, user) < 2)
		if(isxeno(user))
			return
		var/obj/item/grab/G = W
		if(istype(G.grabbed_thing, /mob/living))
			var/mob/living/M = G.grabbed_thing
			var/state = user.grab_level
			user.drop_held_item()
			switch(state)
				if(GRAB_PASSIVE)
					M.visible_message(SPAN_WARNING("[user]将[M]猛砸向\the [src]！"))
					M.apply_damage(7)
					if(!not_damageable) //Impossible to destroy
						health -= 10
				if(GRAB_AGGRESSIVE)
					M.visible_message(SPAN_DANGER("[user]将[M]撞向\the [src]！"))
					if(prob(50))
						M.apply_effect(1, WEAKEN)
					M.apply_damage(10)
					if(!not_damageable) //Impossible to destroy
						health -= 25
				if(GRAB_CHOKE)
					M.visible_message(SPAN_DANGER("[user]将[M]压碎在\the [src]上！"))
					M.apply_effect(5, WEAKEN)
					M.apply_damage(20)
					if(!not_damageable) //Impossible to destroy
						health -= 50

			M.attack_log += text("\[[time_stamp()]\] <font color='orange'>was slammed against [src] by [key_name(user)]</font>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>slammed [key_name(M)] against [src]</font>")
			msg_admin_attack("[key_name(user)] slammed [key_name(M)] against [src] at [get_area_name(M)]", M.loc.x, M.loc.y, M.loc.z)

			healthcheck(1, 1, 1, M) //The person thrown into the window literally shattered it
			return ATTACKBY_HINT_UPDATE_NEXT_MOVE
		return

	if(W.flags_item & NOBLUDGEON)
		return

	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER) && !not_deconstructable)
		if(!anchored)
			var/area/area = get_area(W)
			if(!area.allow_construction)
				to_chat(user, SPAN_WARNING("\The [src] must be fastened on a proper surface!"))
				return
			var/turf/open/T = loc
			var/obj/structure/blocker/anti_cade/AC = locate(/obj/structure/blocker/anti_cade) in T // for M2C HMG, look at smartgun_mount.dm
			if(!(istype(T) && T.allow_construction))
				to_chat(user, SPAN_WARNING("\The [src] must be fastened on a proper surface!"))
				return
			if(AC)
				to_chat(usr, SPAN_WARNING("\The [src] cannot be fastened here!"))  //might cause some friendly fire regarding other items like barbed wire, shouldn't be a problem?
				return

		if(reinf && state >= 1)
			state = 3 - state
			playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
			to_chat(user, (state == 1 ? SPAN_NOTICE("You have unfastened the window from the frame.") : SPAN_NOTICE("You have fastened the window to the frame.")))
		else if(reinf && state == 0 && !static_frame)
			anchored = !anchored
			update_nearby_icons()
			playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
			to_chat(user, (anchored ? SPAN_NOTICE("You have fastened the frame to the floor.") : SPAN_NOTICE("You have unfastened the frame from the floor.")))
		else if(!reinf && !static_frame)
			anchored = !anchored
			update_nearby_icons()
			playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
			to_chat(user, (anchored ? SPAN_NOTICE("You have fastened the window to the floor.") : SPAN_NOTICE("You have unfastened the window.")))
		else if(static_frame && state == 0)
			SEND_SIGNAL(user, COMSIG_MOB_DISASSEMBLE_WINDOW, src)
			deconstruct(TRUE)
	else if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR) && reinf && state <= 1 && !not_deconstructable)
		state = 1 - state
		playsound(loc, 'sound/items/Crowbar.ogg', 25, 1)
		to_chat(user, (state ? SPAN_NOTICE("You have pried the window into the frame.") : SPAN_NOTICE("You have pried the window out of the frame.")))
	else
		if(!not_damageable) //Impossible to destroy
			health -= W.force * W.demolition_mod
			if(health <= 7  && !reinf && !static_frame && !not_deconstructable)
				anchored = FALSE
				update_nearby_icons()
				step(src, get_dir(user, src))
		healthcheck(1, 1, 1, user, W)
		return ..()
	return

/obj/structure/window/proc/is_full_window()
	return !(flags_atom & ON_BORDER)

/obj/structure/window/deconstruct(disassembled = TRUE)
	if(disassembled)
		if(reinf)
			new /obj/item/stack/sheet/glass/reinforced(loc, 2)
		else
			new /obj/item/stack/sheet/glass(loc, 2)
	return ..()


/obj/structure/window/proc/shatter_window(create_debris)
	if(create_debris)
		handle_debris()
	deconstruct(FALSE)

/obj/structure/window/clicked(mob/user, list/mods)
	if(mods[ALT_CLICK])
		revrotate(user)
		return TRUE

	return ..()

/obj/structure/window/verb/rotate()
	set name = "Rotate Window Counter-Clockwise"
	set category = "Object"
	set src in oview(1)

	if(static_frame || not_deconstructable || !(flags_atom & ON_BORDER))
		return 0

	if(anchored)
		to_chat(usr, SPAN_WARNING("它被固定在地板上，你无法旋转！"))
		return 0

	setDir(turn(dir, 90))



/obj/structure/window/verb/revrotate()
	set name = "Rotate Window Clockwise"
	set category = "Object"
	set src in oview(1)

	if(static_frame || not_deconstructable || !(flags_atom & ON_BORDER))
		return 0
	if(anchored)
		to_chat(usr, SPAN_WARNING("它被固定在地板上，你无法旋转！"))
		return 0

	setDir(turn(dir, 270))



//This proc is used to update the icons of nearby windows.
/obj/structure/window/proc/update_nearby_icons()
	update_icon()
	for(var/direction in GLOB.cardinals)
		for(var/obj/structure/window/W in get_step(src, direction))
			W.update_icon()

/obj/structure/window/fire_act(exposed_temperature, exposed_volume)
	if(exposed_temperature > T0C + 800)
		if(!not_damageable)
			health -= floor(exposed_volume / 100)
		healthcheck(0) //Don't make hit sounds, it's dumb with fire/heat
	..()

/obj/structure/window/phoronbasic
	name = "福罗窗"
	desc = "一种福罗玻璃合金窗。看起来极其坚固，难以打破。似乎也极难烧穿。"
	icon_state = "phoronwindow0"
	shardtype = /obj/item/shard/phoron
	health = 120

/obj/structure/window/phoronbasic/fire_act(exposed_temperature, exposed_volume)
	if(exposed_temperature > T0C + 32000)
		health -= floor(exposed_volume / 1000)
		healthcheck(0) //Don't make hit sounds, it's dumb with fire/heat
	..()

/obj/structure/window/phoronbasic/full
	flags_atom = FPRINT
	icon_state = "phoronwindow0"
	basestate = "phoronwindow"
	legacy_full = TRUE


/obj/structure/window/phoronreinforced
	name = "强化福罗窗"
	desc = "一种带有杆状矩阵的福罗玻璃合金窗。看起来坚不可摧，完全无法打破。考虑到基本福罗窗就已极难燃烧，这扇窗看起来是完全防火的。"
	icon_state = "phoronrwindow0"
	shardtype = /obj/item/shard/phoron
	reinf = 1
	health = 160

/obj/structure/window/phoronreinforced/fire_act(exposed_temperature, exposed_volume)
	return

/obj/structure/window/phoronreinforced/full
	flags_atom = FPRINT
	icon_state = "phoronrwindow0"
	basestate = "phoronrwindow"
	legacy_full = TRUE


/obj/structure/window/reinforced
	name = "强化窗"
	desc = "一种用支撑杆加固的玻璃窗。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "rwindow"
	basestate = "rwindow"
	health = 40
	reinf = 1

/obj/structure/window/reinforced/toughened
	name = "安全玻璃"
	desc = "一扇看起来非常坚固的窗户，由钢化玻璃和支撑杆加固，可能防弹。"
	icon_state = "rwindow"
	basestate = "rwindow"
	health = 300
	reinf = 1



/obj/structure/window/reinforced/tinted
	name = "有色窗"
	desc = "一扇有色玻璃窗。看起来相当坚固且不透明。可能需要几次重击才能打碎它。"
	icon_state = "twindow"
	basestate = "twindow"
	opacity = TRUE

/obj/structure/window/reinforced/tinted/frosted
	name = "隐私窗"
	desc = "一扇玻璃隐私窗。看起来比普通的强化窗可能少承受几次打击。"
	icon_state = "fwindow"
	basestate = "fwindow"
	health = 30

/obj/structure/window/reinforced/ultra
	name = "超强化窗"
	desc = "一扇超强化窗，旨在确保简报台区域的安全。"
	icon_state = "fwindow"
	basestate = "fwindow"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/window/reinforced/ultra/initialize_pass_flags(datum/pass_flags_container/PF)
	. = ..()
	if (PF)
		PF.flags_can_pass_all = NONE
		PF.flags_can_pass_front = NONE
		PF.flags_can_pass_behind = PASS_OVER^(PASS_OVER_ACID_SPRAY)
	flags_can_pass_front_temp = NONE
	flags_can_pass_behind_temp = NONE

/obj/structure/window/reinforced/ultra/Initialize()
	. = ..()
	if(is_mainship_level(z))
		RegisterSignal(SSdcs, COMSIG_GLOB_HIJACK_IMPACTED, PROC_REF(deconstruct))

/obj/structure/window/reinforced/full
	flags_atom = FPRINT
	icon_state = "rwindow0"
	basestate = "rwindow"
	legacy_full = TRUE

/obj/structure/window/shuttle
	name = "穿梭机窗口"
	desc = "一扇带有专门耐热杆状矩阵的穿梭机玻璃窗。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon = 'icons/turf/podwindows.dmi'
	icon_state = "window"
	basestate = "window"
	health = 40
	reinf = 1
	flags_atom = FPRINT

/obj/structure/window/shuttle/update_icon() //icon_state has to be set manually
	return

/obj/structure/window/full
	flags_atom = FPRINT
	icon_state = "window0"
	basestate = "window"
	legacy_full = TRUE



//Framed windows

/obj/structure/window/framed
	name = "理论窗"
	layer = TABLE_LAYER
	static_frame = 1
	flags_atom = FPRINT
	var/window_frame //For perspective windows,so the window frame doesn't magically dissapear
	var/list/tiles_special = list(/obj/structure/machinery/door/airlock,
		/obj/structure/window/framed,
		/obj/structure/girder,
		/obj/structure/window_frame)
	tiles_with = list(/turf/closed/wall)

/obj/structure/window/framed/Initialize()
	. = ..()
	relativewall()
	relativewall_neighbours()

/obj/structure/window/framed/Destroy(force)
	for(var/obj/effect/alien/weeds/weedwall/window/found_weedwall in get_turf(src))
		qdel(found_weedwall)
	var/list/turf/cardinal_neighbors = list(get_step(src, NORTH), get_step(src, SOUTH), get_step(src, EAST), get_step(src, WEST))
	for(var/turf/cardinal_turf as anything in cardinal_neighbors)
		for(var/obj/structure/bed/nest/found_nest in cardinal_turf)
			if(found_nest.dir == get_dir(found_nest, src))
				qdel(found_nest) //nests are built on walls, no walls, no nest
	. = ..()

/obj/structure/window/framed/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_GLASS

/obj/structure/window/framed/update_nearby_icons()
	relativewall_neighbours()

/obj/structure/window/framed/update_icon()
	relativewall()

/obj/structure/window/framed/ex_act(severity, explosion_direction, datum/cause_data/cause_data)
	if(not_damageable) //Impossible to destroy
		return

	health -= severity * EXPLOSION_DAMAGE_MULTIPLIER_WINDOW

	var/mob/M = cause_data?.resolve_mob()
	if(health > 0)
		healthcheck(FALSE, TRUE, user = M)
		return

	if(M)
		M.count_niche_stat(STATISTICS_NICHE_DESTRUCTION_WINDOWS, 1)
		SEND_SIGNAL(M, COMSIG_MOB_EXPLODE_W_FRAME, src)

	if(health >= -3000)
		var/location = get_turf(src)
		playsound(src, "windowshatter", 50, 1)
		handle_debris(severity, explosion_direction)
		deconstruct(disassembled = FALSE)
		create_shrapnel(location, rand(1,5), explosion_direction, , /datum/ammo/bullet/shrapnel/light/glass, cause_data)
	else
		qdel(src)
	return


/obj/structure/window/framed/deconstruct(disassembled = TRUE)
	if(window_frame)
		var/obj/structure/window_frame/new_window_frame = new window_frame(loc, TRUE)
		new_window_frame.icon_state = "[new_window_frame.basestate][junction]_frame"
		new_window_frame.setDir(dir)
	return ..()

//Almayer windows

/obj/structure/window/framed/almayer
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "alm_rwindow0"
	basestate = "alm_rwindow"
	health = 100 //Was 600
	reinf = 1
	dir = NORTHEAST
	window_frame = /obj/structure/window_frame/almayer
	plane = TURF_PLANE

/obj/structure/window/framed/almayer/hull
	name = "船体窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。这扇窗由特殊材料制成，以防止船体破裂。无法从这里通过。"
	//icon_state = "rwindow0_debug" //Uncomment to check hull in the map editor
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000 //Failsafe, shouldn't matter

/obj/structure/window/framed/almayer/hull/hijack_bustable //I exist to explode after hijack, that is all.

/obj/structure/window/framed/almayer/hull/hijack_bustable/Initialize()
	. = ..()
	if(is_mainship_level(z))
		RegisterSignal(SSdcs, COMSIG_GLOB_HIJACK_IMPACTED, PROC_REF(deconstruct))

/obj/structure/window/framed/almayer/white
	icon_state = "white_rwindow0"
	basestate = "white_rwindow"
	window_frame = /obj/structure/window_frame/almayer/white

/obj/structure/window/framed/almayer/white/hull
	name = "船体窗"
	desc = "为保障研究区域安全而设计的超强化窗户。采用特殊材料制成，以防船体破损。这里无路可通。"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000 //Failsafe, shouldn't matter

/obj/structure/window/framed/almayer/aicore
	icon_state = "ai_rwindow0"
	basestate = "ai_rwindow"
	window_frame = /obj/structure/window_frame/almayer/aicore

/obj/structure/window/framed/almayer/aicore/hull
	name = "船体窗"
	desc = "为保护AI核心而设计的超强化窗户。采用特殊材料制成以防船体破损，任何东西都无法穿透。"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000 //Failsafe, shouldn't matter

/obj/structure/window/framed/almayer/aicore/white
	icon_state = "w_ai_rwindow0"
	basestate = "w_ai_rwindow"
	window_frame = /obj/structure/window_frame/almayer/aicore/white

/obj/structure/window/framed/almayer/aicore/black
	icon_state = "alm_ai_rwindow0"
	basestate = "alm_ai_rwindow"
	window_frame = /obj/structure/window_frame/almayer/aicore/black

/obj/structure/window/framed/almayer/aicore/hull/black
	icon_state = "alm_ai_rwindow0"
	basestate = "alm_ai_rwindow"
	window_frame = /obj/structure/window_frame/almayer/aicore/black
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000 //Failsafe, shouldn't matter

/obj/structure/window/framed/almayer/aicore/hull/black/hijack_bustable //I exist to explode after hijack, that is all.

/obj/structure/window/framed/almayer/aicore/hull/black/hijack_bustable/Initialize()
	. = ..()
	if(is_mainship_level(z))
		RegisterSignal(SSdcs, COMSIG_GLOB_HIJACK_IMPACTED, PROC_REF(deconstruct))

/obj/structure/window/framed/almayer/aicore/white/hull
	name = "船体窗"
	desc = "为保护AI核心而设计的超强化窗户。采用特殊材料制成以防船体破损，任何东西都无法穿透。"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000 //Failsafe, shouldn't matter

//Colony windows

/obj/structure/window/framed/colony
	name = "window"
	icon_state = "col_window0"
	basestate = "col_window"
	window_frame = /obj/structure/window_frame/colony

/obj/structure/window/framed/colony/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "col_rwindow0"
	basestate = "col_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/colony/reinforced

/obj/structure/window/framed/colony/reinforced/tinted
	name = "有色强化窗"
	desc = "墙框内嵌有特殊杆状矩阵的玻璃窗。看起来相当坚固。可能需要几次重击才能打碎它。这扇窗是不透明的。你有一种不安的感觉，似乎有人在另一侧窥视。"
	opacity = TRUE

/obj/structure/window/framed/colony/reinforced/hull
	name = "船体窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。这扇窗由特殊材料制成，以防止船体破裂。无法从这里通过。"
	//icon_state = "rwindow0_debug" //Uncomment to check hull in the map editor
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000 //Failsafe, shouldn't matter

//Yautja windows

/obj/structure/window/framed/colony/reinforced/yautja
	name = "异形强化窗"
	icon_state = "pred_window0"
	basestate = "pred_window"

/obj/structure/window/framed/colony/reinforced/hull/yautja
	name = "异形船体窗"
	icon_state = "pred_window0"
	basestate = "pred_window"

//Chigusa windows

/obj/structure/window/framed/chigusa
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "chig_rwindow0"
	basestate = "chig_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/chigusa

//Trijent Dam windows

/obj/structure/window/framed/hangar
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon_state = "hngr_window0"
	basestate = "hngr_window"
	health = 40
	window_frame = /obj/structure/window_frame/hangar

/obj/structure/window/framed/hangar/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "hngr_rwindow0"
	basestate = "hngr_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hangar/reinforced

/obj/structure/window/framed/bunker
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon_state = "bnkr_window0"
	basestate = "bnkr_window"
	health = 40
	window_frame = /obj/structure/window_frame/bunker

/obj/structure/window/framed/bunker/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "bnkr_rwindow0"
	basestate = "bnkr_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/bunker/reinforced

/obj/structure/window/framed/wood
	name = "window"
	icon_state = "wood_window0"
	basestate = "wood_window"
	window_frame = /obj/structure/window_frame/wood

/obj/structure/window/framed/wood/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	health = 100
	reinf = 1
	icon_state = "wood_rwindow0"
	basestate = "wood_rwindow"
	window_frame = /obj/structure/window_frame/wood/reinforced

//Sorokyne Strata windows

/obj/structure/window/framed/strata
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/strata_windows.dmi'
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 40
	window_frame = /obj/structure/window_frame/strata

/obj/structure/window/framed/strata/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/strata/reinforced

/obj/structure/window/framed/strata/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000

//Kutjevo Refinery windows

/obj/structure/window/framed/kutjevo
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/kutjevo/kutjevo_windows.dmi'
	icon_state = "kutjevo_window0"
	basestate = "kutjevo_window"
	health = 40
	window_frame = /obj/structure/window_frame/kutjevo

/obj/structure/window/framed/kutjevo/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。可见横杆。可能需要几次重击才能打碎它。"
	icon_state = "kutjevo_window_alt0"
	basestate = "kutjevo_window_alt"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/kutjevo/reinforced

/obj/structure/window/framed/kutjevo/reinforced/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	icon_state = "kutjevo_window_hull"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000

//Shivas Snowball (Ice v3) windows

/obj/structure/window/framed/shiva
	name = "聚凯夫纶框架窗"
	desc = "嵌在聚凯夫纶框架中的半透明材料板。非常易碎。"
	icon = 'icons/turf/walls/ice_colony/shiva_windows.dmi'
	icon_state = "shiva_window0"
	basestate = "shiva_window"
	health = 40
	window_frame = /obj/structure/window_frame/shiva

/obj/structure/window/framed/shiva/reinforced
	name = "强化聚凯夫纶框架窗"
	desc = "嵌在聚凯夫纶框架中的半透明材料板。可能需要几次重击才能打碎它。"
	icon_state = "shiva_window_r0"
	basestate = "shiva_window_r"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/shiva/reinforced

/obj/structure/window/framed/shiva/grey
	icon_state = "shiva_window_gr0"
	basestate = "shiva_window_gr"
	window_frame = /obj/structure/window_frame/shiva/grey

/obj/structure/window/framed/shiva/reinforced/grey
	icon_state = "shiva_window_gr_r0"
	basestate = "shiva_window_gr_r"
	window_frame = /obj/structure/window_frame/shiva/reinforced/grey

/obj/structure/window/framed/shiva/orange
	icon_state = "shiva_window_oj0"
	basestate = "shiva_window_oj"
	window_frame = /obj/structure/window_frame/shiva/orange

/obj/structure/window/framed/shiva/blue
	icon_state = "shiva_window_blu0"
	basestate = "shiva_window_blu"
	window_frame = /obj/structure/window_frame/shiva/blue

/obj/structure/window/framed/shiva/pink
	icon_state = "shiva_window_pnk0"
	basestate = "shiva_window_pnk"
	window_frame = /obj/structure/window_frame/shiva/pink

/obj/structure/window/framed/shiva/white
	icon_state = "shiva_window_wht0"
	basestate = "shiva_window_wht"
	window_frame = /obj/structure/window_frame/shiva/white

/obj/structure/window/framed/shiva/red
	icon_state = "shiva_window_red0"
	basestate = "shiva_window_red"
	window_frame = /obj/structure/window_frame/shiva/red

//Solaris Ridge windows

/obj/structure/window/framed/solaris
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/solaris/solaris_windows.dmi'
	icon_state = "solaris_window0"
	basestate = "solaris_window"
	health = 40
	window_frame = /obj/structure/window_frame/solaris

/obj/structure/window/framed/solaris/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。内部沿基座用几根强化矩阵杆加固。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "solaris_rwindow0"
	basestate = "solaris_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/solaris/reinforced

/obj/structure/window/framed/solaris/reinforced/tinted
	name = "有色强化窗"
	desc = "一扇有色玻璃窗。看起来相当坚固且不透明。可能需要几次重击才能打碎它。"
	opacity = TRUE

/obj/structure/window/framed/solaris/reinforced/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000

//Greybox development windows

/obj/structure/window/framed/dev
	name = "灰盒窗"
	desc = "墙框内的玻璃窗。就像在橙色盒子里一样！"
	icon = 'icons/turf/walls/dev/dev_windows.dmi'
	icon_state = "dev_window0"
	basestate = "dev_window"
	health = 40
	window_frame = /obj/structure/window_frame/dev

/obj/structure/window/framed/dev/reinforced
	name = "灰盒强化窗"
	desc = "强化墙框内的玻璃窗。就像在橙色盒子里一样！"
	icon_state = "dev_rwindow0"
	basestate = "dev_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/dev/reinforced

/obj/structure/window/framed/dev/reinforced/hull
	name = "灰盒船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000

//Prison windows

/obj/structure/window/framed/prison
	name = "window"
	icon_state = "prison_window0"
	basestate = "prison_window"
	window_frame = /obj/structure/window_frame/prison

/obj/structure/window/framed/prison/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	health = 100
	reinf = 1
	icon_state = "prison_rwindow0"
	basestate = "prison_rwindow"
	window_frame = /obj/structure/window_frame/prison/reinforced

/obj/structure/window/framed/prison/reinforced/hull
	name = "船体窗"
	desc = "墙框内嵌有特殊杆状矩阵的玻璃窗。此窗配有自动百叶系统，以防任何大气泄漏。"
	health = 200
	//icon_state = "rwindow0_debug" //Uncomment to check hull in the map editor
	var/triggered = FALSE //indicates if the shutters have already been triggered

/obj/structure/window/framed/prison/reinforced/hull/Destroy(force)
	if(force)
		return ..()
	spawn_shutters()
	. = ..()

/obj/structure/window/framed/prison/reinforced/hull/proc/spawn_shutters(from_dir = 0)
	if(triggered)
		return

	triggered = TRUE
	for(var/direction in GLOB.cardinals)
		if(direction == from_dir)
			continue //doesn't check backwards
		for(var/obj/structure/window/framed/prison/reinforced/hull/W in get_step(src,direction) )
			W.spawn_shutters(turn(direction,180))
	var/obj/structure/machinery/door/poddoor/shutters/almayer/pressure/pressure_door = new(get_turf(src))
	switch(junction)
		if(4,5,8,9,12)
			pressure_door.setDir(SOUTH)
		else
			pressure_door.setDir(EAST)
	pressure_door.close()

/obj/structure/window/framed/prison/cell
	name = "牢房窗户"
	desc = "墙框内嵌有特殊杆状矩阵的玻璃窗。"
	icon_state = "prison_cellwindow0"
	basestate = "prison_cellwindow"

//Corsat windows

/obj/structure/window/framed/corsat
	icon = 'icons/turf/walls/windows_corsat.dmi'
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	health = 100
	reinf = 1
	icon_state = "padded_rwindow0"
	basestate = "padded_rwindow"
	window_frame = /obj/structure/window_frame/corsat

/obj/structure/window/framed/corsat/research
	desc = "墙框内嵌有特殊杆状矩阵的紫色有色玻璃窗。看起来相当坚固。可能需要一些重击才能打碎它。"
	health = 200
	icon_state = "paddedresearch_rwindow0"
	basestate = "paddedresearch_rwindow"
	window_frame = /obj/structure/window_frame/corsat/research

/obj/structure/window/framed/corsat/security
	desc = "墙框内嵌有特殊杆状矩阵的红色有色玻璃窗。看起来非常坚固。"
	health = 300
	icon_state = "paddedsec_rwindow0"
	basestate = "paddedsec_rwindow"
	window_frame = /obj/structure/window_frame/corsat/security

/obj/structure/window/framed/corsat/cell
	name = "牢房窗户"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。这扇窗由特殊材料制成，以防止船体破裂。无法从这里通过。"
	icon_state = "padded_cellwindow0"
	basestate = "padded_cellwindow"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000 //Failsafe, shouldn't matter

/obj/structure/window/framed/corsat/cell/research
	icon_state = "paddedresearch_cellwindow0"
	basestate = "paddedresearch_cellwindow"

/obj/structure/window/framed/corsat/cell/security
	icon_state = "paddedsec_cellwindow0"
	basestate = "paddedsec_cellwindow"

/obj/structure/window/framed/corsat/hull
	name = "船体窗"
	desc = "墙框内嵌有特殊杆状矩阵的玻璃窗。此窗配有自动百叶系统，以防任何大气泄漏。"
	health = 200
	var/triggered = FALSE //indicates if the shutters have already been triggered

/obj/structure/window/framed/corsat/hull/research
	icon_state = "paddedresearch_rwindow0"
	basestate = "paddedresearch_rwindow"
	window_frame = /obj/structure/window_frame/corsat/research
	health = 300

/obj/structure/window/framed/corsat/hull/security
	icon_state = "paddedsec_rwindow0"
	basestate = "paddedsec_rwindow"
	window_frame = /obj/structure/window_frame/corsat/security
	health = 400

/obj/structure/window/framed/corsat/hull/Destroy(force)
	if(force)
		return ..()

	spawn_shutters()
	. = ..()

/obj/structure/window/framed/corsat/hull/proc/spawn_shutters(from_dir = 0)
	if(triggered)
		return

	triggered = 1
	for(var/direction in GLOB.cardinals)
		if(direction == from_dir)
			continue //doesn't check backwards

		for(var/obj/structure/window/framed/corsat/hull/W in get_step(src,direction) )
			W.spawn_shutters(turn(direction,180))

	var/obj/structure/machinery/door/poddoor/shutters/almayer/pressure/pressure_door = new(get_turf(src))
	switch(junction)
		if(4,5,8,9,12)
			pressure_door.setDir(SOUTH)
		else
			pressure_door.setDir(EAST)

	INVOKE_ASYNC(pressure_door, TYPE_PROC_REF(/obj/structure/machinery/door, close))

/obj/structure/window/framed/corsat/indestructible/
	name = "船体窗"
	desc = "墙框内嵌有特殊杆状矩阵的玻璃窗。此窗经过强化，几乎能承受宇宙中任何冲击。"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000

/obj/structure/window/framed/corsat/indestructible/research
	icon_state = "paddedresearch_rwindow0"
	basestate = "paddedresearch_rwindow"
	window_frame = /obj/structure/window_frame/corsat/research

/obj/structure/window/framed/corsat/indestructible/security
	icon_state = "paddedsec_rwindow0"
	basestate = "paddedsec_rwindow"
	window_frame = /obj/structure/window_frame/corsat/security

//UPP windows

/obj/structure/window/framed/upp_ship
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/upp_windows.dmi'
	icon_state = "uppwall_window0"
	basestate = "uppwall_window"
	health = 40
	window_frame = /obj/structure/window_frame/upp_ship

/obj/structure/window/framed/upp_ship/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/upp_ship/reinforced

/obj/structure/window/framed/upp_ship/hull
	name = "船体窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。这扇窗由特殊材料制成，以防止船体破裂。无法从这里通过。"
	//	icon_state = "upp_rwindow0"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/upp_ship/hull

//UPP Almayer retexture windows

/obj/structure/window/framed/upp
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/upp_almayer_windows.dmi'
	icon_state = "upp_window0"
	basestate = "upp_window"
	health = 40
	window_frame = /obj/structure/window_frame/upp

/obj/structure/window/framed/upp/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "upp_rwindow0"
	basestate = "upp_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/upp/reinforced

/obj/structure/window/framed/upp/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	//	icon_state = "upp_rwindow0"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/upp/hull

// Hybrisa windows

// Colony
/obj/structure/window/framed/hybrisa/colony
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/hybrisa_colony_window.dmi'
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 15
	window_frame = /obj/structure/window_frame/hybrisa/colony

/obj/structure/window/framed/hybrisa/colony/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hybrisa/colony/reinforced

/obj/structure/window/framed/hybrisa/colony/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/hybrisa/colony/hull

// Research
/obj/structure/window/framed/hybrisa/research
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/hybrisaresearchbrown_windows.dmi'
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 15
	window_frame = /obj/structure/window_frame/hybrisa/research

/obj/structure/window/framed/hybrisa/research/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hybrisa/research/reinforced

/obj/structure/window/framed/hybrisa/research/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/hybrisa/research/hull

// Marshalls
/obj/structure/window/framed/hybrisa/marshalls
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/hybrisa_marshalls_windows.dmi'
	icon_state = "prison_window0"
	basestate = "prison_window"
	health = 15
	window_frame = /obj/structure/window_frame/hybrisa/marshalls

/obj/structure/window/framed/hybrisa/marshalls/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "prison_rwindow0"
	basestate = "prison_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hybrisa/marshalls/reinforced

/obj/structure/window/framed/hybrisa/marshalls/cell
	name = "牢房窗户"
	desc = "墙框内嵌有特殊杆状矩阵的玻璃窗。"
	icon_state = "prison_cellwindow0"
	basestate = "prison_cellwindow"
	health = 100

// Hospital
/obj/structure/window/framed/hybrisa/colony/hospital
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/hybrisa_hospital_colonywindows.dmi'
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 15
	window_frame = /obj/structure/window_frame/hybrisa/colony/hospital

/obj/structure/window/framed/hybrisa/colony/hospital/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hybrisa/colony/hospital/reinforced

/obj/structure/window/framed/hybrisa/colony/hospital/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/hybrisa/colony/hospital/hull

// Offices
/obj/structure/window/framed/hybrisa/colony/office
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/hybrisa_offices_windows.dmi'
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 15
	window_frame = /obj/structure/window_frame/hybrisa/colony/office

/obj/structure/window/framed/hybrisa/colony/office/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hybrisa/colony/office/reinforced

/obj/structure/window/framed/hybrisa/colony/office/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/hybrisa/colony/office/hull

// Engineering
/obj/structure/window/framed/hybrisa/colony/engineering
	name = "window"
	desc = "墙框内的玻璃窗。"
	icon = 'icons/turf/walls/hybrisa_engineering_windows.dmi'
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 15
	window_frame = /obj/structure/window_frame/hybrisa/colony/engineering

/obj/structure/window/framed/hybrisa/colony/engineering/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗。透过它看时光线折射异常。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hybrisa/colony/engineering/reinforced

/obj/structure/window/framed/hybrisa/colony/engineering/hull
	name = "船体窗"
	desc = "一扇玻璃窗。某种直觉告诉你这扇窗坚不可摧。"
	icon_state = "strata_window0"
	basestate = "strata_window"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/hybrisa/colony/engineering/hull

// Space-Port
/obj/structure/window/framed/hybrisa/spaceport
	name = "window"
	icon = 'icons/turf/walls/hybrisa_spaceport_windows.dmi'
	icon_state = "prison_window0"
	basestate = "prison_window"
	window_frame = /obj/structure/window_frame/hybrisa/spaceport
	health = 15

/obj/structure/window/framed/hybrisa/spaceport/reinforced
	name = "强化窗"
	desc = "一扇玻璃窗，在墙框内带有特殊的杆状矩阵。看起来相当坚固。可能需要几次重击才能打碎它。"
	icon_state = "prison_rwindow0"
	basestate = "prison_rwindow"
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/hybrisa/spaceport/reinforced

/obj/structure/window/framed/hybrisa/spaceport/cell
	name = "window"
	desc = "墙框内嵌有特殊杆状矩阵的玻璃窗。"
	icon_state = "prison_cellwindow0"
	basestate = "prison_cellwindow"
	health = 100
