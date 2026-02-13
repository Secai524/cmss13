/*
CONTAINS:
T-RAY
DETECTIVE SCANNER
HEALTH ANALYZER
GAS ANALYZER
PLANT ANALYZER
MASS SPECTROMETER
REAGENT SCANNER
FORENSIC SCANNER
K9 SCANNER
*/
/obj/item/device/t_scanner
	name = "\improper T-ray scanner"
	desc = "一种用于探测电缆和管道等地板下物体的太赫兹射线发射器和扫描仪。"
	icon_state = "t-ray0"
	var/on = 0
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	w_class = SIZE_SMALL
	item_state = "electronic"

	matter = list("metal" = 150)

/obj/item/device/t_scanner/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/device/t_scanner/attack_self(mob/user)
	..()
	on = !on
	icon_state = "t-ray[on]"

	if(on)
		START_PROCESSING(SSobj, src)


/obj/item/device/t_scanner/process()
	if(!on)
		STOP_PROCESSING(SSobj, src)
		return null

	for(var/turf/T in range(1, src.loc) )

		if(!T.intact_tile)
			continue

		for(var/obj/O in T.contents)

			if(O.level != 1)
				continue

			if(O.invisibility == 101)
				O.invisibility = 0
				O.alpha = 128
				spawn(10)
					if(O && !QDELETED(O))
						var/turf/U = O.loc
						if(U.intact_tile)
							O.invisibility = 101
							O.alpha = 255

		var/mob/living/M = locate() in T
		if(M && M.invisibility == 2)
			M.invisibility = 0
			spawn(2)
				if(M)
					M.invisibility = INVISIBILITY_LEVEL_TWO


/obj/item/device/healthanalyzer
	name = "\improper HF2 health analyzer"
	icon_state = "health"
	item_state = "analyzer"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/tools.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_righthand.dmi'
	)
	desc = "一种手持式生命体征扫描仪，能够区分目标的生命体征。前面板可提供目标状态的基本读数。"
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	flags_item = NOBLUDGEON
	throwforce = 3
	w_class = SIZE_SMALL
	throw_speed = SPEED_VERY_FAST
	throw_range = 10
	matter = list("metal" = 200)

	var/popup_window = TRUE
	var/last_scan
	var/datum/health_scan/last_health_display
	var/alien = FALSE

/obj/item/device/healthanalyzer/Destroy()
	QDEL_NULL(last_health_display)
	return ..()

/obj/item/device/healthanalyzer/attack(mob/living/target_mob, mob/living/user)
	if(!istype(target_mob, /mob/living/carbon) || isxeno(target_mob))
		to_chat(user, SPAN_WARNING("[src]无法理解这个生物。"))
		return
	if(!popup_window)
		last_scan = target_mob.health_scan(user, FALSE, TRUE, popup_window, alien)
	else
		if (!last_health_display)
			last_health_display = new(target_mob)
		else
			last_health_display.target_mob = target_mob
		SStgui.close_user_uis(user, src)
		last_scan = last_health_display.ui_data(user, DETAIL_LEVEL_HEALTHANALYSER)
		last_health_display.look_at(user, DETAIL_LEVEL_HEALTHANALYSER, bypass_checks = FALSE, ignore_delay = FALSE, alien = alien)
	to_chat(user, SPAN_NOTICE("[user]已分析[target_mob]的生命体征。"))
	playsound(src.loc, 'sound/items/healthanalyzer.ogg', 50)
	src.add_fingerprint(user)
	return

/obj/item/device/healthanalyzer/attack_self(mob/user)
	..()

	if(!last_scan)
		user.show_message("未找到之前的扫描记录。")
		return

	if(popup_window)
		tgui_interact(user)
	else
		user.show_message(last_scan)

	return

/obj/item/device/healthanalyzer/tgui_interact(mob/user, datum/tgui/ui)
	if(!last_scan)
		return

	SStgui.close_user_uis(user, last_health_display)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HealthScan", "Stored Health Scan")
		ui.open()
		ui.set_autoupdate(FALSE)

/obj/item/device/healthanalyzer/ui_data(mob/user)
	return last_scan

/obj/item/device/healthanalyzer/verb/toggle_hud_mode()
	set name = "Switch Hud Mode"
	set category = "Object"
	set src in usr
	popup_window = !popup_window
	last_scan = null // reset the data
	to_chat(usr, "扫描仪[popup_window ? "now" : "no longer"] shows results on the hud.")

/obj/item/device/healthanalyzer/alien
	name = "\improper YMX scanner"
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	icon_state = "scanner"
	item_state = "analyzer"
	desc = "一种外星设计的手持式生命体征扫描仪，能够区分目标的生命体征。前面板可提供目标状态的基本读数。"
	alien = TRUE
	black_market_value = 35

/obj/item/device/analyzer
	desc = "一种手持式环境扫描仪，可报告当前气体水平。"
	name = "analyzer"
	icon_state = "atmos"
	item_state = "analyzer"
	w_class = SIZE_SMALL
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 20

	matter = list("metal" = 30,"glass" = 20)



/obj/item/device/analyzer/attack_self(mob/user as mob)
	..()

	if (user.stat)
		return
	if (!(istype(usr, /mob/living/carbon/human) || SSticker) && SSticker.mode.name != "monkey")
		to_chat(usr, SPAN_DANGER("你的手不够灵巧，无法完成此操作！"))
		return

	var/turf/location = user.loc
	if (!( istype(location, /turf) ))
		return

	var/env_pressure = location.return_pressure()
	var/env_gas = location.return_gas()
	var/env_temp = location.return_temperature()

	user.show_message(SPAN_NOTICE("<B>结果：</B>"), 1)
	if(abs(env_pressure - ONE_ATMOSPHERE) < 10)
		user.show_message(SPAN_NOTICE("压力：[round(env_pressure,0.1)] 千帕。"), 1)
	else
		user.show_message(SPAN_DANGER("压力：[round(env_pressure,0.1)] 千帕。"), 1)
	if(env_pressure > 0)
		user.show_message(SPAN_NOTICE("气体类型：[env_gas]"), 1)
		user.show_message(SPAN_NOTICE("温度：[floor(env_temp-T0C)]&deg;摄氏度。"), 1)

	src.add_fingerprint(user)
	return

/obj/item/device/mass_spectrometer
	desc = "一种手持式质谱仪，用于识别血样中的微量化学物质。"
	name = "质谱仪"
	icon_state = "spectrometer"
	item_state = "analyzer"
	w_class = SIZE_SMALL
	flags_atom = FPRINT|CONDUCT|OPENCONTAINER
	flags_equip_slot = SLOT_WAIST
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 20

	matter = list("metal" = 30,"glass" = 20)


	var/details = 0
	var/recent_fail = 0

/obj/item/device/mass_spectrometer/Initialize()
	. = ..()
	create_reagents(5)

/obj/item/device/mass_spectrometer/on_reagent_change()
	if(reagents.total_volume)
		icon_state = initial(icon_state) + "_s"
	else
		icon_state = initial(icon_state)

/obj/item/device/mass_spectrometer/attack_self(mob/user)
	..()

	if (user.stat)
		return
	if (crit_fail)
		to_chat(user, SPAN_DANGER("该设备已严重故障，无法再使用！"))
		return
	if (!(istype(user, /mob/living/carbon/human) || SSticker) && SSticker.mode.name != "monkey")
		to_chat(user, SPAN_DANGER("你的手不够灵巧，无法完成此操作！"))
		return


/obj/item/device/mass_spectrometer/adv
	name = "高级质谱仪"
	icon_state = "adv_spectrometer"
	details = 1


/obj/item/device/reagent_scanner
	name = "试剂扫描仪"
	desc = "一种手持式试剂扫描仪，用于识别化学制剂。"
	icon_state = "spectrometer"
	item_state = "analyzer"
	w_class = SIZE_SMALL
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	matter = list("metal" = 30,"glass" = 20)


	var/details = 0
	var/recent_fail = 0

/obj/item/device/reagent_scanner/afterattack(obj/O, mob/user as mob, proximity)
	if(!proximity)
		return
	if (user.stat)
		return
	if (!(istype(user, /mob/living/carbon/human) || SSticker) && SSticker.mode.name != "monkey")
		to_chat(user, SPAN_DANGER("你的手不够灵巧，无法完成此操作！"))
		return
	if(!istype(O))
		return
	if (crit_fail)
		to_chat(user, SPAN_DANGER("该设备已严重故障，无法再使用！"))
		return

	if(!QDELETED(O.reagents))
		var/dat = ""
		if(length(O.reagents.reagent_list) > 0)
			var/one_percent = O.reagents.total_volume / 100
			for (var/datum/reagent/R in O.reagents.reagent_list)
				if(prob(reliability))
					dat += "\n \t \blue [R.name][details ? ": [R.volume / one_percent]%" : ""]"
					recent_fail = 0
				else if(recent_fail)
					crit_fail = 1
					dat = null
					break
				else
					recent_fail = 1
		if(dat)
			to_chat(user, SPAN_NOTICE("发现的化学物质：[dat]"))
		else
			to_chat(user, SPAN_NOTICE("在[O]中未发现活性化学制剂。"))
	else
		to_chat(user, SPAN_NOTICE("在[O]中未发现显著的化学制剂。"))

	return

/obj/item/device/reagent_scanner/adv
	name = "高级试剂扫描仪"
	icon_state = "adv_spectrometer"
	details = 1

/obj/item/device/demo_scanner
	name = "爆破扫描仪"
	desc = "一种专门设计用于分析炸弹的手持式试剂扫描仪。它可以报告化学容器和爆炸外壳的爆炸与火灾危险，包括爆炸和火灾强度。然而，它无法预测诸如破片或燃烧持续时间等效应，也无法预测由即时化学反应引起的危险。"
	icon_state = "demolitions_scanner"
	item_state = "analyzer"
	w_class = SIZE_SMALL
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	matter = list("metal" = 30,"glass" = 20)
	var/scan_name = ""
	var/dat = ""
	var/ex_potential = 0
	var/int_potential = 0
	var/rad_potential = 0
	var/datum/reagents/holder

/obj/item/device/demo_scanner/afterattack(obj/O, mob/user as mob, proximity)
	if(!proximity)
		return
	if(user.stat)
		return
	if(!(istype(user, /mob/living/carbon/human) || SSticker) && SSticker.mode.name != "monkey")
		to_chat(user, SPAN_DANGER("你的手不够灵巧，无法完成此操作！"))
		return
	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		to_chat(user, SPAN_WARNING("你不知道如何使用[name]。"))
		return
	if(!istype(O))
		return

	scan_name = O.name
	dat = ""
	ex_potential = 0
	int_potential = 0
	rad_potential = 0

	if(istype(O, /obj/item/ammo_magazine/flamer_tank))
		var/obj/item/ammo_magazine/flamer_tank/tank = O
		if(!length(tank.reagents.reagent_list))
			to_chat(user, SPAN_NOTICE("在[O]中未检测到燃料"))
			return
		var/result
		var/datum/reagent/chem = tank.reagents.reagent_list[1]
		result += SPAN_BLUE("Fuel Statistics:")
		result += SPAN_BLUE("<br>Intensity: [min(chem.intensityfire, tank.max_intensity)]")
		result += SPAN_BLUE("<br>Duration: [min(chem.durationfire, tank.max_duration)]")
		result += SPAN_BLUE("<br>Range: [min(chem.rangefire, tank.max_range)]")
		to_chat(user, SPAN_NOTICE("[result]"))
		return

	if(istype(O,/obj/item/explosive))
		var/obj/item/explosive/E = O
		if(!E.customizable)
			to_chat(user, SPAN_NOTICE("错误：该品牌炸药受数据保护。扫描已取消。"))
			return
		holder = E.reagents
		for(var/obj/container in E.containers)
			scan(container)
	else if(istype(O,/obj/item/ammo_magazine/rocket/custom))
		var/obj/item/ammo_magazine/rocket/custom/E = O
		if(!E.warhead)
			to_chat(user, SPAN_NOTICE("在[E]中未检测到弹头。"))
			return
		holder = E.warhead.reagents
		for(var/obj/container in E.warhead.containers)
			scan(container)
	else if(istype(O,/obj/item/mortar_shell/custom))
		var/obj/item/mortar_shell/custom/E = O
		if(!E.warhead)
			to_chat(user, SPAN_NOTICE("在[E]中未检测到弹头。"))
			return
		holder = E.warhead.reagents
		for(var/obj/container in E.warhead.containers)
			scan(container)
	else
		scan(O)
		if(O.reagents)
			holder = O.reagents
	if(dat && holder)
		if(ex_potential)
			dat += SPAN_ORANGE("<br>EXPLOSIVE HAZARD: ignition will create explosive detonation.<br>Potential detonation power: [min(ex_potential, holder.max_ex_power)]")
		if(int_potential)
			dat += SPAN_RED("<br>FIRE HAZARD: ignition will create chemical fire.<br>Expected fire intensity rating of [min(max(int_potential,holder.min_fire_int),holder.max_fire_int)] in a [min(max(rad_potential,holder.min_fire_rad),holder.max_fire_rad)] meter radius.")
		to_chat(user, SPAN_NOTICE("发现的化学物质：[dat]"))
	else
		to_chat(user, SPAN_NOTICE("在[O]中未发现活性化学制剂。"))
	return

/obj/item/device/demo_scanner/proc/scan(obj/O)
	if(QDELETED(O.reagents))
		return
	if(length(O.reagents.reagent_list) > 0)
		for(var/datum/reagent/R in O.reagents.reagent_list)
			dat += SPAN_BLUE("<br>[R.name]: [R.volume]u")
			if(R.explosive)
				ex_potential += R.volume*R.power
			if(R.chemfiresupp)
				int_potential += R.intensitymod * R.volume
				rad_potential += R.radiusmod * R.volume
	return dat

/obj/item/device/demo_scanner/attack_self(mob/user)
	..()

	if(!dat)
		to_chat(user, SPAN_NOTICE("无可用扫描数据。"))
		return
	if(alert(user,"打印最新扫描结果？","[scan_name]","Yes","No") == "Yes")
		var/obj/item/paper/printing = new /obj/item/paper/()
		printing.name = scan_name
		printing.info = "发现的化学物质：[dat]"
		user.put_in_hands(printing)

/obj/item/device/black_market_scanner
	name = "可疑装置"
	desc = "这似乎是...尸检扫描仪、老式T射线扫描仪和某种机器人夹具的临时组合体，但你能看到里面有个灯泡。这到底是什么鬼东西？"
	icon_state = "mendoza_scanner"
	item_state = "analyzer"
	w_class = SIZE_SMALL
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	matter = list("metal" = 60, "glass" = 30)

/obj/item/device/black_market_scanner/Initialize()
	. = ..()
	update_icon()

/obj/item/device/black_market_scanner/update_icon(scan_value = 0, scanning = FALSE)
	. = ..()
	overlays.Cut()
	overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_flash")
	if(scanning)
		overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_clamp_on")
		switch(scan_value)
			if(0)
				overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_value_red")
			if(1 to 15)
				overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_value_orange")
			if(15 to 20)
				overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_value_yellow")
			if(25 to 30)
				overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_value_green")
			if(35 to 49)
				overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_value_cyan")
			else
				overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_value_white")
		addtimer(CALLBACK(src, PROC_REF(update_icon)), 1 SECONDS)
	else
		overlays += image('icons/obj/items/devices.dmi', "+mendoza_scanner_clamp_off")

/obj/item/device/black_market_scanner/afterattack(atom/hit_atom, mob/user, proximity)
	if(!proximity)
		return
	if(!ismovable(hit_atom))
		return ..()
	var/market_value = get_black_market_value(hit_atom)
	if(isnull(market_value))
		return ..()
	market_value = POSITIVE(market_value)
	user.visible_message(SPAN_WARNING("[user]按下[src]上的一个按钮，将其对准[hit_atom]..."), SPAN_WARNING("You scan [hit_atom]..."))
	update_icon(market_value, TRUE)
	playsound(user, 'sound/machines/twobeep.ogg', 15, TRUE)
	to_chat(user, SPAN_NOTICE("你扫描了[hit_atom]并注意到[src]的屏幕上显示读数，内容是：<b>物品价值：[market_value]<b>"))

/obj/item/device/black_market_hacking_device
	name = "改装的安全权限调谐器"
	desc = "一个安全权限调谐器，电线和引脚以奇怪的角度伸出。底部的手写标签提到了ASRS系统。"
	icon_state = "bm_hacker"
	item_state = "analyzer"
	icon = 'icons/obj/items/tools.dmi'
	w_class = SIZE_SMALL
	flags_atom = FPRINT
	flags_equip_slot = SLOT_WAIST
	inherent_traits = list(TRAIT_TOOL_BLACKMARKET_HACKER)

/obj/item/device/cmb_black_market_tradeband
	name = "\improper CMB Tradeband Compliance Device"
	desc = "一种用于重置任何对交易设备信号范围所做篡改的设备。偶尔用于修复事故中损坏的信号芯片，但更常用于纠正交易中的不当操作。请谨慎使用，因为它也会清除任何潜在非法交易的证据。为满足边境地区CMB-ICC团队的联合组织要求而制造，在那里被篡改的机器难以移动和翻新。走私者当心。"
	icon_state = "cmb_scanner"
	item_state = "analyzer"
	w_class = SIZE_SMALL
	flags_atom = FPRINT
	flags_equip_slot = SLOT_WAIST
	inherent_traits = list(TRAIT_TOOL_TRADEBAND)

/obj/item/device/k9_scanner
	name = "\improper K9 tracking device"
	desc = "一种用于追踪合成K9助手的小型手持工具，它们总在不合时宜的时候跑到奇怪的地方去..."
	icon_state = "tracking0"
	item_state = "tracking1"
	pickup_sound = 'sound/handling/multitool_pickup.ogg'
	drop_sound = 'sound/handling/multitool_drop.ogg'
	flags_atom = FPRINT
	force = 5
	w_class = SIZE_TINY
	throwforce = 5
	throw_range = 15
	throw_speed = SPEED_VERY_FAST

	matter = list("metal" = 50,"glass" = 20)

	var/mob/living/carbon/human/tracked_k9

/obj/item/device/k9_scanner/Destroy()
	. = ..()
	tracked_k9 = null

/obj/item/device/k9_scanner/attack(mob/attacked_mob as mob, mob/user as mob)
	if(!isk9synth(attacked_mob))
		to_chat(user, SPAN_BOLDWARNING("错误：无法与此设备同步。"))
		return
	//we now know the attacked mob is a k9
	tracked_k9 = attacked_mob
	icon_state = "tracking1"
	to_chat(user, SPAN_WARNING("[src]现已同步至：[attacked_mob]。"))

/obj/item/device/k9_scanner/attack_self(mob/user)
	. = ..()
	if (!tracked_k9)
		to_chat(user, SPAN_WARNING("错误：当前未追踪任何K9单位。请使用扫描仪对准K9单位以进行追踪。"))
		return

	var/turf/self_turf = get_turf(src)
	var/turf/scanner_turf = get_turf(tracked_k9)
	var/area/self_area = get_area(self_turf)
	var/area/scanner_area = get_area(scanner_turf)

	if(self_turf.z != scanner_turf.z || self_area.fake_zlevel != scanner_area.fake_zlevel)
		to_chat(user, SPAN_BOLDWARNING("[src]亮起：<b>无法联系到已链接的K9！<b>"))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 15, TRUE)
		return

	var/dist = get_dist(self_turf, scanner_turf)
	var/direction = dir2text(Get_Compass_Dir(self_turf, scanner_turf))
	if(dist > 1)
		to_chat(user, SPAN_BOLDNOTICE("[src]亮起：[tracked_k9]位于<b>'[direction]方向[dist]米处</b>'"))
	else
		to_chat(user, SPAN_BOLDNOTICE("[src]亮起：<b>--><--</b>"))
	playsound(src, 'sound/machines/ping.ogg', 15, TRUE)

