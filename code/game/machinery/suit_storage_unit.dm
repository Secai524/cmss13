//////////////////////////////////////
// inserted_suit STORAGE UNIT /////////////////
//////////////////////////////////////


/obj/structure/machinery/suit_storage_unit
	name = "太空服存储单元"
	desc = "一个工业U-Stor-It存储单元，设计用于容纳各种太空服。其内置设备还允许用户通过紫外线净化循环对内容物进行消毒。控制面板上悬挂着一个警告标签，上面写着\"STRICTLY NO BIOLOGICALS IN THE CONFINES OF THE UNIT\"."
	icon = 'icons/obj/structures/machinery/suitstorage.dmi'
	icon_state = "closed" //order is: [has helmet][has suit][has human][is open][is locked][is UV cycling][is powered][is dirty/broken] [is superUVcycling]
	anchored = TRUE
	density = TRUE
	var/obj/item/clothing/suit/space/inserted_suit
	var/obj/item/clothing/head/helmet/space/inserted_helmet
	var/obj/item/clothing/mask/inserted_mask
	var/obj/item/tank/inserted_tank
	var/starting_suit_type
	var/starting_helmet_type
	var/starting_mask_type
	var/starting_tank_type
	var/isopen = FALSE
	var/isUV = FALSE



/obj/structure/machinery/suit_storage_unit/Initialize()
	. = ..()
	if(starting_suit_type)
		inserted_suit = new starting_suit_type(src)
	if(starting_helmet_type)
		inserted_helmet = new starting_helmet_type(src)
	if(starting_mask_type)
		inserted_mask = new starting_mask_type(src)
	if(starting_tank_type)
		inserted_tank = new starting_tank_type(src)
	update_icon()

/obj/structure/machinery/suit_storage_unit/Destroy()
	QDEL_NULL(inserted_suit)
	QDEL_NULL(inserted_helmet)
	QDEL_NULL(inserted_mask)
	QDEL_NULL(inserted_tank)
	. = ..()


/obj/structure/machinery/suit_storage_unit/update_icon()
	overlays.Cut()
	if(isUV)
		icon_state = "disinfecting"
		return
	else if(isopen)
		if(inserted_helmet)
			overlays += image("helmet")

		if(inserted_suit)
			overlays += image("suit")
		if(inserted_mask)
			overlays += image("mask")
		if(inserted_tank)
			overlays += image("tank")

		icon_state = "open"

	else
		icon_state = "closed"
	if(stat & NOPOWER)
		icon_state += "_off"


/obj/structure/machinery/suit_storage_unit/power_change()
	..()
	if(stat & NOPOWER)
		dump_everything()
		if(isUV)
			isUV = FALSE
			update_icon()

/obj/structure/machinery/suit_storage_unit/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				dump_everything()
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			if(prob(50))
				dump_everything() //So suits don't survive all the time
			deconstruct(FALSE)


/obj/structure/machinery/suit_storage_unit/attack_hand(mob/user)
	var/dat
	if(..())
		return
	if(stat & NOPOWER)
		dat+= "<HR><BR><A href='byond://?src=\ref[user];mach_close=suit_storage_unit'>Close panel</A>"
		return
	if(isUV) //The thing is running its cauterisation cycle. You have to wait.
		dat += SET_CLASS("<B>Unit is cauterising contents with UV ray. Please wait.</B>", INTERFACE_RED)
		dat += "<BR>"

	else
		dat+= SET_CLASS("<font size = 4><B>U-Stor-It Suit Storage Unit, model DS1900</B></FONT>", INTERFACE_BLUE)
		dat += "<BR>"
		dat+= "<B>Welcome to the Unit control panel.</B><HR>"

		dat += "<font color='black'>Helmet storage compartment: <B>[inserted_helmet ? inserted_helmet.name : "</font><font color ='grey'>No helmet detected."]</B></font><BR>"
		if(inserted_helmet && isopen)
			dat += "<A href='byond://?src=\ref[src];dispense_helmet=1'>Dispense helmet</A><BR>"

		dat += "<font color='black'>Suit storage compartment: <B>[inserted_suit ? inserted_suit.name : "</font><font color ='grey'>No exosuit detected."]</B></font><BR>"
		if(inserted_suit && isopen)
			dat += "<A href='byond://?src=\ref[src];dispense_suit=1'>Dispense suit</A><BR>"

		dat += "<font color='black'>Breathmask storage compartment: <B>[inserted_mask ? inserted_mask.name : "</font><font color ='grey'>No breathmask detected."]</B></font><BR>"
		if(inserted_mask  && isopen)
			dat += "<A href='byond://?src=\ref[src];dispense_mask=1'>Dispense mask</A><BR>"

		dat += "<font color='black'>Tank storage compartment: <B>[inserted_tank ? inserted_tank.name : "</font><font color ='grey'>No tank detected."]</B></font><BR>"
		if(inserted_tank  && isopen)
			dat += "<A href='byond://?src=\ref[src];dispense_tank=1'>Dispense tank</A><BR>"

		dat+= "<HR><font color='black'>Unit is: [isopen ? "Open" : "Closed"] - <A href='byond://?src=\ref[src];toggle_open=1'>[isopen ? "Close" : "Open"] Unit</A></font><BR>"

		dat += "<A href='byond://?src=\ref[src];start_UV=1'>Start Disinfection cycle</A><BR>"
		dat += "<BR><BR><A href='byond://?src=\ref[user];mach_close=suit_storage_unit'>Close control panel</A>"

	show_browser(user, dat, "太空服存储单元", "suit_storage_unit", width = 400, height = 500)
	return


/obj/structure/machinery/suit_storage_unit/Topic(href, href_list) //I fucking HATE this proc
	if(..())
		return
	if (Adjacent(usr))
		usr.set_interaction(src)
		if (href_list["dispense_helmet"])
			dispense_helmet()
			updateUsrDialog()
			update_icon()
		if (href_list["dispense_suit"])
			dispense_suit()
			updateUsrDialog()
			update_icon()
		if (href_list["dispense_mask"])
			dispense_mask()
			updateUsrDialog()
			update_icon()
		if (href_list["dispense_tank"])
			dispense_tank()
			updateUsrDialog()
			update_icon()
		if (href_list["toggle_open"])
			toggle_open()
			updateUsrDialog()
			update_icon()
		if (href_list["start_UV"])
			start_UV(usr)
			updateUsrDialog()
			update_icon()

	add_fingerprint(usr)




/obj/structure/machinery/suit_storage_unit/proc/dispense_helmet()
	if(inserted_helmet)
		inserted_helmet.forceMove(loc)
		inserted_helmet = null



/obj/structure/machinery/suit_storage_unit/proc/dispense_suit()
	if(inserted_suit)
		inserted_suit.forceMove(loc)
		inserted_suit = null



/obj/structure/machinery/suit_storage_unit/proc/dispense_mask()
	if(inserted_mask)
		inserted_mask.forceMove(loc)
		inserted_mask = null


/obj/structure/machinery/suit_storage_unit/proc/dispense_tank()
	if(inserted_tank)
		inserted_tank.forceMove(loc)
		inserted_tank = null


/obj/structure/machinery/suit_storage_unit/proc/dump_everything()
	dispense_helmet()
	dispense_suit()
	dispense_mask()
	dispense_tank()


/obj/structure/machinery/suit_storage_unit/proc/toggle_open(mob/user as mob)
	if(isUV)
		to_chat(user, "<font color='red'>无法打开单元。</font>")
		return
	isopen = !isopen
	update_icon()


/obj/structure/machinery/suit_storage_unit/proc/start_UV(mob/user)
	set waitfor = 0

	if(isopen)
		to_chat(user, "<font color='red'>单元存储未关闭——中止操作。</font>")
		return

	if(isUV)
		return

	if(!inserted_helmet && !inserted_mask && !inserted_suit) //shit's empty yo
		to_chat(user, "<font color='red'>单元存储舱为空。没有物品需要消毒——中止操作。</font>")
		return
	to_chat(user, SPAN_NOTICE("你启动了单元的灼烧净化循环。"))
	isUV = 1
	update_icon()
	updateUsrDialog()

	sleep(150)

	if(QDELETED(src))
		return
	if(inserted_helmet)
		inserted_helmet.clean_blood()
	if(inserted_suit)
		inserted_suit.clean_blood()
	if(inserted_mask)
		inserted_mask.clean_blood()
	if(inserted_tank)
		inserted_tank.clean_blood()
	isUV = 0 //Cycle ends
	update_icon()
	updateUsrDialog()




/obj/structure/machinery/suit_storage_unit/attackby(obj/item/I, mob/living/user)

	if(!(stat & NOPOWER))

		if(isopen)

			if( istype(I,/obj/item/clothing/suit/space) )
				var/obj/item/clothing/suit/space/S = I
				if(inserted_suit)
					to_chat(user, SPAN_WARNING("单元内已有一件太空服。"))
					return
				if(user.drop_inv_item_to_loc(S, src))
					to_chat(user, SPAN_NOTICE("你将[S.name]装入存储舱。"))
					inserted_suit = S
					update_icon()
					updateUsrDialog()
				return

			if( istype(I,/obj/item/clothing/head/helmet) )
				var/obj/item/clothing/head/helmet/H = I
				if(inserted_helmet)
					to_chat(user, SPAN_WARNING("单元内已有一个头盔。"))
					return
				to_chat(user, SPAN_NOTICE("你将[H.name]装入存储舱。"))
				if(user.drop_inv_item_to_loc(H, src))
					inserted_helmet = H
					update_icon()
					updateUsrDialog()
				return

			if( istype(I,/obj/item/clothing/mask) )
				var/obj/item/clothing/mask/M = I
				if(inserted_mask)
					to_chat(user, SPAN_WARNING("该单元已包含一个面罩。"))
					return
				to_chat(user, SPAN_NOTICE("你将[M.name]装入存储舱。"))
				if(user.drop_inv_item_to_loc(M, src))
					inserted_mask = M
					update_icon()
					updateUsrDialog()
				return

			if( istype(I,/obj/item/tank) )
				var/obj/item/tank/T = I
				if(inserted_tank)
					to_chat(user, SPAN_WARNING("该单元已包含一个气罐。"))
					return
				to_chat(user, SPAN_NOTICE("你将[T.name]装入存储舱。"))
				if(user.drop_inv_item_to_loc(T, src))
					inserted_tank = T
					update_icon()
					updateUsrDialog()
				return



/obj/structure/machinery/suit_storage_unit/attack_remote(mob/user as mob)
	return attack_hand(user)

/obj/structure/machinery/suit_storage_unit/carbon_unit
	starting_suit_type = /obj/item/clothing/suit/space/uscm
	starting_helmet_type = /obj/item/clothing/head/helmet/space/uscm
	starting_mask_type = /obj/item/clothing/mask/breath
	starting_tank_type = /obj/item/tank/oxygen

/obj/structure/machinery/suit_storage_unit/standard_unit
	starting_suit_type = /obj/item/clothing/suit/space
	starting_helmet_type = /obj/item/clothing/head/helmet/space
	starting_mask_type = /obj/item/clothing/mask/breath
	starting_tank_type = /obj/item/tank/oxygen

/obj/structure/machinery/suit_storage_unit/compression_suit
	starting_suit_type = /obj/item/clothing/suit/space/compression
	starting_helmet_type = /obj/item/clothing/head/helmet/space/compression
	starting_mask_type = /obj/item/clothing/mask/breath
	starting_tank_type = /obj/item/tank/oxygen

/obj/structure/machinery/suit_storage_unit/compression_suit/uscm
	starting_suit_type = /obj/item/clothing/suit/space/compression/uscm
	starting_helmet_type = /obj/item/clothing/head/helmet/space/compression/uscm
	starting_mask_type = /obj/item/clothing/mask/breath
	starting_tank_type = /obj/item/tank/oxygen
