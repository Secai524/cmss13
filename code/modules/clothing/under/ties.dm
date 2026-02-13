/obj/item/clothing/accessory
	name = "accessory"
	desc = "如果你看到这个，请使用管理员求助。"
	icon = 'icons/obj/items/clothing/accessory/ties.dmi'
	w_class = SIZE_SMALL
	var/image/inv_overlay = null //overlay used when attached to clothing.
	var/obj/item/clothing/has_suit = null //the suit the tie may be attached to
	var/list/mob_overlay = list()
	var/overlay_state = null
	var/inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/ties.dmi'
	var/list/accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/ties.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/ties.dmi'
	)
	///Jumpsuit flags that cause the accessory to be hidden. format: "x" OR "(x|y|z)" (w/o quote marks).
	var/jumpsuit_hide_states
	var/high_visibility //if it should appear on examine without detailed view
	var/removable = TRUE
	flags_equip_slot = SLOT_ACCESSORY
	sprite_sheets = list(SPECIES_MONKEY = 'icons/mob/humans/species/monkeys/onmob/ties_monkey.dmi')
	var/original_item_path = /obj/item/clothing/accessory
	worn_accessory_slot = 1

/obj/item/clothing/accessory/attack_self(mob/user)
	if(can_become_accessory)
		revert_from_accessory(user)
		return
	return ..()

/obj/item/clothing/accessory/Initialize()
	. = ..()
	inv_overlay = image("icon" = inv_overlay_icon, "icon_state" = "[item_state? "[item_state]" : "[icon_state]"]")
	flags_atom |= USES_HEARING

/obj/item/clothing/accessory/Destroy()
	if(has_suit)
		has_suit.remove_accessory()
	inv_overlay = null
	. = ..()

/obj/item/clothing/accessory/proc/can_attach_to(mob/user, obj/item/clothing/C)
	return TRUE

//when user attached an accessory to clothing/clothes
/obj/item/clothing/accessory/proc/on_attached(obj/item/clothing/clothes, mob/living/user, silent)
	if(!istype(clothes))
		return
	has_suit = clothes
	forceMove(has_suit)
	has_suit.overlays += get_inv_overlay()

	if(user)
		if(!silent)
			to_chat(user, SPAN_NOTICE("你将\the [src]安装到\the [has_suit]上。"))
		src.add_fingerprint(user)

	if(ismob(clothes.loc))
		var/mob/wearer = clothes.loc
		if(LAZYLEN(actions))
			for(var/datum/action/action in actions)
				action.give_to(wearer)
	return TRUE

/obj/item/clothing/accessory/proc/on_removed(mob/living/user, obj/item/clothing/clothes)
	if(!has_suit)
		return

	if(ismob(clothes.loc))
		var/mob/wearer = clothes.loc
		if(LAZYLEN(actions))
			for(var/datum/action/action in actions)
				action.remove_from(wearer)

	has_suit.overlays -= get_inv_overlay()
	has_suit = null
	if(usr)
		usr.put_in_hands(src)
		src.add_fingerprint(usr)
	else
		src.forceMove(get_turf(src))
	return TRUE

//default attackby behaviour
/obj/item/clothing/accessory/attackby(obj/item/I, mob/user)
	..()

//default attack_hand behaviour
/obj/item/clothing/accessory/attack_hand(mob/user as mob)
	if(has_suit)
		return //we aren't an object on the ground so don't call parent. If overriding to give special functions to a host item, return TRUE so that the host doesn't continue its own attack_hand.
	..()

///Extra text to append when attached to another clothing item and the host clothing is examined.
/obj/item/clothing/accessory/proc/additional_examine_text()
	return "attached to it."

/obj/item/clothing/accessory/tie
	name = "蓝色领带"
	desc = "一条新丝绸按扣领带。"
	icon_state = "bluetie"
	worn_accessory_slot = ACCESSORY_SLOT_TIE

/obj/item/clothing/accessory/tie/red
	name = "红色领带"
	icon_state = "redtie"

/obj/item/clothing/accessory/tie/green
	name = "绿色领带"
	icon_state = "greentie"

/obj/item/clothing/accessory/tie/black
	name = "黑色领带"
	icon_state = "blacktie"

/obj/item/clothing/accessory/tie/gold
	name = "金色领带"
	icon_state = "goldtie"

/obj/item/clothing/accessory/tie/purple
	name = "紫色领带"
	icon_state = "purpletie"

/obj/item/clothing/accessory/tie/horrible
	name = "糟糕的领带"
	desc = "一条新丝绸按扣领带。这条令人作呕。"
	icon_state = "horribletie"

/obj/item/clothing/accessory/stethoscope
	name = "stethoscope"
	desc = "一个过时但仍有用的医疗器具，用于倾听人体声音。它也能让你看起来像知道自己在做什么。"
	icon_state = "stethoscope"
	icon = 'icons/obj/items/clothing/accessory/misc.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/misc.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi',
	)
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	worn_accessory_slot = ACCESSORY_SLOT_UTILITY

/obj/item/clothing/accessory/stethoscope/attack(mob/living/carbon/human/being, mob/living/user)
	if(!ishuman(being) || !isliving(user))
		return

	var/body_part = parse_zone(user.zone_selected)
	if(!body_part)
		return

	var/sound = null
	if(being.stat == DEAD || (being.status_flags & FAKEDEATH))
		sound = "can't hear anything at all, they must have kicked the bucket"
		user.visible_message("[user]将[src]贴在[being]的[body_part]上并仔细倾听。", "You place [src] against [being.p_their()] [body_part] and... you [sound].")
		return

	switch(body_part)
		if("chest")
			if(skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC)) // only medical personnel can take advantage of it
				if(!ishuman(being))
					return // not a human; only humans have the variable internal_organs_by_name // "cast" it a human type since we confirmed it is one
				if(isnull(being.internal_organs_by_name))
					return // they have no organs somehow
				var/datum/internal_organ/heart/heart = being.internal_organs_by_name["heart"]
				if(heart)
					switch(heart.organ_status)
						if(ORGAN_LITTLE_BRUISED)
							sound = "hear <font color='yellow'>small murmurs with each heart beat</font>, it is possible that [being.p_their()] heart is <font color='yellow'>subtly damaged</font>"
						if(ORGAN_BRUISED)
							sound = "hear <font color='orange'>deviant heart beating patterns</font>, result of probable <font color='orange'>heart damage</font>"
						if(ORGAN_BROKEN)
							sound = "hear <font color='red'>irregular and additional heart beating patterns</font>, probably caused by impaired blood pumping, [being.p_their()] heart is certainly <font color='red'>failing</font>"
						else
							sound = "hear <font color='green'>normal heart beating patterns</font>, [being.p_their()] heart is surely <font color='green'>healthy</font>"
				var/datum/internal_organ/lungs/lungs = being.internal_organs_by_name["lungs"]
				if(lungs)
					if(sound)
						sound += ". You also "
					switch(lungs.organ_status)
						if(ORGAN_LITTLE_BRUISED)
							sound += "hear <font color='yellow'>some crackles when [being.p_they()] breath</font>, [being.p_they()] is possibly suffering from <font color='yellow'>a small damage to the lungs</font>"
						if(ORGAN_BRUISED)
							sound += "hear <font color='orange'>unusual respiration sounds</font> and noticeable difficulty to breath, possibly signalling <font color='orange'>ruptured lungs</font>"
						if(ORGAN_BROKEN)
							sound += "<font color='red'>barely hear any respiration sounds</font> and a lot of difficulty to breath, [being.p_their()] lungs are <font color='red'>heavily failing</font>"
						else
							sound += "hear <font color='green'>normal respiration sounds</font> aswell, that means [being.p_their()] lungs are <font color='green'>healthy</font>, probably"
				else
					sound = "can't hear. Really, anything at all, how weird"
			else
				sound = "hear a lot of sounds... it's quite hard to distinguish, really"
		if("eyes","mouth")
			sound = "can't hear anything. Maybe that isn't the smartest idea"
		else
			sound = "hear a sound here and there, but none of them give you any good information"
	user.visible_message("[user]将[src]贴在[being]的[body_part]上并仔细倾听。", "You place [src] against [being.p_their()] [body_part] and... you [sound].")


//Medals
/obj/item/clothing/accessory/medal
	name = "medal"
	desc = "一枚勋章。"
	icon_state = "bronze_service"
	item_state = "bronze"
	icon = 'icons/obj/items/clothing/accessory/medals.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/medals.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/medals.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/medals.dmi'
	)
	var/recipient_name //name of the person this is awarded to.
	var/recipient_rank
	var/medal_citation
	worn_accessory_slot = ACCESSORY_SLOT_MEDAL
	high_visibility = TRUE
	jumpsuit_hide_states = UNIFORM_JACKET_REMOVED
	worn_accessory_limit = 2
	var/awarding_faction

/obj/item/clothing/accessory/medal/on_attached(obj/item/clothing/S, mob/living/user, silent)
	. = ..()
	if(.)
		RegisterSignal(S, COMSIG_ITEM_EQUIPPED, PROC_REF(remove_medal))

/obj/item/clothing/accessory/medal/proc/remove_medal(obj/item/clothing/C, mob/user, slot)
	SIGNAL_HANDLER
	if(user.real_name != recipient_name && (slot == WEAR_BODY || slot == WEAR_JACKET))
		C.remove_accessory(user, src)
		user.drop_held_item(src)

/obj/item/clothing/accessory/medal/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	if(.)
		UnregisterSignal(C, COMSIG_ITEM_EQUIPPED)

/obj/item/clothing/accessory/medal/attack(mob/living/carbon/human/H, mob/living/carbon/human/user)
	if(!(istype(H) && istype(user)))
		return ..()
	if(recipient_name != H.real_name)
		to_chat(user, SPAN_WARNING("[src]并非授予[H]的。"))
		return

	var/obj/item/clothing/U
	if(H.wear_suit && H.wear_suit.can_attach_accessory(src)) //Prioritises topmost garment, IE service jackets, if possible.
		U = H.wear_suit
	else
		U = H.w_uniform //Will be null if no uniform. That this allows medal ceremonies in which the hero is wearing no pants is correct and just.
	if(!U)
		if(user == H)
			to_chat(user, SPAN_WARNING("你身上没有可以佩戴[src]的衣物。"))
		else
			to_chat(user, SPAN_WARNING("[H]身上没有可以佩戴[src]的衣物。"))
		return

	if(user == H)
		user.visible_message(SPAN_NOTICE("[user]将[src]别在\his [U.name]上。"),
		SPAN_NOTICE("You pin [src] to your [U.name]."))

	else
		if(user.action_busy)
			return
		if(user.a_intent != INTENT_HARM)
			user.affected_message(H,
			SPAN_NOTICE("You start to pin [src] onto [H]."),
			SPAN_NOTICE("[user] starts to pin [src] onto you."),
			SPAN_NOTICE("[user] starts to pin [src] onto [H]."))
			if(!do_after(user, 20, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, H))
				return
			if(!(U == H.w_uniform || U == H.wear_suit))
				to_chat(user, SPAN_WARNING("[H]在你将[src]别上去之前脱下了\his [U.name]。"))
				return
			user.affected_message(H,
			SPAN_NOTICE("You pin [src] to [H]'s [U.name]."),
			SPAN_NOTICE("[user] pins [src] to your [U.name]."),
			SPAN_NOTICE("[user] pins [src] to [H]'s [U.name]."))

		else
			user.affected_message(H,
			SPAN_ALERT("You start to pin [src] to [H]."),
			SPAN_ALERT("[user] starts to pin [src] to you."),
			SPAN_ALERT("[user] starts to pin [src] to [H]."))
			if(!do_after(user, 10, INTERRUPT_ALL, BUSY_ICON_HOSTILE, H))
				return
			if(!(U == H.w_uniform || U == H.wear_suit))
				to_chat(user, SPAN_WARNING("[H] took off \his [U.name] before you could finish pinning [src] to \him."))
				return
			user.affected_message(H,
			SPAN_DANGER("You slam the [src.name]'s pin through [H]'s [U.name] and into \his chest."),
			SPAN_DANGER("[user] slams the [src.name]'s pin through your [U.name] and into your chest!"),
			SPAN_DANGER("[user] slams the [src.name]'s pin through [H]'s [U.name] and into \his chest."))

			/*Some duplication from punch code due to attack message and damage stats.
			This does cut damage and awarding multiple medals like this to the same person will cause bleeding.*/
			H.last_damage_data = create_cause_data("macho bullshit", user)
			user.animation_attack_on(H)
			user.flick_attack_overlay(H, "punch")
			playsound(user.loc, "punch", 25, 1)
			H.apply_damage(5, BRUTE, "chest", 1)

			if(!H.stat && H.pain.feels_pain)
				if(prob(35))
					INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, emote), "pain")
				else
					INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, emote), "me", 1, "winces.")

	if(U.can_attach_accessory(src) && user.drop_held_item())
		U.attach_accessory(H, src, TRUE)

/obj/item/clothing/accessory/medal/can_attach_to(mob/user, obj/item/clothing/C)
	if(user.real_name != recipient_name)
		return FALSE
	return TRUE

/obj/item/clothing/accessory/medal/get_examine_text(mob/user)
	. = ..()

	var/citation_to_read = ""
	if(medal_citation)
		citation_to_read = "The citation reads \'[medal_citation]\'."

	. += "Awarded to: \'[recipient_rank] [recipient_name]\'. [citation_to_read]"

/obj/item/clothing/accessory/medal/ribbon
	name = "勋表"
	desc = "一枚军事勋表。"

/obj/item/clothing/accessory/medal/ribbon/commendation
	name = MARINE_RIBBON_COMMENDATION
	desc = "为表彰值得注意的行为和行动而颁发的勋表，通常与正式的嘉奖信一同颁发。这是USCM颁发的最基本奖项。"
	icon_state = "ribbon_commendation"
	awarding_faction = FACTION_MARINE

/obj/item/clothing/accessory/medal/ribbon/leadership
	name = MARINE_RIBBON_LEADERSHIP
	desc = "授予那些其协调、决策或士气维持对所在单位的成功或生存起到关键作用的军官、士官或班长的勋表。"
	icon_state = "ribbon_leadership"
	awarding_faction = FACTION_MARINE

/obj/item/clothing/accessory/medal/ribbon/proficiency
	name = MARINE_RIBBON_PROFICIENCY
	desc = "为表彰在战场上出色的专业技术而颁发的勋表。授予那些其技能或创新直接促成任务成功的工程、医疗或后勤人员。"
	icon_state = "ribbon_proficiency"
	awarding_faction = FACTION_MARINE

/obj/item/clothing/accessory/medal/purple_heart
	name = MARINE_MEDAL_PURPLE_HEART
	desc = "授予那些在行动中负伤或阵亡的人员。一枚象征牺牲与坚韧的庄严信物，用以认可服役所付出的身体与个人代价。"
	icon_state = "purple_heart"
	awarding_faction = FACTION_MARINE

/obj/item/clothing/accessory/medal/bronze
	name = "铜质奖章"
	desc = "一枚铜质奖章。"
	icon_state = "bronze"

/obj/item/clothing/accessory/medal/silver
	name = "银质奖章"
	desc = "一枚银质奖章。"
	icon_state = "silver"
	item_state = "silver"

/obj/item/clothing/accessory/medal/silver/star
	name = MARINE_MEDAL_SILVER_STAR
	desc = "授予在行动中表现英勇者。银星勋章表彰那些超越职责要求的人：冲入险境、在一切似乎无望时坚守阵地、或在敌人猛烈火力下拯救生命。"
	icon_state = "silver_star"
	awarding_faction = FACTION_MARINE

/obj/item/clothing/accessory/medal/silver/valor
	name = MARINE_MEDAL_VALOR
	desc = "授予在战斗行动中表现英勇的行为。表彰那些在炮火下保持冷静、坚定和勇敢，为所在班组的生存和士气做出贡献的陆战队员。"
	awarding_faction = FACTION_MARINE

/obj/item/clothing/accessory/medal/gold/corporate_award
	name = WY_MEDAL_AWARD_1
	desc = "一枚小型金色公司徽章，授予为维兰德-汤谷利益做出显著贡献者。"
	icon_state = "corporate_award"
	awarding_faction = FACTION_WY

/obj/item/clothing/accessory/medal/gold/corporate_award2
	name = WY_MEDAL_AWARD_2
	desc = "一枚大型金色公司徽章，授予为维兰德-汤谷利益做出显著贡献者。"
	icon_state = "corporate_award2"
	awarding_faction = FACTION_WY

/obj/item/clothing/accessory/medal/gold
	name = "金质奖章"
	desc = "一枚尊贵的金质奖章。"
	icon_state = "gold"
	item_state = "gold"

/obj/item/clothing/accessory/medal/gold/cross
	name = MARINE_MEDAL_GALACTIC_CROSS
	desc = "美国殖民地海军陆战队内部第二高的荣誉。授予在极端条件下表现英勇的行为。当任务的成功或战友的生存取决于非凡的勇气和快速反应时。"
	icon_state = "ua_cross"
	awarding_faction = FACTION_MARINE

/obj/item/clothing/accessory/medal/platinum
	name = "铂金奖章"
	desc = "一枚极其尊贵的铂金奖章，仅在特殊情况下由将军颁发。"
	icon_state = "platinum"
	item_state = "platinum"

/obj/item/clothing/accessory/medal/platinum/honor
	name = MARINE_MEDAL_HONOR
	desc = "美国殖民地海军陆战队颁发的最高荣誉。授予那些以无与伦比的勇气、自我牺牲和对职责的奉献精神采取行动的人——通常是在面对必死之境时。佩戴此奖章者，将与陆战队的传奇人物并肩。"
	awarding_faction = "USCM HC"

//Legacy medals.
//Keeping in code as to allow medal records to display correctly, but won't be issued further.
/obj/item/clothing/accessory/medal/legacy
	name = "传承奖章"
	desc = "一枚老旧废弃的奖章。"

/obj/item/clothing/accessory/medal/legacy/distinguished_conduct
	name = MARINE_LEGACY_MEDAL_CONDUCT
	desc = "一枚授予杰出行为的铜质奖章。虽然是一项巨大的荣誉，但这是美国殖民地海军陆战队颁发的最基础的奖项之一。"
	icon_state = "conduct"

/obj/item/clothing/accessory/medal/legacy/bronze_heart
	name = MARINE_LEGACY_MEDAL_BRONZE_HEART
	desc = "一枚心形铜质奖章，授予牺牲者。通常追授或在执勤中受重伤时授予。"
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/legacy/heroism
	name = MARINE_LEGACY_MEDAL_HEROISM
	desc = "一枚极其罕见的金质奖章，仅由美国殖民地海军陆战队颁发。获得此奖章是最高荣誉，因此存世极少。"
	icon_state = "heroism"

//Playtime Service Medals
/obj/item/clothing/accessory/medal/bronze/service
	name = "铜质服役奖章"
	desc = "一枚授予陆战队员在美国殖民地海军陆战队服役的铜质奖章。这是一种非常常见的奖章，通常是陆战队员获得的第一枚奖章。"
	icon_state = "bronze_service"

/obj/item/clothing/accessory/medal/silver/service
	name = "银质服役奖章"
	desc = "一枚授予陆战队员在美国殖民地海军陆战队服役的闪亮银质奖章。这是一种较为常见的奖章，标志着陆战队员在执勤岗位上度过的时间。"
	icon_state = "silver_service"

/obj/item/clothing/accessory/medal/gold/service
	name = "金质服役奖章"
	desc = "一枚授予陆战队员在美国殖民地海军陆战队服役的尊贵金质奖章。这是一种罕见的奖章，标志着陆战队员在执勤岗位上度过的时间。"
	icon_state = "gold_service"

/obj/item/clothing/accessory/medal/platinum/service
	name = "铂金服役勋章"
	desc = "可授予陆战队员的最高服役勋章；此类勋章由USCM将军亲手授予。它象征着一名陆战队员在执勤岗位上所付出的漫长时光。"
	icon_state = "platinum_service"

//Armbands
/obj/item/clothing/accessory/armband
	name = "红色臂章"
	desc = "一个花哨的红色臂章！"
	icon_state = "red"
	icon = 'icons/obj/items/clothing/accessory/armbands.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/armbands.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/armbands.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/armbands.dmi'
	)
	worn_accessory_slot = ACCESSORY_SLOT_ARMBAND
	worn_accessory_limit = 2

/obj/item/clothing/accessory/armband/cargo
	name = "货运臂章"
	desc = "船员佩戴的臂章，用于显示其所属部门。这个是棕色的。"
	icon_state = "cargo"

/obj/item/clothing/accessory/armband/engine
	name = "工程臂章"
	desc = "船员佩戴的臂章，用于显示其所属部门。这个是橙色的，带有反光条！"
	icon_state = "engie"

/obj/item/clothing/accessory/armband/science
	name = "科研臂章"
	desc = "船员佩戴的臂章，用于显示其所属部门。这个是紫色的。"
	icon_state = "rnd"

/obj/item/clothing/accessory/armband/hydro
	name = "水培臂章"
	desc = "船员佩戴的臂章，用于显示其所属部门。这个是绿色和蓝色的。"
	icon_state = "hydro"

/obj/item/clothing/accessory/armband/med
	name = "医疗臂章"
	desc = "船员佩戴的臂章，用于显示其所属部门。这个是白色的。"
	icon_state = "med"

/obj/item/clothing/accessory/armband/medgreen
	name = "急救员臂章"
	desc = "船员佩戴的臂章，用于显示其所属部门。这个是白色和绿色的。"
	icon_state = "medgreen"

/obj/item/clothing/accessory/armband/nurse
	name = "护士臂章"
	desc = "新手护士佩戴的臂章，表明她们还不是医生。这个是深红色的。"
	icon_state = "nurse"

/obj/item/clothing/accessory/armband/squad
	name = "小队臂章"
	desc = "小队配色臂章，佩戴以便于识别。"
	icon_state = "armband_squad"
	var/dummy_icon_state = "armband_%SQUAD%"
	var/static/list/valid_icon_states
	item_state_slots = null

/obj/item/clothing/accessory/armband/squad/Initialize(mapload, ...)
	. = ..()
	if(!valid_icon_states)
		valid_icon_states = icon_states(icon)
	adapt_to_squad()

/obj/item/clothing/accessory/armband/squad/proc/update_clothing_wrapper(mob/living/carbon/human/wearer)
	SIGNAL_HANDLER

	var/is_worn_by_wearer = recursive_holder_check(src) == wearer
	if(is_worn_by_wearer)
		update_clothing_icon()
	else
		UnregisterSignal(wearer, COMSIG_SET_SQUAD)

/obj/item/clothing/accessory/armband/squad/update_clothing_icon()
	adapt_to_squad()

/obj/item/clothing/accessory/armband/squad/pickup(mob/user, silent)
	. = ..()
	adapt_to_squad()

/obj/item/clothing/accessory/armband/squad/equipped(mob/user, slot, silent)
	RegisterSignal(user, COMSIG_SET_SQUAD, PROC_REF(update_clothing_wrapper), TRUE)
	adapt_to_squad()
	return ..()

/obj/item/clothing/accessory/armband/squad/proc/adapt_to_squad()
	if(has_suit)
		has_suit.overlays -= get_inv_overlay()
	var/squad_color = "squad"
	var/mob/living/carbon/human/wearer = recursive_holder_check(src)
	if(istype(wearer) && wearer.assigned_squad)
		var/squad_name = lowertext(wearer.assigned_squad.name)
		if("armband_[squad_name]" in valid_icon_states)
			squad_color = squad_name
	icon_state = replacetext(initial(dummy_icon_state), "%SQUAD%", squad_color)
	inv_overlay = image("icon" = inv_overlay_icon, "icon_state" = "[item_state? "[item_state]" : "[icon_state]"]")
	if(has_suit)
		has_suit.overlays += get_inv_overlay()

/obj/item/clothing/accessory/armband/mp
	name = "宪兵臂章"
	desc = "USCM宪兵在军事设施上佩戴的臂章。通常也由宪兵办公室人员佩戴。"
	icon_state = "armband_mp"

//patches
/obj/item/clothing/accessory/patch
	name = "USCM臂章"
	desc = "一个防火的肩部臂章，由美国殖民地海军陆战队的男女成员佩戴。"
	icon_state = "uscmpatch"
	icon = 'icons/obj/items/clothing/accessory/patches.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/patches.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/patches.dmi',
	)
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/patches_flairs.dmi',
	)
	jumpsuit_hide_states = (UNIFORM_SLEEVE_CUT|UNIFORM_JACKET_REMOVED)
	flags_obj = OBJ_IS_HELMET_GARB
	worn_accessory_slot = ACCESSORY_SLOT_PATCH
	worn_accessory_limit = 4

/obj/item/clothing/accessory/patch/falcon
	name = "USCM 坠落猎鹰臂章"
	desc = "一块防火肩章，由美国殖民地海军陆战队第四旅第二营'坠落猎鹰'的男女成员佩戴。"
	icon_state = "fallingfalconspatch"
	item_state_slots = list(WEAR_AS_GARB = "falconspatch")
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/accessory/patch/devils
	name = "USCM 太阳恶魔徽章"
	desc = "一块防火肩章，由美国殖民地海军陆战队第二师第一团第三营'太阳恶魔'的男女成员佩戴。"
	icon_state = "solardevilspatch"

/obj/item/clothing/accessory/patch/forecon
	name = "USCM 武装侦察徽章"
	desc = "一块防火肩章，由美国殖民地海军陆战队武装侦察部队'汉尤特号'的男女成员佩戴。"
	icon_state = "forecon_patch"

/obj/item/clothing/accessory/patch/royal_marines
	name = "TWE 皇家海军陆战队突击队徽章"
	desc = "一块防火肩章，由皇家海军陆战队突击队的男女成员佩戴。"
	icon_state = "commandopatch"

/obj/item/clothing/accessory/patch/upp
	name = "UPP 徽章"
	desc = "一块防火肩章，由进步人民联盟武装集体的男女成员佩戴。"
	icon_state = "upppatch"

/obj/item/clothing/accessory/patch/upp/airborne
	name = "UPP 空降侦察徽章"
	desc = "一块防火肩章，由第173空降侦察排的男女成员佩戴。"
	icon_state = "vdvpatch"

/obj/item/clothing/accessory/patch/upp/naval
	name = "UPP 海军步兵徽章"
	desc = "一块防火肩章，由UPP海军步兵的男女成员佩戴。"
	icon_state = "navalpatch"

/obj/item/clothing/accessory/patch/ua
	name = "联合美洲徽章"
	desc = "一块防火肩章，由联合美洲的男女成员佩戴。联合美洲是太阳系及外星殖民地中经济和政治的巨人，其军事实力无与伦比。"
	icon_state = "uapatch"

/obj/item/clothing/accessory/patch/uasquare
	name = "联合美洲徽章"
	desc = "一块防火肩章，由联合美洲的男女成员佩戴。联合美洲是太阳系及外星殖民地中经济和政治的巨人，其军事实力无与伦比。"
	icon_state = "uasquare"

/obj/item/clothing/accessory/patch/falconalt
	name = "USCM 坠落猎鹰 UA 徽章"
	desc = "一块防火肩章，由美国殖民地海军陆战队第四旅第二营'坠落猎鹰'的男女成员佩戴。"
	icon_state = "fallingfalconsaltpatch"

/obj/item/clothing/accessory/patch/twe
	name = "三界帝国徽章"
	desc = "一块防火肩章，由效忠于三界帝国的男女成员佩戴。这是三界帝国的一种旧式标志。"
	icon_state = "twepatch"

/obj/item/clothing/accessory/patch/uscmlarge
	name = "USCM 大型胸章"
	desc = "一块防火胸章，由美国殖民地海军陆战队第四旅第二营'坠落猎鹰'的男女成员佩戴。"
	icon_state = "fallingfalconsbigpatch"

/obj/item/clothing/accessory/patch/wy
	name = "维兰德-汤谷徽章"
	desc = "一块防火黑色肩章，印有维兰德-汤谷标志。这是对公司忠诚的象征，或者根据你的观点，也可能是讽刺性的嘲弄。"
	icon_state = "wypatch"

/obj/item/clothing/accessory/patch/wysquare
	name = "维兰德-汤谷徽章"
	desc = "一块防火黑色肩章，印有维兰德-汤谷标志。这是对公司忠诚的象征，或者根据你的观点，也可能是讽刺性的嘲弄。"
	icon_state = "wysquare"

/obj/item/clothing/accessory/patch/wy_faction
	name = "维兰德-汤谷徽章" // For WY factions like PMC's - on the right shoulder rather then left.
	desc = "一块防火黑色肩章，印有维兰德-汤谷标志。这是对公司忠诚的象征。"
	icon_state = "wypatch_faction"

/obj/item/clothing/accessory/patch/wy_white
	name = "维兰德-汤谷徽章"
	desc = "一块防火白色肩章，印有维兰德-汤谷标志。这是对公司忠诚的象征，或者根据你的观点，也可能是讽刺性的嘲弄。"
	icon_state = "wypatch_white"

/obj/item/clothing/accessory/patch/wyfury
	name = "维兰德-汤谷 狂怒 '161' 徽章"
	desc = "一块防火肩章。曾由菲奥里纳'狂暴'161设施的工人佩戴，后由囚犯佩戴，是该设施于2179年失联后留下的罕见遗物。"
	icon_state = "fury161patch"

/obj/item/clothing/accessory/patch/upp/alt
	name = "UPP 徽章"
	desc = "一块旧的防火肩章，曾由进步人民联盟武装集体的成员佩戴。"
	icon_state = "upppatch_alt"

/obj/item/clothing/accessory/patch/falcon/squad_main
	name = "USCM 坠落猎鹰小队臂章"
	desc = "一块防火肩章，是USCM第4旅第2营“坠落猎鹰”小队佩戴的臂章。以小队配色缝制。"
	icon_state = "fallingfalcons_squad"
	var/dummy_icon_state = "fallingfalcons_%SQUAD%"
	var/static/list/valid_icon_states
	item_state_slots = null

/obj/item/clothing/accessory/patch/falcon/squad_main/Initialize(mapload, ...)
	. = ..()
	if(!valid_icon_states)
		valid_icon_states = icon_states(icon)
	adapt_to_squad()

/obj/item/clothing/accessory/patch/falcon/squad_main/proc/update_clothing_wrapper(mob/living/carbon/human/wearer)
	SIGNAL_HANDLER

	var/is_worn_by_wearer = recursive_holder_check(src) == wearer
	if(is_worn_by_wearer)
		update_clothing_icon()
	else
		UnregisterSignal(wearer, COMSIG_SET_SQUAD) // we can't set this in dropped, because dropping into a helmet unsets it and then it never updates

/obj/item/clothing/accessory/patch/falcon/squad_main/update_clothing_icon()
	adapt_to_squad()
	if(istype(loc, /obj/item/storage/internal) && istype(loc.loc, /obj/item/clothing/head/helmet))
		var/obj/item/clothing/head/helmet/headwear = loc.loc
		headwear.update_icon()
	return ..()

/obj/item/clothing/accessory/patch/falcon/squad_main/pickup(mob/user, silent)
	. = ..()
	adapt_to_squad()

/obj/item/clothing/accessory/patch/falcon/squad_main/equipped(mob/user, slot, silent)
	RegisterSignal(user, COMSIG_SET_SQUAD, PROC_REF(update_clothing_wrapper), TRUE)
	adapt_to_squad()
	return ..()

/obj/item/clothing/accessory/patch/falcon/squad_main/proc/adapt_to_squad()
	var/squad_color = "squad"
	var/mob/living/carbon/human/wearer = recursive_holder_check(src)
	if(istype(wearer) && wearer.assigned_squad)
		var/squad_name = lowertext(wearer.assigned_squad.name)
		if("fallingfalcons_[squad_name]" in valid_icon_states)
			squad_color = squad_name
	icon_state = replacetext(initial(dummy_icon_state), "%SQUAD%", squad_color)

/obj/item/clothing/accessory/patch/cec_patch
	name = "CEC臂章"
	desc = "一块老旧褪色的防火圆形臂章，在橙红分割的背景上有一颗金星。曾由宇宙探索军团（CEC）的成员佩戴，CEC是UPP下属致力于探索、资源评估和在新世界建立殖民地的部门。这枚臂章让人想起CEC驾驶老旧星舰执行的大胆任务，象征着在逆境中的坚韧不拔。"
	icon_state = "cecpatch"
	item_state_slots = list(WEAR_AS_GARB = "cecpatch")

/obj/item/clothing/accessory/patch/freelancer_patch
	name = "自由佣兵公会臂章"
	desc = "一块防火圆形臂章，在垂直分割的黑蓝背景上有一个白色骷髅头。由自由佣兵公会的一名熟练佣兵佩戴，该公会是一个装备精良、在外围殖民地受雇的团体，以其专业性和中立性闻名。这枚臂章是佩戴者在该团体服役时期的个人纪念品，代表着在危险的佣兵合同世界中度过的生涯。"
	icon_state = "mercpatch"
	item_state_slots = list(WEAR_AS_GARB = "mercpatch")

/obj/item/clothing/accessory/patch/merc_patch
	name = "旧自由佣兵公会臂章"
	desc = "一块褪色、破旧的防火圆形臂章，在垂直分割的黑红背景上有一个白色骷髅头。曾由一个在外围殖民地受雇、装备精良的佣兵团体佩戴，以其专业性和中立性闻名。现任所有者与这枚臂章的关联不明——无论是作为服役所得、作为纪念品保留，还是仅仅拾获，已与原佩戴者失去联系。"
	icon_state = "mercpatch_red"
	item_state_slots = list(WEAR_AS_GARB = "mercpatch_red")

/obj/item/clothing/accessory/patch/medic_patch
	name = "战地医疗兵臂章"
	desc = "一块圆形臂章，白色背景上有一个红十字，带有醒目的红色边框。被普遍认为是援助和中立的象征，由各殖民地的医疗兵佩戴。无论是真正医疗专长的标志、纪念品，还是仅仅作为装饰，它的存在都能在危急时刻带来一丝希望。"
	icon_state = "medicpatch"

/obj/item/clothing/accessory/patch/clf_patch
	name = "CLF臂章"
	desc = "一块带白边的圆形防火臂章。设计包含三颗白星和三色背景：绿、黑、红，象征着殖民地解放阵线为独立和统一而战。这枚臂章由CLF战士佩戴，作为反抗企业和政府压迫的徽章，代表着他们为自由、自决的殖民地未来而进行的斗争。尽管被一些人恐惧和憎恶，它仍然是抵抗与革命的强大象征。"
	icon_state = "clfpatch"

/obj/item/clothing/accessory/patch/msf_patch
	name = "海军太空部队赫库力斯臂章"
	desc = "一块防火肩章，描绘了海军太空部队第三部队“赫库力斯”的徽标，该部队部署在从外层帷幕到ICSC网络的整个盎格鲁-日耳曼臂区域，这枚臂章通常由任何分配到MSF赫库力斯的将军佩戴，美国太空司令部和UA盟军司令部的将军通常有自己的臂章。"
	icon_state = "msfpatch"

/obj/item/clothing/accessory/patch/hyperdyne_patch
	name = "海珀戴恩公司臂章"
	desc = "一块光滑的公司臂章，印有海珀戴恩公司的徽标——该公司是最强大的企业集团之一。以合成人生产、人工智能研究和深空物流闻名。佩戴此臂章意味着对利润的忠诚高于对人。"
	icon_state = "hyperdynepatch"

// Misc

/obj/item/clothing/accessory/dogtags
	name = "可挂载身份牌"
	desc = "一副坚固的狗牌，本应佩戴于美国殖民地海军陆战队员的颈部，但由于预算重新分配、陆战队员丢失狗牌以及多起陆战队员吞食狗牌的事件，现在它们被固定在制服或护甲上。"
	icon_state = "dogtag"
	icon = 'icons/obj/items/clothing/accessory/misc.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/misc.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi'
	)
	worn_accessory_slot = ACCESSORY_SLOT_DECOR

/obj/item/clothing/accessory/poncho
	name = "USCM雨披"
	desc = "标准USCM雨披有多种气候变体。定制设计，可连接到标准USCM护甲变体上，舒适、根据需要保暖或降温，且合身。陆战队员别无所求。被亲切地称为\"woobie\"."
	icon_state = "poncho"
	icon = 'icons/obj/items/clothing/accessory/ponchos.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/ponchos.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/ponchos.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/ponchos.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)
	worn_accessory_slot = ACCESSORY_SLOT_PONCHO
	flags_atom = MAP_COLOR_INDEX

/obj/item/clothing/accessory/poncho/Initialize()
	. = ..()
	// Only do this for the base type '/obj/item/clothing/accessory/poncho'.
	select_gamemode_skin(/obj/item/clothing/accessory/poncho)
	inv_overlay = image("icon" = inv_overlay_icon, "icon_state" = "[icon_state]")
	update_icon()

/obj/item/clothing/accessory/poncho/green
	icon_state = "poncho"

/obj/item/clothing/accessory/poncho/brown
	icon_state = "d_poncho"

/obj/item/clothing/accessory/poncho/black
	icon_state = "u_poncho"

/obj/item/clothing/accessory/poncho/blue
	icon_state = "c_poncho"

/obj/item/clothing/accessory/poncho/purple
	icon_state = "s_poncho"

/obj/item/clothing/accessory/clf_cape
	name = "撕裂的CLF旗帜"
	desc = "一面撕裂的CLF旗帜，带有一个别针，可以将其作为披风穿戴。"
	icon_state = "clf_cape"
	icon = 'icons/obj/items/clothing/accessory/ponchos.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/ponchos.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/ponchos.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/ponchos.dmi'
	)
	worn_accessory_slot = ACCESSORY_SLOT_PONCHO


//Ties that can store stuff

/obj/item/storage/internal/accessory
	storage_slots = 3

/obj/item/clothing/accessory/storage
	name = "负重装备"
	desc = "在你手不够用时用来装东西。"
	icon_state = "webbing"
	icon = 'icons/obj/items/clothing/accessory/webbings.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/webbings.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/webbings.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/webbings.dmi'
	)
	w_class = SIZE_LARGE //too big to store in other pouches
	var/obj/item/storage/internal/hold = /obj/item/storage/internal/accessory
	worn_accessory_slot = ACCESSORY_SLOT_STORAGE
	high_visibility = TRUE

/obj/item/clothing/accessory/storage/Initialize()
	. = ..()
	hold = new hold(src)

/obj/item/clothing/accessory/storage/Destroy()
	QDEL_NULL(hold)
	return ..()

/obj/item/clothing/accessory/storage/clicked(mob/user, list/mods)
	if(mods[ALT_CLICK] && !isnull(hold) && loc == user && !user.get_active_hand()) //To pass quick-draw attempts to storage. See storage.dm for explanation.
		return
	. = ..()

/obj/item/clothing/accessory/storage/attack_hand(mob/user as mob, mods)
	if (!isnull(hold) && hold.handle_attack_hand(user, mods))
		..(user)
	return TRUE

/obj/item/clothing/accessory/storage/MouseDrop(obj/over_object as obj)
	if (has_suit || hold)
		return

	if (hold.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/accessory/storage/attackby(obj/item/W, mob/user)
	return hold.attackby(W, user)

/obj/item/clothing/accessory/storage/emp_act(severity)
	. = ..()
	hold.emp_act(severity)

/obj/item/clothing/accessory/storage/hear_talk(mob/M, msg)
	hold.hear_talk(M, msg)
	..()

/obj/item/clothing/accessory/storage/attack_self(mob/user)
	..()
	to_chat(user, SPAN_NOTICE("你清空了[src]。"))
	var/turf/T = get_turf(src)
	hold.storage_close(usr)
	for(var/obj/item/I in hold.contents)
		hold.remove_from_storage(I, T)
	src.add_fingerprint(user)

/obj/item/clothing/accessory/storage/on_attached(obj/item/clothing/C, mob/living/user, silent)
	. = ..()
	if(.)
		C.w_class = w_class //To prevent monkey business.
		C.verbs += /obj/item/clothing/suit/storage/verb/toggle_draw_mode

/obj/item/clothing/accessory/storage/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	if(.)
		C.w_class = initial(C.w_class)
		C.verbs -= /obj/item/clothing/suit/storage/verb/toggle_draw_mode

/obj/item/storage/internal/accessory/webbing
	bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/sniper,
	)

/obj/item/clothing/accessory/storage/webbing
	name = "webbing"
	desc = "一个由合成棉带和搭扣组成的坚固组合，随时准备分担你的负重。"
	icon_state = "webbing"
	hold = /obj/item/storage/internal/accessory/webbing

/obj/item/clothing/accessory/storage/webbing/black
	name = "黑色战术背心"
	icon_state = "webbing_black"
	item_state = "webbing_black"

/obj/item/clothing/accessory/storage/webbing/iasf
	name = "IASF空降战术背心"
	desc = "配发给IASF空降部队的耐用吊带系统，旨在均匀分布重量以提升舒适度和机动性。配有加固口袋，用于在高风险渗透任务中携带必要装备。"
	icon_state = "webbing_twe"
	item_state = "webbing_twe"

/obj/item/clothing/accessory/storage/webbing/five_slots
	hold = /obj/item/storage/internal/accessory/webbing/five_slots

/obj/item/storage/internal/accessory/webbing/five_slots
	storage_slots = 5

/obj/item/storage/internal/accessory/black_vest
	storage_slots = 5

/obj/item/clothing/accessory/storage/black_vest
	name = "黑色战术背心"
	desc = "坚固的黑色合成棉背心，带有多个口袋，可容纳你所需但无法手持的物品。"
	icon_state = "vest_black"
	hold = /obj/item/storage/internal/accessory/black_vest

/obj/item/clothing/accessory/storage/black_vest/attackby(obj/item/W, mob/living/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_WIRECUTTERS) && skillcheck(user, SKILL_RESEARCH, SKILL_RESEARCH_TRAINED))
		var/components = 0
		var/obj/item/reagent_container/glass/beaker/beaker
		var/obj/item/cell/battery
		for(var/obj/item in hold.contents)
			if(istype(item, /obj/item/device/radio) || istype(item, /obj/item/stack/cable_coil) || istype(item, /obj/item/device/healthanalyzer))
				components++
			else if(istype(item, /obj/item/reagent_container/hypospray) && !istype(item, /obj/item/reagent_container/hypospray/autoinjector))
				var/obj/item/reagent_container/hypospray/H = item
				if(H.mag)
					beaker = H.mag
				components++
			else if(istype(item, /obj/item/cell))
				battery = item
				components++
			else
				components--
		if(components == 5)
			var/obj/item/clothing/accessory/storage/black_vest/acid_harness/AH
			if(istype(src, /obj/item/clothing/accessory/storage/black_vest/brown_vest))
				AH = new /obj/item/clothing/accessory/storage/black_vest/acid_harness/brown(get_turf(loc))
			else
				AH = new /obj/item/clothing/accessory/storage/black_vest/acid_harness(get_turf(loc))
			if(beaker)
				AH.beaker = beaker
				AH.hold.handle_item_insertion(beaker)
			AH.battery = battery
			AH.hold.handle_item_insertion(battery)
			qdel(src)
			return
	. = ..()

/obj/item/clothing/accessory/storage/black_vest/brown_vest
	name = "棕色战术背心"
	desc = "破旧的棕褐色合成棉背心，带有多个口袋，解放你的双手。"
	icon_state = "vest_brown"

/obj/item/clothing/accessory/storage/black_vest/waistcoat
	name = "战术马甲"
	desc = "一件时尚的黑色马甲，带有大量隐蔽口袋，兼具实用性与时尚感，且不损外观。"
	icon_state = "waistcoat"

/obj/item/clothing/accessory/storage/tool_webbing
	name = "工具背带"
	desc = "一种棕色合成棉背带，功能类似于民用工具围裙，但更耐用，适合野外使用。"
	hold = /obj/item/storage/internal/accessory/tool_webbing
	icon_state = "vest_brown"

/obj/item/clothing/accessory/storage/black_vest/leg_pouch
	name = "腿部挂包"
	desc = "一个迷彩腿部挂包，通常为猎人、军人以及梦想成为军人的人所使用。"
	icon = 'icons/obj/items/clothing/accessory/legpouch.dmi'
	icon_state = "leg_pouch"
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/legpouch.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/legpouch.dmi',
	)
	flags_atom = MAP_COLOR_INDEX

/obj/item/clothing/accessory/storage/black_vest/leg_pouch/Initialize()
	. = ..()
	select_gamemode_skin(/obj/item/clothing/accessory/storage/black_vest/leg_pouch)
	inv_overlay = image("icon" = inv_overlay_icon, "icon_state" = "[icon_state]")
	update_icon()

/obj/item/clothing/accessory/storage/black_vest/leg_pouch/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	if(flags_atom & MAP_COLOR_INDEX)
		return
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon_state = "j_leg_pouch"
		if("classic")
			icon_state = "c_leg_pouch"
		if("desert")
			icon_state = "d_leg_pouch"
		if("snow")
			icon_state = "s_leg_pouch"
		if("urban")
			icon_state = "u_leg_pouch"

/obj/item/clothing/accessory/storage/black_vest/black_leg_pouch
	name = "黑色腿部挂包"
	desc = "一个黑色腿部挂包，通常为猎人、军人以及梦想成为军人的人所使用。"
	icon = 'icons/obj/items/clothing/accessory/legpouch.dmi'
	icon_state = "leg_pouch_black"
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/legpouch.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/legpouch.dmi',
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/accessory/storage/tool_webbing/small
	name = "小型工具背带"
	desc = "一种棕色合成棉背带，功能类似于民用工具围裙，但更耐用，适合野外使用。这是小型低预算版本。"
	hold = /obj/item/storage/internal/accessory/tool_webbing/small

/obj/item/storage/internal/accessory/tool_webbing
	storage_slots = 7
	can_hold = list(
		/obj/item/tool/screwdriver,
		/obj/item/tool/wrench,
		/obj/item/tool/weldingtool,
		/obj/item/tool/crowbar,
		/obj/item/tool/wirecutters,
		/obj/item/stack/cable_coil,
		/obj/item/device/multitool,
		/obj/item/tool/shovel/etool,
		/obj/item/weapon/gun/smg/nailgun/compact,
		/obj/item/device/defibrillator/synthetic,
		/obj/item/stack/rods,
	)

/obj/item/storage/internal/accessory/tool_webbing/small
	storage_slots = 6

/obj/item/clothing/accessory/storage/tool_webbing/small/equipped
	hold = /obj/item/storage/internal/accessory/tool_webbing/small/equipped

/obj/item/storage/internal/accessory/tool_webbing/small/equipped/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)

/obj/item/clothing/accessory/storage/tool_webbing/equipped
	hold = /obj/item/storage/internal/accessory/tool_webbing/equipped

/obj/item/storage/internal/accessory/tool_webbing/equipped/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/device/multitool(src)

/obj/item/clothing/accessory/storage/tool_webbing/yellow_drop
	name = "工具垂降挂包"
	desc = "一对耐用的垂降挂包，专为携带工具而设计。"
	icon_state = "drop_pouch_engineering"

/obj/item/clothing/accessory/storage/tool_webbing/yellow_drop/small
	name = "小型工具垂降挂包"
	desc = "一对耐用的垂降挂包，专为携带工具而设计。这是稍小一些的预算版本。"
	hold = /obj/item/storage/internal/accessory/tool_webbing/small

/obj/item/clothing/accessory/storage/tool_webbing/yellow_drop/equipped
	hold = /obj/item/storage/internal/accessory/tool_webbing/equipped

/obj/item/clothing/accessory/storage/tool_webbing/yellow_drop/small/equipped
	hold = /obj/item/storage/internal/accessory/tool_webbing/small/equipped

/obj/item/storage/internal/accessory/surg_vest
	storage_slots = 14
	can_hold = list(
		/obj/item/tool/surgery,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/nanopaste,
	)

/obj/item/storage/internal/accessory/surg_vest/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/surgical_tray))
		var/obj/item/storage/surgical_tray/ST = W
		if(!length(ST.contents))
			return
		if(length(contents) >= storage_slots)
			to_chat(user, SPAN_WARNING("手术背心已经满了。"))
			return
		if(!do_after(user, 5 SECONDS * user.get_skill_duration_multiplier(SKILL_MEDICAL), INTERRUPT_ALL, BUSY_ICON_GENERIC))
			return
		for(var/obj/item/I in ST)
			if(length(contents) >= storage_slots)
				break
			ST.remove_from_storage(I)
			attempt_item_insertion(I, TRUE, user)
		user.visible_message("[user]将工具从\the [ST]转移到手术背心上。", SPAN_NOTICE("You transfer the tools from \the [ST] to the surgical webbing vest."), max_distance = 3)
		return
	return ..()

/obj/item/storage/internal/accessory/surg_vest/equipped/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel/pict_system(src)
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/surgicaldrill(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/synthgraft(src)

/obj/item/clothing/accessory/storage/surg_vest
	name = "手术工具背心"
	desc = "一种专门用于存放手术工具的浅绿色合成棉背心。"
	icon_state = "vest_surg"
	hold = /obj/item/storage/internal/accessory/surg_vest

/obj/item/clothing/accessory/storage/surg_vest/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/drop_green
	name = "绿色手术工具挎包"
	desc = "一种专门用于存放手术工具的浅绿色合成棉挎包。"
	icon_state = "drop_pouch_surgical_green"

/obj/item/clothing/accessory/storage/surg_vest/drop_green/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/drop_green/upp
	hold = /obj/item/storage/internal/accessory/surg_vest/drop_green/upp

/obj/item/storage/internal/accessory/surg_vest/drop_green/upp/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/surgicaldrill(src)
	new /obj/item/tool/surgery/scalpel/pict_system(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/reagent_container/blood/OMinus(src)

/obj/item/clothing/accessory/storage/surg_vest/blue
	name = "蓝色手术工具背心"
	desc = "一种专门用于存放手术工具的哑光蓝色合成棉背心。"
	icon_state = "vest_blue"

/obj/item/clothing/accessory/storage/surg_vest/blue/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/drop_blue
	name = "蓝色手术工具挎包"
	desc = "一种专门用于存放手术工具的哑光蓝色合成棉挎包。"
	icon_state = "drop_pouch_surgical_blue"

/obj/item/clothing/accessory/storage/surg_vest/drop_blue/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/black
	name = "黑色手术工具背心"
	desc = "一种专门用于存放手术工具的战术黑色合成棉背心。"
	icon_state = "vest_black"

/obj/item/clothing/accessory/storage/surg_vest/black/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/drop_black
	name = "黑色手术工具挎包"
	desc = "一种专门用于存放手术工具的战术黑色合成棉挎包。"
	icon_state = "drop_pouch_surgical_black"

/obj/item/clothing/accessory/storage/surg_vest/drop_black/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/knifeharness
	name = "M272型刀具背心"
	desc = "一种曾被USCM使用的旧式M272型刀具背心。最多可容纳5把刀。由合成棉制成。"
	icon_state = "vest_knives"
	hold = /obj/item/storage/internal/accessory/knifeharness

/obj/item/clothing/accessory/storage/knifeharness/attack_hand(mob/user, mods)
	if(!mods || !mods[ALT_CLICK] || !length(hold.contents))
		return ..()

	hold.contents[length(contents)].attack_hand(user, mods)

/obj/item/storage/internal/accessory/knifeharness
	storage_slots = 5
	max_storage_space = 5
	can_hold = list(
		/obj/item/tool/kitchen/utensil/knife,
		/obj/item/tool/kitchen/utensil/pknife,
		/obj/item/tool/kitchen/knife,
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
	)
	storage_flags = STORAGE_ALLOW_QUICKDRAW|STORAGE_FLAGS_POUCH

	COOLDOWN_DECLARE(draw_cooldown)

/obj/item/storage/internal/accessory/knifeharness/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/weapon/throwing_knife(src)

/obj/item/storage/internal/accessory/knifeharness/attack_hand(mob/user, mods)
	. = ..()

	if(!COOLDOWN_FINISHED(src, draw_cooldown))
		to_chat(user, SPAN_WARNING("你需要等待片刻才能拔出另一把刀！"))
		return FALSE

	if(length(contents))
		contents[length(contents)].attack_hand(user, mods)
		COOLDOWN_START(src, draw_cooldown, BAYONET_DRAW_DELAY)

/obj/item/storage/internal/accessory/knifeharness/_item_insertion(obj/item/inserted_item, prevent_warning = 0)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/storage/internal/accessory/knifeharness/_item_removal(obj/item/removed_item, atom/new_location)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/clothing/accessory/storage/droppouch
	name = "挎包"
	desc = "一个便于携带零散物品的挎包。"
	icon_state = "drop_pouch"

	hold = /obj/item/storage/internal/accessory/drop_pouch

/obj/item/clothing/accessory/storage/droppouch/black
	name = "黑色挎包"
	icon_state = "drop_pouch_black"

/obj/item/storage/internal/accessory/drop_pouch
	w_class = SIZE_LARGE //Allow storage containers that's medium or below
	storage_slots = null
	max_w_class = SIZE_MEDIUM
	max_storage_space = 8 //weight system like backpacks, hold enough for 2 medium (normal) size items, or 4 small items, or 8 tiny items
	cant_hold = list( //Prevent inventory powergame
		/obj/item/storage/firstaid,
		/obj/item/storage/bible,
		/obj/item/storage/toolkit,
		)
	storage_flags = STORAGE_ALLOW_DRAWING_METHOD_TOGGLE

/obj/item/clothing/accessory/storage/holster
	name = "肩挂式枪套"
	desc = "一个手枪枪套，附带一个挎包，可额外存放两个弹匣或快速装弹器。"
	icon_state = "holster"
	worn_accessory_slot = ACCESSORY_SLOT_STORAGE
	high_visibility = TRUE
	hold = /obj/item/storage/internal/accessory/holster

/obj/item/storage/internal/accessory/holster
	w_class = SIZE_LARGE
	max_w_class = SIZE_MEDIUM
	var/obj/item/weapon/gun/current_gun
	var/sheatheSound = 'sound/weapons/gun_pistol_sheathe.ogg'
	var/drawSound = 'sound/weapons/gun_pistol_draw.ogg'
	storage_flags = STORAGE_ALLOW_QUICKDRAW|STORAGE_FLAGS_POUCH
	can_hold = list(

//Can hold variety of pistols and revolvers together with ammo for them. Can also hold the flare pistol and signal/illumination flares.
	/obj/item/weapon/gun/pistol,
	/obj/item/weapon/gun/energy/taser,
	/obj/item/weapon/gun/revolver,
	/obj/item/ammo_magazine/pistol,
	/obj/item/ammo_magazine/revolver,
	/obj/item/weapon/gun/flare,
	/obj/item/device/flashlight/flare
	)

/obj/item/storage/internal/accessory/holster/on_stored_atom_del(atom/movable/AM)
	if(AM == current_gun)
		current_gun = null

/obj/item/clothing/accessory/storage/holster/attack_hand(mob/user, mods)
	var/obj/item/storage/internal/accessory/holster/H = hold
	if(H.current_gun && ishuman(user) && (loc == user || has_suit))
		if(mods && mods[ALT_CLICK] && length(H.contents) > 1) //Withdraw the most recently inserted magazine, if possible.
			var/obj/item/I = H.contents[length(H.contents)]
			if(isgun(I))
				I = H.contents[length(H.contents) - 1]
			I.attack_hand(user)
		else
			H.current_gun.attack_hand(user)
		return

	..()

/obj/item/storage/internal/accessory/holster/can_be_inserted(obj/item/W, mob/user, stop_messages = FALSE)
	if( ..() ) //If the parent did their thing, this should be fine. It pretty much handles all the checks.
		if(isgun(W))
			if(current_gun)
				if(!stop_messages)
					to_chat(usr, SPAN_WARNING("[src]已经装有一把[W]了。"))
				return
		else //Must be ammo.
			var/ammo_slots = storage_slots - 1 //We have a slot reserved for the gun
			var/ammo_stored = length(contents)
			if(current_gun)
				ammo_stored--
			if(ammo_stored >= ammo_slots)
				if(!stop_messages)
					to_chat(usr, SPAN_WARNING("[src]无法容纳更多弹匣了。"))
				return
		return 1

/obj/item/storage/internal/accessory/holster/_item_insertion(obj/item/W)
	if(isgun(W))
		current_gun = W //If there's no active gun, we want to make this our gun
		playsound(src, sheatheSound, 15, TRUE)
	. = ..()

/obj/item/storage/internal/accessory/holster/_item_removal(obj/item/W)
	if(isgun(W))
		current_gun = null
		playsound(src, drawSound, 15, TRUE)
	. = ..()

/obj/item/clothing/accessory/storage/holster/armpit
	name = "肩挂式枪套"
	desc = "一个破旧的手枪枪套。非常适合隐蔽携带。"
	icon_state = "holster"

/obj/item/clothing/accessory/storage/holster/waist
	name = "肩挂式枪套"
	desc = "一个手枪枪套。由昂贵的皮革制成。"
	icon_state = "holster"

/*
	Holobadges are worn on the belt or neck, and can be used to show that the holder is an authorized
	Security agent - the user details can be imprinted on the badge with a Security-access ID card,
	or they can be emagged to accept any ID for use in disguises.
*/

/obj/item/clothing/accessory/holobadge

	name = "holobadge"
	desc = "这枚发光的蓝色徽章标志着佩戴者就是法律。"
	icon_state = "holobadge"
	icon = 'icons/obj/items/clothing/accessory/misc.dmi'
	inv_overlay_icon = 'icons/obj/items/clothing/accessory/inventory_overlays/misc.dmi'
	accessory_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi'
	)
	flags_equip_slot = SLOT_WAIST
	jumpsuit_hide_states = UNIFORM_JACKET_REMOVED
	worn_accessory_slot = ACCESSORY_SLOT_DECOR

	var/stored_name = null

/obj/item/clothing/accessory/holobadge/cord
	icon_state = "holobadge-cord"
	flags_equip_slot = SLOT_FACE
	accessory_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi',
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi',
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/accessory/misc.dmi'
	)

/obj/item/clothing/accessory/holobadge/attack_self(mob/user)
	..()

	if(!stored_name)
		to_chat(user, "在刷卡前挥舞徽章毫无意义。")
		return
	if(isliving(user))
		user.visible_message(SPAN_DANGER("[user]展示了他们的维兰德-汤谷内部安全法律授权徽章。\n上面写着：[stored_name]，维兰德-汤谷安全部。"),SPAN_DANGER("You display your Wey-Yu Internal Security Legal Authorization Badge.\nIt reads: [stored_name], Wey-Yu Security."))

/obj/item/clothing/accessory/holobadge/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/card/id))

		var/obj/item/card/id/id_card = null

		if(istype(O, /obj/item/card/id))
			id_card = O

		if(ACCESS_MARINE_BRIG in id_card.access)
			to_chat(user, "你将你的身份信息刻印到徽章上。")
			stored_name = id_card.registered_name
			name = "全息徽章 ([stored_name])"
			desc = "这个发光的蓝色徽章标志着[stored_name]就是法律。"
		else
			to_chat(user, "[src]拒绝了你的权限不足。")
		return
	..()

/obj/item/clothing/accessory/holobadge/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(SPAN_DANGER("[user]侵入了[M]的个人空间，固执地将[src]戳到他们脸上。"),SPAN_DANGER("You invade [M]'s personal space, thrusting [src] into their face insistently. You are the law."))

/obj/item/storage/box/holobadge // re-org this out in the future
	name = "全息徽章盒"
	desc = "一个声称装有全息徽章的盒子。"

/obj/item/storage/box/holobadge/New()
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge/cord(src)
	new /obj/item/clothing/accessory/holobadge/cord(src)
	..()
	return

/obj/item/clothing/accessory/storage/owlf_vest
	name = "\improper OWLF agent vest"
	desc = "这是一件看起来很花哨的防弹背心，需要附着在制服上。" //No stats for these yet, just placeholder implementation.
	icon_state = "owlf_vest"
	item_state = "owlf_vest"

/*
Wrist Accessories
*/

/obj/item/clothing/accessory/wrist
	name = "bracelet"
	desc = "一条由织物带制成的简单手环。"
	icon = 'icons/obj/items/clothing/accessory/wrist_accessories.dmi'
	icon_state = "bracelet"
	inv_overlay_icon = null
	worn_accessory_slot = ACCESSORY_SLOT_WRIST_L
	worn_accessory_limit = 4
	var/which_wrist = "left wrist"

/obj/item/clothing/accessory/wrist/get_examine_text(mob/user)
	. = ..()

	switch(worn_accessory_slot)
		if(ACCESSORY_SLOT_WRIST_L)
			which_wrist = "left wrist"
		if(ACCESSORY_SLOT_WRIST_R)
			which_wrist = "right wrist"
	. += "It will be worn on the [which_wrist]."

/obj/item/clothing/accessory/wrist/additional_examine_text()
	return "on the [which_wrist]."

/obj/item/clothing/accessory/wrist/attack_self(mob/user)
	..()

	switch(worn_accessory_slot)
		if(ACCESSORY_SLOT_WRIST_L)
			worn_accessory_slot = ACCESSORY_SLOT_WRIST_R
			to_chat(user, SPAN_NOTICE("[src]将佩戴在右手腕上。"))
		if(ACCESSORY_SLOT_WRIST_R)
			worn_accessory_slot = ACCESSORY_SLOT_WRIST_L
			to_chat(user, SPAN_NOTICE("[src]将佩戴在左手腕上。"))

/obj/item/clothing/accessory/wrist/watch
	name = "数字腕表"
	desc = "一块廉价的仅24小时制数字腕表。它有一个糟糕的红色显示屏，很适合在黑暗中查看！"
	icon = 'icons/obj/items/clothing/accessory/watches.dmi'
	icon_state = "cheap_watch"
	worn_accessory_limit = 1 // though, this means you can wear a watch on each wrist, which should be fine, although you might look stupid for doing this

/obj/item/clothing/accessory/wrist/watch/get_examine_text(mob/user)
	. = ..()

	. += "It reads: [SPAN_NOTICE("[worldtime2text()]")]"

/obj/item/clothing/accessory/wrist/watch/additional_examine_text()
	. = ..()

	. += " It reads: [SPAN_NOTICE("[worldtime2text()]")]"


//TEMPORARY

/obj/item/clothing/accessory/helmet/cover
	name = "土豆套"
	desc = "如果你看到这个，请使用管理员求助。"
	garbage = TRUE // for all intents and purposes, yes
	flags_obj = OBJ_IS_HELMET_GARB
	w_class = SIZE_TINY
	worn_accessory_slot = ACCESSORY_SLOT_HELM_C
	worn_accessory_limit = 2 // cover a helmet with a raincover and a netting i guess
	icon = 'icons/obj/items/clothing/helmet_garb.dmi'
	accessory_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/helmet_garb/helmet_covers.dmi',
	)
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/helmet_covers.dmi',
	)

/obj/item/clothing/accessory/helmet/cover/raincover
	name = "raincover"
	desc = "标准的M10战斗头盔本身在10米深度内就具有防水性。这使得顶部可能完全防水。至少有点用。"
	icon_state = "raincover"

/obj/item/clothing/accessory/helmet/cover/raincover/jungle
	name = "丛林防雨罩"
	icon_state = "raincover_jungle"

/obj/item/clothing/accessory/helmet/cover/raincover/desert
	name = "沙漠防雨罩"
	icon_state = "raincover_desert"

/obj/item/clothing/accessory/helmet/cover/raincover/urban
	name = "城市防雨罩"
	icon_state = "raincover_urban"

/obj/item/clothing/accessory/helmet/cover/netting
	name = "战斗伪装网"
	desc = "大概是头盔用的战斗伪装网。也可能只是为阿尔迈耶号上不存在的炊事人员订购的额外发网。大概没什么用。"
	icon_state = "netting"

/obj/item/clothing/accessory/helmet/cover/netting/desert
	name = "沙漠战斗伪装网"
	icon_state = "netting_desert"

/obj/item/clothing/accessory/helmet/cover/netting/jungle
	name = "丛林战斗伪装网"
	icon_state = "netting_jungle"

/obj/item/clothing/accessory/helmet/cover/netting/urban
	name = "城市作战伪装网"
	icon_state = "netting_urban"
