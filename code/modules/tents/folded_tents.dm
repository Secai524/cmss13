/obj/item/folded_tent
	name = "折叠式抽象帐篷"
	icon = 'icons/obj/structures/tents_folded.dmi'
	icon_state = "tent"
	w_class = SIZE_LARGE
	/// Required cleared area along X axis
	var/dim_x = 1
	/// Required cleared area along Y axis
	var/dim_y = 1
	/// Tents map template typepath
	var/template_preset = "abstract"
	///Map template datum used for tent
	var/datum/map_template/template
	/// If this tent can be deployed anywhere
	var/unrestricted_deployment = FALSE

/obj/item/folded_tent/Initialize(mapload, ...)
	. = ..()
	if(template_preset == "abstract") //So spawning an abstract tent won't fail create and destroy
		return
	set_template(SSmapping.tent_type_templates[template_preset])
	if(!template)
		CRASH("[src] initialized with template preset, \"[template_preset]\", that does not exist.")

/obj/item/folded_tent/proc/set_template(datum/map_template/new_template)
	if(!istype(new_template))
		return
	template = new_template
	dim_x = template.width
	dim_y = template.height

/// Check an area is clear for deployment of the tent
/obj/item/folded_tent/proc/check_area(turf/ref_turf, mob/message_receiver, display_error = FALSE)
	SHOULD_NOT_SLEEP(TRUE)
	. = TRUE
	var/list/turf_block = get_deployment_area(ref_turf)
	for(var/turf/turf as anything in turf_block)
		var/area/area = get_area(turf)
		if(!area.can_build_special && !unrestricted_deployment)
			if(message_receiver)
				to_chat(message_receiver, SPAN_WARNING("你无法在限制区域部署帐篷。"))
			if(display_error)
				new /obj/effect/overlay/temp/tent_deployment_area/error(turf)
			return FALSE
		if(istype(turf, /turf/open/shuttle))
			if(message_receiver)
				to_chat(message_receiver, SPAN_BOLDWARNING("你在干什么？！！请不要在运输机上建造那个！"))
			return FALSE
		if(turf.density)
			if(message_receiver)
				to_chat(message_receiver, SPAN_WARNING("你无法在此处部署[src]，有东西([turf])挡路了。"))
			if(display_error)
				new /obj/effect/overlay/temp/tent_deployment_area/error(turf)
			return FALSE
		for(var/atom/movable/atom as anything in turf)
			if(isliving(atom) || (atom.density && atom.can_block_movement) || istype(atom, /obj/structure/tent))
				if(message_receiver)
					to_chat(message_receiver, SPAN_WARNING("你无法在此处部署[src]，有东西([atom.name])挡路了。"))
				if(display_error)
					new /obj/effect/overlay/temp/tent_deployment_area/error(turf)
				return FALSE
	return TRUE

/obj/item/folded_tent/proc/unfold(mob/user, turf/ref_turf)
	if(!istype(template))
		to_chat(user, SPAN_BOLDWARNING("[src]不包含帐篷！它坏了！"))
		CRASH("[src] attempted to unfold \"[template]\" as a tent.")
	template.load(ref_turf, FALSE, FALSE)

/obj/item/folded_tent/proc/get_deployment_area(turf/ref_turf)
	RETURN_TYPE(/list/turf)
	return CORNER_BLOCK(ref_turf, dim_x, dim_y)

/obj/item/folded_tent/attack_self(mob/living/user)
	. = ..()
	var/off_x = -(tgui_input_number(user, "如果面向北方或南方", "Set X Offset", 0, dim_x, 0, 30 SECONDS, TRUE))
	var/off_y = -(tgui_input_number(user, "如果面向东方或西方", "Set Y Offset", 0, dim_y, 0, 30 SECONDS, TRUE))
	var/turf/deploy_turf = user.loc
	if(!istype(deploy_turf))
		return // In a locker or something. Get lost you already have a home.

	switch(user.dir) //Handles offsets when deploying
		if(NORTH)
			deploy_turf = locate(deploy_turf.x + off_x, deploy_turf.y + 1, deploy_turf.z)
		if(SOUTH)
			deploy_turf = locate(deploy_turf.x + off_x, deploy_turf.y - dim_y, deploy_turf.z)
		if(EAST)
			deploy_turf = locate(deploy_turf.x + 1, deploy_turf.y + off_y, deploy_turf.z)
		if(WEST)
			deploy_turf = locate(deploy_turf.x - dim_x, deploy_turf.y + off_y, deploy_turf.z)

	if(!istype(deploy_turf) || (deploy_turf.x + dim_x > world.maxx) || (deploy_turf.y + dim_y > world.maxy)) // Map border basically
		return

	if(!is_ground_level(deploy_turf.z) && !unrestricted_deployment)
		to_chat(user, SPAN_WARNING("USCM作战帐篷用于作战行动，而非舰上或太空娱乐。"))
		return

	var/list/obj/effect/overlay/temp/tent_deployment_area/turf_overlay = list()
	var/list/turf/deployment_area = get_deployment_area(deploy_turf)

	if(!check_area(deploy_turf, user, TRUE))
		for(var/turf/turf in deployment_area)
			new /obj/effect/overlay/temp/tent_deployment_area(turf) // plus error in check_area
		return

	for(var/turf/turf in deployment_area)
		turf_overlay += new /obj/effect/overlay/temp/tent_deployment_area/casting(turf)

	user.visible_message(SPAN_INFO("[user]开始部署[src]..."),
		SPAN_WARNING("You start assembling [src]... Stand still, it might take a bit to figure it out..."))
	if(!do_after(user, 6 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
		to_chat(user, SPAN_WARNING("你被打断了！"))
		for(var/gfx in turf_overlay)
			qdel(gfx)
		return

	if(!check_area(deploy_turf, user, TRUE))
		for(var/gfx in turf_overlay)
			QDEL_IN(gfx, 1.5 SECONDS)
		return

	unfold(user, deploy_turf)
	user.visible_message(SPAN_INFO("[user]完成了[src]的部署！"), SPAN_INFO("You finish deploying [src]!"))
	for(var/gfx in turf_overlay)
		qdel(gfx)
	qdel(src) // Success!

/obj/item/folded_tent/cmd
	name = "折叠式USCM指挥帐篷"
	icon_state = "cmd"
	desc = "一个标准的USCM指挥帐篷。此型号配备自供电监控控制台和一部电话。请在合适位置展开以最大化效用。不包含参谋军官。入口朝南。"
	template_preset = "tent_cmd"

/obj/item/folded_tent/med
	name = "折叠式USCM医疗帐篷"
	icon_state = "med"
	desc = "一个标准的USCM医疗帐篷。此型号配备先进的野战手术设施。请在合适位置展开以最大化治疗效果。不包含手术托盘。入口朝南。"
	template_preset = "tent_med"

/obj/item/folded_tent/reqs
	name = "折叠式USCM补给帐篷"
	icon_state = "req"
	desc = "一个标准的USCM补给帐篷。现在，无论身在何处，您都能享受补给线服务！请在合适位置展开以优化资源分配。不包含ASRS。入口朝南。"
	template_preset = "tent_reqs"

/obj/item/folded_tent/big
	name = "折叠式USCM大型帐篷"
	icon_state = "big"
	desc = "一个标准的USCM帐篷。此型号是更大、更通用的版本。请在合适位置展开以获得最佳前线作战基地氛围。入口朝南。"
	template_preset = "tent_big"

/obj/item/folded_tent/mess
	name = "折叠式USCM食堂帐篷"
	icon_state = "mess"
	desc = "一个标准的USCM食堂帐篷。此型号配备厨房和用餐设施。请在合适位置展开以最大化餐食分发。入口朝南。"
	template_preset = "tent_mess"

/obj/effect/overlay/temp/tent_deployment_error
	icon = 'icons/effects/effects.dmi'
	icon_state = "placement_zone"
	color = "#bb0000"
	effect_duration = 1.5 SECONDS
	layer = ABOVE_FLY_LAYER

/obj/effect/overlay/temp/tent_deployment_area
	icon = 'icons/effects/effects.dmi'
	icon_state = "placement_zone"
	color = "#f39e00"
	effect_duration = 1.5 SECONDS
	layer = FLY_LAYER

/obj/effect/overlay/temp/tent_deployment_area/casting
	effect_duration = 10 SECONDS
	color = "#228822"

/obj/effect/overlay/temp/tent_deployment_area/error
	layer = ABOVE_FLY_LAYER
	color = "#bb0000"
