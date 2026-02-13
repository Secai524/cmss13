#define TANK_MAX_RELEASE_PRESSURE (3*ONE_ATMOSPHERE)
#define TANK_DEFAULT_RELEASE_PRESSURE 24
#define TANK_MIN_RELEASE_PRESSURE 0

/obj/item/tank
	name = "tank"
	icon = 'icons/obj/items/tank.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/tanks_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/tanks_righthand.dmi',
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/misc.dmi'
	)
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_BACK
	w_class = SIZE_MEDIUM

	var/pressure_full = ONE_ATMOSPHERE*4

	var/pressure = ONE_ATMOSPHERE*4
	var/gas_type = GAS_TYPE_AIR
	var/temperature = T20C

	force = 5
	throwforce = 10
	throw_speed = SPEED_FAST
	throw_range = 4

	var/distribute_pressure = ONE_ATMOSPHERE
	var/integrity = 3
	var/volume = 70
	var/manipulated_by = null //Used by _onclick/hud/screen_objects.dm internals to determine if someone has messed with our tank or not.
						//If they have and we haven't scanned it with the PDA or gas analyzer then we might just breath whatever they put in it.

/obj/item/tank/get_examine_text(mob/user)
	. = ..()
	if(in_range(src, user))
		var/celsius_temperature = temperature-T0C
		var/descriptive
		switch(celsius_temperature)
			if(-280 to 20)
				descriptive = "cold"
			if(20 to 40)
				descriptive = "room temperature"
			if(40 to 80)
				descriptive = "lukewarm"
			if(80 to 100)
				descriptive = "warm"
			if(100 to 300)
				descriptive = "hot"
			else
				descriptive = "furiously hot"

		. += SPAN_NOTICE("\The [icon2html(src, user)][src] feels [descriptive]")


/obj/item/tank/attackby(obj/item/W as obj, mob/user as mob)
	..()

	if((istype(W, /obj/item/device/analyzer)) && get_dist(user, src) <= 1)
		for(var/mob/O in viewers(user, null))
			to_chat(O, SPAN_DANGER("[user]已对[icon2html(src, O)] [src]使用了[W]"))

		manipulated_by = user.real_name //This person is aware of the contents of the tank.

		to_chat(user, SPAN_NOTICE("[icon2html(src, user)]的分析结果"))
		if(pressure>0)
			to_chat(user, SPAN_NOTICE("压力：[round(pressure,0.1)]千帕。"))
			to_chat(user, SPAN_NOTICE("[gas_type]：100%"))
			to_chat(user, SPAN_NOTICE("温度：[floor(temperature-T0C)]°C。"))
		else
			to_chat(user, SPAN_NOTICE("气罐已空！"))
		src.add_fingerprint(user)


/obj/item/tank/attack_self(mob/user)
	. = ..()

	tgui_interact(user)

/obj/item/tank/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "坦克", name)
		ui.open()

/obj/item/tank/ui_state(mob/user)
	return GLOB.inventory_state

/obj/item/tank/ui_data(mob/user)
	var/list/data = list()

	data["tankPressure"] = floor(pressure)
	data["tankMaxPressure"] = floor(pressure_full)
	data["ReleasePressure"] = floor(distribute_pressure)
	data["defaultReleasePressure"] = floor(TANK_DEFAULT_RELEASE_PRESSURE)
	data["maxReleasePressure"] = floor(TANK_MAX_RELEASE_PRESSURE)
	data["minReleasePressure"] = floor(TANK_MIN_RELEASE_PRESSURE)

	var/mask_connected = FALSE
	var/using_internal = FALSE

	if(istype(loc,/mob/living/carbon))
		var/mob/living/carbon/location = loc
		if(location.internal == src)
			using_internal = TRUE
		if(location.internal == src || (location.wear_mask && (location.wear_mask.flags_inventory & ALLOWINTERNALS)))
			mask_connected = TRUE

	data["mask_connected"] = mask_connected
	data["valve_open"] = using_internal

	return data

/obj/item/tank/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("pressure")
			var/tgui_pressure = params["pressure"]
			if(tgui_pressure == "reset")
				src.distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
			else if(tgui_pressure == "max")
				src.distribute_pressure = TANK_MAX_RELEASE_PRESSURE
			else if(tgui_pressure == "min")
				src.distribute_pressure = TANK_MIN_RELEASE_PRESSURE
			else if(text2num(tgui_pressure) != null)
				pressure = text2num(tgui_pressure)
			src.distribute_pressure = min(max(floor(src.distribute_pressure), 0), TANK_MAX_RELEASE_PRESSURE)
			. = TRUE

		if("valve")
			if(istype(loc,/mob/living/carbon))
				var/mob/living/carbon/location = loc
				if(location.internal == src)
					location.internal = null
					to_chat(usr, SPAN_NOTICE("你关闭了气罐释放阀。"))
				else
					if(location.wear_mask && (location.wear_mask.flags_inventory & ALLOWINTERNALS))
						location.internal = src
						to_chat(usr, SPAN_NOTICE("你打开了\the [src]的阀门。"))
					else
						to_chat(usr, SPAN_NOTICE("你需要连接\the [src]的东西。"))
				. = TRUE

/obj/item/tank/return_air()
	return list(gas_type, temperature, pressure)

/obj/item/tank/return_pressure()
	return pressure

/obj/item/tank/return_temperature()
	return temperature

/obj/item/tank/return_gas()
	return gas_type
