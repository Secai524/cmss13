/obj/item/storage/box/implant
	name = "植入体盒"
	desc = "一个存放皮下植入注射器的无菌金属锁盒。"
	icon = 'icons/obj/items/storage/kits.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/briefcases_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/briefcases_righthand.dmi',
	)
	icon_state = "implantbox"
	use_sound = "toolbox"
	storage_slots = 5
	can_hold = list(/obj/item/device/implanter)
	w_class = SIZE_SMALL


/obj/item/storage/box/implant/picker
	desc = "一个装有制造皮下植入注射器打印机的无菌金属锁盒。"
	foldable = FALSE
	storage_slots = 2
	var/picks_left = 2
	var/list/pickable = list(
		"Nightvision Implant" = /obj/item/device/implanter/nvg,
		"Rejuvenation Implant" = /obj/item/device/implanter/rejuv,
		"Agility Implant" = /obj/item/device/implanter/agility,
		"Subdermal Armor" = /obj/item/device/implanter/subdermal_armor
	)

/obj/item/storage/box/implant/picker/open(mob/user)
	select_implants(user)
	return ..()

/obj/item/storage/box/implant/picker/attack_self(mob/user)
	select_implants(user)
	return ..()

/obj/item/storage/box/implant/picker/proc/select_implants(mob/user)
	while(picks_left)
		if(!length(pickable))
			picks_left = 0
			break
		var/list/options = list()
		for(var/name in pickable)
			options += name
		var/choice = tgui_input_list(usr, "选择你的植入体", "Implants Select", options)
		if(!choice || !(choice in pickable))
			return
		picks_left--
		var/path = pickable[choice]
		pickable -= choice
		new path(src)
		stoplag()

/obj/item/device/implanter
	name = "implanter"
	desc = "一种将植入体注入你体内的注射器。注射过程相当刺痛。"
	icon = 'icons/obj/items/syringe.dmi'
	icon_state = "implanter"

	w_class = SIZE_SMALL

	var/implant_type
	var/uses = 1
	var/implant_time = 3 SECONDS
	var/implant_string = "Awesome."

/obj/item/device/implanter/update_icon()
	if(!uses)
		icon_state = "[initial(icon_state)]0"
		return

	icon_state = initial(icon_state)

/obj/item/device/implanter/attack(mob/living/M, mob/living/user)
	if(!uses || !implant_type)
		return ..()

	if(LAZYISIN(M.implants, implant_type))
		to_chat(user, SPAN_WARNING("[M]已拥有此植入体！"))
		return

	if(LAZYLEN(M.implants) >= M.max_implants)
		to_chat(user, SPAN_WARNING("[M]无法接受更多植入体！"))
		return

	var/self_inject = TRUE
	if(M != user)
		self_inject = FALSE
		if(!do_after(user, implant_time, INTERRUPT_ALL, BUSY_ICON_GENERIC, M, INTERRUPT_MOVED, BUSY_ICON_GENERIC))
			return

	implant(M, self_inject)

/obj/item/device/implanter/attack_self(mob/user)
	..()
	implant(user, TRUE)

/obj/item/device/implanter/proc/implant(mob/M, self_inject)
	if(uses <= 0)
		return

	if(LAZYISIN(M.implants, implant_type))
		QDEL_NULL(M.implants[implant_type])

	if(self_inject)
		to_chat(M, SPAN_NOTICE("你为自己植入了\the [src]。你感觉[implant_string]"))
	else
		to_chat(M, SPAN_NOTICE("你已被植入\the [src]。你感觉[implant_string]"))

	playsound(src, 'sound/items/air_release.ogg', 75, TRUE)
	var/obj/item/device/internal_implant/I = new implant_type(M)
	LAZYSET(M.implants, implant_type, I)
	I.on_implanted(M)
	uses = max(uses - 1, 0)
	if(!uses)
		garbage = TRUE
	update_icon()

/obj/item/device/internal_implant
	name = "implant"
	desc = "一种植入体，通常通过植入器输送。"
	icon_state = "implant"

	var/mob/living/host

/obj/item/device/internal_implant/proc/on_implanted(mob/living/M)
	SHOULD_CALL_PARENT(TRUE)
	host = M

/obj/item/device/internal_implant/Destroy()
	host = null
	return ..()

/obj/item/device/implanter/nvg
	name = "夜视植入体"
	desc = "此植入体将赋予你夜视能力。这些植入体在死亡时会损坏。"
	implant_type = /obj/item/device/internal_implant/nvg
	implant_string = "your pupils dilating to unsettling levels."

/obj/item/device/internal_implant/nvg
	var/implant_health = 2

/obj/item/device/internal_implant/nvg/on_implanted(mob/living/M)
	. = ..()
	RegisterSignal(M, COMSIG_HUMAN_POST_UPDATE_SIGHT, PROC_REF(give_nvg))
	RegisterSignal(M, COMSIG_MOB_DEATH, PROC_REF(remove_health))
	give_nvg(M)

/obj/item/device/internal_implant/nvg/proc/remove_health(mob/living/M)
	SIGNAL_HANDLER
	implant_health--
	if(implant_health <= 0)
		UnregisterSignal(M, list(
			COMSIG_HUMAN_POST_UPDATE_SIGHT,
			COMSIG_MOB_DEATH
		))
		to_chat(M, SPAN_WARNING("一切都感觉暗了许多。"))
	else
		to_chat(M, SPAN_WARNING("你感觉夜视植入体的效果正在减弱。"))

/obj/item/device/internal_implant/nvg/proc/give_nvg(mob/living/M)
	SIGNAL_HANDLER
	M.see_in_dark = 12
	M.lighting_alpha = LIGHTING_PLANE_ALPHA_SOMEWHAT_INVISIBLE
	M.sync_lighting_plane_alpha()

/obj/item/device/implanter/rejuv
	name = "再生植入体"
	desc = "该植入体将在濒死边缘自动激活。激活后，它将耗尽自身，大幅治疗你的伤势，并注入一种能显著加速并钝化所有痛感的兴奋剂。"
	implant_type = /obj/item/device/internal_implant/rejuv
	implant_string = "something beating next to your heart." //spooky second heart deep lore

/obj/item/device/internal_implant/rejuv
	/// Assoc list where the keys are the reagent ids of the reagents to be injected and the values are the amount to be injected
	var/list/stimulant_to_inject = list(
		"speed_stimulant" = 0.5,
		"redemption_stimulant" = 3,
	)

/obj/item/device/internal_implant/rejuv/on_implanted(mob/living/M)
	. = ..()
	RegisterSignal(M, list(
		COMSIG_MOB_TAKE_DAMAGE,
		COMSIG_HUMAN_TAKE_DAMAGE,
		COMSIG_XENO_TAKE_DAMAGE
	), PROC_REF(check_revive))

/obj/item/device/internal_implant/rejuv/proc/check_revive(mob/living/M, list/damagedata, damagetype)
	SIGNAL_HANDLER
	if((M.health - damagedata["damage"]) <= M.health_threshold_crit)
		UnregisterSignal(M, list(
			COMSIG_MOB_TAKE_DAMAGE,
			COMSIG_HUMAN_TAKE_DAMAGE,
			COMSIG_XENO_TAKE_DAMAGE
		))

		INVOKE_ASYNC(src, PROC_REF(revive), M)

/obj/item/device/internal_implant/rejuv/proc/revive(mob/living/M)
	M.heal_all_damage()

	for(var/i in stimulant_to_inject)
		var/reagent_id = i
		var/injection_amt = stimulant_to_inject[i]
		M.reagents.add_reagent(reagent_id, injection_amt)

/obj/item/device/implanter/agility
	name = "敏捷植入体"
	desc = "该植入体将使你更加敏捷，允许你极快地翻越障碍物，并能以消防员姿势搬运他人。"
	implant_type = /obj/item/device/internal_implant/agility
	implant_string = "your heartrate increasing significantly and your pupils dilating."

/obj/item/device/implanter/agility/get_examine_text(user)
	. = ..()
	. += SPAN_NOTICE("To fireman carry someone, aggressive-grab them and drag their sprite to yours.")

/obj/item/device/internal_implant/agility
	var/move_delay_mult  = 0.94
	var/climb_delay_mult = 0.20
	var/carry_delay_mult = 0.25
	var/grab_delay_mult  = 0.30

/obj/item/device/internal_implant/agility/on_implanted(mob/living/M)
	. = ..()
	RegisterSignal(M, COMSIG_HUMAN_POST_MOVE_DELAY, PROC_REF(handle_movedelay))
	RegisterSignal(M, COMSIG_LIVING_CLIMB_STRUCTURE, PROC_REF(handle_climbing))
	RegisterSignal(M, COMSIG_HUMAN_CARRY, PROC_REF(handle_fireman))
	RegisterSignal(M, COMSIG_MOB_GRAB_UPGRADE, PROC_REF(handle_grab))

/obj/item/device/internal_implant/agility/proc/handle_movedelay(mob/living/M, list/movedata)
	SIGNAL_HANDLER
	movedata["move_delay"] *= move_delay_mult

/obj/item/device/internal_implant/agility/proc/handle_climbing(mob/living/M, list/climbdata)
	SIGNAL_HANDLER
	climbdata["climb_delay"] *= climb_delay_mult

/obj/item/device/internal_implant/agility/proc/handle_fireman(mob/living/M, list/carrydata)
	SIGNAL_HANDLER
	carrydata["carry_delay"] *= carry_delay_mult
	return COMPONENT_CARRY_ALLOW

/obj/item/device/internal_implant/agility/proc/handle_grab(mob/living/M, list/grabdata)
	SIGNAL_HANDLER
	grabdata["grab_delay"] *= grab_delay_mult
	return TRUE

/obj/item/device/implanter/subdermal_armor
	name = "皮下护甲植入体"
	desc = "该植入体将在你的皮肤下生成护甲，减少受到的伤害并强化骨骼。"
	implant_type = /obj/item/device/internal_implant/subdermal_armor
	implant_string = "your skin becoming significantly harder... That's going to hurt in a decade."

/obj/item/device/internal_implant/subdermal_armor
	var/burn_damage_mult = 0.9
	var/brute_damage_mult = 0.85
	var/bone_break_mult = 0.25

/obj/item/device/internal_implant/subdermal_armor/on_implanted(mob/living/M)
	. = ..()
	RegisterSignal(M, list(
		COMSIG_MOB_TAKE_DAMAGE,
		COMSIG_HUMAN_TAKE_DAMAGE,
		COMSIG_XENO_TAKE_DAMAGE
	), PROC_REF(handle_damage))
	RegisterSignal(M, COMSIG_HUMAN_BONEBREAK_PROBABILITY, PROC_REF(handle_bonebreak))

/obj/item/device/internal_implant/subdermal_armor/proc/handle_damage(mob/living/M, list/damagedata, damagetype)
	SIGNAL_HANDLER
	if(damagetype == BRUTE)
		damagedata["damage"] *= brute_damage_mult
	else if(damagetype == BURN)
		damagedata["damage"] *= burn_damage_mult

/obj/item/device/internal_implant/subdermal_armor/proc/handle_bonebreak(mob/living/M, list/bonedata)
	SIGNAL_HANDLER
	bonedata["bonebreak_probability"] *= bone_break_mult
