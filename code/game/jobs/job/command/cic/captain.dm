//Commander
/datum/job/command/commander
	title = JOB_CO
	supervisors = "USCM（殖民地海军陆战队）最高指挥部"
	selection_class = "job_co"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADMIN_NOTIFY|ROLE_WHITELISTED
	flags_whitelist = WHITELIST_COMMANDER
	gear_preset = /datum/equipment_preset/uscm_co


/datum/job/command/commander/proc/check_career_path(client/player)
	switch(player.prefs.co_career_path)
		if("Infantry")
			gear_preset_whitelist = list(
			"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co/infantry,
			"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/infantry/council,
			"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/infantry/council/plus,
			)
		if("Intel")
			gear_preset_whitelist = list(
			"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co/intel,
			"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/intel/council,
			"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/intel/council/plus,
			)
		if("医疗区")
			gear_preset_whitelist = list(
			"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co/medical,
			"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/medical/council,
			"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/medical/council/plus,
			)
		if("Aviation")
			gear_preset_whitelist = list(
			"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co/aviation,
			"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/aviation/council,
			"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/aviation/council/plus,
			)
		if("Tanker")
			gear_preset_whitelist = list(
			"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co/tanker,
			"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/tanker/council,
			"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/tanker/council/plus,
			)
		if("工程部")
			gear_preset_whitelist = list(
			"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co/engineering,
			"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/engineering/council,
			"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/engineering/council/plus,
			)
		if("Logistics")
			gear_preset_whitelist = list(
			"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co/logistics,
			"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/logistics/council,
			"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/logistics/council/plus,
			)

/datum/job/command/commander/New()
	. = ..()
	gear_preset_whitelist = list(
		"[JOB_CO][WHITELIST_NORMAL]" = /datum/equipment_preset/uscm_co,
		"[JOB_CO][WHITELIST_COUNCIL]" = /datum/equipment_preset/uscm_co/council,
		"[JOB_CO][WHITELIST_LEADER]" = /datum/equipment_preset/uscm_co/council/plus
	)

/datum/job/command/commander/generate_entry_message()
	entry_message_body = "<a href='[generate_wiki_link()]'>您不仅是此次行动的指挥官，也是[MAIN_SHIP_NAME]号的舰长。</a>您的任务是带领海军陆战队员执行任务，同时保护并指挥舰船及其船员。您的工作涉及深度角色扮演，需要您始终以高级军官的身份行事并保持角色一致性。作为指挥官，您的唯一上级是最高指挥部。您必须遵守<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_CO_RULES]'>指挥官行为准则</a>。违反准则可能导致对您的纪律处分。祝您顺利。"
	return ..()

/datum/job/command/commander/get_whitelist_status(client/player)
	. = ..()
	if(!.)
		return
	check_career_path(player)
	if(player.check_whitelist_status(WHITELIST_COMMANDER_LEADER|WHITELIST_COMMANDER_COLONEL))
		return get_desired_status(player.prefs.commander_status, WHITELIST_LEADER)
	if(player.check_whitelist_status(WHITELIST_COMMANDER_COUNCIL|WHITELIST_COMMANDER_COUNCIL_LEGACY))
		return get_desired_status(player.prefs.commander_status, WHITELIST_COUNCIL)
	if(player.check_whitelist_status(WHITELIST_COMMANDER))
		return get_desired_status(player.prefs.commander_status, WHITELIST_NORMAL)

/datum/job/command/commander/announce_entry_message(mob/living/carbon/human/H)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(all_hands_on_deck), "Attention all hands, [H.get_paygrade(0)] [H.real_name] on deck!"), 1.5 SECONDS)
	return ..()

/datum/job/command/commander/generate_entry_conditions(mob/living/player, whitelist_status, late_join = FALSE)
	. = ..()
	GLOB.marine_leaders[JOB_CO] = player
	RegisterSignal(player, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_leader_candidate))
	if(!late_join)
		addtimer(CALLBACK(src, PROC_REF(handle_entry_fax), player, whitelist_status), 15 SECONDS)

/// handles the sending of the CO lore faxes upon roundstart
/datum/job/command/commander/proc/handle_entry_fax(mob/living/player, whitelist_status)
	var/list/co_briefing_files = SSmapping.configs[GROUND_MAP].co_briefing_files
	var/faction_alignment = "Unaligned"

	if(!co_briefing_files)	// ground map has no defined briefing faxes
		return

	if(!player.client)	// our CO has ghosted or DC'd within the 15 seconds
		return

	if(player.client.prefs.affiliation)
		faction_alignment = player.client.prefs.affiliation

	var/obj/item/paper/captain_brief/co_briefing = new /obj/item/paper/captain_brief

	if(co_briefing_files[faction_alignment])
		co_briefing.info = file2text(co_briefing_files[faction_alignment])
	else
		qdel(co_briefing)
		return

	var/datum/asset/asset = get_asset_datum(/datum/asset/simple/paper)
	co_briefing.info = replacetext(co_briefing.info, "%%USCMLOGO%%", asset.get_url_mappings()["logo_uscm.png"])
	co_briefing.info = replacetext(co_briefing.info, "%%DARKBACKGROUND%%", asset.get_url_mappings()["background_dark2.jpg"])

	var/obj/structure/machinery/faxmachine/receiver
	for(var/target_machine_code as anything in GLOB.fax_network.all_faxcodes)
		var/obj/structure/machinery/faxmachine/target_machine = GLOB.fax_network.all_faxcodes[target_machine_code]
		if(target_machine.sub_name == "指挥官")
			receiver = target_machine
			break
	if(!receiver)
		return
	if(receiver.inoperable())
		return
	co_briefing.forceMove(receiver.loc)
	playsound(receiver.loc, "sound/machines/twobeep.ogg", 45)
	receiver.langchat_speech("beeps with a priority message", get_mobs_in_view(GLOB.world_view_size, receiver), GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
	receiver.visible_message("[SPAN_BOLD(receiver)]发出哔声，收到一条优先信息。")
	if(!receiver.radio_alert_tag)
		return
	ai_silent_announcement("COMMUNICATIONS REPORT: Fax Machine [receiver.machine_id_tag], [receiver.sub_name ? "[receiver.sub_name]" : ""], now receiving priority fax.", "[receiver.radio_alert_tag]")

/datum/job/command/commander/proc/cleanup_leader_candidate(mob/M)
	SIGNAL_HANDLER
	GLOB.marine_leaders -= JOB_CO

/obj/effect/landmark/start/captain
	name = JOB_CO
	icon_state = "co_spawn"
	job = /datum/job/command/commander
