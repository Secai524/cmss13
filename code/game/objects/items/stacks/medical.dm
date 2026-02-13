/obj/item/stack/medical
	name = "医疗包"
	singular_name = "医疗包"
	icon = 'icons/obj/items/medical_stacks.dmi'
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/medical.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	amount = 10
	max_amount = 10
	w_class = SIZE_SMALL
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	attack_speed = 3
	var/heal_brute = 0
	var/heal_burn = 0
	var/alien = FALSE

/obj/item/stack/medical/attack_self(mob/user)
	..()
	attack(user, user)

/obj/item/stack/medical/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(!istype(M))
		to_chat(user, SPAN_DANGER("\The [src] cannot be applied to [M]!"))
		return 1

	if(!ishuman(user))
		to_chat(user, SPAN_WARNING("你的手不够灵巧，无法完成此操作！"))
		return 1

	var/mob/living/carbon/human/H = M
	var/obj/limb/affecting = H.get_limb(user.zone_selected)

	if(HAS_TRAIT(H, TRAIT_FOREIGN_BIO) && !alien)
		to_chat(user, SPAN_WARNING("\The [src] is incompatible with the biology of [H]!"))
		return TRUE

	if(!affecting)
		to_chat(user, SPAN_WARNING("[H]没有[parse_zone(user.zone_selected)]！"))
		return 1

	if(affecting.display_name == "head")
		if(H.head && istype(H.head,/obj/item/clothing/head/helmet/space))
			to_chat(user, SPAN_WARNING("你无法透过[H.head]使用[src]！"))
			return 1
	else
		if(H.wear_suit && istype(H.wear_suit,/obj/item/clothing/suit/space))
			to_chat(user, SPAN_WARNING("你无法透过[H.wear_suit]使用[src]！"))
			return 1

	if(affecting.status & (LIMB_ROBOT|LIMB_SYNTHSKIN))
		to_chat(user, SPAN_WARNING("这对机械肢体毫无用处。"))
		return 1

/obj/item/stack/medical/bruise_pack
	name = "纱布卷"
	singular_name = "medical gauze"
	desc = "用于包裹血淋淋的断肢和撕裂伤的无菌纱布。"
	icon_state = "brutepack"
	item_state_slots = list(WEAR_AS_GARB = "brutepack (bandages)")
	stack_id = "bruise pack"

/obj/item/stack/medical/bruise_pack/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(..())
		return 1

	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M

		var/obj/limb/affecting = H.get_limb(user.zone_selected)

		if(user.skills)
			if(!skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
				if(!do_after(user, 10, INTERRUPT_NO_NEEDHAND, BUSY_ICON_FRIENDLY, M, INTERRUPT_MOVED, BUSY_ICON_MEDICAL))
					return 1


		if(affecting.get_incision_depth())
			to_chat(user, SPAN_NOTICE("[M]的[affecting.display_name]已被切开，你需要的不止是绷带！"))
			return TRUE

		var/possessive = "[user == M ? "your" : "\the [M]'s"]"
		var/possessive_their = "[user == M ? user.p_their() : "\the [M]'s"]"
		switch(affecting.bandage())
			if(WOUNDS_BANDAGED)
				user.affected_message(M,
					SPAN_HELPFUL("You <b>bandage</b> [possessive] <b>[affecting.display_name]</b>."),
					SPAN_HELPFUL("[user] <b>bandages</b> your <b>[affecting.display_name]</b>."),
					SPAN_NOTICE("[user] bandages [possessive_their] [affecting.display_name]."))
				use(1)
				playsound(user, 'sound/handling/bandage.ogg', 25, 1, 2)
			if(WOUNDS_ALREADY_TREATED)
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上的伤口已经处理过了。"))
				return TRUE
			else
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上没有伤口。"))
				return TRUE

/obj/item/stack/medical/bruise_pack/two
	amount = 2

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "用于治疗烧伤、感染伤口，并缓解特殊部位的瘙痒。"
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	item_state_slots = list(WEAR_AS_GARB = "ointment")
	heal_burn = 5
	stack_id = "ointment"

/obj/item/stack/medical/ointment/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(..())
		return 1

	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M

		var/obj/limb/affecting = H.get_limb(user.zone_selected)

		if(user.skills)
			if(!skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
				if(!do_after(user, 10, INTERRUPT_NO_NEEDHAND, BUSY_ICON_FRIENDLY, M, INTERRUPT_MOVED, BUSY_ICON_MEDICAL))
					return 1

		if(affecting.get_incision_depth())
			to_chat(user, SPAN_NOTICE("[M]的[affecting.display_name]已被切开，你需要的不止是药膏！"))
			return TRUE

		var/possessive = "[user == M ? "your" : "\the [M]'s"]"
		var/possessive_their = "[user == M ? user.p_their() : "\the [M]'s"]"
		switch(affecting.salve())
			if(WOUNDS_BANDAGED)
				user.affected_message(M,
					SPAN_HELPFUL("You <b>salve the burns</b> on [possessive] <b>[affecting.display_name]</b>."),
					SPAN_HELPFUL("[user] <b>salves the burns</b> on your <b>[affecting.display_name]</b>."),
					SPAN_NOTICE("[user] salves the burns on [possessive_their] [affecting.display_name]."))
				affecting.status &= ~LIMB_THIRD_DEGREE_BURNS
				affecting.heal_damage(burn = heal_burn)

				use(1)
				playsound(user, 'sound/handling/ointment_spreading.ogg', 25, 1, 2)
			if(WOUNDS_ALREADY_TREATED)
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上的烧伤已经处理过了。"))
				return TRUE
			else
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上没有烧伤。"))
				return TRUE

/obj/item/stack/medical/advanced/bruise_pack
	name = "创伤包"
	singular_name = "创伤包"
	desc = "用于处理严重伤势的创伤包。"
	icon_state = "traumakit"
	item_state = "brutekit"
	heal_brute = 12

	stack_id = "advanced bruise pack"

/obj/item/stack/medical/advanced/bruise_pack/attack(mob/living/carbon/M, mob/user)
	if(..())
		return 1

	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M

		var/obj/limb/affecting = H.get_limb(user.zone_selected)
		var/heal_amt = heal_brute
		if(user.skills)
			if(!skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC)) //untrained marines have a hard time using it
				to_chat(user, SPAN_WARNING("你开始笨拙地摆弄[src]。"))
				if(!do_after(user, 30, INTERRUPT_NO_NEEDHAND, BUSY_ICON_FRIENDLY, M, INTERRUPT_MOVED, BUSY_ICON_MEDICAL))
					return
				heal_amt = 3 //non optimal application means less healing

		if(affecting.get_incision_depth())
			to_chat(user, SPAN_NOTICE("[M]的[affecting.display_name]已被切开，你需要的不止是创伤包！"))
			return TRUE

		var/possessive = "[user == M ? "your" : "\the [M]'s"]"
		var/possessive_their = "[user == M ? user.p_their() : "\the [M]'s"]"
		switch(affecting.bandage(TRUE))
			if(WOUNDS_BANDAGED)
				user.affected_message(M,
					SPAN_HELPFUL("You <b>clean and seal</b> the wounds on [possessive] <b>[affecting.display_name]</b> with bioglue."),
					SPAN_HELPFUL("[user] <b>cleans and seals</b> the wounds on your <b>[affecting.display_name]</b> with bioglue."),
					SPAN_NOTICE("[user] cleans and seals the wounds on [possessive_their] [affecting.display_name] with bioglue."))
				//If a suture datum exists, apply half the damage as sutures. This ensures consistency in healing amounts.
				if(SEND_SIGNAL(affecting, COMSIG_LIMB_ADD_SUTURES, TRUE, FALSE, heal_amt * 0.5))
					heal_amt *= 0.5
				affecting.heal_damage(brute = heal_amt)
				use(1)
			if(WOUNDS_ALREADY_TREATED)
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上的伤口已经处理过了。"))
				return TRUE
			else
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上没有伤口。"))
				return TRUE

/obj/item/stack/medical/advanced/bruise_pack/upgraded
	name = "升级版创伤包"
	singular_name = "升级版创伤包"
	stack_id = "升级版创伤包"

	icon_state = "traumakit_upgraded"
	desc = "升级版创伤治疗包。效果是标准配发的三倍，且无法补充。请仅用于最危急的伤口，谨慎使用。"

	max_amount = 10
	amount = 10

/obj/item/stack/medical/advanced/bruise_pack/upgraded/Initialize(mapload, ...)
	. = ..()
	heal_brute = initial(heal_brute) * 3 // 3x stronger

/obj/item/stack/medical/advanced/bruise_pack/predator
	name = "疗伤草药"
	singular_name = "mending herb"
	desc = "一种由柔软叶片制成的膏药，用于涂抹瘀伤。"
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	icon_state = "brute_herbs"
	item_state = "brute_herbs"
	heal_brute = 15
	stack_id = "疗伤草药"
	alien = TRUE

/obj/item/stack/medical/advanced/ointment
	name = "烧伤包"
	singular_name = "烧伤包"
	desc = "用于严重烧伤的治疗包。"
	icon_state = "burnkit"
	item_state = "burnkit"
	heal_burn = 12

	stack_id = "烧伤包"

/obj/item/stack/medical/advanced/ointment/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(..())
		return 1

	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M

		var/heal_amt = heal_burn
		var/obj/limb/affecting = H.get_limb(user.zone_selected)
		if(user.skills)
			if(!skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC)) //untrained marines have a hard time using it
				to_chat(user, SPAN_WARNING("你开始笨拙地摆弄[src]。"))
				if(!do_after(user, 30, INTERRUPT_NO_NEEDHAND, BUSY_ICON_FRIENDLY, M, INTERRUPT_MOVED, BUSY_ICON_MEDICAL))
					return
				heal_amt = 3 //non optimal application means less healing

		if(affecting.get_incision_depth())
			to_chat(user, SPAN_NOTICE("[M]的[affecting.display_name]被切开了，光用烧伤包可不够！"))
			return TRUE

		var/possessive = "[user == M ? "your" : "\the [M]'s"]"
		var/possessive_their = "[user == M ? user.p_their() : "\the [M]'s"]"
		switch(affecting.salve(TRUE))
			if(WOUNDS_BANDAGED)
				user.affected_message(M,
					SPAN_HELPFUL("You <b>cover the burns</b> on [possessive] <b>[affecting.display_name]</b> with regenerative membrane."),
					SPAN_HELPFUL("[user] <b>covers the burns</b> on your <b>[affecting.display_name]</b> with regenerative membrane."),
					SPAN_NOTICE("[user] covers the burns on [possessive_their] [affecting.display_name] with regenerative membrane."))
				//If a suture datum exists, apply half the damage as grafts. This ensures consistency in healing amounts.
				if(SEND_SIGNAL(affecting, COMSIG_LIMB_ADD_SUTURES, FALSE, TRUE, heal_amt * 0.5))
					heal_amt *= 0.5
				affecting.status &= ~LIMB_THIRD_DEGREE_BURNS
				affecting.heal_damage(burn = heal_amt)

				use(1)
			if(WOUNDS_ALREADY_TREATED)
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上的烧伤已经处理过了。"))
				return TRUE
			else
				to_chat(user, SPAN_WARNING("[possessive]的[affecting.display_name]上没有烧伤。"))
				return TRUE

/obj/item/stack/medical/advanced/ointment/upgraded
	name = "升级版烧伤包"
	singular_name = "升级版烧伤包"
	stack_id = "升级版烧伤包"

	icon_state = "burnkit_upgraded"
	desc = "一个升级版烧伤治疗包。效果是标准配发的三倍，且无法补充。请仅在处理最危急的烧伤时谨慎使用。"

	max_amount = 10
	amount = 10

/obj/item/stack/medical/advanced/ointment/upgraded/Initialize(mapload, ...)
	. = ..()
	heal_burn = initial(heal_burn) * 3 // 3x stronger

/obj/item/stack/medical/advanced/ointment/predator
	name = "舒缓草药"
	singular_name = "soothing herb"
	desc = "一种由冰冷的蓝色花瓣制成的药膏，用于涂抹在烧伤处。"
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	icon_state = "burn_herbs"
	item_state = "burn_herbs"
	heal_burn = 15
	stack_id = "舒缓草药"
	alien = TRUE

/obj/item/stack/medical/splint
	name = "医用夹板"
	singular_name = "medical splint"
	desc = "一套包含不同夹板和固定纱布的套装。怎么，你以为我们在这只会摔断腿吗？"
	icon_state = "splint"
	item_state = "splint"
	amount = 5
	max_amount = 5
	stack_id = "splint"

	var/indestructible_splints = FALSE

/obj/item/stack/medical/splint/Initialize(mapload, amount)
	. = ..()
	if(MODE_HAS_MODIFIER(/datum/gamemode_modifier/indestructible_splints))
		icon_state = "nanosplint"
		indestructible_splints = TRUE
		update_icon()

/obj/item/stack/medical/splint/attack(mob/living/carbon/M, mob/user)
	if(..())
		return 1

	if(user.action_busy)
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/limb/affecting = H.get_limb(user.zone_selected)
		var/limb = affecting.display_name

		if(!(affecting.name in list("l_arm", "r_arm", "l_leg", "r_leg", "r_hand", "l_hand", "r_foot", "l_foot", "chest", "groin", "head")))
			to_chat(user, SPAN_WARNING("你无法在那里使用夹板！"))
			return

		if(affecting.status & LIMB_DESTROYED)
			var/message = SPAN_WARNING("[user == M ? "You don't" : "[M] doesn't"] have \a [limb]!")
			to_chat(user, message)
			return

		if(affecting.status & LIMB_SPLINTED)
			var/message = "[user == M ? "Your" : "[M]'s"]"
			to_chat(user, SPAN_WARNING("[message][limb]已经上好夹板了！"))
			return

		if(M != user)
			var/possessive = "[user == M ? "your" : "\the [M]'s"]"
			var/possessive_their = "[user == M ? user.p_their() : "\the [M]'s"]"
			user.affected_message(M,
				SPAN_HELPFUL("You <b>start splinting</b> [possessive] <b>[affecting.display_name]</b>."),
				SPAN_HELPFUL("[user] <b>starts splinting</b> your <b>[affecting.display_name]</b>."),
				SPAN_NOTICE("[user] starts splinting [possessive_their] [affecting.display_name]."))
		else
			if((!user.hand && (affecting.name in list("r_arm", "r_hand"))) || (user.hand && (affecting.name in list("l_arm", "l_hand"))))
				to_chat(user, SPAN_WARNING("You can't apply a splint to the \
					[affecting.name == "r_hand"||affecting.name == "l_hand" ? "hand":"arm"] you're using!"))
				return
			// Self-splinting
			user.affected_message(M,
				SPAN_HELPFUL("You <b>start splinting</b> your <b>[affecting.display_name]</b>."),
				,
				SPAN_NOTICE("[user] starts splinting \his [affecting.display_name]."))

		if(affecting.apply_splints(src, user, M, indestructible_splints)) // Referenced in external organ helpers.
			use(1)
			playsound(user, 'sound/handling/splint1.ogg', 25, 1, 2)

/obj/item/stack/medical/splint/nano
	name = "纳米夹板"
	singular_name = "nano splint"

	icon_state = "nanosplint"
	desc = "先进技术使这些夹板能在保持柔韧性和抗损伤性的同时固定骨骼。这些夹板数量不多，请谨慎用于关键部位。"

	indestructible_splints = TRUE
	amount = 5
	max_amount = 5

	stack_id = "nano splint"

/obj/item/stack/medical/splint/nano/research
	desc = "先进技术使这些夹板能在保持柔韧性和抗损伤性的同时固定骨骼。它们由耐用的碳纤维制成，看起来价格不菲，最好谨慎使用。"
