/obj/item/clothing/glasses/hud
	name = "HUD"
	icon = 'icons/obj/items/clothing/glasses/huds.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/huds.dmi',
	)
	gender = NEUTER
	desc = "一种平视显示器，能提供（近乎）实时的重要信息。"
	flags_atom = null //doesn't protect eyes because it's a monocle, duh


/obj/item/clothing/glasses/hud/health
	name = "\improper HealthMate HUD"
	desc = "一种平视显示器，可扫描视野内的人类并提供其健康状况的准确数据。"
	icon_state = "healthhud"
	item_state = "healthhud"
	deactive_state = "degoggles"
	flags_armor_protection = 0
	toggleable = TRUE
	hud_type = MOB_HUD_MEDICAL_ADVANCED
	actions_types = list(/datum/action/item_action/toggle/hudgoggles, /datum/action/item_action/view_publications)
	req_skill = SKILL_MEDICAL
	req_skill_level = SKILL_MEDICAL_MEDIC

/obj/item/clothing/glasses/hud/health/prescription
	name = "\improper Prescription HealthMate HUD"
	desc = "一种平视显示器，可扫描视野内的人类并提供其健康状况的准确数据。包含处方镜片。"
	prescription = TRUE

/datum/action/item_action/view_publications/New(Target)
	..()
	name = "查看研究出版物"
	button.name = name
	button.overlays.Cut()
	var/image/IMG = image('icons/mob/hud/actions.dmi', button, "research")
	button.overlays += IMG

/datum/action/item_action/view_publications/update_button_icon()
	return

/datum/action/item_action/view_publications/can_use_action()
	if(owner && !owner.is_mob_incapacitated() && owner.faction != FACTION_SURVIVOR)
		return TRUE

/datum/action/item_action/view_publications/action_activate()
	. = ..()
	var/obj/item/clothing/glasses/hud/health/hud = holder_item
	hud.tgui_interact(owner)

/obj/item/clothing/glasses/hud/health/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/item/clothing/glasses/hud/health/ui_data(mob/user)
	var/list/data = list(
		"published_documents" = GLOB.chemical_data.research_publications,
		"terminal_view" = FALSE
	)
	return data

/obj/item/clothing/glasses/hud/health/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PublishedDocsHud", name)
		ui.open()

/obj/item/clothing/glasses/hud/health/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/user = usr
	if(user.stat || user.is_mob_restrained() || !in_range(src, user))
		return

	switch(action)
		if ("read_document")
			var/print_type = params["print_type"]
			var/print_title = params["print_title"]
			var/obj/item/paper/research_report/report = GLOB.chemical_data.get_report(print_type, print_title)
			if(report)
				report.read_paper(user)
			return

/obj/item/clothing/glasses/hud/health/verb/view_publications()
	set category = "Object"
	set name = "查看研究出版物"
	set src in usr

	if(!usr.stat && !usr.is_mob_restrained() && usr.faction != FACTION_SURVIVOR)
		tgui_interact(usr)

/obj/item/clothing/glasses/hud/health/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/user = usr
	if(user.stat || user.is_mob_restrained() || !in_range(src, user))
		return

	if(href_list["read_document"])
		var/obj/item/paper/research_report/report = GLOB.chemical_data.research_documents[href_list["print_type"]][href_list["print_title"]]
		if(report)
			report.read_paper(user)

/obj/item/clothing/glasses/hud/health/basic
	name = "\improper Basic HealthMate HUD"
	desc = "一种平视显示器，可扫描视野内的人类并提供其健康状况的准确数据。这是较简化的型号。"
	hud_type = MOB_HUD_MEDICAL_BASIC
	req_skill = NONE
	req_skill_level = NONE
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/hud/health/basic/prescription
	name = "\improper Prescription Basic HealthMate HUD"
	desc = "一种平视显示器，可扫描视野内的人类并提供其健康状况的准确数据。这款简化型号包含处方镜片。"
	prescription = TRUE

/obj/item/clothing/glasses/hud/health/science
	name = "定制版健康伴侣平视显示器" // combined HealthMateHUD and Reagent Scanner HUD for CMO
	desc = "这副健康伴侣平视显示护目镜经过改装，采用轻质钛合金镜框，并定制集成了来自试剂分析仪的额外线路和低剖面组件，使其兼具健康伴侣和试剂扫描平视显示器的功能，同时不改变护目镜的外形。"
	req_skill = SKILL_RESEARCH
	req_skill_level = SKILL_RESEARCH_TRAINED
	clothing_traits = list(TRAIT_REAGENT_SCANNER)

/obj/item/clothing/glasses/hud/health/science/prescription
	name = "处方定制版健康伴侣平视显示器" // combined HealthMateHUD and Reagent Scanner HUD for CMO but prescription
	desc = parent_type::desc + " This pair contains prescription lenses."
	prescription = TRUE

/obj/item/clothing/glasses/hud/sensor
	name = "\improper SensorMate HUD"
	desc = "一种更老旧的平视显示器，能显示任何个体从其作战服传感器传来的最后已知生物特征数据。"
	icon_state = "sensorhud"
	deactive_state = "sensorhud_d"
	flags_armor_protection = 0
	toggleable = TRUE
	hud_type = MOB_HUD_MEDICAL_ADVANCED
	actions_types = list(/datum/action/item_action/toggle)
	req_skill = SKILL_MEDICAL
	req_skill_level = SKILL_MEDICAL_DEFAULT

/obj/item/clothing/glasses/hud/sensor/prescription
	name = "\improper Prescription SensorMate HUD"
	desc = "一种更老旧的平视显示器，能显示任何个体从其作战服传感器传来的最后已知生物特征数据。包含处方镜片。"
	prescription = TRUE

/obj/item/clothing/glasses/hud/security
	name = "\improper PatrolMate HUD"
	desc = "一种平视显示器，可扫描视野内的人类并提供其身份状态和安保记录的准确数据。"
	icon_state = "securityhud"
	deactive_state = "degoggles"
	toggleable = TRUE
	flags_armor_protection = 0
	hud_type = MOB_HUD_SECURITY_ADVANCED
	actions_types = list(/datum/action/item_action/toggle/hudgoggles)

/obj/item/clothing/glasses/hud/security/prescription
	name = "\improper Prescription PatrolMate HUD"
	desc = "一种平视显示器，可扫描视野内的人类并提供其身份状态和安保记录的准确数据。"
	prescription = TRUE

/obj/item/clothing/glasses/hud/security/jensenshades
	name = "增强型墨镜"
	gender = PLURAL
	desc = "偏振式生物神经眼镜，旨在增强你的视觉。你为什么不试着找份工作？"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
	)
	icon_state = "jensenshades"
	item_state = "jensenshades"
	vision_flags = SEE_MOBS
	invisa_view = 2
	toggleable = FALSE
	actions_types = list()
