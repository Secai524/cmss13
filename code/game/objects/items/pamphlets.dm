/obj/item/pamphlet
	name = "指导手册"
	desc = "用于快速传授关键知识的手册。"
	icon = 'icons/obj/items/pamphlets.dmi'
	icon_state = "pamphlet_written"
	item_state = "paper"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_righthand.dmi'
	)
	pickup_sound = 'sound/handling/paper_pickup.ogg'
	drop_sound = 'sound/handling/paper_drop.ogg'
	w_class = SIZE_TINY
	throw_speed = SPEED_FAST
	throw_range = 20
	var/datum/character_trait/trait = /datum/character_trait
	var/flavour_text = "You read over the pamphlet a few times, learning a new skill."
	var/bypass_pamphlet_limit = FALSE

/obj/item/pamphlet/Initialize()
	. = ..()

	trait = GLOB.character_traits[trait]

/obj/item/pamphlet/attack_self(mob/living/carbon/human/user)
	..()

	if(!can_use(user))
		return
	on_use(user)

	qdel(src)

/obj/item/pamphlet/proc/can_use(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE
	if(trait in user.traits)
		to_chat(user, SPAN_WARNING("你已经知道了！"))
		return FALSE
	if(user.has_used_pamphlet == TRUE && !bypass_pamphlet_limit)
		to_chat(user, SPAN_WARNING("你已经使用过手册了！"))
		return FALSE
	return TRUE

/obj/item/pamphlet/proc/on_use(mob/living/carbon/human/user)
	to_chat(user, SPAN_NOTICE(flavour_text))
	trait.apply_trait(user)
	if(!bypass_pamphlet_limit)
		user.has_used_pamphlet = TRUE

/obj/item/pamphlet/skill/medical
	name = "医疗指导手册"
	desc = "用于快速传授关键知识的手册。这本带有医疗徽章。"
	icon_state = "pamphlet_medical"
	trait = /datum/character_trait/skills/medical

/obj/item/pamphlet/skill/science
	name = "科研指导手册"
	desc = "用于快速传授关键知识的手册。这本带有科研徽章。"
	icon_state = "pamphlet_science"
	trait = /datum/character_trait/skills/science

/obj/item/pamphlet/skill/engineer
	name = "工程指导手册"
	desc = "用于快速传授关键知识的手册。这本带有工程徽章。"
	icon_state = "pamphlet_construction"
	trait = /datum/character_trait/skills/miniengie

/obj/item/pamphlet/skill/jtac
	name = "JTAC指导手册"
	desc = "用于快速传授关键知识的手册。这本上面有一个无线电的图像。"
	icon_state = "pamphlet_jtac"
	trait = /datum/character_trait/skills/jtac

/obj/item/pamphlet/skill/spotter
	name = "观察员指导手册"
	desc = "用于快速传授关键知识的手册。这本上面有一副望远镜的图像。"
	icon_state = "pamphlet_spotter"
	trait = /datum/character_trait/skills/spotter
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/spotter/can_use(mob/living/carbon/human/user)
	var/specialist_skill = user.skills.get_skill_level(SKILL_SPEC_WEAPONS)
	if(specialist_skill == SKILL_SPEC_SNIPER)
		to_chat(user, SPAN_WARNING("你不需要使用这个！把它交给另一名陆战队员，让他成为你的观察员。"))
		return FALSE
	if(specialist_skill != SKILL_SPEC_DEFAULT)
		to_chat(user, SPAN_WARNING("你已经是专家了！把这个交给训练不足的陆战队员。"))
		return FALSE

	if(user.job != JOB_SQUAD_MARINE)
		to_chat(user, SPAN_WARNING("只有班里的步枪兵可以使用这个。"))
		return

	var/obj/item/card/id/ID = user.get_idcard()
	if(!ID) //not wearing an ID
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE
	if(!ID.check_biometrics(user))
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE

	return ..()

/obj/item/pamphlet/skill/spotter/on_use(mob/living/carbon/human/user)
	. = ..()
	user.rank_fallback = "ass"
	user.hud_set_squad()

	var/obj/item/card/id/ID = user.get_idcard()
	ID.set_assignment((user.assigned_squad ? (user.assigned_squad.name + " ") : "") + "Spotter")
	ID.minimap_icon_override = "spotter"
	user.update_minimap_icon()
	GLOB.data_core.manifest_modify(user.real_name, WEAKREF(user), "Spotter")

/obj/item/pamphlet/skill/honorguard
	name = "仪仗队指导手册"
	desc = "用于快速传授关键知识的手册。这本详细说明了仪仗队的职责。"
	icon_state = "pamphlet_written"
	trait = null
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/honorguard/can_use(mob/living/carbon/human/user)
	if(user.job != JOB_POLICE)
		to_chat(user, SPAN_WARNING("只有宪兵可以使用这个。"))
		return

	var/obj/item/card/id/id_card = user.get_idcard()
	if(!id_card || !id_card.check_biometrics(user)) //not wearing an ID
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE

	if(user.rank_fallback == "hgmp"|| (id_card.minimap_icon_override == "honorguard"))
		to_chat(user, SPAN_WARNING("你已经是仪仗队员了！"))
		return FALSE

	return ..()

/obj/item/pamphlet/skill/honorguard/on_use(mob/living/carbon/human/user)
	. = ..()
	user.rank_fallback = "hgmp"
	user.hud_set_squad()

	var/obj/item/card/id/id_card = user.get_idcard()
	id_card.set_assignment((user.assigned_squad ? (user.assigned_squad.name + " ") : "") + JOB_POLICE_HG)
	id_card.minimap_icon_override = "honorguard"//Different to Whiskey Honor Guard
	user.update_minimap_icon()
	GLOB.data_core.manifest_modify(user.real_name, WEAKREF(user), JOB_POLICE_HG)

/obj/item/pamphlet/skill/cosmartgun
	name = "骑士指导手册"
	desc = "用于快速传授关键知识的小册子。这本封面上印有智能枪的图案。"
	icon_state = "pamphlet_loader"
	bypass_pamphlet_limit = TRUE
	trait = /datum/character_trait/skills/cosmartgun

/obj/item/pamphlet/skill/cosmartgun/can_use(mob/living/carbon/human/user)
	if(user.job != JOB_CO && user.job != JOB_WO_CO)
		to_chat(user, SPAN_WARNING("只有指挥官可以使用这个。"))
		return
	return ..()

/obj/item/pamphlet/skill/loader
	name = "装弹手指导手册"
	desc = "用于快速传授关键知识的小册子。这本封面上印有火箭的图案。"
	icon_state = "pamphlet_loader"
	trait = /datum/character_trait/skills/loader
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/loader/can_use(mob/living/carbon/human/user)
	var/specialist_skill = user.skills.get_skill_level(SKILL_SPEC_WEAPONS)
	if(specialist_skill == SKILL_SPEC_ROCKET)
		to_chat(user, SPAN_WARNING("你不需要使用这个！把它交给另一名陆战队员，让他成为你的装弹手。"))
		return FALSE
	if(specialist_skill != SKILL_SPEC_DEFAULT)
		to_chat(user, SPAN_WARNING("你已经是专家了！把这个交给训练不足的陆战队员。"))
		return FALSE

	if(user.job != JOB_SQUAD_MARINE)
		to_chat(user, SPAN_WARNING("只有班里的步枪兵可以使用这个。"))
		return

	var/obj/item/card/id/ID = user.get_idcard()
	if(!ID) //not wearing an ID
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE
	if(!ID.check_biometrics(user))
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE

	return ..()

/obj/item/pamphlet/skill/loader/on_use(mob/living/carbon/human/user)
	. = ..()
	user.rank_fallback = "load"
	user.hud_set_squad()

	var/obj/item/card/id/ID = user.get_idcard()
	ID.set_assignment((user.assigned_squad ? (user.assigned_squad.name + " ") : "") + "Loader")
	ID.minimap_icon_override = "loader"
	user.update_minimap_icon()
	GLOB.data_core.manifest_modify(user.real_name, WEAKREF(user), "Loader")

/obj/item/pamphlet/skill/mortar_operator
	name = "迫击炮操作员指导手册"
	desc = "用于快速传授关键知识的小册子。这本封面上印有迫击炮的图案。"
	icon_state = "pamphlet_mortar"
	trait = /datum/character_trait/skills/mortar
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/mortar_operator/can_use(mob/living/carbon/human/user)
	if(user.job != JOB_SQUAD_MARINE)
		to_chat(user, SPAN_WARNING("只有班里的步枪兵可以使用这个。"))
		return

	var/obj/item/card/id/ID = user.get_idcard()
	if(!ID) //not wearing an ID
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE
	if(!ID.check_biometrics(user))
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE

	return ..()

/obj/item/pamphlet/skill/mortar_operator/on_use(mob/living/carbon/human/user)
	. = ..()
	user.rank_fallback = "mortar"
	user.hud_set_squad()

	var/obj/item/card/id/ID = user.get_idcard()
	ID.set_assignment((user.assigned_squad ? (user.assigned_squad.name + " ") : "") + "Mortar Operator")
	ID.minimap_icon_override = "mortar"
	user.update_minimap_icon()
	GLOB.data_core.manifest_modify(user.real_name, WEAKREF(user), "Mortar Operator")

/obj/item/pamphlet/skill/k9_handler
	name = "K9驯犬员指导手册"
	desc = "用于快速传授关键知识的小册子。这本封面上印有合成人K9救援单位的图案。"
	icon_state = "pamphlet_k9_handler"
	trait = /datum/character_trait/skills/k9_handler
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/k9_handler/can_use(mob/living/carbon/human/user)
	if(isk9synth(user))
		to_chat(user, SPAN_WARNING("你不需要使用这个！把它交给另一名陆战队员，让他成为你的驯犬员。"))
		return FALSE

	if(user.job != JOB_SQUAD_MEDIC && user.job != JOB_POLICE)
		to_chat(user, SPAN_WARNING("这不是给你用的。"))
		return

	var/obj/item/card/id/ID = user.get_idcard()
	if(!istype(ID)) //not wearing an ID
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE
	if(!ID.check_biometrics(user))
		to_chat(user, SPAN_WARNING("你应该先佩戴好身份卡再这么做。"))
		return FALSE

	return ..()

/obj/item/pamphlet/skill/k9_handler/on_use(mob/living/carbon/human/user)
	. = ..()
	user.rank_fallback = "medk9"
	user.hud_set_squad()

	var/obj/item/card/id/ID = user.get_idcard()
	ID.set_assignment((user.assigned_squad ? (user.assigned_squad.name + " ") : "") + "K9 Handler")
	ID.minimap_icon_override = "medic_k9"
	user.update_minimap_icon()
	GLOB.data_core.manifest_modify(user.real_name, WEAKREF(user), "K9 Handler")

/obj/item/pamphlet/skill/machinegunner
	name = "重机枪手指导手册"
	desc = "用于快速传授关键知识的小册子。这本封面上印有工程和机枪徽章。"
	icon_state = "pamphlet_machinegunner"
	trait = /datum/character_trait/skills/engineering
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/powerloader
	name = "动力装载机指导手册"
	desc = "用于快速传授关键知识的小册子。这本封面上印有动力装载机徽章。标题写着“搬运货物与碾碎脑袋——卡特彼勒P-5000工作装载机实用指南”。"
	icon_state = "pamphlet_powerloader"
	trait = /datum/character_trait/skills/powerloader
	/// it's really not necessary to stop people from learning powerloader skill
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/police
	name = "警务指导手册"
	desc = "用于快速传授关键知识的手册。这本上面有一个无线电的图像。"
	icon_state = "pamphlet_jtac"
	trait = /datum/character_trait/skills/police
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/surgery
	name = "手术指导手册"
	desc = "用于快速传授关键知识的手册。这本带有医疗徽章。"
	icon_state = "pamphlet_medical"
	trait = /datum/character_trait/skills/surgery
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/skill/intel
	name = "野战情报指导手册"
	desc = "用于快速传授关键知识的小册子。这本封面上印有情报徽章。"
	icon_state = "pamphlet_reading"
	trait = /datum/character_trait/skills/intel
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/language
	name = "翻译手册"
	desc = "懒惰的USCM译员用来在现场快速学习新语言的小册子。"
	flavour_text = "You go over the pamphlet, learning a new language."
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/language/russian
	name = "《赌注》印刷本"
	desc = "《帕里》，英文亦作《赌注》，是俄国剧作家安东·契诃夫创作的短篇小说，讲述一名律师与一名银行家之间的赌约；银行家赌律师无法忍受15年的单独监禁，并承诺以200万卢布作为交换。如果你知道这个故事，那你一定是个有品位的读者；既然知道这个，你为什么还会在USCM？"
	trait = /datum/character_trait/language/russian

/obj/item/pamphlet/language/japanese
	name = "《流浪佣兵冒险续篇》书页"
	desc = "这是著名异世界漫画《流浪佣兵冒险续篇》的几页残篇，讲述了一队被送入奇幻世界的自由佣兵的冒险故事。你怎么会知道这个？"
	trait = /datum/character_trait/language/japanese

/obj/item/pamphlet/language/chinese
	name = "《小红书》摘页"
	desc = "没有共产党就没有新中国！这本手册教你如何发动一场导致上亿人民死亡的饥荒。显然这能帮你学中文。"
	trait = /datum/character_trait/language/chinese

/obj/item/pamphlet/language/german
	name = "《99个气球》歌词译文"
	desc = "这是80年代德国标志性热门歌曲《99个气球》的潦草译文，本是为营年度卡拉OK之夜准备的。我想你现在能更好地利用它了。"
	trait = /datum/character_trait/language/german

/obj/item/pamphlet/language/spanish
	name = "拉丁美洲——南部UA各州快速翻译指南"
	desc = "这本小册子是为在地球上活动的情报官设计的，用于与拉丁美洲各州的当地民众交流，但仅限于那些在方言与习俗课上全程睡着的IO。"
	trait = /datum/character_trait/language/spanish



//Restricted languages, spawnable for events.

/obj/item/pamphlet/language/yautja
	name = "污损的羊皮纸"
	desc = "一张泛黄的旧羊皮纸，上面布满了来自外星文字系统的奇怪符文。这些字母似乎在你眼前来回移动、变换位置。"
	trait = /datum/character_trait/language/sainja

/obj/item/pamphlet/language/xenomorph
	name = "异形生物学家的档案"
	desc = "一份异形生物学家的文件，记录并详细描述了关于被捕获异形通过发声和信息素进行交流的观察，以及关于人类尝试复制这些交流的笔记。"
	trait = /datum/character_trait/language/xenomorph

/obj/item/pamphlet/language/monkey
	name = "潦草的涂鸦"
	gender = PLURAL
	desc = "一张纸上画满了香蕉和各种灵长类动物的粗糙图画。可能是一个三岁小孩画的——或者是一个异常聪明的陆战队员。"
	trait = /datum/character_trait/language/primitive


/obj/item/pamphlet/trait
	bypass_pamphlet_limit = TRUE
	/// What trait to give the user
	var/trait_to_give

/obj/item/pamphlet/trait/can_use(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE

	if(HAS_TRAIT(user, trait_to_give))
		to_chat(user, SPAN_WARNING("你已经知道了！"))
		return FALSE

	if(!(user.job in JOB_SQUAD_ROLES_LIST))
		to_chat(user, SPAN_WARNING("只有班里的步枪兵可以使用这个。"))
		return FALSE

	if(user.has_used_pamphlet && !bypass_pamphlet_limit)
		to_chat(user, SPAN_WARNING("你已经使用过手册了！"))
		return FALSE

	return TRUE

/obj/item/pamphlet/trait/on_use(mob/living/carbon/human/user)
	to_chat(user, SPAN_NOTICE(flavour_text))
	ADD_TRAIT(user, trait_to_give, "pamphlet")
	if(!bypass_pamphlet_limit)
		user.has_used_pamphlet = TRUE

/obj/item/pamphlet/trait/vulture
	name = "\improper M707 instructional pamphlet"
	desc = "一本用于快速传授如何操作重武器并为其提供观测指引重要知识的小册子。"
	icon_state = "pamphlet_vulture"
	trait_to_give = TRAIT_VULTURE_USER
