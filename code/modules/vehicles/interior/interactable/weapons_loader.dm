/obj/structure/weapons_loader
	name = "弹药装填机"
	desc = "一台重型机械，用于分类、移动并将各种弹药装填至正确的炮位。"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "weapons_loader"

	anchored = TRUE
	density = TRUE
	unacidable = TRUE
	unslashable = TRUE
	explo_proof = TRUE

	var/obj/vehicle/multitile/vehicle = null

// Loading new magazines
/obj/structure/weapons_loader/attackby(obj/item/I, mob/user)
	if(!istype(I, /obj/item/ammo_magazine/hardpoint))
		return ..()

	if(!skillcheck(user, SKILL_VEHICLE, SKILL_VEHICLE_LARGE))
		to_chat(user, SPAN_NOTICE("你完全不知道如何操作这东西！"))
		return

	// Check if any of the hardpoints accept the magazine
	var/obj/item/hardpoint/reloading_hardpoint = null
	for(var/obj/item/hardpoint/H in vehicle.get_hardpoints_with_ammo())
		if(QDELETED(H) || QDELETED(H.ammo))
			continue

		if(istype(I, H.ammo.type))
			reloading_hardpoint = H
			break

	if(isnull(reloading_hardpoint))
		return ..()

	// Reload the hardpoint
	reloading_hardpoint.try_add_clip(I, user)

// Hardpoint reloading
/obj/structure/weapons_loader/attack_hand(mob/living/carbon/human/user)

	if(!user || !istype(user))
		return

	handle_reload(user)

/obj/structure/weapons_loader/proc/reload_ammo()
	set name = "Reload Ammo"
	set category = "Object"
	set src in range(1)

	var/mob/living/carbon/human/H = usr
	if(!H || !istype(H))
		return

	handle_reload(H)

/obj/structure/weapons_loader/proc/handle_reload(mob/living/carbon/human/user)

	//something went bad, try to reconnect to vehicle if user is currently buckled in and connected to vehicle
	if(!vehicle)
		if(isVehicle(user.interactee))
			vehicle = user.interactee
		if(!istype(vehicle))
			to_chat(user, SPAN_WARNING("严重错误！请向管理员求助！代码：T_VMIS"))
			return

	var/list/hps = vehicle.get_hardpoints_with_ammo()

	if(!skillcheck(user, SKILL_VEHICLE, SKILL_VEHICLE_LARGE))
		to_chat(user, SPAN_NOTICE("你完全不知道如何操作这东西！"))
		return

	if(!LAZYLEN(hps))
		to_chat(user, SPAN_WARNING("所有武器挂点都无法重新装弹！"))
		return

	var/chosen_hp = tgui_input_list(usr, "选择武器挂点", "Hardpoint Menu", (hps + "Cancel"))
	if(chosen_hp == "Cancel")
		return

	var/obj/item/hardpoint/HP = chosen_hp

	// If someone removed the hardpoint while their dialogue was open or something
	if(QDELETED(HP))
		to_chat(user, SPAN_WARNING("错误！未找到模块！"))
		return

	if(!LAZYLEN(HP.backup_clips))
		to_chat(user, SPAN_WARNING("\The [HP] has no remaining backup magazines!"))
		return

	var/obj/item/ammo_magazine/M = LAZYACCESS(HP.backup_clips, 1)
	if(!M)
		to_chat(user, SPAN_DANGER("出错了！请向管理员求助！代码：T_BMIS"))
		return

	to_chat(user, SPAN_NOTICE("你开始为\the [HP]重新装弹。"))

	if(!do_after(user, 10, INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
		to_chat(user, SPAN_WARNING("在为\the [HP]重新装弹时，有事情打断了你。"))
		return

	HP.ammo.forceMove(get_turf(src))
	HP.ammo.update_icon()
	HP.ammo = M
	LAZYREMOVE(HP.backup_clips, M)

	playsound(loc, 'sound/machines/hydraulics_3.ogg', 50)
	to_chat(user, SPAN_NOTICE("你为\the [HP]重新装弹完毕。弹药：<b>[SPAN_HELPFUL(HP.ammo.current_rounds)]/[SPAN_HELPFUL(HP.ammo.max_rounds)]</b> | 弹匣：<b>[SPAN_HELPFUL(LAZYLEN(HP.backup_clips))]/[SPAN_HELPFUL(HP.max_clips)]</b>"))

/obj/structure/weapons_loader/wy
	icon = 'icons/obj/vehicles/interiors/general_wy.dmi'
