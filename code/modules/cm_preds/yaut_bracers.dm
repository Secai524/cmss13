/obj/item/clothing/gloves/yautja
	name = "远古外星护腕"
	desc = "一对奇怪的外星护腕。"

	icon = 'icons/obj/items/hunter/pred_bracers.dmi'
	icon_state = "bracer"
	item_icons = list(
		WEAR_HANDS = 'icons/mob/humans/onmob/hunter/pred_bracers.dmi'
	)

	siemens_coefficient = 0

	flags_item = ITEM_PREDATOR
	flags_inventory = CANTSTRIP
	flags_equip_slot = SLOT_NO_STORE|SLOT_HANDS
	flags_cold_protection = BODY_FLAG_HANDS
	flags_heat_protection = BODY_FLAG_HANDS
	flags_armor_protection = BODY_FLAG_HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROT
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROT
	unacidable = TRUE

	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

	var/notification_sound = TRUE // Whether the bracer pings when a message comes or not
	var/charge = 1500
	var/charge_max = 1500
	/// The amount charged per process
	var/charge_rate = 60
	/// Cooldown on draining power from APC
	var/charge_cooldown = COOLDOWN_BRACER_CHARGE
	var/cloak_timer = 0
	var/cloak_malfunction = 0
	/// Determines the alpha level of the cloaking device.
	var/cloak_alpha = 50
	/// If TRUE will change the mob invisibility level, providing 100% invisibility. Exclusively for events.
	var/true_cloak = FALSE

	var/mob/living/carbon/human/owner //Pred spawned on, or thrall given to.
	var/obj/item/clothing/gloves/yautja/linked_bracer //Bracer linked to this one (thrall or mentor).
	COOLDOWN_DECLARE(bracer_recharge)
	/// What minimap icon this bracer should have
	var/minimap_icon
	///sprite style
	var/material

/obj/item/clothing/gloves/yautja/equipped(mob/user, slot)
	. = ..()
	if(slot == WEAR_HANDS)
		START_PROCESSING(SSobj, src)
		owner = user
		if(isyautja(owner))
			minimap_icon = owner.assigned_equipment_preset?.minimap_icon
		toggle_lock_internal(user, TRUE)
		RegisterSignal(user, list(COMSIG_MOB_STAT_SET_ALIVE, COMSIG_MOB_DEATH), PROC_REF(update_minimap_icon))
		INVOKE_NEXT_TICK(src, PROC_REF(update_minimap_icon), user)

/obj/item/clothing/gloves/yautja/Destroy()
	STOP_PROCESSING(SSobj, src)
	owner = null
	if(linked_bracer)
		linked_bracer.linked_bracer = null
		linked_bracer = null
	return ..()

/obj/item/clothing/gloves/yautja/dropped(mob/user)
	owner = null
	STOP_PROCESSING(SSobj, src)
	flags_item = initial(flags_item)
	UnregisterSignal(user, list(COMSIG_MOB_STAT_SET_ALIVE, COMSIG_MOB_DEATH))
	SSminimaps.remove_marker(user)
	unlock_bracer() // So as to prevent the bracer being stuck with nodrop if the pred gets gibbed/arm removed/etc.
	..()

/obj/item/clothing/gloves/yautja/pickup(mob/living/user)
	. = ..()
	if(!isyautja(user))
		to_chat(user, SPAN_WARNING("护腕贴着你的皮肤感觉冰冷，带着一种陌生的、近乎异类的沉重感。"))

/obj/item/clothing/gloves/yautja/process()
	if(!ishuman(loc))
		STOP_PROCESSING(SSobj, src)
		return
	var/mob/living/carbon/human/human_holder = loc

	if(charge < charge_max)
		var/charge_increase = charge_rate
		if(is_ground_level(human_holder.z))
			charge_increase = charge_rate / 6
		else if(is_mainship_level(human_holder.z))
			charge_increase = charge_rate / 3

		charge = min(charge + charge_increase, charge_max)
		var/perc_charge = (charge / charge_max * 100)
		human_holder.update_power_display(perc_charge, material)

	//Non-Yautja have a chance to get stunned with each power drain
	if(!HAS_TRAIT(human_holder, TRAIT_CLOAKED))
		return
	if(human_holder.stat == DEAD)
		decloak(human_holder, TRUE)
	if(!HAS_TRAIT(human_holder, TRAIT_YAUTJA_TECH) && !human_holder.hunter_data.thralled && prob(2))
		decloak(human_holder)
		shock_user(human_holder)

/// handles decloaking only on HUNTER gloves
/obj/item/clothing/gloves/yautja/proc/decloak()
	SIGNAL_HANDLER
	return

/// Called to update the minimap icon of the predator
/obj/item/clothing/gloves/yautja/proc/update_minimap_icon()
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/human_owner = owner
	var/turf/wearer_turf = get_turf(owner)
	SSminimaps.remove_marker(owner)
	if(!wearer_turf)
		return

	if(!isyautja(owner))
		var/image/underlay = image('icons/ui_icons/map_blips.dmi', null, "bracer_stolen")
		var/overlay_icon_state
		if(owner.stat >= DEAD)
			if(human_owner.undefibbable)
				overlay_icon_state = "undefibbable"
			else
				overlay_icon_state = "defibbable"
		else
			overlay_icon_state = null
		if(overlay_icon_state)
			var/image/overlay = image('icons/ui_icons/map_blips.dmi', null, overlay_icon_state)
			underlay.overlays += overlay
		SSminimaps.add_marker(owner, MINIMAP_FLAG_YAUTJA, underlay)
	else
		var/image/underlay = image('icons/ui_icons/map_blips.dmi', null, minimap_icon)
		if(owner?.stat >= DEAD)
			var/image/overlay = image('icons/ui_icons/map_blips.dmi', null, "undefibbable")
			underlay.overlays += overlay
		SSminimaps.add_marker(owner, MINIMAP_FLAG_YAUTJA, underlay)
/*
*This is the main proc for checking AND draining the bracer energy. It must have human passed as an argument.
*It can take a negative value in amount to restore energy.
*Also instantly updates the yautja power HUD display.
*/
/obj/item/clothing/gloves/yautja/proc/drain_power(mob/living/carbon/human/human, amount)
	if(!human)
		return FALSE
	if(charge < amount)
		to_chat(human, SPAN_WARNING("你的护腕能量不足。仅剩<b>[charge]/[charge_max]</b>，需要<B>[amount]</b>。"))
		return FALSE

	charge -= amount
	var/perc = (charge / charge_max * 100)
	human.update_power_display(perc, material)

	return TRUE

/obj/item/clothing/gloves/yautja/proc/shock_user(mob/living/carbon/human/M)
	if(!HAS_TRAIT(M, TRAIT_YAUTJA_TECH) && !M.hunter_data.thralled)
		//Spark
		playsound(M, 'sound/effects/sparks2.ogg', 60, 1)
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(2, 1, src)
		s.start()
		M.visible_message(SPAN_WARNING("[src]发出哔哔声并向[M]的身体发送了一道电击！"))
		//Stun and knock out, scream in pain
		M.apply_effect(2, STUN)
		M.apply_effect(2, WEAKEN)
		if(M.pain.feels_pain)
			M.emote("scream")
		//Apply a bit of burn damage
		M.apply_damage(5, BURN, "l_arm", 0, 0, 0, src)
		M.apply_damage(5, BURN, "r_arm", 0, 0, 0, src)

//We use this to determine whether we should activate the given verb, or a random verb
//0 - do nothing, 1 - random function, 2 - this function
/obj/item/clothing/gloves/yautja/hunter/proc/check_random_function(mob/living/carbon/human/user, forced = FALSE, always_delimb = FALSE)
	if(!istype(user))
		return TRUE

	if(forced || HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		return FALSE

	if(user.is_mob_incapacitated()) //let's do this here to avoid to_chats to dead guys
		return TRUE

	var/workingProbability = 20
	var/randomProbability = 10
	if(issynth(user)) // Synths are smart, they can figure this out pretty well
		workingProbability = 40
		randomProbability = 4
	else if(isresearcher(user)) // Researchers are sort of smart, they can sort of figure this out
		workingProbability = 25
		randomProbability = 7

	to_chat(user, SPAN_NOTICE("你按了几个按钮..."))
	//Add a little delay so the user wouldn't be just spamming all the buttons
	user.next_move = world.time + 3
	if(do_after(user, 3, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, numticks = 1))
		if(prob(randomProbability))
			return activate_random_verb(user)
		if(!prob(workingProbability))
			to_chat(user, SPAN_WARNING("你摆弄着按钮但什么都没发生..."))
			return TRUE

	if(always_delimb)
		return delimb_user(user)

	return FALSE

/obj/item/clothing/gloves/yautja/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("They currently have <b>[charge]/[charge_max]</b> charge.")

// Toggle the notification sound
/obj/item/clothing/gloves/yautja/verb/toggle_notification_sound()
	set name = "Toggle Bracer Sound"
	set desc = "Toggle your bracer's notification sound."
	set src in usr

	notification_sound = !notification_sound
	to_chat(usr, SPAN_NOTICE("护腕的声音现在已[notification_sound ? "on" : "off"]."))

/obj/item/clothing/gloves/yautja/thrall/update_minimap_icon()
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/human_owner = owner
	var/image/underlay = image('icons/ui_icons/map_blips.dmi', null, minimap_icon)
	var/overlay_icon_state
	if(owner.stat >= DEAD)
		if(human_owner.undefibbable)
			overlay_icon_state = "undefibbable"
		else
			overlay_icon_state = "defibbable"
		var/image/overlay = image('icons/ui_icons/map_blips.dmi', null, overlay_icon_state)
		underlay.overlays += overlay
		SSminimaps.add_marker(owner, MINIMAP_FLAG_YAUTJA, underlay)
	else
		SSminimaps.add_marker(owner, MINIMAP_FLAG_YAUTJA, underlay)

/obj/item/clothing/gloves/yautja/hunter
	name = "氏族护腕"
	desc = "一副由铁血战士佩戴的极其复杂但操作简单的装甲护腕。它有许多功能，激活它们以使用部分功能。"

	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH

	charge = 3000
	charge_max = 3000

	cloak_alpha = 10

	var/exploding = 0
	var/disc_timer = 0
	var/explosion_type = 1 //0 is BIG explosion, 1 ONLY gibs the user.
	var/name_active = TRUE
	var/translator_type = PRED_TECH_MODERN
	var/invisibility_sound = PRED_TECH_MODERN
	var/caster_material = "ebony"

	var/obj/item/card/id/bracer_chip/embedded_id
	var/owner_rank = CLAN_RANK_UNBLOODED_INT

	var/caster_deployed = FALSE
	var/obj/item/weapon/gun/energy/yautja/plasma_caster/caster

	var/bracer_attachment_deployed = FALSE
	var/obj/item/bracer_attachments/left_bracer_attachment
	var/obj/item/bracer_attachments/right_bracer_attachment

	///A list of all intrinsic bracer actions
	var/list/bracer_actions = list(/datum/action/predator_action/bracer/wristblade, /datum/action/predator_action/bracer/caster, /datum/action/predator_action/bracer/cloak, /datum/action/predator_action/bracer/thwei, /datum/action/predator_action/bracer/capsule, /datum/action/predator_action/bracer/translator, /datum/action/predator_action/bracer/self_destruct, /datum/action/predator_action/bracer/smartdisc)

/obj/item/clothing/gloves/yautja/hunter/get_examine_text(mob/user)
	. = ..()
	if(left_bracer_attachment)
		. += SPAN_NOTICE("The left bracer attachment is [left_bracer_attachment.attached_weapon].")
	if(right_bracer_attachment)
		. += SPAN_NOTICE("The right bracer attachment is [right_bracer_attachment.attached_weapon].")

/obj/item/clothing/gloves/yautja/hunter/Initialize(mapload, new_translator_type, new_invis_sound, new_caster_material, new_owner_rank, new_bracer_material)
	. = ..()
	if(new_owner_rank)
		owner_rank = new_owner_rank
	embedded_id = new(src)
	if(new_translator_type)
		translator_type = new_translator_type
	if(new_invis_sound)
		invisibility_sound = new_invis_sound
	if(new_caster_material)
		caster_material = new_caster_material
	caster = new(src, FALSE, caster_material)
	if(new_bracer_material)
		icon_state = "bracer_" + new_bracer_material
		material = new_bracer_material

/obj/item/clothing/gloves/yautja/hunter/emp_act(severity)
	. = ..()
	charge = max(charge - (1000/severity), 0) //someone made weaker emp have higer severity so we divide
	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		if(wearer.gloves == src)
			wearer.visible_message(SPAN_DANGER("你听到嘶嘶声和噼啪声！"), SPAN_DANGER("Your bracers hiss and spark!"), SPAN_DANGER("你听到嘶嘶声和噼啪声！"))
			if(HAS_TRAIT(wearer, TRAIT_CLOAKED))
				decloak(wearer, TRUE, DECLOAK_EMP)
		else
			var/turf/our_turf = get_turf(src)
			our_turf.visible_message(SPAN_DANGER("你听到嘶嘶声和噼啪声！"), SPAN_DANGER("你听到嘶嘶声和噼啪声！"))

/obj/item/clothing/gloves/yautja/hunter/equipped(mob/user, slot)
	. = ..()
	if(slot != WEAR_HANDS)
		move_chip_to_bracer()
	else
		if(embedded_id.registered_name)
			embedded_id.set_user_data(user)

	for(var/datum/action/action as anything in bracer_actions)
		give_action(user, action)


//Any projectile can decloak a predator. It does defeat one free bullet though.
/obj/item/clothing/gloves/yautja/hunter/proc/bullet_hit(mob/living/carbon/human/H, obj/projectile/P)
	SIGNAL_HANDLER

	var/ammo_flags = P.ammo.flags_ammo_behavior | P.projectile_override_flags
	if(ammo_flags & (AMMO_ROCKET|AMMO_ENERGY|AMMO_ACIDIC)) //<--- These will auto uncloak.
		decloak(H) //Continue on to damage.
	else if(prob(20))
		decloak(H)
		return COMPONENT_CANCEL_BULLET_ACT //Absorb one free bullet.

/obj/item/clothing/gloves/yautja/hunter/toggle_notification_sound()
	set category = "Yautja.Misc"
	..()

/obj/item/clothing/gloves/yautja/hunter/Destroy()
	QDEL_NULL(caster)
	QDEL_NULL(embedded_id)
	QDEL_NULL(left_bracer_attachment)
	QDEL_NULL(right_bracer_attachment)
	return ..()

/obj/item/clothing/gloves/yautja/hunter/process()
	if(!ishuman(loc))
		STOP_PROCESSING(SSobj, src)
		return

	var/mob/living/carbon/human/human = loc

	//Non-Yautja have a chance to get stunned with each power drain
	if((!HAS_TRAIT(human, TRAIT_YAUTJA_TECH) && !human.hunter_data.thralled) && prob(4))
		if(HAS_TRAIT(human, TRAIT_CLOAKED))
			decloak(human, TRUE, DECLOAK_SPECIES)
		shock_user(human)

	return ..()

/obj/item/clothing/gloves/yautja/hunter/dropped(mob/user)
	move_chip_to_bracer()
	if(HAS_TRAIT(user, TRAIT_CLOAKED))
		decloak(user, TRUE)

	for(var/datum/action/action as anything in bracer_actions)
		remove_action(user, action)

	..()

/obj/item/clothing/gloves/yautja/hunter/on_enter_storage(obj/item/storage/S)
	if(ishuman(loc))
		var/mob/living/carbon/human/human = loc
		if(HAS_TRAIT(human, TRAIT_CLOAKED))
			decloak(human, TRUE)
	. = ..()

//We use this to activate random verbs for non-Yautja
/obj/item/clothing/gloves/yautja/hunter/proc/activate_random_verb(mob/user)
	var/option = rand(1, 10)
	//we have options from 1 to 7, but we're giving the user a higher probability of being punished if they already rolled this bad
	switch(option)
		if(1)
			. = attachment_internal(user, TRUE)
		if(2)
			. = track_gear_internal(user, TRUE)
		if(3)
			. = cloaker_internal(user, TRUE)
		if(4)
			. = caster_internal(user, TRUE)
		if(5)
			. = injectors_internal(user, TRUE)
		if(6)
			. = call_disc_internal(user, TRUE)
		if(7)
			. = translate_internal(user, TRUE)
		if(8)
			. =	remove_attachment_internal(user, TRUE)
		else
			. = delimb_user(user)

//This is used to punish people that fiddle with technology they don't understand
/obj/item/clothing/gloves/yautja/hunter/proc/delimb_user(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(isyautja(user))
		return

	var/obj/limb/O = user.get_limb(check_zone("r_arm"))
	O.droplimb()
	O = user.get_limb(check_zone("l_arm"))
	O.droplimb()

	to_chat(user, SPAN_NOTICE("设备发出奇怪的声响并脱落了...连同你的手臂！"))
	playsound(user,'sound/weapons/wristblades_on.ogg', 15, 1)
	return TRUE

//bracer attachments
/obj/item/bracer_attachments
	name = "腕刃护腕附件"
	desc = "如果你看到这个，请报告。"
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	///Typepath of the weapon attached to the bracer
	var/obj/item/attached_weapon_type
	///Reference to the weapon attached to the bracer
	var/obj/item/attached_weapon
	///Attachment deployment sound
	var/deployment_sound
	///Attachment rectraction sound
	var/retract_sound

/obj/item/bracer_attachments/Initialize(mapload, ...)
	. = ..()
	if(attached_weapon_type)
		attached_weapon = new attached_weapon_type(src)

/obj/item/bracer_attachments/Destroy()
	QDEL_NULL(attached_weapon)
	. = ..()

/obj/item/bracer_attachments/chain_gauntlets
	name = "链甲护手"
	icon_state = "metal_gauntlet"
	item_state = "metal_gauntlet"
	attached_weapon_type = /obj/item/weapon/bracer_attachment/chain_gauntlets
	desc = "由外星合金制成的护手，在它被装进你的护腕后，你或许可以在上面缠上一些链条。"
	deployment_sound = 'sound/handling/combistick_close.ogg'
	retract_sound = 'sound/handling/combistick_close.ogg'

/obj/item/bracer_attachments/wristblades
	name = "腕刃护腕附件"
	desc = "一对巨大的锯齿状刀刃。"
	icon_state = "wrist"
	item_state = "wristblade"
	attached_weapon_type = /obj/item/weapon/bracer_attachment/wristblades
	deployment_sound = 'sound/weapons/wristblades_on.ogg'
	retract_sound = 'sound/weapons/wristblades_off.ogg'

/obj/item/bracer_attachments/scimitars
	name = "弯刀护腕附件"
	desc = "一对巨大的锯齿状刀刃。"
	icon_state = "scim"
	item_state = "scim"
	attached_weapon_type = /obj/item/weapon/bracer_attachment/scimitar
	deployment_sound = 'sound/weapons/scims_on.ogg'
	retract_sound = 'sound/weapons/scims_off.ogg'

/obj/item/bracer_attachments/scimitars_alt
	name = "弯刀护腕附件"
	desc = "一对巨大的锯齿状刀刃。"
	icon_state = "scim_alt"
	item_state = "scim_alt"
	attached_weapon_type = /obj/item/weapon/bracer_attachment/scimitar/alt
	deployment_sound = 'sound/weapons/scims_alt_on.ogg'
	retract_sound = 'sound/weapons/scims_alt_off.ogg'

/obj/item/bracer_attachments/shield
	name ="盾牌护腕附件"
	desc ="一个由同心金属合金板制成的盾牌。这些板可以相互折叠以便紧凑存放，同时仍能提供卓越的保护。"
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	icon_state = "bracer_shield_off"
	item_state = "bracer_shield_off"
	attached_weapon_type = /obj/item/weapon/shield/riot/yautja/bracer_shield
	deployment_sound = 'sound/weapons/wristblades_on.ogg'
	retract_sound = 'sound/weapons/wristblades_off.ogg'

/obj/item/clothing/gloves/yautja/hunter/attackby(obj/item/attacking_item, mob/user)
	if(!istype(attacking_item, /obj/item/bracer_attachments))
		return ..()

	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, SPAN_WARNING("你不知道如何将[attacking_item]安装到[src]上。"))
		return

	var/obj/item/bracer_attachments/bracer_attachment = attacking_item
	if(!bracer_attachment.attached_weapon_type)
		CRASH("[key_name(user)] attempted to attach the [bracer_attachment] to the [src], with no valid attached_weapon.")

	if(left_bracer_attachment && right_bracer_attachment)
		to_chat(user, SPAN_WARNING("[src]上的护腕附件已达最大数量。"))
		return

	var/attach_to_left = TRUE
	if(!left_bracer_attachment && !right_bracer_attachment)
		var/selected = tgui_alert(user, "你想将[bracer_attachment]安装在左手还是右手？", "[src]", list("Right", "Left"), 15 SECONDS)
		if(!selected)
			return

		if(selected == "Right") //its right, left because in-game itll show up as left, right
			attach_to_left = FALSE

	if(attacking_item.loc != user)
		to_chat(user, SPAN_WARNING("你必须手持[attacking_item]才能安装。"))
		return

	var/bracer_attached = FALSE
	if(attach_to_left && !left_bracer_attachment)
		left_bracer_attachment = bracer_attachment
		user.drop_inv_item_to_loc(bracer_attachment, src)
		bracer_attached = TRUE
	if(!bracer_attached && !right_bracer_attachment)
		right_bracer_attachment = bracer_attachment
		user.drop_inv_item_to_loc(bracer_attachment, src)

	to_chat(user, SPAN_NOTICE("你将[bracer_attachment]安装到[src]上。"))
	playsound(loc, 'sound/weapons/pred_attach.ogg')
	return ..()

/obj/item/clothing/gloves/yautja/hunter/verb/remove_attachment()
	set name = "Remove Bracer Attachment"
	set desc = "Remove Bracer Attachment From Your Bracer."
	set category = "Yautja.Weapons"
	set src in usr
	return remove_attachment_internal(usr, TRUE)

/obj/item/clothing/gloves/yautja/hunter/proc/remove_attachment_internal(mob/living/carbon/human/user, forced = FALSE)
	if(!user.loc || user.is_mob_incapacitated() || !ishuman(user))
		return

	. = check_random_function(user, forced)
	if(.)
		return

	if(!left_bracer_attachment && !right_bracer_attachment)
		to_chat(user, SPAN_WARNING("[src]没有安装任何护腕！"))
		return

	if(bracer_attachment_deployed)
		to_chat(user, SPAN_WARNING("先收回你的附件！"))
		return

	if(left_bracer_attachment)
		if(!user.put_in_any_hand_if_possible(left_bracer_attachment))
			user.drop_inv_item_on_ground(left_bracer_attachment)
		to_chat(user, SPAN_NOTICE("你从[src]上拆除了[left_bracer_attachment]。"))
		playsound(src, 'sound/machines/click.ogg', 15, 1)
		left_bracer_attachment = null

	if(right_bracer_attachment)
		if(!user.put_in_any_hand_if_possible(right_bracer_attachment))
			user.drop_inv_item_on_ground(right_bracer_attachment)
		to_chat(user, SPAN_NOTICE("你从[src]上拆除了[right_bracer_attachment]。"))
		playsound(src, 'sound/machines/click.ogg', 15, 1)
		right_bracer_attachment = null

	playsound(src, 'sound/machines/click.ogg', 15, 1)

	return FALSE

/obj/item/clothing/gloves/yautja/hunter/verb/bracer_attachment()
	set name = "Use Bracer Attachment"
	set desc = "Extend your bracer attachment. They cannot be dropped, but can be retracted."
	set category = "Yautja.Weapons"
	set src in usr
	return attachment_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/attachment_internal(mob/living/carbon/human/user, forced = FALSE)
	if(!user.loc || user.is_mob_incapacitated() || !ishuman(user))
		return

	. = check_random_function(user, forced)
	if(.)
		return

	if(bracer_attachment_deployed)
		retract_bracer_attachments(user)
	else
		deploy_bracer_attachments(user)

	var/datum/action/predator_action/bracer/wristblade/wb_action
	for(wb_action as anything in user.actions)
		if(istypestrict(wb_action, /datum/action/predator_action/bracer/wristblade))
			wb_action.update_button_icon(bracer_attachment_deployed)
			break

	return TRUE

/obj/item/clothing/gloves/yautja/hunter/proc/deploy_bracer_attachments(mob/living/carbon/human/user) //take the weapons from the attachments in the bracer, and puts them in the callers hand
	if(!drain_power(user, 50))
		return
	if(!left_bracer_attachment && !right_bracer_attachment)
		to_chat(user, SPAN_WARNING("[src]没有护腕附件！"))
		return

	if(left_bracer_attachment)
		var/obj/limb/left_hand = user.get_limb("l_hand")
		if(!user.l_hand && left_hand.is_usable())
			if(user.put_in_l_hand(left_bracer_attachment.attached_weapon))
				to_chat(user, SPAN_NOTICE("你展开了[left_bracer_attachment.attached_weapon]。"))
				bracer_attachment_deployed = TRUE
				playsound(loc,left_bracer_attachment.deployment_sound, 25, TRUE)


	if(right_bracer_attachment)
		var/obj/limb/right_hand = user.get_limb("r_hand")
		if(!user.r_hand && right_hand.is_usable())
			if(user.put_in_r_hand(right_bracer_attachment.attached_weapon))
				to_chat(user, SPAN_NOTICE("你展开了[right_bracer_attachment.attached_weapon]。"))
				bracer_attachment_deployed = TRUE
				playsound(loc,right_bracer_attachment.deployment_sound, 25, TRUE)

/obj/item/clothing/gloves/yautja/hunter/proc/retract_bracer_attachments(mob/living/carbon/human/user) //if the attachments weapon is in the callers hands, retract them back into the attachments
	if(left_bracer_attachment && left_bracer_attachment.attached_weapon.loc == user)
		user.drop_inv_item_to_loc(left_bracer_attachment.attached_weapon, left_bracer_attachment, FALSE, TRUE)
		to_chat(user, SPAN_NOTICE("你收回了[left_bracer_attachment.attached_weapon]。"))
		playsound(loc, left_bracer_attachment.retract_sound, 25, TRUE)

	if(right_bracer_attachment && right_bracer_attachment.attached_weapon.loc == user)
		user.drop_inv_item_to_loc(right_bracer_attachment.attached_weapon, right_bracer_attachment, FALSE, TRUE)
		to_chat(user, SPAN_NOTICE("你收回了[right_bracer_attachment.attached_weapon]。"))
		playsound(loc, right_bracer_attachment.retract_sound, 25, TRUE)

	bracer_attachment_deployed = FALSE

/obj/item/clothing/gloves/yautja/hunter/verb/track_gear()
	set name = "Track Yautja Gear"
	set desc = "Find Yauja Gear."
	set category = "Yautja.Tracker"
	set src in usr
	. = track_gear_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/track_gear_internal(mob/user, forced = FALSE)
	. = check_random_function(user, forced)
	if(.)
		return

	var/mob/living/carbon/human/hunter = user
	var/atom/hunter_eye = hunter.client.get_eye()

	var/dead_on_planet = 0
	var/dead_on_almayer = 0
	var/dead_low_orbit = 0
	var/gear_on_planet = 0
	var/gear_on_almayer = 0
	var/gear_low_orbit = 0
	var/closest = 10000
	/// The item itself, to be referenced so Yautja know what to look for.
	var/obj/closest_item
	var/direction = -1
	var/atom/areaLoc = null
	for(var/obj/item/tracked_item as anything in GLOB.loose_yautja_gear)
		var/atom/loc = get_true_location(tracked_item)
		if(tracked_item.anchored)
			continue
		if(is_honorable_carrier(recursive_holder_check(tracked_item)))
			continue
		var/area/location = get_area(loc)
		if(location?.flags_area & AREA_YAUTJA_GROUNDS)
			continue
		if(is_reserved_level(loc.z))
			gear_low_orbit++
		else if(is_mainship_level(loc.z))
			gear_on_almayer++
		else if(is_ground_level(loc.z))
			gear_on_planet++
		if(hunter_eye.z == loc.z)
			var/dist = get_dist(hunter_eye, loc)
			if(dist < closest)
				closest = dist
				closest_item = tracked_item
				direction = Get_Compass_Dir(hunter_eye, loc)
				areaLoc = loc
	for(var/mob/living/carbon/human/dead_yautja as anything in GLOB.yautja_mob_list)
		if(dead_yautja.stat != DEAD)
			continue
		var/area/location = get_area(dead_yautja)
		if(location?.flags_area & AREA_YAUTJA_GROUNDS)
			continue
		if(is_reserved_level(dead_yautja.z))
			dead_low_orbit++
		else if(is_mainship_level(dead_yautja.z))
			dead_on_almayer++
		else if(is_ground_level(dead_yautja.z))
			dead_on_planet++
		if(hunter_eye.z == dead_yautja.z)
			var/dist = get_dist(hunter_eye, dead_yautja)
			if(dist < closest)
				closest = dist
				direction = Get_Compass_Dir(hunter_eye, dead_yautja)
				areaLoc = loc

	var/output = FALSE
	if(dead_on_planet || dead_on_almayer || dead_low_orbit)
		output = TRUE
		to_chat(hunter, SPAN_NOTICE("你的护腕显示出已死亡铁血战士的生物信号[dead_on_planet ? ", <b>[dead_on_planet]</b> in the hunting grounds" : ""][dead_on_almayer ? ", <b>[dead_on_almayer]</b> in orbit" : ""][dead_low_orbit ? ", <b>[dead_low_orbit]</b> in low orbit" : ""]."))
	if(gear_on_planet || gear_on_almayer || gear_low_orbit)
		output = TRUE
		to_chat(hunter, SPAN_NOTICE("你的护腕显示出铁血战士科技信号[gear_on_planet ? ", <b>[gear_on_planet]</b> in the hunting grounds" : ""][gear_on_almayer ? ", <b>[gear_on_almayer]</b> in orbit" : ""][gear_low_orbit ? ", <b>[gear_low_orbit]</b> in low orbit" : ""]."))
	if(closest < 900)
		output = TRUE
		var/areaName = get_area_name(areaLoc)
		if(closest == 0)
			to_chat(hunter, SPAN_NOTICE("你正位于[closest_item ? " <b>[closest_item.name]</b>'s" : ""] signature."))
		else
			to_chat(hunter, SPAN_NOTICE("最近的信号[closest_item ? ", a <b>[closest_item.name]</b>" : ""], is [closest > 10 ? "approximately <b>[round(closest, 10)]</b>" : "<b>[closest]</b>"] paces <b>[dir2text(direction)]</b> in <b>[areaName]</b>."))
	if(!output)
		to_chat(hunter, SPAN_NOTICE("没有需要你关注的信号。"))
	return TRUE

/obj/item/clothing/gloves/yautja/hunter/verb/cloaker()
	set name = "Toggle Cloaking Device"
	set desc = "Activate your suit's cloaking device. It will malfunction if the suit takes damage or gets excessively wet."
	set category = "Yautja.Utility"
	set src in usr
	. = cloaker_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/cloaker_internal(mob/user, forced = FALSE, silent = FALSE, instant = FALSE)
	. = check_random_function(user, forced)
	if(.)
		return

	var/mob/living/carbon/human/M = user
	var/new_alpha = cloak_alpha

	if(!istype(M) || M.is_mob_incapacitated())
		return FALSE

	if(HAS_TRAIT(user, TRAIT_CLOAKED)) //Turn it off.
		if(cloak_timer > world.time)
			to_chat(M, SPAN_WARNING("你的隐形装置正忙！剩余时间：<B>[max(floor((cloak_timer - world.time) / 10), 1)]</b>秒。"))
			return FALSE
		decloak(user)
	else //Turn it on!
		if(exploding)
			to_chat(M, SPAN_WARNING("你的护腕正忙于剧烈爆炸，无法启动隐形装置。"))
			return FALSE

		if(cloak_malfunction > world.time)
			to_chat(M, SPAN_WARNING("你的隐形装置故障，目前无法启用！"))
			return FALSE

		if(cloak_timer > world.time)
			to_chat(M, SPAN_WARNING("你的隐形装置仍在充能！剩余时间：<B>[max(floor((cloak_timer - world.time) / 10), 1)]</b>秒。"))
			return FALSE

		if(!drain_power(M, 50))
			return FALSE

		ADD_TRAIT(M, TRAIT_CLOAKED, TRAIT_SOURCE_EQUIPMENT(WEAR_HANDS))

		RegisterSignal(M, COMSIG_HUMAN_EXTINGUISH, PROC_REF(wrapper_fizzle_camouflage))
		RegisterSignal(M, COMSIG_HUMAN_PRE_BULLET_ACT, PROC_REF(bullet_hit))
		RegisterSignal(M, COMSIG_MOB_EFFECT_CLOAK_CANCEL, PROC_REF(decloak))

		cloak_timer = world.time + 1.5 SECONDS
		if(true_cloak)
			M.invisibility = INVISIBILITY_LEVEL_ONE
			M.see_invisible = SEE_INVISIBLE_LEVEL_ONE

		log_game("[key_name_admin(user)] has enabled their cloaking device.")
		if(!silent)
			M.visible_message(SPAN_WARNING("[M]消失在空气中！"), SPAN_NOTICE("You are now invisible to normal detection."))
			var/sound_to_use
			if(invisibility_sound == PRED_TECH_MODERN)
				sound_to_use = 'sound/effects/pred_cloakon_modern.ogg'
			else
				sound_to_use = 'sound/effects/pred_cloakon.ogg'
			playsound(M.loc, sound_to_use, 15, 1, 4)

		if(!instant)
			animate(M, alpha = new_alpha, time = 1.5 SECONDS, easing = SINE_EASING|EASE_OUT)
		else
			M.alpha = new_alpha

		var/datum/mob_hud/security/advanced/SA = GLOB.huds[MOB_HUD_SECURITY_ADVANCED]
		SA.remove_from_hud(M)
		var/datum/mob_hud/xeno_infection/XI = GLOB.huds[MOB_HUD_XENO_INFECTION]
		XI.remove_from_hud(M)
		if(!instant)
			anim(M.loc,M,'icons/mob/mob.dmi',,"cloak",,M.dir)

	var/datum/action/predator_action/bracer/cloak/cloak_action
	for(cloak_action as anything in M.actions)
		if(istypestrict(cloak_action, /datum/action/predator_action/bracer/cloak))
			cloak_action.update_button_icon(HAS_TRAIT(user, TRAIT_CLOAKED))
			break

	return TRUE

/obj/item/clothing/gloves/yautja/hunter/proc/wrapper_fizzle_camouflage()
	SIGNAL_HANDLER

	var/mob/wearer = src.loc
	wearer.visible_message(SPAN_DANGER("[wearer]的隐形装置失效了！"), SPAN_DANGER("Your cloak fizzles out!"))

	var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
	sparks.set_up(5, 4, src)
	sparks.start()

	decloak(wearer, TRUE, DECLOAK_EXTINGUISHER)

/obj/item/clothing/gloves/yautja/hunter/decloak(mob/user, forced, force_multiplier = DECLOAK_FORCED)
	if(!user)
		return

	SEND_SIGNAL(src, COMSIG_PRED_BRACER_DECLOAKED)

	UnregisterSignal(user, COMSIG_HUMAN_EXTINGUISH)
	UnregisterSignal(user, COMSIG_HUMAN_PRE_BULLET_ACT)
	UnregisterSignal(user, COMSIG_MOB_EFFECT_CLOAK_CANCEL)

	var/decloak_timer = (DECLOAK_STANDARD * force_multiplier)
	if(forced)
		cloak_malfunction = world.time + decloak_timer

	REMOVE_TRAIT(user, TRAIT_CLOAKED, TRAIT_SOURCE_EQUIPMENT(WEAR_HANDS))
	log_game("[key_name_admin(user)] has disabled their cloaking device.")
	user.visible_message(SPAN_WARNING("[user]的身影闪烁显现！"), SPAN_WARNING("Your cloaking device deactivates."))
	var/sound_to_use
	if(invisibility_sound == PRED_TECH_MODERN)
		sound_to_use = 'sound/effects/pred_cloakoff_modern.ogg'
	else
		sound_to_use = 'sound/effects/pred_cloakoff.ogg'
	playsound(user.loc, sound_to_use, 15, 1, 4)
	user.alpha = initial(user.alpha)
	if(true_cloak)
		user.invisibility = initial(user.invisibility)
		user.see_invisible = initial(user.see_invisible)
	cloak_timer = world.time + (DECLOAK_STANDARD / 2)

	var/datum/mob_hud/security/advanced/SA = GLOB.huds[MOB_HUD_SECURITY_ADVANCED]
	SA.add_to_hud(user)
	var/datum/mob_hud/xeno_infection/XI = GLOB.huds[MOB_HUD_XENO_INFECTION]
	XI.add_to_hud(user)

	anim(user.loc, user, 'icons/mob/mob.dmi', null, "uncloak", null, user.dir)

/obj/item/clothing/gloves/yautja/hunter/verb/caster()
	set name = "Use Plasma Caster"
	set desc = "Activate your plasma caster. If it is dropped it will retract back into your armor."
	set category = "Yautja.Weapons"
	set src in usr
	. = caster_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/caster_internal(mob/living/carbon/human/user, forced = FALSE)
	if(!user.loc || user.is_mob_incapacitated() || !ishuman(user))
		return

	. = check_random_function(user, forced)
	if(.)
		return

	if(caster_deployed)
		if(caster.loc == user)
			user.drop_inv_item_to_loc(caster, src, FALSE, TRUE)
		caster_deployed = FALSE
	else
		if(!drain_power(user, 50))
			return
		if(user.get_active_hand())
			to_chat(user, SPAN_WARNING("你必须空出一只手才能激活你的等离子肩炮！"))
			return
		var/obj/limb/hand = user.get_limb(user.hand ? "l_hand" : "r_hand")
		if(!istype(hand) || !hand.is_usable())
			to_chat(user, SPAN_WARNING("你无法持有那个！"))
			return
		if(user.faction == FACTION_YAUTJA_YOUNG)
			to_chat(user, SPAN_WARNING("你尚未获得这项权利！"))
			return
		user.put_in_active_hand(caster)
		caster_deployed = TRUE
		if(user.client?.prefs.custom_cursors)
			user.client?.mouse_pointer_icon = 'icons/effects/mouse_pointer/plasma_caster_mouse.dmi'
		to_chat(user, SPAN_NOTICE("你激活了你的等离子肩炮。当前模式为[caster.mode]。"))
		playsound(src, 'sound/weapons/pred_plasmacaster_on.ogg', 15, TRUE)

		var/datum/action/predator_action/bracer/caster/caster_action
		for(caster_action as anything in user.actions)
			if(istypestrict(caster_action, /datum/action/predator_action/bracer/caster))
				caster_action.update_button_icon(caster_deployed)
				break

	return TRUE

/obj/item/clothing/gloves/yautja/hunter/proc/explode(mob/living/carbon/victim)
	set waitfor = 0

	if(exploding)
		return

	notify_ghosts(header = "Yautja self destruct", message = "[victim.real_name] is self destructing to protect their honor!", source = victim, action = NOTIFY_ORBIT)

	exploding = 1
	var/turf/T = get_turf(victim)
	if(explosion_type == SD_TYPE_BIG && (is_ground_level(T.z) || MODE_HAS_MODIFIER(/datum/gamemode_modifier/yautja_shipside_large_sd)))
		playsound(src, 'sound/voice/pred_deathlaugh.ogg', 100, 0, 17, status = 0)

	playsound(src, 'sound/effects/pred_countdown.ogg', 100, 0, 17, status = 0)
	message_admins(FONT_SIZE_XL("<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];admincancelpredsd=1;bracer=\ref[src];victim=\ref[victim]'>CLICK TO CANCEL THIS PRED SD</a>"))
	do_after(victim, rand(72, 80), INTERRUPT_NONE, BUSY_ICON_HOSTILE)

	T = get_turf(victim)
	if(istype(T) && exploding)
		victim.apply_damage(50,BRUTE,"chest")
		if(victim)
			victim.gib() // kills the pred
			qdel(victim)
		var/datum/cause_data/cause_data = create_cause_data("yautja self-destruct", victim)
		if(explosion_type == SD_TYPE_BIG && (is_ground_level(T.z) || MODE_HAS_MODIFIER(/datum/gamemode_modifier/yautja_shipside_large_sd)))
			cell_explosion(T, 600, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, cause_data) //Dramatically BIG explosion.
		else
			cell_explosion(T, 800, 550, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, cause_data)

/obj/item/clothing/gloves/yautja/hunter/verb/change_explosion_type()
	set name = "Change Explosion Type"
	set desc = "Changes your bracer explosion to either only gib you or be a big explosion."
	set category = "Yautja.Misc"
	set src in usr

	if(explosion_type == SD_TYPE_SMALL && exploding)
		to_chat(usr, SPAN_WARNING("你为什么要这么做？"))
		return

	if(alert("Which explosion type do you want?","爆炸腕带", "Small", "Big") == "Big")
		explosion_type = SD_TYPE_BIG
		log_attack("[key_name_admin(usr)] has changed their Self-Destruct to Large")
	else
		explosion_type = SD_TYPE_SMALL
		log_attack("[key_name_admin(usr)] has changed their Self-Destruct to Small")
		return

/obj/item/clothing/gloves/yautja/hunter/verb/activate_suicide()
	set name = "Final Countdown (!)"
	set desc = "Activate the explosive device implanted into your bracers. You have failed! Show some honor!"
	set category = "Yautja.Misc"
	set src in usr
	. = activate_suicide_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/activate_suicide_internal(mob/user, forced = FALSE)
	. = check_random_function(user, forced, TRUE)
	if(.)
		return

	var/mob/living/carbon/human/boomer = user
	var/area/grounds = get_area(boomer)

	if(HAS_TRAIT(boomer, TRAIT_CLOAKED))
		to_chat(boomer, SPAN_WARNING("隐形时不行。这可能会干扰程序。"))
		return
	if(boomer.stat == DEAD)
		to_chat(boomer, SPAN_WARNING("现在做这个已经太迟了！"))
		return
	if(boomer.health < boomer.health_threshold_crit)
		to_chat(boomer, SPAN_WARNING("当你陷入昏迷时，你在倒下前未能启动自毁装置。"))
		return
	if(boomer.stat != CONSCIOUS)
		to_chat(boomer, SPAN_WARNING("在你昏迷时不行..."))
		return
	if(boomer.is_mob_incapacitated() || (!exploding && HAS_TRAIT(boomer, TRAIT_HAULED)))
		to_chat(boomer, SPAN_WARNING("你当前的状态无法执行此操作。"))
		return
	if(grounds?.flags_area & AREA_YAUTJA_HUNTING_GROUNDS) // Hunted need mask to escape
		to_chat(boomer, SPAN_WARNING("你的臂铠不允许你启动自毁程序，以保护狩猎场。"))
		return
	if(user.faction == FACTION_YAUTJA_YOUNG)
		to_chat(boomer, SPAN_WARNING("你还未掌握此物的使用方法。")) // No SDing for youngbloods
		return

	var/obj/item/grab/G = boomer.get_active_hand()
	if(istype(G))
		var/mob/living/carbon/human/victim = G.grabbed_thing
		if(victim.stat == DEAD)
			var/obj/item/clothing/gloves/yautja/hunter/bracer = victim.gloves
			var/message = "Are you sure you want to detonate this [victim.species]'s bracer?"
			if(isspeciesyautja(victim))
				message = "你确定要将这个[victim.species]送往伟大的狩猎场吗？"
			if(istype(bracer))
				if(forced || tgui_alert(boomer, message, "爆炸腕带", list("Yes", "No"), 20 SECONDS) == "Yes")
					if(boomer.stat == DEAD)
						to_chat(boomer, SPAN_WARNING("现在做这个已经太迟了！"))
						return
					if(boomer.stat != CONSCIOUS)
						to_chat(boomer, SPAN_WARNING("在你昏迷时不行..."))
						return
					if(boomer.is_mob_incapacitated() || HAS_TRAIT(boomer, TRAIT_HAULED))
						to_chat(boomer, SPAN_WARNING("你当前的状态无法执行此操作。"))
						return
					if(boomer.get_active_hand() == G && victim && victim.gloves == bracer && !bracer.exploding)
						var/area/A = get_area(boomer)
						var/turf/T = get_turf(boomer)
						if(A)
							message_admins(FONT_SIZE_HUGE("ALERT: [boomer] ([boomer.key]) triggered the predator self-destruct sequence of [victim] ([victim.key]) in [A.name] [ADMIN_JMP(T)]</font>"))
							log_attack("[key_name(boomer)] triggered the predator self-destruct sequence of [victim] ([victim.key]) in [A.name]")
						if (!bracer.exploding)
							bracer.explode(victim)
						boomer.visible_message(SPAN_WARNING("[boomer]按下了[victim]腕带上的几个按钮。"),SPAN_DANGER("You activate the timer. May [victim]'s final hunt be swift."))
						message_all_yautja("[boomer.real_name] has triggered [victim.real_name]'s bracer's self-destruction sequence.")
			else
				to_chat(boomer, SPAN_WARNING("<b>这个[victim.species]没有佩戴腕带。</b>"))
			return

	if(boomer.gloves != src && !forced)
		return

	if(exploding)
		if(forced || tgui_alert(boomer, "你确定要停止倒计时吗？", "爆炸腕带", list("Yes", "No"), 20 SECONDS) == "Yes")
			if(boomer.gloves != src)
				return
			if(boomer.stat == DEAD)
				to_chat(boomer, SPAN_WARNING("现在做这个已经太迟了！"))
				return
			if(boomer.stat != CONSCIOUS)
				to_chat(boomer, SPAN_WARNING("在你昏迷时不行..."))
				return
			exploding = FALSE
			to_chat(boomer, SPAN_NOTICE("你的腕带停止了哔哔声。"))
			message_all_yautja("[boomer.real_name] has cancelled their bracer's self-destruction sequence.")
			message_admins("[key_name(boomer)] has deactivated their Self-Destruct.")

			var/datum/action/predator_action/bracer/self_destruct/sd_action
			for(sd_action as anything in boomer.actions)
				if(istypestrict(sd_action, /datum/action/predator_action/bracer/self_destruct))
					sd_action.update_button_icon(exploding)
					break

		return

	if(istype(boomer.wear_mask,/obj/item/clothing/mask/facehugger) || (boomer.status_flags & XENO_HOST))
		to_chat(boomer, SPAN_WARNING("奇怪……似乎有什么东西在干扰你的腕带功能……"))
		return

	if(forced || tgui_alert(boomer, "引爆腕带？你确定吗？\n\n注意：如果你在战斗期间或之后因任何非意外原因启动自毁程序，即视为接受自毁。启动自毁程序，意味着你已接受即将到来的死亡，以挽回任何失去的荣誉。", "爆炸腕带", list("Yes", "No"), 20 SECONDS) == "Yes")
		if(boomer.gloves != src)
			return
		if(boomer.stat == DEAD)
			to_chat(boomer, SPAN_WARNING("现在做这个已经太迟了！"))
			return
		if(boomer.stat != CONSCIOUS)
			to_chat(boomer, SPAN_WARNING("在你昏迷时不行..."))
			return
		if(boomer.is_mob_incapacitated() || HAS_TRAIT(boomer, TRAIT_HAULED))
			to_chat(boomer, SPAN_WARNING("你当前的状态无法执行此操作。"))
			return
		if(grounds?.flags_area & AREA_YAUTJA_HUNTING_GROUNDS) //Hunted need mask to escape
			to_chat(boomer, SPAN_WARNING("你的臂铠不允许你启动自毁程序，以保护狩猎场。"))
			return
		if(exploding)
			return
		to_chat(boomer, SPAN_DANGER("你设定了计时器。愿你在通往伟大狩猎场的旅途中一路顺风。"))
		var/area/A = get_area(boomer)
		var/turf/T = get_turf(boomer)
		message_admins(FONT_SIZE_HUGE("ALERT: [boomer] ([boomer.key]) triggered their predator self-destruct sequence [A ? "in [A.name]":""] [ADMIN_JMP(T)]"))
		log_attack("[key_name(boomer)] triggered their predator self-destruct sequence in [A ? "in [A.name]":""]")
		message_all_yautja("[boomer.real_name] has triggered their bracer's self-destruction sequence.")
		explode(boomer)

		var/datum/action/predator_action/bracer/self_destruct/sd_action
		for(sd_action as anything in boomer.actions)
			if(istypestrict(sd_action, /datum/action/predator_action/bracer/self_destruct))
				sd_action.update_button_icon(exploding)
				break

	return TRUE

/obj/item/clothing/gloves/yautja/hunter/verb/remote_kill()
	set name = "Remotely Kill Youngblood"
	set desc = "Remotley kill a youngblood for breaking the honour code."
	set category = "Yautja.Misc"
	set src in usr
	. = remote_kill_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/remote_kill_internal(mob/living/carbon/human/user, forced = FALSE)
	if(!user.loc || user.is_mob_incapacitated() || !ishuman(user))
		return

	if(user.faction == FACTION_YAUTJA_YOUNG)
		to_chat(user, SPAN_WARNING("这个按钮不属于你。"))
		return

	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, SPAN_WARNING("出现了一个长长的列表，但你无法理解其含义。"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/human/target_youngbloods as anything in GLOB.yautja_mob_list)
		if(target_youngbloods.faction == FACTION_YAUTJA_YOUNG && target_youngbloods.stat != DEAD)
			target_list[target_youngbloods.real_name] = target_youngbloods

	if(!length(target_list))
		to_chat(user, SPAN_NOTICE("当前没有存活的年轻猎手。"))
		return

	var/choice = tgui_input_list(user, "选择一名年轻猎手进行处决：", "Kill Youngblood", target_list)

	if(!choice)
		return

	var/mob/living/target_youngblood = target_list[choice]

	var/reason = tgui_input_text(user, "年轻猎手处决者", "Provide a reason for terminating [target_youngblood.real_name].")
	if(!reason)
		to_chat(user, SPAN_WARNING("你必须为处决[target_youngblood.real_name]提供一个理由。"))
		return

	var/area/location = get_area(target_youngblood)
	var/turf/floor = get_turf(target_youngblood)
	target_youngblood.death(create_cause_data("Youngblood Termination"), TRUE)
	message_all_yautja("[user.real_name] has terminated [target_youngblood.real_name] for: '[reason]'.")
	message_admins(FONT_SIZE_LARGE("ALERT: [user.real_name] ([user.key]) Terminated [target_youngblood.real_name] ([target_youngblood.key]) in [location.name] for: '[reason]' [ADMIN_JMP(floor)]</font>"))

#define YAUTJA_CREATE_CRYSTAL_COOLDOWN "yautja_create_crystal_cooldown"

/obj/item/clothing/gloves/yautja/hunter/verb/injectors()
	set name = "生成稳定水晶"
	set category = "Yautja.Utility"
	set desc = "Create a focus crystal to energize your natural healing processes."
	set src in usr
	. = injectors_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/injectors_internal(mob/user, forced = FALSE)
	if(user.is_mob_incapacitated())
		return FALSE

	. = check_random_function(user, forced)
	if(.)
		return

	if(user.get_active_hand())
		to_chat(user, SPAN_WARNING("你的惯用手必须为空！"))
		return FALSE

	if(TIMER_COOLDOWN_CHECK(src, YAUTJA_CREATE_CRYSTAL_COOLDOWN))
		var/remaining_time = DisplayTimeText(S_TIMER_COOLDOWN_TIMELEFT(src, YAUTJA_CREATE_CRYSTAL_COOLDOWN))
		to_chat(user, SPAN_WARNING("你最近合成了一枚稳定水晶。新的水晶将在[remaining_time]后可用。"))
		return FALSE

	if(!drain_power(user, 400))
		return FALSE

	S_TIMER_COOLDOWN_START(src, YAUTJA_CREATE_CRYSTAL_COOLDOWN, 2 MINUTES)

	to_chat(user, SPAN_NOTICE("你感到一阵轻微的嘶嘶声，一枚水晶注射器落入你手中。"))
	var/obj/item/reagent_container/hypospray/autoinjector/yautja/O = new(user)
	user.put_in_active_hand(O)
	playsound(src, 'sound/machines/click.ogg', 15, 1)
	return TRUE
#undef YAUTJA_CREATE_CRYSTAL_COOLDOWN

/obj/item/clothing/gloves/yautja/hunter/verb/healing_capsule()
	set name = "制造治疗胶囊"
	set category = "Yautja.Utility"
	set desc = "Create a healing capsule for your healing gun."
	set src in usr
	. = healing_capsule_internal(usr, FALSE)

#define YAUTJA_CREATE_CAPSULE_COOLDOWN "yautja_create_capsule_cooldown"
/obj/item/clothing/gloves/yautja/hunter/proc/healing_capsule_internal(mob/user, forced = FALSE)
	if(user.is_mob_incapacitated())
		return FALSE

	. = check_random_function(user, forced)
	if(.)
		return

	if(user.get_active_hand())
		to_chat(user, SPAN_WARNING("你的惯用手必须为空！"))
		return FALSE

	if(TIMER_COOLDOWN_CHECK(src, YAUTJA_CREATE_CAPSULE_COOLDOWN))
		var/remaining_time = DisplayTimeText(S_TIMER_COOLDOWN_TIMELEFT(src, YAUTJA_CREATE_CAPSULE_COOLDOWN))
		to_chat(user, SPAN_WARNING("你最近合成了一枚治疗胶囊。新的胶囊将在[remaining_time]后可用。"))
		return FALSE

	if(!drain_power(user, 600))
		return FALSE

	S_TIMER_COOLDOWN_START(src, YAUTJA_CREATE_CAPSULE_COOLDOWN, 4 MINUTES)

	to_chat(user, SPAN_NOTICE("你感到你的腕带一阵搅动，弹出了一枚治疗胶囊。"))
	var/obj/item/tool/surgery/healing_gel/O = new(user)
	user.put_in_active_hand(O)
	playsound(src, 'sound/machines/click.ogg', 15, 1)
	return TRUE

#undef YAUTJA_CREATE_CAPSULE_COOLDOWN

/obj/item/clothing/gloves/yautja/hunter/verb/call_disc()
	set name = "Call Smart-Disc"
	set category = "Yautja.Weapons"
	set desc = "Call back your smart-disc, if it's in range. If not you'll have to go retrieve it."
	set src in usr
	. = call_disc_internal(usr, FALSE)


/obj/item/clothing/gloves/yautja/hunter/proc/call_disc_internal(mob/user, forced = FALSE)
	if(user.is_mob_incapacitated())
		return FALSE

	. = check_random_function(user, forced)
	if(.)
		return

	if(disc_timer)
		to_chat(user, SPAN_WARNING("你的腕带需要一些时间恢复。"))
		return FALSE

	if(!drain_power(user, 70))
		return FALSE

	disc_timer = TRUE
	addtimer(VARSET_CALLBACK(src, disc_timer, FALSE), 10 SECONDS)

	for(var/mob/living/simple_animal/hostile/smartdisc/S in range(7))
		to_chat(user, SPAN_WARNING("[S]向后跳跃，朝你而来！"))
		new /obj/item/explosive/grenade/spawnergrenade/smartdisc(S.loc)
		qdel(S)

	for(var/obj/item/explosive/grenade/spawnergrenade/smartdisc/D in range(10))
		if(isturf(D.loc))
			D.boomerang(user)

	return TRUE

/obj/item/clothing/gloves/yautja/hunter/verb/remove_tracked_item()
	set name = "Remove Item from Tracker"
	set desc = "Remove an item from the Yautja tracker."
	set category = "Yautja.Tracker"
	set src in usr
	. = remove_tracked_item_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/remove_tracked_item_internal(mob/user, forced = FALSE)
	if(user.is_mob_incapacitated())
		return FALSE

	. = check_random_function(user, forced)
	if(.)
		return

	var/obj/item/tracked_item = user.get_active_hand()
	if(!tracked_item)
		to_chat(user, SPAN_WARNING("你需要将物品拿在手中才能将其从追踪系统移除！"))
		return FALSE
	if(!(tracked_item in GLOB.tracked_yautja_gear))
		to_chat(user, SPAN_WARNING("[tracked_item]不在追踪系统上。"))
		return FALSE
	tracked_item.RemoveElement(/datum/element/yautja_tracked_item)
	to_chat(user, SPAN_NOTICE("你将<b>[tracked_item]</b>从追踪系统中移除。"))
	return TRUE


/obj/item/clothing/gloves/yautja/hunter/verb/add_tracked_item()
	set name = "Add Item to Tracker"
	set desc = "Add an item to the Yautja tracker."
	set category = "Yautja.Tracker"
	set src in usr
	. = add_tracked_item_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/add_tracked_item_internal(mob/user, forced = FALSE)
	if(user.is_mob_incapacitated())
		return FALSE

	. = check_random_function(user, forced)
	if(.)
		return

	var/obj/item/untracked_item = user.get_active_hand()
	if(!untracked_item)
		to_chat(user, SPAN_WARNING("你需要将物品拿在手中才能将其从追踪系统移除！"))
		return FALSE
	if(untracked_item in GLOB.tracked_yautja_gear)
		to_chat(user, SPAN_WARNING("[untracked_item]已被追踪。"))
		return FALSE
	untracked_item.AddElement(/datum/element/yautja_tracked_item)
	to_chat(user, SPAN_NOTICE("你将<b>[untracked_item]</b>添加到追踪系统。"))
	return TRUE

/obj/item/clothing/gloves/yautja/hunter/verb/translate()
	set name = "翻译器"
	set desc = "Emit a message from your bracer to those nearby."
	set category = "Yautja.Utility"
	set src in usr
	. = translate_internal(usr, FALSE)

/obj/item/clothing/gloves/yautja/hunter/proc/translate_internal(mob/living/user, forced = FALSE)
	if(!user || user.stat)
		return

	. = check_random_function(user, forced)
	if(.)
		return

	if(user.client.prefs.muted & MUTE_IC)
		to_chat(user, SPAN_DANGER("你无法翻译（静音）。"))
		return

	var/list/heard = get_mobs_in_view(7, user)
	for(var/mob/heard_mob in heard)
		if(heard_mob.ear_deaf)
			heard -= heard_mob

	var/image/translator_bubble = image('icons/mob/effects/talk.dmi', src, "pred_translator", TYPING_LAYER)
	user.show_speech_bubble(heard, looping_bubble = TRUE, animated = FALSE, speech_bubble = translator_bubble)
	var/message = tgui_input_text(user, "腕带发出哔哔声，等待翻译", "翻译器", multiline = TRUE)
	user.remove_speech_bubble(translator_bubble)
	if(!message || !user.client)
		return

	if(!drain_power(user, 50))
		return

	user.show_speech_bubble(heard, "pred_translator1")

	log_say("[user.name != "未知" ? user.name : "([user.real_name])"] \[Yautja Translator\]: [message] (CKEY: [user.key]) (JOB: [user.job]) (AREA: [get_area_name(user)])")

	var/overhead_color = "#ff0505"
	var/span_class = "yautja_translator"
	if(translator_type != PRED_TECH_MODERN)
		if(translator_type == PRED_TECH_RETRO)
			overhead_color = "#FFFFFF"
			span_class = "retro_translator"
		message = replacetext(message, "a", "@")
		message = replacetext(message, "e", "3")
		message = replacetext(message, "i", "1")
		message = replacetext(message, "o", "0")
		message = replacetext(message, "s", "5")
		message = replacetext(message, "l", "1")

	user.langchat_speech(message, heard, GLOB.all_languages, overhead_color, TRUE)

	var/voice_name = "A strange voice"
	if(user.name == user.real_name && user.alpha == initial(user.alpha))
		voice_name = "<b>[user.name]</b>"
	for(var/mob/heard_human as anything in heard)
		if(heard_human.stat && !isobserver(heard_human))
			continue //Unconscious
		to_chat(heard_human, "[SPAN_INFO("[voice_name] says,")] <span class='[span_class]'>'[message]'</span>")

/obj/item/clothing/gloves/yautja/hunter/verb/bracername()
	set name = "切换腕甲名称"
	set desc = "Toggle whether fellow Yautja that examine you will be able to see your name."
	set category = "Yautja.Misc"
	set src in usr

	if(usr.is_mob_incapacitated())
		return

	name_active = !name_active
	to_chat(usr, SPAN_NOTICE("[src]将[name_active ? "now" : "no longer"] show your name when fellow Yautja examine you."))

/obj/item/clothing/gloves/yautja/hunter/verb/idchip()
	set name = "Toggle ID Chip"
	set desc = "Reveal/Hide your embedded bracer ID chip."
	set category = "Yautja.Misc"
	set src in usr

	if(usr.is_mob_incapacitated())
		return

	var/mob/living/carbon/human/H = usr
	if(!istype(H) || !HAS_TRAIT(usr, TRAIT_YAUTJA_TECH))
		to_chat(usr, SPAN_WARNING("你不知道如何使用这个。"))
		return

	if(H.wear_id == embedded_id)
		to_chat(H, SPAN_NOTICE("你收回了你的身份芯片。"))
		move_chip_to_bracer()
	else if(H.wear_id)
		to_chat(H, SPAN_WARNING("有东西阻碍了你的身份芯片部署！"))
	else
		to_chat(H, SPAN_NOTICE("你暴露了你的身份芯片。"))
		if(!H.equip_to_slot_if_possible(embedded_id, WEAR_ID))
			to_chat(H, SPAN_WARNING("芯片部署过程中出现错误！（请为此提交错误报告）"))
			move_chip_to_bracer()

/obj/item/clothing/gloves/yautja/hunter/proc/move_chip_to_bracer()
	if(!embedded_id || !embedded_id.loc)
		return

	if(embedded_id.loc == src)
		return

	if(ismob(embedded_id.loc))
		var/mob/M = embedded_id.loc
		M.u_equip(embedded_id, src, FALSE, TRUE)
	else
		embedded_id.forceMove(src)

/// Verb to let Yautja attempt the unlocking.
/obj/item/clothing/gloves/yautja/hunter/verb/toggle_lock()
	set name = "Toggle Bracer Lock"
	set desc = "Toggle the lock on your bracers, allowing them to be removed."
	set category = "Yautja.Misc"
	set src in usr

	if(usr.stat)
		to_chat(usr, SPAN_WARNING("你现在无法这么做……"))
		return FALSE
	if(!HAS_TRAIT(usr, TRAIT_YAUTJA_TECH))
		to_chat(usr, SPAN_WARNING("你完全不知道如何使用这个……"))
		return FALSE

	attempt_toggle_lock(usr, FALSE)
	return TRUE

/// Handles all the locking and unlocking of bracers.
/obj/item/clothing/gloves/yautja/proc/attempt_toggle_lock(mob/user, force_lock)
	if(!user)
		return FALSE

	var/obj/item/grab/held_mob = user.get_active_hand()
	if(!istype(held_mob))
		log_attack("[key_name_admin(user)] has unlocked their own bracer.")
		toggle_lock_internal(user)
		return TRUE

	var/mob/living/carbon/human/victim = held_mob.grabbed_thing
	var/obj/item/clothing/gloves/yautja/bracer = victim.gloves
	if(isspeciesyautja(victim) && !(victim.stat == DEAD))
		to_chat(user, SPAN_WARNING("你无法解锁活着的猎手的腕带！"))
		return FALSE

	if(!istype(bracer))
		to_chat(user, SPAN_WARNING("<b>这个[victim.species]没有佩戴腕带。</b>"))
		return FALSE

	if(alert("Are you sure you want to unlock this [victim.species]'s bracer?", "解锁腕带", "Yes", "No") != "Yes")
		return FALSE

	if(user.get_active_hand() == held_mob && victim && victim.gloves == bracer)
		log_interact(user, victim, "[key_name(user)] unlocked the [bracer.name] of [key_name(victim)].")
		user.visible_message(SPAN_WARNING("[user]按下了[victim]手腕上腕带的几个按钮。"),SPAN_DANGER("You unlock the bracer."))
		bracer.toggle_lock_internal(victim)
		return TRUE

/// The actual unlock/lock function.
/obj/item/clothing/gloves/yautja/proc/toggle_lock_internal(mob/wearer, force_lock)
	if(((flags_item & NODROP) || (flags_inventory & CANTSTRIP)) && !force_lock)
		return unlock_bracer(wearer)

	return lock_bracer(wearer)

/obj/item/clothing/gloves/yautja/proc/lock_bracer(mob/wearer)
	flags_item |= NODROP
	flags_inventory |= CANTSTRIP
	if(wearer)
		if(isyautja(wearer))
			to_chat(wearer, SPAN_WARNING("腕带牢固地扣在你的前臂上，并以一种舒适、熟悉的方式发出哔哔声。"))
		else
			to_chat(wearer, SPAN_WARNING("臂铠紧紧箍住你的前臂，发出愤怒的蜂鸣声。它取不下来了！"))
	playsound(src, 'sound/items/air_release.ogg', 15, 1)
	return TRUE

/obj/item/clothing/gloves/yautja/proc/unlock_bracer(mob/wearer)
	flags_item &= ~NODROP
	flags_inventory &= ~CANTSTRIP
	if(wearer)
		if(!isyautja(wearer))
			to_chat(wearer, SPAN_WARNING("臂铠发出悦耳的蜂鸣声，松开了你的前臂。"))
		else
			to_chat(wearer, SPAN_WARNING("伴随着一声愤怒的鸣响，臂铠松开了你的前臂。"))
	playsound(src, 'sound/items/air_release.ogg', 15, 1)
	return TRUE
