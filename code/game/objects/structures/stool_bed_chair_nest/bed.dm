/*
 * Contains:
 * Beds
 * Roller beds
 */

/*
 * Beds
 */
/obj/structure/bed
	name = "bed"
	desc = "一个放置在矩形金属框架上的床垫。用于以舒适的方式支撑躺卧的人，尤其适用于常规睡眠。古老的技术，但依然有用。"
	icon_state = "bed"
	icon = 'icons/obj/structures/props/furniture/chairs.dmi'
	can_buckle = TRUE
	buckle_lying = 90
	throwpass = TRUE
	debris = list(/obj/item/stack/sheet/metal)
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 1
	var/foldabletype //To fold into an item (e.g. roller bed item)
	var/buckling_y = 0 //pixel y shift to give to the buckled mob.
	var/buckling_x = 0 //pixel x shift to give to the buckled mob.
	///if the bed can carry big mobs (tier 3s)
	var/can_carry_big = FALSE
	var/obj/structure/closet/bodybag/buckled_bodybag
	var/accepts_bodybag = FALSE //Whether you can buckle bodybags to this bed
	var/base_bed_icon //Used by beds that change sprite when something is buckled to them
	var/hit_bed_sound = 'sound/effects/metalhit.ogg' //sound player when attacked by a xeno
	/// Sound when buckled to a bed/chair/stool
	var/buckling_sound = 'sound/effects/buckle.ogg'
	surgery_duration_multiplier = SURGERY_SURFACE_MULT_UNSUITED

/obj/structure/bed/initialize_pass_flags(datum/pass_flags_container/PF)
	if(PF)
		PF.flags_can_pass_all = PASS_OVER|PASS_AROUND|PASS_UNDER

/obj/structure/bed/update_icon()
	if(base_bed_icon)
		if(buckled_mob || buckled_bodybag)
			icon_state = "[base_bed_icon]_up"
		else
			icon_state = "[base_bed_icon]_down"

/obj/structure/bed/Destroy()
	if(buckled_bodybag)
		unbuckle()
	. = ..()

/obj/structure/bed/ex_act(power)
	if(power >= EXPLOSION_THRESHOLD_VLOW)
		deconstruct(FALSE)

/obj/structure/bed/deconstruct(disassembled = TRUE)
	if(!disassembled)
		if(!isnull(buildstacktype) && buildstackamount)
			new buildstacktype(get_turf(src), buildstackamount)
	return ..()

/obj/structure/bed/afterbuckle(mob/M)
	. = ..()
	if(. && buckled_mob == M)
		M.pixel_y = buckling_y
		M.old_y = buckling_y
		M.pixel_x = buckling_x
		M.old_x = buckling_x
		if(base_bed_icon)
			density = TRUE
	else
		M.pixel_y = initial(buckled_mob.pixel_y)
		M.old_y = initial(buckled_mob.pixel_y)
		M.pixel_x = initial(buckled_mob.pixel_x)
		M.old_x = initial(buckled_mob.pixel_x)
		if(base_bed_icon)
			density = FALSE

	update_icon()

//Unsafe proc
/obj/structure/bed/proc/do_buckle_bodybag(obj/structure/closet/bodybag/B, mob/user)
	B.visible_message(SPAN_NOTICE("[user]将[B]扣在[src]上！"))
	B.roller_buckled = src
	B.forceMove(loc)
	B.setDir(dir)
	buckled_bodybag = B
	density = TRUE
	update_icon()
	if(buckling_y)
		buckled_bodybag.pixel_y = buckled_bodybag.buckle_offset + buckling_y
	add_fingerprint(user)
	var/mob/living/carbon/human/contained_mob = locate() in B.contents
	if(contained_mob)
		SEND_SIGNAL(src, COMSIG_LIVING_BED_BUCKLED, contained_mob)

/obj/structure/bed/unbuckle()
	if(buckled_bodybag)
		buckled_bodybag.pixel_y = initial(buckled_bodybag.pixel_y)
		buckled_bodybag.roller_buckled = null
		buckled_bodybag = null
		density = FALSE
		update_icon()
	else
		..()

/obj/structure/bed/manual_unbuckle(mob/user)
	if(buckled_bodybag)
		unbuckle()
		add_fingerprint(user)
		return 1
	else
		. = ..()

//Trying to buckle a mob
/obj/structure/bed/buckle_mob(mob/living/carbon/human/mob, mob/user)
	if(buckled_bodybag)
		return
	if(ishuman(mob))
		if(MODE_HAS_MODIFIER(/datum/gamemode_modifier/disable_stripdrag_enemy) && (mob.stat == DEAD || mob.health < mob.health_threshold_crit) && !mob.get_target_lock(user.faction_group) && !(mob.status_flags & PERMANENTLY_DEAD))
			to_chat(user, SPAN_WARNING("你不能扣住其他派系的危急或死亡成员！"))
			return FALSE
	..()
	if(mob.loc == src.loc && buckling_sound && mob.buckled)
		playsound(src, buckling_sound, 20)
		SEND_SIGNAL(src, COMSIG_LIVING_BED_BUCKLED, mob)

/obj/structure/bed/Move(NewLoc, direct)
	. = ..()
	if(. && buckled_bodybag && !handle_buckled_bodybag_movement(loc,direct)) //Movement fails if buckled mob's move fails.
		return 0

/obj/structure/bed/proc/handle_buckled_bodybag_movement(NewLoc, direct)
	if(!(direct & (direct - 1))) //Not diagonal move. the obj's diagonal move is split into two cardinal moves and those moves will handle the buckled bodybag's movement.
		if(!buckled_bodybag.Move(NewLoc, direct))
			forceMove(buckled_bodybag.loc)
			last_move_dir = buckled_bodybag.last_move_dir
			return 0
	return 1

/obj/structure/bed/roller/BlockedPassDirs(atom/movable/mover, target_dir)
	if(mover == buckled_bodybag)
		return NO_BLOCKED_MOVEMENT
	return ..()

/obj/structure/bed/MouseDrop_T(atom/dropping, mob/user)
	if(accepts_bodybag && !buckled_bodybag && !buckled_mob && istype(dropping,/obj/structure/closet/bodybag) && ishuman(user))
		if(!isturf(user.loc)) // so they do not buckle themselves
			return
		var/obj/structure/closet/bodybag/B = dropping
		if(!B.roller_buckled)
			do_buckle_bodybag(B, user)
			return TRUE
	else
		. = ..()

/obj/structure/bed/MouseDrop(atom/over_object)
	. = ..()
	if(foldabletype && !buckled_mob && !buckled_bodybag)
		if (istype(over_object, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = over_object
			if (H==usr && !H.is_mob_incapacitated() && Adjacent(H) && in_range(src, over_object))
				var/obj/item/I = new foldabletype(get_turf(src))
				H.put_in_hands(I)
				H.visible_message(SPAN_WARNING("[H]从地上抓起了[src]！"),
				SPAN_WARNING("You grab [src] from the floor!"))
				qdel(src)


/obj/structure/bed/attackby(obj/item/W, mob/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		if(buildstacktype)
			playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
			new buildstacktype(loc, buildstackamount)
			qdel(src)

	else if(istype(W, /obj/item/grab) && !buckled_mob)
		var/obj/item/grab/G = W
		if(ismob(G.grabbed_thing))
			var/mob/M = G.grabbed_thing
			var/atom/blocker = LinkBlocked(user, user.loc, loc)
			if(!Adjacent(M))
				visible_message(SPAN_DANGER("[M]距离太远，无法放到[src]上。"))
				return FALSE
			if(blocker)
				to_chat(user, SPAN_WARNING("\The [blocker] is in the way!"))
				return FALSE
			to_chat(user, SPAN_NOTICE("你将[M]放在[src]上。"))
			M.forceMove(loc)
		return TRUE

	else
		. = ..()

/obj/structure/bed/alien
	icon_state = "abed"

/obj/structure/bed/alien/yautja
	icon_state = "abed"
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'

/obj/structure/bed/alien/yautja/leader
	icon_state = "bed"

/*
 * Roller beds
 */
/obj/structure/bed/roller
	name = "滚轮床"
	desc = "一个放置在小框架上的基本软垫皮革板。一点也不舒服，但能让病人在被快速转移到另一地点时躺下休息。不适合手术，但总比没有强。"
	icon = 'icons/obj/structures/rollerbed.dmi'
	icon_state = "roller_down"
	anchored = FALSE
	drag_delay = 0 //Pulling something on wheels is easy
	buckling_y = 3
	foldabletype = /obj/item/roller
	accepts_bodybag = TRUE
	base_bed_icon = "roller"

/obj/structure/bed/roller/Initialize(mapload, ...)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_PREBUCKLE, PROC_REF(check_buckle))

/obj/structure/bed/roller/MouseDrop(atom/over_object)
	if(foldabletype && !buckled_mob && !buckled_bodybag)
		var/mob/living/carbon/human/user = over_object
		if(!length(contents))
			new foldabletype(src)
		var/obj/item/roller/rollerholder = locate(foldabletype) in contents
		if (!istype(over_object, /mob/living/carbon/human))
			return
		if (user == usr && !user.is_mob_incapacitated() && Adjacent(user) && in_range(src, over_object))
			user.put_in_hands(rollerholder)
			user.visible_message(SPAN_INFO("[user]从地上抓起了[src]！"),
			SPAN_INFO("You grab [src] from the floor!"))
			forceMove(rollerholder)

/obj/structure/bed/roller/buckle_mob(mob/mob, mob/user)
	if(iscarbon(mob))
		var/mob/living/carbon/target_mob = mob
		if(target_mob.handcuffed)
			to_chat(user, SPAN_DANGER("你不能将戴着手铐的人扣在这张床上。"))
			return
	..()

/// Signal handler for COMSIG_MOVABLE_PREBUCKLE to potentially block buckling.
/obj/structure/bed/roller/proc/check_buckle(obj/bed, mob/buckle_target, mob/user)
	SIGNAL_HANDLER

	if(buckle_target.mob_size <= MOB_SIZE_XENO)
		if(buckle_target.stat == DEAD || HAS_TRAIT(buckle_target, TRAIT_OPPOSABLE_THUMBS))
			return

	if(buckle_target.mob_size > MOB_SIZE_HUMAN)
		if(!can_carry_big)
			to_chat(user, SPAN_WARNING("[buckle_target]体型太大，无法扣入。"))
			return COMPONENT_BLOCK_BUCKLE
		if(buckle_target.stat != DEAD)
			to_chat(user, SPAN_WARNING("[buckle_target]抵抗了你的固定尝试！"))
			return COMPONENT_BLOCK_BUCKLE

/obj/structure/bed/roller/Collided(atom/movable/moving_atom)
	if(!isxeno(moving_atom))
		return ..()

	if(buckled_mob && buckled_mob.stat != DEAD)
		return ..()

	if(buckled_bodybag)
		var/mob/mob_in_bodybag = locate(/mob) in buckled_bodybag
		if(mob_in_bodybag && mob_in_bodybag.stat != DEAD)
			return ..()

	return

/obj/structure/bed/roller/heavy
	name = "重型滚轮床"
	desc = "一个放置在小而坚固框架上的强化塑钢板。一点也不舒服，但能让重型货物在被快速转移到另一地点时躺下。无法折叠。"
	icon = 'icons/obj/structures/rollerbed.dmi'
	icon_state = "heavy_roller_up"
	anchored = FALSE
	drag_delay = 0 //Pulling something on wheels is easy
	buckling_y = 3
	foldabletype = null
	accepts_bodybag = TRUE
	base_bed_icon = null
	density = TRUE
	buildstacktype = /obj/item/stack/sheet/plasteel
	can_carry_big = TRUE

/obj/item/roller
	name = "滚轮床"
	desc = "一个可以随身携带的折叠滚轮床。"
	icon = 'icons/obj/structures/rollerbed.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "folded"
	item_state = "rbed"
	w_class = SIZE_SMALL //Fits in a backpack
	drag_delay = 1 //Pulling something on wheels is easy
	matter = list("plastic" = 5000)
	var/rollertype = /obj/structure/bed/roller

/obj/item/roller/attack_self(mob/user)
	..()
	deploy_roller(user, user.loc)

/// Handles the switch between a item/roller to a structure/bed/roller, and storing one within the other when not in use
/obj/item/roller/proc/deploy_roller(mob/user, atom/location, mob/target_mob)
	if(!length(contents))
		new rollertype(src)
	var/obj/structure/bed/roller/roller = locate(rollertype) in contents
	roller.forceMove(location)
	to_chat(user, SPAN_NOTICE("你部署了[roller]。"))
	roller.add_fingerprint(user)
	user.temp_drop_inv_item(src)
	forceMove(roller)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_ROLLER_DEPLOYED, roller)
	if(target_mob)
		roller.buckle_mob(target_mob, user)

/obj/item/roller/afterattack(obj/target, mob/user, proximity)
	if(!proximity)
		return
	if(ismob(target))
		var/turf/target_turf = get_turf(target)
		if(!target_turf.density)
			deploy_roller(user, target_turf, target)
	if(isturf(target))
		var/turf/T = target
		if(!T.density)
			deploy_roller(user, target)

//////////////////////////////////////////////
// PORTABLE SURGICAL BED //
//////////////////////////////////////////////

/obj/structure/bed/portable_surgery
	name = "便携式手术床"
	desc = "一张可折叠的手术床。它并不完美，但这是你在没有真正手术台的情况下能得到的最好选择。"
	icon = 'icons/obj/structures/rollerbed.dmi'
	icon_state = "surgical_down"
	buckling_y = 2
	foldabletype = /obj/item/roller/surgical
	base_bed_icon = "surgical"
	accepts_bodybag = FALSE
	surgery_duration_multiplier = SURGERY_SURFACE_MULT_ADEQUATE

/obj/item/roller/surgical
	name = "便携式手术床"
	desc = "一个可以随身携带的折叠手术床。"
	icon_state = "surgical_folded"
	item_state = "sbed"
	rollertype = /obj/structure/bed/portable_surgery
	matter = list("plastic" = 6000)

////////////////////////////////////////////
			//MEDEVAC STRETCHER
//////////////////////////////////////////////

//List of all activated medevac stretchers
GLOBAL_LIST_EMPTY(activated_medevac_stretchers)

/obj/structure/bed/medevac_stretcher
	name = "医疗后送担架"
	desc = "一个带有集成信标的医疗后送担架，用于通过运输机升降装置快速撤离受伤病人。可接收病人和尸袋。完全不适合手术。"
	icon = 'icons/obj/structures/rollerbed.dmi'
	icon_state = "stretcher_down"
	buckling_y = -1
	foldabletype = /obj/item/roller/medevac
	base_bed_icon = "stretcher"
	accepts_bodybag = TRUE
	var/stretcher_activated
	var/view_range = 5
	/// Allows Medevac beds to act like they're working, but not interact with the Medevac system itself. Set prop variable to TRUE when you'd like to bypass regular functions on a Medevac bed
	var/prop
	var/obj/structure/dropship_equipment/medevac_system/linked_medevac
	surgery_duration_multiplier = SURGERY_SURFACE_MULT_AWFUL //On the one hand, it's a big stretcher. On the other hand, you have a big sheet covering the patient and those damned Fulton hookups everywhere.
	var/faction = FACTION_MARINE

/obj/structure/bed/medevac_stretcher/upp
	name = "UPP医疗后送担架"
	faction = FACTION_UPP

/obj/structure/bed/medevac_stretcher/prop
	prop = TRUE
	foldabletype = null
	stretcher_activated = TRUE

/obj/structure/bed/medevac_stretcher/Destroy()
	if(stretcher_activated)
		stretcher_activated = FALSE
		GLOB.activated_medevac_stretchers -= src
		if(linked_medevac)
			linked_medevac.linked_stretcher = null
			linked_medevac = null
		update_icon()
	. = ..()

/obj/structure/bed/medevac_stretcher/update_icon()
	..()
	overlays.Cut()
	if(stretcher_activated)
		overlays += image("beacon_active_[density ? "up":"down"]")

	if(buckled_mob || buckled_bodybag)
		overlays += image("icon_state"="stretcher_box","layer"=LYING_LIVING_MOB_LAYER + 0.1)

/obj/structure/bed/medevac_stretcher/verb/toggle_medevac_beacon_verb()
	set name = "Toggle medevac"
	set desc = "Toggle the medevac beacon inside the stretcher."
	set category = "Object"
	set src in oview(1)

	toggle_medevac_beacon(usr)

// Used to pretend to be a camera
/obj/structure/bed/medevac_stretcher/proc/can_use()
	return TRUE

// Used to pretend to be a camera
/obj/structure/bed/medevac_stretcher/proc/isXRay()
	return FALSE

/obj/structure/bed/medevac_stretcher/proc/toggle_medevac_beacon(mob/user)
	if(!ishuman(user))
		return

	if(!skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
		to_chat(user, SPAN_WARNING("你不知道如何使用[src]。"))
		return

	if(user == buckled_mob)
		to_chat(user, SPAN_WARNING("当你被扣在[src]上时，无法够到信标激活按钮。"))
		return

	if(prop)
		to_chat(user, SPAN_NOTICE("[src]的信标被锁定在[stretcher_activated ? "on" : "off"] position."))
		return

	if(stretcher_activated)
		stretcher_activated = FALSE
		GLOB.activated_medevac_stretchers -= src
		if(linked_medevac)
			linked_medevac.linked_stretcher = null
			linked_medevac = null
		to_chat(user, SPAN_NOTICE("你关闭了[src]的信标。"))
		update_icon()

	else
		if(!is_ground_level(z))
			to_chat(user, SPAN_WARNING("你无法在此处激活[src]的信标。"))
			return

		var/area/AR = get_area(src)
		if(CEILING_IS_PROTECTED(AR.ceiling, CEILING_PROTECTION_TIER_1))
			to_chat(user, SPAN_WARNING("[src]必须位于开阔地带或玻璃屋顶下。"))
			return

		stretcher_activated = TRUE
		GLOB.activated_medevac_stretchers += src
		to_chat(user, SPAN_NOTICE("你激活了[src]的信标。"))
		update_icon()

/obj/item/roller/medevac
	name = "医疗后送担架"
	desc = "一个可折叠携带的医疗后送担架。"
	icon_state = "stretcher_folded"
	item_state = "mvbed"
	rollertype = /obj/structure/bed/medevac_stretcher
	matter = list("plastic" = 5000, "metal" = 5000)

/obj/item/roller/medevac/deploy_roller(mob/user, atom/location)
	var/obj/structure/bed/medevac_stretcher/medevac_stretcher = new rollertype(location)
	medevac_stretcher.add_fingerprint(user)
	user.temp_drop_inv_item(src)
	qdel(src)
	medevac_stretcher.toggle_medevac_beacon(user)

//bedroll
/obj/structure/bed/bedroll
	name = "展开的铺盖卷"
	desc = "在那些漫长任务中无处可睡时，你至少记得带上一样能带来舒适的东西。"
	icon = 'icons/obj/structures/rollerbed.dmi'
	icon_state = "bedroll_o"
	buckling_y = 0
	foldabletype = /obj/item/roller/bedroll
	accepts_bodybag = FALSE
	debris = null
	buildstacktype = null

/obj/item/roller/bedroll
	name = "折叠的铺盖卷"
	desc = "USCMC标准配发铺盖卷，其服役时间和你记忆一样久。标签上写着休息前需展开，但谁在乎规定呢，对吧？"
	icon_state = "bedroll"
	rollertype = /obj/structure/bed/bedroll

/obj/structure/bed/bedroll/comfy
	name = "展开的舒适铺盖卷"
	desc = "一张舒适到在三个星区因导致过度打盹而被视为非法的铺盖卷。"
	icon_state = "bedroll_comfy_o"
	foldabletype = /obj/item/roller/bedroll/comfy

/obj/item/roller/bedroll/comfy
	name = "折叠的舒适铺盖卷"
	desc = "折叠起来人畜无害——但别被骗了。它在三个星区因导致过度打盹而被视为非法。"
	icon_state = "bedroll_comfy"
	rollertype = /obj/structure/bed/bedroll/comfy

/obj/structure/bed/bedroll/comfy/blue
	color = "#8cb9e2"
	foldabletype = /obj/item/roller/bedroll/comfy/blue

/obj/item/roller/bedroll/comfy/blue
	color = "#8cb9e2"
	rollertype = /obj/structure/bed/bedroll/comfy/blue

/obj/structure/bed/bedroll/comfy/red
	color = "#df4f4f"
	foldabletype = /obj/item/roller/bedroll/comfy/red

/obj/item/roller/bedroll/comfy/red
	color = "#df4f4f"
	rollertype = /obj/structure/bed/bedroll/comfy/red

/obj/structure/bed/bedroll/comfy/pink
	color = "#eaa8b2"
	foldabletype = /obj/item/roller/bedroll/comfy/pink

/obj/item/roller/bedroll/comfy/pink
	color = "#eaa8b2"
	rollertype = /obj/structure/bed/bedroll/comfy/pink

/obj/structure/bed/bedroll/comfy/green
	color = "#b3e290"
	foldabletype = /obj/item/roller/bedroll/comfy/green

/obj/item/roller/bedroll/comfy/green
	color = "#b3e290"
	rollertype = /obj/structure/bed/bedroll/comfy/green

/obj/structure/bed/bedroll/comfy/yellow
	color = "#e2df90"
	foldabletype = /obj/item/roller/bedroll/comfy/yellow

/obj/item/roller/bedroll/comfy/yellow
	color = "#e2df90"
	rollertype = /obj/structure/bed/bedroll/comfy/yellow

//Hospital Rollers (non foldable)

/obj/structure/bed/roller/hospital
	name = "病床"
	icon = 'icons/obj/structures/rollerbed.dmi'
	icon_state = "bigrollerempty_up"
	foldabletype = null
	base_bed_icon = "bigrollerempty"

	var/body_icon_state = "bigroller"
	var/raised_with_body = TRUE
	var/mob/living/carbon/human/body
	var/datum/equipment_preset/body_preset = /datum/equipment_preset/corpse/hybrisa/civilian

/obj/structure/bed/roller/hospital/Initialize(mapload, ...)
	. = ..()
	if(SSticker.current_state >= GAME_STATE_PLAYING)
		create_body()
	else
		RegisterSignal(SSdcs, COMSIG_GLOB_MODE_POSTSETUP, PROC_REF(create_body))

/obj/structure/bed/roller/hospital/Destroy()
	if(body)
		QDEL_NULL(body)
	return ..()

/obj/structure/bed/roller/hospital/attackby()
	if(body)
		return
	..()

/obj/structure/bed/roller/hospital/attack_hand()
	if(body)
		if(raised_with_body)
			raised_with_body = FALSE
			update_icon()
			return
		else
			dump_body()
			update_icon()
			return
	..()

/obj/structure/bed/roller/hospital/update_icon()
	overlays.Cut()
	if(body)
		icon_state = body_icon_state + "body"
		if(raised_with_body)
			icon_state = icon_state + "_up"
		else
			icon_state = icon_state + "_down"
	else
		..()

/obj/structure/bed/roller/hospital/MouseDrop_T(atom/dropping, mob/user)
	if(body)
		return
	..()

/obj/structure/bed/roller/hospital/proc/create_body()
	SIGNAL_HANDLER
	body = new(loc)
	body.create_hud()
	contents += body
	arm_equipment(body, body_preset, TRUE, FALSE)
	body.death(create_cause_data("exposure"))
	update_icon()

/obj/structure/bed/roller/hospital/proc/dump_body()
	var/turf/dump_turf = get_turf(src)
	body.forceMove(dump_turf)
	contents -= body
	body = null

/obj/structure/bed/roller/hospital/attack_alien(mob/living/carbon/xenomorph/user)
	if(user.a_intent == INTENT_HARM && body)
		dump_body()
	return ..()

/obj/structure/bed/roller/hospital/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(body)
		dump_body()
	return ..()

/obj/structure/bed/roller/hospital/bloody
	base_bed_icon = "bigrollerbloodempty"
	body_icon_state = "bigrollerblood"
	body_preset = /datum/equipment_preset/corpse/hybrisa/civilian/burst

/obj/structure/bed/roller/hospital_empty
	icon_state = "bigrollerempty2_down"
	foldabletype = null
/obj/structure/bed/roller/hospital_empty/bigrollerempty
	icon_state = "bigrollerempty_down"
	buckling_y = 2
	base_bed_icon = "bigrollerempty"
/obj/structure/bed/roller/hospital_empty/bigrollerempty2
	icon_state = "bigrollerempty2_down"
	buckling_y = 2
	base_bed_icon = "bigrollerempty2"
/obj/structure/bed/roller/hospital_empty/bigrollerempty3
	icon_state = "bigrollerempty3_down"
	buckling_y = 2
	base_bed_icon = "bigrollerempty3"
/obj/structure/bed/roller/hospital_empty/bigrollerbloodempty
	icon_state = "bigrollerbloodempty_down"
	buckling_y = 2
	base_bed_icon = "bigrollerbloodempty"

// Hospital divider (not a bed)
/obj/structure/bed/hybrisa/hospital/hospitaldivider
	name = "医用隔帘"
	desc = "用于保护隐私的医用隔帘。"
	icon = 'icons/obj/structures/props/curtain.dmi'
	icon_state = "hospitalcurtain"
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	can_buckle = FALSE
	hit_bed_sound = 'sound/effects/thud.ogg'
