/obj/item/device/defibrillator
	name = "紧急除颤器"
	desc = "手持式紧急除颤器，用于恢复心室颤动患者的心跳。可选择性地将人从死亡中救回。"
	icon_state = "defib"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	item_state = "defib"
	icon = 'icons/obj/items/medical_tools.dmi'
	flags_atom = FPRINT|CONDUCT
	flags_item = NOBLUDGEON
	flags_equip_slot = SLOT_WAIST
	force = 5
	throwforce = 5
	w_class = SIZE_MEDIUM

	///If target's chest is blocked
	var/blocked_by_suit = TRUE
	/// Min damage defib deals to victims' heart
	var/min_heart_damage_dealt = 3
	/// Max damage defib deals to victims' heart
	var/max_heart_damage_dealt = 5
	var/ready = 0
	var/damage_heal_threshold = 12 //This is the maximum non-oxy damage the defibrillator will heal to get a patient above -100, in all categories
	var/datum/effect_system/spark_spread/spark_system = new /datum/effect_system/spark_spread
	var/charge_cost = 66 //How much energy is used.
	var/obj/item/cell/dcell = null
	var/datum/effect_system/spark_spread/sparks = new
	var/defib_cooldown = 0 //Cooldown for toggling the defib
	var/shock_cooldown = 0 //cooldown for shocking someone - separate to toggling
	var/base_icon_state = "defib" //used for overlays of charge

	/// Skill requirements.
	var/skill_to_check = SKILL_MEDICAL
	var/skill_level = SKILL_MEDICAL_MEDIC
	var/skill_to_check_alt = null
	var/skill_level_alt = 0
	/// If the defib can be used by anyone.
	var/noskill = FALSE

	/// If defib should produce visual sparks on revive.
	var/should_spark = TRUE

	/// Used for different descriptions and other fluff text.
	var/fluff_tool = "paddles"
	var/fluff_target_part = "chest"
	var/fluff_revive_message = "Defibrillation successful"

	/// Sound sets for different defibs.
	var/sound_charge = 'sound/items/defib_charge.ogg'
	var/sound_charge_skill4 = 'sound/items/defib_charge_skill4.ogg'
	var/sound_charge_skill3 = 'sound/items/defib_charge_skill3.ogg'
	var/sound_failed = 'sound/items/defib_failed.ogg'
	var/sound_success = 'sound/items/defib_success.ogg'
	var/sound_safety_on = 'sound/items/defib_safetyOn.ogg'
	var/sound_safety_off = 'sound/items/defib_safetyOff.ogg'
	var/sound_release = 'sound/items/defib_release.ogg'

/mob/living/carbon/human/proc/check_tod()
	if(!undefibbable && world.time <= timeofdeath + revive_grace_period)
		return TRUE
	return FALSE

/obj/item/device/defibrillator/Initialize(mapload, ...)
	. = ..()

	if(should_spark)
		sparks.set_up(5, 0, src)
		sparks.attach(src)
	dcell = new/obj/item/cell(src)
	update_icon()

/obj/item/device/defibrillator/Destroy()
	QDEL_NULL(dcell)
	if(should_spark)
		QDEL_NULL(sparks)
	return ..()

/obj/item/device/defibrillator/update_icon()
	icon_state = initial(icon_state)
	overlays.Cut()

	if(ready)
		icon_state += "_out"

	if(dcell && dcell.charge)
		switch(floor(dcell.charge * 100 / dcell.maxcharge))
			if(67 to INFINITY)
				overlays += "+[base_icon_state]full"
			if(34 to 66)
				overlays += "+[base_icon_state]half"
			if(3 to 33)
				overlays += "+[base_icon_state]low"
			if(0 to 3)
				overlays += "+[base_icon_state]empty"
	else
		overlays += "+[base_icon_state]empty"

/obj/item/device/defibrillator/get_examine_text(mob/user)
	. = ..()
	var/maxuses = 0
	var/currentuses = 0
	maxuses = floor(dcell.maxcharge / charge_cost)
	currentuses = floor(dcell.charge / charge_cost)
	if(maxuses != 1)
		. += SPAN_INFO("It has [currentuses] out of [maxuses] uses left in its internal battery.")
	if(MODE_HAS_MODIFIER(/datum/gamemode_modifier/defib_past_armor) || !blocked_by_suit  && !istype(src, /obj/item/device/defibrillator/synthetic))
		. += SPAN_NOTICE("This defibrillator will ignore worn armor.")

/obj/item/device/defibrillator/attack_self(mob/living/carbon/human/user)
	..()

	if(defib_cooldown > world.time) //cooldown only to prevent spam toggling
		return

	//Job knowledge requirement
	if(user.skills && !noskill)
		if(!skillcheck(user, skill_to_check, skill_level))
			if(!skill_to_check_alt || (!skillcheck(user, skill_to_check_alt, skill_level_alt)))
				to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
				return

	defib_cooldown = world.time + 10 //1 second cooldown every time the defib is toggled
	ready = !ready
	user.visible_message(SPAN_NOTICE("[user]将[src] [ready? "on and takes the [fluff_tool] out" : "off and puts the [fluff_tool] back in"]."),
	SPAN_NOTICE("You turn [src] [ready? "on and take the [fluff_tool] out" : "off and put the [fluff_tool] back in"]."))
	if(should_spark)
		playsound(get_turf(src), "sparks", 15, 1, 0)
	if(ready)
		w_class = SIZE_LARGE
		playsound(get_turf(src), sound_safety_on, 25, 0)
	else
		w_class = initial(w_class)
		playsound(get_turf(src), sound_safety_off, 25, 0)
	update_icon()
	add_fingerprint(user)

/mob/living/carbon/human/proc/get_ghost(check_client = TRUE, check_can_reenter = TRUE)
	if(client)
		return null

	for(var/mob/dead/observer/G in GLOB.observer_list)
		if(G.mind && G.mind.original == src)
			var/mob/dead/observer/ghost = G
			if(ghost && (!check_client || ghost.client) && (!check_can_reenter || ghost.can_reenter_corpse))
				return ghost

/mob/living/carbon/human/proc/is_revivable(ignore_heart = FALSE)
	if(isnull(internal_organs_by_name) || isnull(internal_organs_by_name["heart"]))
		return FALSE
	var/datum/internal_organ/heart/heart = internal_organs_by_name["heart"]
	var/obj/limb/head = get_limb("head")

	if(chestburst || !head || head.status & LIMB_DESTROYED || !ignore_heart && (!heart || heart.organ_status >= ORGAN_BROKEN) || !has_brain() || status_flags & PERMANENTLY_DEAD)
		return FALSE
	return TRUE

/obj/item/device/defibrillator/proc/check_revive(mob/living/carbon/human/H, mob/living/carbon/human/user)
	if(!ishuman(H) || isyautja(H))
		to_chat(user, SPAN_WARNING("你无法对[H]进行除颤。你甚至不知道该把[fluff_tool]放在哪里！"))
		return
	if(issynth(H))
		to_chat(user, SPAN_WARNING("你无法对[H]进行除颤。你需要合成人重置密钥来重启！"))
		return
	if(!ready)
		balloon_alert(user, "取出[fluff_tool]")
		to_chat(user, SPAN_WARNING("先把[src]的[fluff_tool]取出来。"))
		return
	if(dcell.charge < charge_cost)
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src]的电池电量太低！需要充电。"))
		return
	if(H.stat != DEAD)
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src]发出嗡嗡声：检测到生命体征。中止操作。"))
		return

	if(!H.is_revivable())
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src]发出嗡嗡声：患者的总体状况不允许复苏。"))
		return

	if((!MODE_HAS_MODIFIER(/datum/gamemode_modifier/defib_past_armor) && blocked_by_suit) && H.wear_suit && (istype(H.wear_suit, /obj/item/clothing/suit/armor) || istype(H.wear_suit, /obj/item/clothing/suit/storage/marine)) && prob(95))
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：电极板检测到电阻 >100,000 欧姆。可能原因：防护服或护甲干扰。"))
		return

	if(!H.check_tod())
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：患者脑死亡。"))
		return

	return TRUE

/obj/item/device/defibrillator/proc/can_defib(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(shock_cooldown > world.time) //cooldown is only for shocking, this is so that you can immediately shock when you take the paddles out - stan_albatross
		return FALSE

	shock_cooldown = world.time + 20 //2 second cooldown before you can try shocking again

	if(user.action_busy) //Currently deffibing
		return FALSE

	//job knowledge requirement
	if(user.skills && !noskill)
		if(!skillcheck(user, skill_to_check, skill_level))
			if(!skill_to_check_alt || (!skillcheck(user, skill_to_check_alt, skill_level_alt)))
				to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
				return

	if(!check_revive(target, user))
		return FALSE

	var/mob/dead/observer/G = target.get_ghost()
	if(istype(G) && G.client)
		playsound_client(G.client, 'sound/effects/adminhelp_new.ogg')
		to_chat(G, SPAN_BOLDNOTICE(FONT_SIZE_LARGE("Someone is trying to revive your body. Return to it if you want to be resurrected! \
			(Verbs -> Ghost -> Re-enter corpse, or <a href='byond://?src=\ref[G];reentercorpse=1'>click here!</a>)")))

	user.visible_message(SPAN_NOTICE("[user] 开始在[target]的[fluff_target_part]上设置[fluff_tool]。"),
		SPAN_HELPFUL("You start <b>setting up</b> the [fluff_tool] on <b>[target]</b>'s [fluff_target_part]."))
	if(user.get_skill_duration_multiplier(SKILL_MEDICAL) == 0.35)
		playsound(get_turf(src), sound_charge_skill4, 25, 0)
	else if(user.get_skill_duration_multiplier(SKILL_MEDICAL) == 0.75)
		playsound(get_turf(src), sound_charge_skill3, 25, 0)
	else
		playsound(get_turf(src), sound_charge, 25, 0) //Do NOT vary this tune, it needs to be precisely 7 seconds

	//Taking square root not to make defibs too fast...
	if(!do_after(user, (4 + (3 * user.get_skill_duration_multiplier(SKILL_MEDICAL))) SECONDS, INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, target, INTERRUPT_MOVED, BUSY_ICON_MEDICAL))
		user.visible_message(SPAN_WARNING("[user] 停止在[target]的[fluff_target_part]上设置[fluff_tool]。"),
		SPAN_WARNING("You stop setting up the [fluff_tool] on [target]'s [fluff_target_part]."))
		return FALSE

	if(!check_revive(target, user))
		return FALSE

	return TRUE

/obj/item/device/defibrillator/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!can_defib(target, user))
		return FALSE

	//Do this now, order doesn't matter
	sparks.start()
	dcell.use(charge_cost)
	update_icon()
	playsound(get_turf(src), sound_release, 25, 1)
	user.visible_message(SPAN_NOTICE("[user] 用[fluff_tool]电击了[target]。"),
		SPAN_HELPFUL("You shock <b>[target]</b> with the [fluff_tool]."))
	target.visible_message(SPAN_DANGER("[target]的身体抽搐了一下。"))
	shock_cooldown = world.time + 10 //1 second cooldown before you can shock again

	var/datum/internal_organ/heart/heart = target.internal_organs_by_name["heart"]

	if(!target.is_revivable())
		playsound(get_turf(src), sound_failed, 25, 0)
		if(heart && heart.organ_status >= ORGAN_BROKEN)
			user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：除颤失败。患者心脏损伤过重。建议立即进行手术。"))
			msg_admin_niche("[key_name_admin(user)] failed an attempt to revive [key_name_admin(target)] with [src] because of heart damage.")
			return
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：除颤失败。患者的整体状况不允许复苏。"))
		msg_admin_niche("[key_name_admin(user)] failed an attempt to revive [key_name_admin(target)] with [src].")
		return

	if(!target.client && !(target.status_flags & FAKESOUL)) //Freak case, no client at all. This is a braindead mob (like a colonist)
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：未检测到生命信号，正在尝试复苏..."))

	if(isobserver(target.mind?.current) && !target.client) //Let's call up the correct ghost! Also, bodies with clients only, thank you.
		target.mind.transfer_to(target, TRUE)


	//At this point, the defibrillator is ready to work
	target.apply_damage(-damage_heal_threshold, BRUTE)
	target.apply_damage(-damage_heal_threshold, BURN)
	target.apply_damage(-damage_heal_threshold, TOX)
	target.apply_damage(-damage_heal_threshold, CLONE)
	target.apply_damage(-target.getOxyLoss(), OXY)
	target.updatehealth() //Needed for the check to register properly

	if(!(target.species?.flags & NO_CHEM_METABOLIZATION))
		for(var/datum/reagent/R in target.reagents.reagent_list)
			var/datum/chem_property/P = R.get_property(PROPERTY_ELECTROGENETIC)//Adrenaline helps greatly at restarting the heart
			if(P)
				P.trigger(target)
				target.reagents.remove_reagent(R.id, 1)
				break
	if(target.health > target.health_threshold_dead)
		user.visible_message(SPAN_NOTICE("[icon2html(src, viewers(src))] \The [src] 发出哔声：[fluff_revive_message]。"))
		msg_admin_niche("[key_name_admin(user)] successfully revived [key_name_admin(target)] with [src].")
		playsound(get_turf(src), sound_success, 25, 0)
		user.track_life_saved(user.job)
		if(!user.statistic_exempt && ishuman(target))
			user.life_revives_total++
		target.handle_revive()
		if(heart)
			heart.take_damage(rand(min_heart_damage_dealt, max_heart_damage_dealt), TRUE) // Make death and revival leave lasting consequences

		to_chat(target, SPAN_NOTICE("你突然感到一阵电击，意识被拉回了现世。"))
		if(target.client?.prefs.toggles_flashing & FLASH_CORPSEREVIVE)
			window_flash(target.client)
	else
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：除颤失败。生命体征过于微弱，修复损伤后重试。")) //Freak case
		msg_admin_niche("[key_name_admin(user)] failed an attempt to revive [key_name_admin(target)] with [src] because of weak vitals.")
		playsound(get_turf(src), sound_failed, 25, 0)
		if(heart && prob(25))
			heart.take_damage(rand(min_heart_damage_dealt, max_heart_damage_dealt), TRUE) // Make death and revival leave lasting consequences

/obj/item/device/defibrillator/low_charge/Initialize(mapload, ...) //for survivors and such
	. = ..()
	dcell.charge = 100
	update_icon()

/obj/item/device/defibrillator/upgraded
	name = "升级版紧急除颤器"
	icon_state = "adv_defib"
	item_state = "adv_defib"
	desc = "一种先进的可充电除颤器，利用感应原理通过金属物体（如护甲）传递电击，效率远高于标准型号，且不会损伤心脏。"

	blocked_by_suit = FALSE
	min_heart_damage_dealt = 0
	max_heart_damage_dealt = 0
	damage_heal_threshold = 35

/obj/item/device/defibrillator/compact_adv
	name = "先进紧凑型除颤器"
	desc = "一种先进的紧凑型除颤器，以牺牲容量换取强大的瞬时功率。可无视护甲，快速强力治疗，但代价是极低的电量。它不会损伤心脏。"
	icon = 'icons/obj/items/medical_tools.dmi'
	icon_state = "compact_defib"
	item_state = "defib"
	base_icon_state = "compact_defib"
	w_class = SIZE_MEDIUM
	blocked_by_suit = FALSE
	min_heart_damage_dealt = 0
	max_heart_damage_dealt = 0
	damage_heal_threshold = 40
	charge_cost = 198

/obj/item/device/defibrillator/compact
	name = "紧凑型除颤器"
	desc ="这款除颤器的电量容量仅为标准紧急除颤器的一半，但可以放入口袋。"
	icon = 'icons/obj/items/medical_tools.dmi'
	icon_state = "compact_defib"
	item_state = "defib"
	base_icon_state = "compact_defib"
	w_class = SIZE_SMALL
	charge_cost = 99


/obj/item/device/defibrillator/synthetic
	name = "维兰德-汤谷合成人重置密钥"
	desc = "海珀戴恩与维兰德-汤谷合作的产物，该设备可以修复合成人单位的主要故障或程序错误，并能够重启遭受严重故障的合成人。它只能使用一次，之后需要重置。"
	icon = 'icons/obj/items/synth/synth_reset_key.dmi'
	icon_state = "reset_key"
	item_state = "synth_reset_key"
	w_class = SIZE_SMALL
	charge_cost = 1000
	force = 0
	throwforce = 0
	skill_to_check = SKILL_ENGINEER
	skill_level = SKILL_ENGINEER_NOVICE
	blocked_by_suit = FALSE
	should_spark = FALSE

	var/synthetic_type_locked = null

	fluff_tool = "electrodes"
	fluff_target_part = "insertion port"
	fluff_revive_message = "Reset complete"

	sound_charge = 'sound/mecha/powerup.ogg'
	sound_charge_skill4 = 'sound/mecha/powerup.ogg'
	sound_charge_skill3 = 'sound/mecha/powerup.ogg'
	sound_failed = 'sound/items/synth_reset_key/shortbeep.ogg'
	sound_success = 'sound/items/synth_reset_key/boot_on.ogg'
	sound_safety_on = 'sound/machines/click.ogg'
	sound_safety_off = 'sound/machines/click.ogg'
	sound_release = 'sound/items/synth_reset_key/release.ogg'

/obj/item/device/defibrillator/synthetic/Initialize()
	. = ..()
	if(istype(src, /obj/item/device/defibrillator/synthetic/seegson))
		AddElement(/datum/element/corp_label/seegson)
	if(istype(src, /obj/item/device/defibrillator/synthetic/hyperdyne))
		AddElement(/datum/element/corp_label/hyperdyne)
	if(istypestrict(src, /obj/item/device/defibrillator/synthetic) || istypestrict(src, /obj/item/device/defibrillator/synthetic/noskill))
		AddElement(/datum/element/corp_label/wy)

/obj/item/device/defibrillator/synthetic/update_icon()
	icon_state = initial(icon_state)
	overlays.Cut()
	if(ready)
		icon_state += "_on"

/obj/item/device/defibrillator/synthetic/get_examine_text(mob/user)
	. = ..()
	if(!noskill)
		. += SPAN_NOTICE("You need some knowledge of electronics and circuitry to use this.")

/obj/item/device/defibrillator/synthetic/check_revive(mob/living/carbon/human/H, mob/living/carbon/human/user)
	if(!issynth(H))
		to_chat(user, SPAN_WARNING("你不能对活体使用[src]！"))
		return FALSE
	if(!ready)
		balloon_alert(user, "先激活它！")
		to_chat(user, SPAN_WARNING("你需要先激活[src]。"))
		return FALSE
	if(synthetic_type_locked && !istype(H.assigned_equipment_preset, synthetic_type_locked))
		to_chat(user, SPAN_WARNING("你不能对这类合成人使用[src]！"))
		return FALSE
	if(dcell.charge < charge_cost)
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 已被使用过！需要重新充电。"))
		return FALSE
	if(H.stat != DEAD)
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：检测到功能签名。中止。"))
		return FALSE

	if(!H.is_revivable())
		user.visible_message(SPAN_WARNING("[icon2html(src, viewers(src))] \The [src] 发出嗡鸣：单位整体状况不允许重新激活。"))
		return FALSE

	return TRUE

/obj/item/device/defibrillator/synthetic/noskill
	name = "SMART 维兰德-汤谷合成人重置密钥"
	desc = "这是海珀戴恩与维兰德-汤谷合作的成果，该设备可以修复合成人单位的主要故障或程序错误，并能够重启遭受严重故障的合成人。它只能使用一次，之后需要重置。此型号带有微功能AI，可由任何人操作。"
	icon_state = "reset_key_ns"
	noskill = TRUE

/obj/item/device/defibrillator/synthetic/hyperdyne
	name = "海珀戴恩合成人重置密钥"
	desc = "这是海珀戴恩的独立设计，基于先前与维兰德-汤谷的合作。该设备可以修复合成人单位的主要故障或程序错误，并能够重启遭受严重故障的合成人。它只能使用一次，之后需要重置。"
	icon_state = "hyper_reset_key"

/obj/item/device/defibrillator/synthetic/hyperdyne/noskill
	name = "SMART 海珀戴恩合成人重置密钥"
	desc = "这是海珀戴恩的独立设计，基于先前与维兰德-汤谷的合作。该设备可以修复合成人单位的主要故障或程序错误，并能够重启遭受严重故障的合成人。它只能使用一次，之后需要重置。此型号带有微功能AI，可由任何人操作。"
	icon_state = "hyper_reset_ns_key"
	noskill = TRUE

/obj/item/device/defibrillator/synthetic/seegson
	name = "希格森 工作乔 重启密钥"
	desc = "希格森工具，用于修复遭受严重故障的工作乔单位，将单位系统重启至出厂设置。与海珀戴恩、维兰德-汤谷及其他设计的合成人不兼容。它只能使用一次，之后需要重置。"
	icon_state = "seeg_reset_key"
	sound_success = 'sound/items/synth_reset_key/seegson_revive.ogg'
	synthetic_type_locked = /datum/equipment_preset/synth/working_joe

/obj/item/device/defibrillator/synthetic/makeshift
	name = "临时合成人电击器"
	desc = "一种类似合成人重置钥匙的工具，但极其粗糙，由备用零件制成，只能重启合成人的系统，并有小概率损坏该系统。它只能使用一次，之后需要重置。"
	icon_state = "makeshift_key"
	should_spark = TRUE
	sound_success = "sparks"
