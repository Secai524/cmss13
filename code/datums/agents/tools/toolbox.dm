/obj/item/storage/toolbox/antag
	name = "可疑的工具箱"
	desc = "一个紧凑且看起来可疑的工具箱。这个工具箱小到可以放进背包。"
	icon_state = "syndicate"
	item_state = "toolbox_syndi"

	w_class = SIZE_MEDIUM

	storage_slots = 8

/obj/item/storage/toolbox/antag/Initialize(mapload, ...)
	. = ..()
	var/color = pick("red","yellow","green","blue","pink","orange","cyan","white")
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/stack/cable_coil(src,30,color)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)
	new /obj/item/pamphlet/engineer/antag(src)

/obj/item/pamphlet/skill/engineer/antag
	name = "可疑的小册子"
	desc = "用于快速传授关键知识的小册子。这本上面有工程部徽章。这本是用暗语写的。"
	trait = /datum/character_trait/skills/miniengie/antag
	bypass_pamphlet_limit = TRUE

/obj/item/pamphlet/engineer/antag/attack_self(mob/living/carbon/human/user)
	if(!user.skills || !istype(user))
		return

	if(!skillcheckexplicit(user, SKILL_ANTAG, SKILL_ANTAG_AGENT))
		to_chat(user, SPAN_WARNING("这本小册子是用暗语写的！你不太看得懂。"))
		return

	. = ..()
