/obj/structure/machinery/ares
	name = "ARES机械装置"
	density = TRUE
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 600
	icon = 'icons/obj/structures/machinery/ares.dmi'
	unslashable = TRUE
	unacidable = TRUE

	var/datum/ares_link/link

/obj/structure/machinery/ares/ex_act(severity)
	return

/obj/structure/machinery/ares/Initialize(mapload, ...)
	link_systems(override = FALSE)
	. = ..()

/obj/structure/machinery/ares/Destroy()
	delink()
	return ..()

/obj/structure/machinery/ares/update_icon()
	..()
	icon_state = initial(icon_state)
	// Broken
	if(stat & BROKEN)
		icon_state += "_broken"

	// Powered
	else if(stat & NOPOWER)
		icon_state = initial(icon_state)
		icon_state += "_off"

/// Handles linking and de-linking the ARES systems.
/obj/structure/machinery/ares/proc/link_systems(datum/ares_link/new_link = GLOB.ares_link, override)
	if(!new_link)
		log_debug("Error: link_systems called without a link datum")
	if(link && !override)
		return FALSE
	if(new_link)
		link = new_link
		new_link.linked_systems += src
		return TRUE

/obj/structure/machinery/ares/proc/delink()
	link.linked_systems -= src
	link = null

/obj/structure/machinery/ares/processor
	name = "ARES处理器"
	desc = "ARES的外部处理器，用于处理海量信息。"
	icon_state = "processor"

/obj/structure/machinery/ares/processor/apollo
	name = "ARES处理器（APOLLO）"
	desc = "ARES的APOLLO处理器外部组件。主要负责协调工作乔和维护无人机。这绝对不是从西格森公司偷来的。"
	icon_state = "apollo_processor"

/obj/structure/machinery/ares/processor/apollo/link_systems(datum/ares_link/new_link = GLOB.ares_link, override)
	..()
	new_link.processor_apollo = src

/obj/structure/machinery/ares/processor/apollo/delink()
	if(link && link.processor_apollo == src)
		link.processor_apollo = null
	..()

/obj/structure/machinery/ares/processor/interface
	name = "ARES处理器（接口）"
	desc = "ARES的外部处理器；此组件负责处理与船员交互的核心进程，包括无线电传输和广播。"
	icon_state = "int_processor"

/obj/structure/machinery/ares/processor/interface/link_systems(datum/ares_link/new_link = GLOB.ares_link, override)
	..()
	new_link.processor_interface = src

/obj/structure/machinery/ares/processor/interface/delink()
	if(link && link.processor_interface == src)
		link.processor_interface = null
	..()

/obj/structure/machinery/ares/processor/bioscan
	name = "ARES处理器（生物扫描）"
	desc = "ARES生物扫描系统的外部组件。没有它，阿尔迈耶号将无法运行生物扫描！"
	icon_state = "bio_processor"

/obj/structure/machinery/ares/processor/bioscan/link_systems(datum/ares_link/new_link = GLOB.ares_link, override)
	..()
	new_link.processor_bioscan = src

/obj/structure/machinery/ares/processor/bioscan/delink()
	if(link && link.processor_bioscan == src)
		link.processor_bioscan = null
	..()

/// Central Core
/obj/structure/machinery/ares/cpu
	name = "ARES中央处理器"
	desc = "这是ARES的中央处理器。采用可抵御核爆的外壳设计，该CPU还包含ARES的黑匣子记录器。"
	icon_state = "CPU"

/obj/structure/machinery/ares/cpu/link_systems(datum/ares_link/new_link = GLOB.ares_link, override)
	..()
	new_link.central_processor = src

/obj/structure/machinery/ares/cpu/delink()
	if(link && link.central_processor == src)
		link.central_processor = null
	..()

/// Memory Substrate,
/obj/structure/machinery/ares/substrate
	name = "ARES存储基板"
	desc = "ARES的存储基板，包含复杂的协议和信息。即使主ARES单元未运行，基板本身也能执行有限的功能。"
	icon_state = "substrate"

/// Sentry
/obj/structure/machinery/defenses/sentry/premade/deployable/almayer/mini/ares
	name = "UA X512-S迷你哨戒炮"
	faction_group = FACTION_LIST_ARES_MARINE

/obj/structure/machinery/defenses/sentry/premade/deployable/almayer/mini/ares/Initialize()
	link_sentry()
	. = ..()

/obj/structure/machinery/defenses/sentry/premade/deployable/almayer/mini/ares/Destroy()
	delink_sentry()
	. = ..()

/obj/structure/machinery/defenses/sentry/premade/deployable/almayer/mini/ares/start_processing()
	sync_iff()
	..()

/obj/structure/machinery/defenses/sentry/premade/deployable/almayer/mini/ares/proc/sync_iff()
	var/datum/ares_link/ares_link = GLOB.ares_link
	if(!ares_link || !ares_link.faction_group)
		faction_group = FACTION_LIST_ARES_MARINE
	faction_group = ares_link.faction_group

/obj/structure/machinery/defenses/sentry/premade/deployable/almayer/mini/ares/proc/link_sentry()
	var/datum/ares_link/link = GLOB.ares_link
	link.core_sentries += src

/obj/structure/machinery/defenses/sentry/premade/deployable/almayer/mini/ares/proc/delink_sentry()
	var/datum/ares_link/link = GLOB.ares_link
	link.core_sentries -= src
