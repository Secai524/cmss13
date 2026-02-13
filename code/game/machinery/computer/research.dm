/obj/structure/machinery/computer/research
	name = "研究数据终端"
	desc = "用于访问研究数据的终端。"
	icon_state = "research"
	req_access = list(ACCESS_MARINE_RESEARCH)
	var/base_purchase_cost = 5
	var/max_clearance = 1 // max clearance level reached by research
	var/main_terminal = FALSE
	var/obj/structure/machinery/photocopier/photocopier
	var/datum/reagent/last_picked_contract

/obj/structure/machinery/computer/research/main_terminal
	name = "研究主终端"
	main_terminal = TRUE
	req_access = list(ACCESS_MARINE_CMO)

/obj/structure/machinery/computer/research/Initialize()
	. = ..()
	photocopier = locate(/obj/structure/machinery/photocopier,get_step(src, NORTH))
	GLOB.chemical_data.research_computers += src

/obj/structure/machinery/computer/research/Destroy()
	QDEL_NULL(photocopier)
	GLOB.chemical_data.research_computers -= src
	last_picked_contract = null
	. = ..()

/obj/structure/machinery/computer/research/attackby(obj/item/B, mob/living/user)
	//Collecting grants
	if(istype(B, /obj/item/paper/research_notes))
		var/obj/item/paper/research_notes/N = B
		if(N.note_type == "grant")
			if(!N.grant)
				return
			GLOB.chemical_data.update_credits(N.grant)
			visible_message(SPAN_NOTICE("[user]扫描了[src]上的[N.name]，收集了[N.grant]研究点数。"))
			N.grant = 0
			qdel(N)
			return
	//Saving to database
	if(istype(B, /obj/item/paper))
		var/obj/item/paper/P = B
		var/response = alert(usr,"是否要将[P.name]保存到研究数据库？","[src]","Yes","No")
		if(response != "Yes")
			return
		response = alert(usr,"使用现有类别还是新建类别？","[src]","Existing","New")
		if(response == "Existing")
			var/list/pool = list()
			for(var/category in GLOB.chemical_data.research_documents)
				pool += category
			pool = sortAssoc(pool)
			response = tgui_input_list(usr,"选择一个类别：", "Categories", pool)
		else if(response == "New")
			response = input(usr,"请输入文件的类别：")
		if(!response)
			response = "Misc."
		var/obj/item/paper/research_report/CR = P.convert_to_chem_report()
		GLOB.chemical_data.save_document(CR, response, CR.name)
		return

	//biomass rewards
	if(istype(B, /obj/item/research_upgrades/reroll))
		var/obj/item/research_upgrades/reroll/reroll = B
		GLOB.chemical_data.reroll_chemicals()
		visible_message(SPAN_NOTICE("[user]将[reroll]插入[src]，正在重新生成合同化学品。"))
		qdel(reroll)

/obj/structure/machinery/computer/research/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/computer/research/attack_hand(mob/user as mob)
	if(inoperable())
		return
	tgui_interact(user)

/obj/structure/machinery/computer/research/ui_static_data(mob/user)
	var/list/contract = list()
	for(var/i in 1 to length(GLOB.chemical_data.contract_chems))
		var/datum/reagent/generated/contract_chem = GLOB.chemical_data.contract_chems["contract-chem-[i]"]
		if(!contract_chem)
			continue
		var/datum/reagent/temp = GLOB.chemical_reagents_list[contract_chem.reagent_recipe_hint]
		contract += list(list(
			"name" = contract_chem.name,
			"property_hint" = contract_chem.property_hint,
			"recipe_hint" = temp.name,
			"id" = contract_chem.id,
			"gen_tier" = contract_chem.gen_tier,
		))
	var/list/static_data = list(
		"base_purchase_cost" = base_purchase_cost,
		"main_terminal" = main_terminal,
		"terminal_view" = TRUE,
		"chems_generated" = isnull(GLOB.chemical_data.contract_chems),
		"contract_chems" = contract,
	)
	return static_data

/obj/structure/machinery/computer/research/ui_data(mob/user)
	var/list/data = list(
		"rsc_credits" = GLOB.chemical_data.rsc_credits,
		"clearance_level" = GLOB.chemical_data.clearance_level,
		"broker_cost" = max(RESEARCH_LEVEL_INCREASE_MULTIPLIER*GLOB.chemical_data.clearance_level + 1, 1),
		"research_documents" = GLOB.chemical_data.research_documents,
		"published_documents" = GLOB.chemical_data.research_publications,
		"clearance_x_access" = GLOB.chemical_data.clearance_x_access,
		"photocopier_error" = !photocopier,
		"printer_toner" = photocopier?.toner,
		"is_contract_picked" = GLOB.chemical_data.picked_chem,
		"world_time" = world.time,
		"next_reroll" = GLOB.chemical_data.next_reroll,
		"contract_cooldown" = (GLOB.chemical_data.picked_chem ? RESEARCH_CONTRACT_PICKED : RESEARCH_CONTRACT_NOT_PICKED)
	)
	return data

/obj/structure/machinery/computer/research/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ResearchTerminal", name)
		ui.open()

/obj/structure/machinery/computer/research/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(inoperable() || !ishuman(usr))
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
		if ("print")
			if(!photocopier)
				return
			if(photocopier.toner)
				var/print_type = params["print_type"]
				var/print_title = params["print_title"]
				photocopier.toner = max(0, photocopier.toner - 1)
				var/obj/item/paper/research_report/printing = new /obj/item/paper/research_report/(photocopier.loc)
				var/obj/item/paper/research_report/report = GLOB.chemical_data.get_report(print_type, print_title)
				if(report)
					printing.name = report.name
					printing.info = report.info
					printing.data = report.data
					printing.completed = report.completed
		if("broker_clearance")
			if(!photocopier)
				return
			if(GLOB.chemical_data.clearance_level < 5)
				var/cost = max((RESEARCH_LEVEL_INCREASE_MULTIPLIER*(GLOB.chemical_data.clearance_level)) + 1, 1)
				if(cost <= GLOB.chemical_data.rsc_credits)
					GLOB.chemical_data.update_credits(cost * -1)
					GLOB.chemical_data.clearance_level++
					visible_message(SPAN_NOTICE("权限等级提升至[GLOB.chemical_data.clearance_level]级，花费[cost]点数。"))
					msg_admin_niche("[key_name(user)] traded research credits to upgrade the clearance to level [GLOB.chemical_data.clearance_level].")
					if(max_clearance < GLOB.chemical_data.clearance_level)
						switch(GLOB.chemical_data.clearance_level)
							if(2)
								new /obj/item/paper/research_notes/unique/tier_two/(photocopier.loc)
								max_clearance = 2
							if(3)
								new /obj/item/paper/research_notes/unique/tier_three/(photocopier.loc)
								max_clearance = 3
							if(4)
								new /obj/item/paper/research_notes/unique/tier_four/(photocopier.loc)
								max_clearance = 4
							if(5)
								new /obj/item/paper/research_notes/unique/tier_five/(photocopier.loc)
								max_clearance = 5
		if("publish_document")
			var/print_type = params["print_type"]
			var/print_title = params["print_title"]
			var/obj/item/paper/research_report/report = GLOB.chemical_data.get_report(print_type, print_title)
			if(!report)
				to_chat(usr, SPAN_WARNING("报告数据损坏。无法传输。"))
				return
			GLOB.chemical_data.publish_document(report, print_type, print_title)
		if("unpublish_document")
			var/print_title = params["print_title"]
			var/print_type = params["print_type"]
			GLOB.chemical_data.unpublish_document(print_type, print_title)
		if("request_clearance_x_access")
			var/purchase_cost = 5
			if(purchase_cost <= GLOB.chemical_data.rsc_credits)
				GLOB.chemical_data.clearance_x_access = TRUE
				GLOB.chemical_data.reached_x_access = TRUE
				GLOB.chemical_data.update_credits(purchase_cost * -1)
				visible_message(SPAN_NOTICE("已获得X级权限。"))
		if("take_contract")
			if(!GLOB.chemical_data.picked_chem)
				var/chem_id = params["id"]
				var/new_id = GLOB.chemical_data.legalize_chem(GLOB.chemical_data.contract_chems[chem_id])
				new /obj/item/paper/research_notes(photocopier ? photocopier.loc : loc, GLOB.chemical_reagents_list[new_id], "synthesis", TRUE)
				GLOB.chemical_data.picked_chem = TRUE
				GLOB.chemical_data.next_reroll = world.time + RESEARCH_CONTRACT_PICKED
				last_picked_contract = GLOB.chemical_reagents_list[new_id]
		if("reprint_last_contract")
			if(last_picked_contract)
				new /obj/item/paper/research_notes(photocopier ? photocopier.loc : loc, last_picked_contract, "synthesis")
				playsound(loc, 'sound/machines/twobeep.ogg', 5, 1)
			else
				playsound(loc, 'sound/machines/buzz-two.ogg', 5, 1)
				langchat_speech("There are no contracts to reprint available", get_mobs_in_view(7, src), GLOB.all_languages, skip_language_check = TRUE, additional_styles = list("langchat_small"))
				visible_message("[icon2html(src, viewers(src))] \The <b>[src]</b> 说道：没有可重新打印的合同")

	playsound(loc, pick('sound/machines/computer_typing1.ogg','sound/machines/computer_typing2.ogg','sound/machines/computer_typing3.ogg'), 5, 1)
