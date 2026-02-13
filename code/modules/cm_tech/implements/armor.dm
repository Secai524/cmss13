
/obj/item/clothing/accessory/health
	name = "装甲板"
	desc = "一块金属创伤板，能够吸收部分冲击。"
	icon = 'icons/obj/items/ceramic_plates.dmi'
	icon_state = "regular2_100"
	var/base_icon_state = "regular2"

	worn_accessory_slot = ACCESSORY_SLOT_ARMOR_C
	w_class = SIZE_MEDIUM
	/// is it *armor* or something different & irrelevant and always passes damage & doesnt take damage to itself?
	var/is_armor = TRUE
	var/armor_health = 10
	var/armor_maxhealth = 10
	var/take_slash_damage = TRUE
	var/slash_durability_mult = 0.25
	var/FF_projectile_durability_mult = 0.1
	var/hostile_projectile_durability_mult = 1

	var/list/health_states = list(
		0,
		50,
		100
	)

	var/scrappable = TRUE
	var/armor_hitsound = 'sound/effects/metalhit.ogg'
	var/armor_shattersound = 'sound/effects/metal_shatter.ogg'

/obj/item/clothing/accessory/health/update_icon()
	for(var/health_state in health_states)
		if(armor_health / armor_maxhealth * 100 <= health_state)
			icon_state = "[base_icon_state]_[health_state]"
			return

/obj/item/clothing/accessory/health/proc/get_damage_status()
	var/percentage = floor(armor_health / armor_maxhealth * 100)
	switch(percentage)
		if(0)
			. = "It is broken."
			if(scrappable)
				. += " If you had two, you could repair it."
		if(1 to 19)
			. = "It is crumbling apart!"
		if(20 to 49)
			. = "It is seriously damaged."
		if(50 to 79)
			. = "It is moderately damaged."
		if(80 to 99)
			. = "It is slightly damaged."
		else
			. = "It is in pristine condition."

/obj/item/clothing/accessory/health/get_examine_text(mob/user)
	. = ..()
	. += "To use it, attach it to your uniform."
	. += SPAN_NOTICE(get_damage_status())

/obj/item/clothing/accessory/health/additional_examine_text()
	. = ..()

	. += "[get_damage_status()]"

/obj/item/clothing/accessory/health/on_attached(obj/item/clothing/S, mob/living/carbon/human/user)
	. = ..()
	if(.)
		RegisterSignal(S, COMSIG_ITEM_EQUIPPED, PROC_REF(check_to_signal))
		RegisterSignal(S, COMSIG_ITEM_DROPPED, PROC_REF(unassign_signals))

		if(istype(user) && user.w_uniform == S)
			check_to_signal(S, user, WEAR_BODY)

/obj/item/clothing/accessory/health/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	if(.)
		unassign_signals(C, user)
		UnregisterSignal(C, list(
			COMSIG_ITEM_EQUIPPED,
			COMSIG_ITEM_DROPPED
		))

/obj/item/clothing/accessory/health/proc/check_to_signal(obj/item/clothing/S, mob/living/user, slot)
	SIGNAL_HANDLER

	if(slot == WEAR_BODY)
		if(take_slash_damage)
			RegisterSignal(user, COMSIG_HUMAN_XENO_ATTACK, PROC_REF(take_slash_damage))
		RegisterSignal(user, COMSIG_HUMAN_BULLET_ACT, PROC_REF(take_bullet_damage))
	else
		unassign_signals(S, user)

/obj/item/clothing/accessory/health/proc/unassign_signals(obj/item/clothing/S, mob/living/user)
	SIGNAL_HANDLER

	UnregisterSignal(user, list(
		COMSIG_HUMAN_XENO_ATTACK,
		COMSIG_HUMAN_BULLET_ACT
	))

/obj/item/clothing/accessory/health/proc/take_bullet_damage(mob/living/carbon/human/user, damage, ammo_flags, obj/projectile/P)
	SIGNAL_HANDLER
	if(damage <= 0 || (ammo_flags & AMMO_IGNORE_ARMOR))
		return
	if(!is_armor)
		return
	var/damage_to_nullify = armor_health
	var/final_proj_mult = FF_projectile_durability_mult

	var/mob/living/carbon/human/pfirer = P.firer
	if(user.faction != pfirer.faction)
		final_proj_mult = hostile_projectile_durability_mult
	armor_health = max(armor_health - damage*final_proj_mult, 0)

	update_icon()
	if(!armor_health && damage_to_nullify)
		user.show_message(SPAN_WARNING("你感觉到[src]碎裂开来。"), null, null, null, CHAT_TYPE_ARMOR_DAMAGE)
		playsound(user, armor_shattersound, 35, TRUE)

	if(damage_to_nullify)
		playsound(user, armor_hitsound, 25, TRUE)
		P.play_hit_effect(user)
		return COMPONENT_CANCEL_BULLET_ACT

/obj/item/clothing/accessory/health/proc/take_slash_damage(mob/living/user, list/slashdata)
	SIGNAL_HANDLER
	if(!is_armor)
		return
	var/armor_damage = slashdata["n_damage"]
	var/damage_to_nullify = armor_health
	armor_health = max(armor_health - armor_damage*slash_durability_mult, 0)

	update_icon()
	if(!armor_health && damage_to_nullify)
		user.show_message(SPAN_WARNING("你感觉到[src]碎裂开来。"), null, null, null, CHAT_TYPE_ARMOR_DAMAGE)
		playsound(user, armor_shattersound, 50, TRUE)

	if(damage_to_nullify)
		slashdata["n_damage"] = 0
		slashdata["slash_noise"] = armor_hitsound

/obj/item/clothing/accessory/health/attackby(obj/item/clothing/accessory/health/I, mob/user)
	if(!istype(I, src.type) || !scrappable || has_suit || I.has_suit || !is_armor)
		return

	if(!I.armor_health && !armor_health)
		to_chat(user, SPAN_NOTICE("你利用护甲碎片拼凑出一块临时陶瓷板。"))
		qdel(I)
		qdel(src)
		user.put_in_active_hand(new /obj/item/clothing/accessory/health/scrap())


/obj/item/clothing/accessory/health/ceramic_plate
	name = "陶瓷板"
	desc = "一块坚固的创伤板，能保护使用者抵御大量子弹。对尖锐物体效果不佳。"
	icon_state = "ceramic2_100"
	base_icon_state = "ceramic2"

	take_slash_damage = FALSE
	scrappable = FALSE
	FF_projectile_durability_mult = 0.3

	armor_health = 100
	armor_maxhealth = 100

	armor_shattersound = 'sound/effects/ceramic_shatter.ogg'

/obj/item/clothing/accessory/health/ceramic_plate/take_bullet_damage(mob/living/user, damage, ammo_flags)
	if(ammo_flags & AMMO_ACIDIC)
		return

	return ..()

/obj/item/clothing/accessory/health/ceramic_plate/take_slash_damage(mob/living/user, list/slashdata)
	return

/obj/item/clothing/accessory/health/scrap
	name = "金属废料"
	desc = "一块薄弱的护甲板，仅能提供少量防护。也许这就够了。"
	icon_state = "scrap_100"
	base_icon_state = "scrap"
	health_states = list(
		0,
		100,
	)

	scrappable = FALSE

	armor_health = 7.5
	armor_maxhealth = 7.5

/obj/item/clothing/accessory/health/scrap/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	if(. && !armor_health)
		qdel(src)

/obj/item/clothing/accessory/health/scrap/take_bullet_damage(mob/living/user, damage, ammo_flags)
	if(ammo_flags & AMMO_ACIDIC)
		return

	return ..()

/obj/item/clothing/accessory/health/scrap/take_slash_damage(mob/living/user, list/slashdata)
	return

/obj/item/clothing/accessory/health/research_plate
	name = "实验型制服附件"
	desc = "制服附件，提供X功能（这东西不该在你手上）"
	is_armor = FALSE
	icon_state = "plate_research"
	icon = 'icons/obj/items/devices.dmi'
	ground_offset_x = 8
	ground_offset_y = 8
	var/obj/item/clothing/attached_uni
	///can the plate be recycled after X condition? 0 means it cannot be recycled, otherwise put in the biomass points to refund.
	var/recyclable_value = 0

/obj/item/clothing/accessory/health/research_plate/Destroy()
	attached_uni = null
	. = ..()

/obj/item/clothing/accessory/health/research_plate/on_attached(obj/item/clothing/attached_to, mob/living/carbon/human/user)
	. = ..()
	attached_uni = attached_to
	RegisterSignal(user, COMSIG_MOB_ITEM_UNEQUIPPED, PROC_REF(on_removed_sig))

/obj/item/clothing/accessory/health/research_plate/proc/can_recycle(mob/living/user) //override this proc for check if you can recycle the plate.
	return FALSE

/obj/item/clothing/accessory/health/research_plate/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_ITEM_UNEQUIPPED)

/obj/item/clothing/accessory/health/research_plate/proc/on_removed_sig(mob/living/user, slot)
	SIGNAL_HANDLER
	if(slot != attached_uni)
		return FALSE
	UnregisterSignal(user, COMSIG_MOB_ITEM_UNEQUIPPED)
	return TRUE

/obj/item/clothing/accessory/health/research_plate/translator
	name = "实验型语言翻译器"
	desc = "无需语言输入即可翻译护板上麦克风接收到的任何语言，能够翻译前所未闻的语言以及已知语言。"

/obj/item/clothing/accessory/health/research_plate/translator/on_attached(obj/item/clothing/S, mob/living/carbon/human/user)
	. = ..()
	to_chat(user, SPAN_NOTICE("[src]发出嗡嗡声，开始监听输入。"))
	user.universal_understand = TRUE

/obj/item/clothing/accessory/health/research_plate/translator/on_removed(mob/living/carbon/human/user, obj/item/clothing/C)
	. = ..()
	if(user.universal_understand)
		to_chat(user, SPAN_NOTICE("[src]发出悲伤的呜鸣声，随后关机。"))
		attached_uni = null
		if(user.chem_effect_flags & CHEM_EFFECT_HYPER_THROTTLE) // we are currently under effect of simular univeral understand drug.
			return
		user.universal_understand = FALSE

/obj/item/clothing/accessory/health/research_plate/translator/on_removed_sig(mob/living/carbon/human/user, slot)
	. = ..()
	if(. == FALSE)
		return
	if(user.universal_understand)
		to_chat(user, SPAN_NOTICE("[src]在关机时发出呜鸣声。"))
		if(user.chem_effect_flags & CHEM_EFFECT_HYPER_THROTTLE) // we are currently under effect of simular univeral understand drug.
			return
		attached_uni = null
		user.universal_understand = FALSE

/obj/item/clothing/accessory/health/research_plate/coagulator
	name = "实验型血液凝固器"
	desc = "一种通过多个传感器和辐射发射器协同作用促进血液凝固的装置。卫生局局长警告，持续暴露于辐射可能危害健康。"

/obj/item/clothing/accessory/health/research_plate/coagulator/on_attached(obj/item/clothing/S, mob/living/carbon/human/user)
	. = ..()
	RegisterSignal(user, COMSIG_BLEEDING_PROCESS, PROC_REF(cancel_bleeding))
	to_chat(user, SPAN_NOTICE("激活[src]时，你感到一阵酥麻。"))

/obj/item/clothing/accessory/health/research_plate/coagulator/proc/cancel_bleeding()
	SIGNAL_HANDLER
	return COMPONENT_BLEEDING_CANCEL

/obj/item/clothing/accessory/health/research_plate/coagulator/on_removed(mob/living/carbon/human/user, obj/item/clothing/C)
	. = ..()
	to_chat(user, SPAN_NOTICE("你感觉到[src]从你的皮肤上剥离。"))
	UnregisterSignal(user, COMSIG_BLEEDING_PROCESS)
	attached_uni = null

/obj/item/clothing/accessory/health/research_plate/coagulator/on_removed_sig(mob/living/carbon/human/user, slot)
	. = ..()
	if(. == FALSE)
		return
	UnregisterSignal(user, COMSIG_BLEEDING_PROCESS)
	attached_uni = null

/obj/item/clothing/accessory/health/research_plate/emergency_injector
	name = "应急化学板"
	desc = "一次性研究用护板，内含多种化学药剂，使用者可同时按下两侧按钮进行注射。注射过程无痛、瞬时，且携带的化学药剂远超普通应急注射器。配备三种模式的用药过量保护功能。"
	var/od_protection_mode = EMERGENCY_PLATE_OD_PROTECTION_DYNAMIC
	var/datum/action/item_action/activation
	var/mob/living/wearer
	var/used = FALSE
	/// 1 means the player overdosed with OD_OFF mode. 2 means the plate adjusted the chemicals injected.
	var/warning_type = FALSE
	var/list/chemicals_to_inject = list(
		"oxycodone" = 20,
		"bicaridine" = 30,
		"kelotane" = 30,
		"meralyne" = 15,
		"dermaline" = 15,
		"dexalinp" = 1,
		"inaprovaline" = 30,
	)
	recyclable_value = 100

/obj/item/clothing/accessory/health/research_plate/emergency_injector/Destroy()
	wearer = null
	if(!QDELETED(activation))
		QDEL_NULL(activation)
	. = ..()

/obj/item/clothing/accessory/health/research_plate/emergency_injector/get_examine_text(mob/user)
	. = ..()
	. += SPAN_INFO("ALT-Clicking the plate will toggle overdose protection.")
	. += SPAN_INFO("Overdose protection seems to be [od_protection_mode == 1 ? "ON" : od_protection_mode == 2 ? "DYNAMIC" : "OFF"]")
	if(used)
		. += SPAN_WARNING("It is already used!")

/obj/item/clothing/accessory/health/research_plate/emergency_injector/clicked(mob/user, list/mods)
	. = ..()
	if(mods[ALT_CLICK])
		var/text = "You toggle overdose protection "
		if(od_protection_mode == EMERGENCY_PLATE_OD_PROTECTION_DYNAMIC)
			od_protection_mode = EMERGENCY_PLATE_OD_PROTECTION_OFF
			text += "to OVERRIDE. Overdose protection is now offline."
		else
			od_protection_mode++
			if(od_protection_mode == EMERGENCY_PLATE_OD_PROTECTION_DYNAMIC)
				text += "to DYNAMIC. Overdose subsystems will inject chemicals but will not go above overdose levels."
			else
				text += "to STRICT. Overdose subsystems will refuse to inject if any of chemicals will overdose."
		to_chat(user, SPAN_NOTICE(text))
		return TRUE
	return

/obj/item/clothing/accessory/health/research_plate/emergency_injector/can_recycle(mob/living/user)
	if(used)
		return TRUE
	return FALSE

/obj/item/clothing/accessory/health/research_plate/emergency_injector/on_attached(obj/item/clothing/S, mob/living/carbon/human/user)
	. = ..()
	wearer = user
	activation = new /datum/action/item_action/toggle/emergency_plate/inject_chemicals(src, attached_uni)
	activation.give_to(wearer)

/obj/item/clothing/accessory/health/research_plate/emergency_injector/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	QDEL_NULL(activation)
	attached_uni = null

/obj/item/clothing/accessory/health/research_plate/emergency_injector/on_removed_sig(mob/living/carbon/human/user, slot)
	. = ..()
	if(. == FALSE)
		return
	QDEL_NULL(activation)
	attached_uni = null

//Action buttons
/datum/action/item_action/toggle/emergency_plate/inject_chemicals/New(Target, obj/item/holder)
	. = ..()
	name = "注射应急护板"
	action_icon_state = "plate_research"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/obj/items/devices.dmi', button, action_icon_state)

/obj/item/clothing/accessory/health/research_plate/emergency_injector/ui_action_click(mob/owner, obj/item/holder)
	if(used)
		to_chat(wearer, SPAN_DANGER("[src]的内部储备已空，请更换护板！"))
		return
	for(var/chemical in chemicals_to_inject)
		var/datum/reagent/reag = GLOB.chemical_reagents_list[chemical]
		if(wearer.reagents.get_reagent_amount(chemical) + chemicals_to_inject[chemical] > reag.overdose)
			if(od_protection_mode == EMERGENCY_PLATE_OD_PROTECTION_STRICT)
				to_chat(wearer, SPAN_DANGER("你按住两个按钮，但护板发出嗡嗡声并拒绝注射，提示可能用药过量！"))
				return
			if (od_protection_mode == EMERGENCY_PLATE_OD_PROTECTION_DYNAMIC)
				var/adjust_volume_to_inject = reag.overdose - wearer.reagents.get_reagent_amount(chemical)
				chemicals_to_inject[chemical] = adjust_volume_to_inject
				warning_type = EMERGENCY_PLATE_ADJUSTED_WARNING
		if(wearer.reagents.get_reagent_amount(chemical) + chemicals_to_inject[chemical] > reag.overdose && od_protection_mode == EMERGENCY_PLATE_OD_PROTECTION_OFF)
			warning_type = EMERGENCY_PLATE_OD_WARNING
		wearer.reagents.add_reagent(chemical, chemicals_to_inject[chemical])
	if(warning_type == EMERGENCY_PLATE_OD_WARNING)
		to_chat(wearer, SPAN_DANGER("你按住两个按钮，护板注射了化学药剂，但发出令人担忧的哔哔声，提示用药过量！"))
	if(warning_type == EMERGENCY_PLATE_ADJUSTED_WARNING)
		to_chat(wearer, SPAN_DANGER("你按住两个按钮，护板注射了化学药剂，并发出令人安心的哔哔声，提示其已调整注射量以防止用药过量！"))
	playsound(loc, "sound/items/air_release.ogg", 100, TRUE)
	used = TRUE

/obj/item/clothing/accessory/health/research_plate/anti_decay
	name = "实验性维生板"
	desc = "一种在用户死亡时激活的维生板，使用多种不同物质和传感器来减缓腐败，将用户永久死亡的时间从5分钟延长至约9分钟。"
	var/mob/living/carbon/human/wearer


/obj/item/clothing/accessory/health/research_plate/anti_decay/Destroy()
	. = ..()
	wearer = null

/obj/item/clothing/accessory/health/research_plate/anti_decay/on_attached(obj/item/clothing/S, mob/living/carbon/human/user)
	. = ..()
	wearer = user
	RegisterSignal(user, COMSIG_MOB_DEATH, PROC_REF(begin_preserving))
	user.revive_grace_period += 4 MINUTES

/obj/item/clothing/accessory/health/research_plate/anti_decay/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	wearer = null
	attached_uni = null

/obj/item/clothing/accessory/health/research_plate/anti_decay/on_removed_sig(mob/living/user, slot)
	. = ..()
	if(. == FALSE)
		return
	wearer = null
	attached_uni = null

/obj/item/clothing/accessory/health/research_plate/anti_decay/proc/begin_preserving()
	SIGNAL_HANDLER
	UnregisterSignal(wearer, COMSIG_MOB_DEATH)
	to_chat(wearer, SPAN_NOTICE("[src]检测到你的死亡，开始注射多种化学物质以延缓你的最终消亡！"))
	RegisterSignal(wearer, COMSIG_HUMAN_REVIVED, PROC_REF(reset_use))

/obj/item/clothing/accessory/health/research_plate/anti_decay/proc/reset_use()
	SIGNAL_HANDLER
	UnregisterSignal(wearer, COMSIG_HUMAN_REVIVED)
	to_chat(wearer, SPAN_NOTICE("[icon2html(src, viewers(src))] \The <b>[src]</b>发出哔哔声：检测到用户生命体征，停止维生程序。"))
	wearer.revive_grace_period = 9 MINUTES







