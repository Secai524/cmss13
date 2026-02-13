/obj/structure/machinery/cm_vending/clothing/dress
	name = "殖民地海军陆战队科技自动个人制服衣柜"
	desc = "一个连接着海量标准制式礼服变体存储库的自动衣柜。"
	icon_state = "dress"
	vendor_theme = VENDOR_THEME_USCM

/obj/structure/machinery/cm_vending/clothing/dress/proc/get_listed_products_for_role(list/role_specific_uniforms)
	. = list()
	for(var/category_type in GLOB.uniform_categories)
		var/display_category = FALSE
		if(!GLOB.uniform_categories[category_type])
			continue
		for(var/category in GLOB.uniform_categories[category_type])
			if((category in role_specific_uniforms) && role_specific_uniforms[category])
				display_category = TRUE
				break
		if(!display_category)
			continue
		. += list(
			list(category_type, 0, null, null, null)
		)
		for(var/object_type in GLOB.uniform_categories[category_type])
			if(!role_specific_uniforms[object_type])
				continue
			for(var/uniform_path in role_specific_uniforms[object_type])
				var/obj/O = uniform_path
				var/name = sanitize(initial(O.name))
				. += list(
					list(name, 0, uniform_path, NO_FLAGS, VENDOR_ITEM_REGULAR)
				)

/obj/structure/machinery/cm_vending/clothing/dress/proc/get_products_preset(list/presets)
	. = list()
	for(var/preset in presets)
		var/datum/equipment_preset/pre = new preset()
		var/list/uniforms = pre.uniform_sets
		. += get_listed_products_for_role(uniforms)
		qdel(pre)

/obj/structure/machinery/cm_vending/clothing/dress/get_listed_products(mob/user)
	if (!user)
		return get_products_preset(typesof(/datum/equipment_preset))

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	var/obj/item/card/id/id_card = H.get_idcard()
	var/list/role_specific_uniforms
	var/list/vended_items
	var/list/display_list = list()
	if(id_card)
		role_specific_uniforms = id_card.uniform_sets
		vended_items = id_card.vended_items
	for(var/category_type in GLOB.uniform_categories)
		var/display_category = FALSE
		if(!GLOB.uniform_categories[category_type])
			continue
		for(var/category in GLOB.uniform_categories[category_type])
			if((category in role_specific_uniforms) && role_specific_uniforms[category])
				display_category = TRUE
				break
		if(!display_category)
			continue
		display_list += list(
			list(category_type, 0, null, null, null)
		)
		for(var/object_type in GLOB.uniform_categories[category_type])
			if(!role_specific_uniforms[object_type])
				continue
			for(var/uniform_path in role_specific_uniforms[object_type])
				var/obj/O = uniform_path
				var/can_vend = TRUE
				if(uniform_path in vended_items)
					can_vend = FALSE
				var/name = sanitize(strip_improper(initial(O.name)))
				var/flags = can_vend ? null : MARINE_CAN_BUY_DRESS
				display_list += list(
					list(name, 0, uniform_path, flags, VENDOR_ITEM_REGULAR)
				)
	return display_list

/obj/structure/machinery/cm_vending/clothing/dress/ui_data(mob/user)

	var/mob/living/carbon/human/H = user
	var/obj/item/card/id/id_card = H.get_idcard()
	var/list/vended_items
	if(id_card)
		vended_items = id_card.vended_items

	var/list/data = list()
	var/list/ui_listed_products = get_listed_products(user)
	var/list/stock_values = list()
	for (var/i in 1 to length(ui_listed_products))
		var/prod_available = TRUE
		var/list/myprod = ui_listed_products[i] //we take one list from listed_products
		var/uniform_path = myprod[3]
		if(uniform_path in vended_items)
			prod_available = FALSE
		stock_values += list(prod_available)

	data["stock_listing"] = stock_values
	data["show_points"] = FALSE
	data["current_m_points"] = available_points_to_display
	return data

/obj/structure/machinery/cm_vending/clothing/dress/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..(action == "vend" ? "" : action, params, ui, state)
	if(.)
		return

	var/mob/living/carbon/human/H = usr
	switch (action)
		if ("vend")
			var/exploiting = TRUE
			var/idx=params["prod_index"]

			var/list/topic_listed_products = get_listed_products(usr)
			var/list/L = topic_listed_products[idx]

			var/item_path = L[3]

			var/obj/item/card/id/id_card = H.get_idcard()

			if(!id_card) //not wearing an ID
				to_chat(H, SPAN_WARNING("权限被拒绝。未检测到身份卡。"))
				return

			if(id_card.registered_name != H.real_name)
				to_chat(H, SPAN_WARNING("检测到错误的身份卡所有者。"))
				return

			if(LAZYLEN(vendor_role) && !vendor_role.Find(id_card.rank))
				to_chat(H, SPAN_WARNING("这台机器不是给你用的。"))
				return

			for(var/category in GLOB.uniform_categories) // Very Hacky fix
				if(!exploiting)
					break
				for(var/specific_category in GLOB.uniform_categories[category])
					if(!exploiting)
						break
					if(!(specific_category in id_card.uniform_sets))
						continue
					for(var/outfit in id_card.uniform_sets[specific_category])
						if(ispath(item_path, outfit))
							exploiting = FALSE
							break


			if(exploiting)
				return

			var/obj/item/IT = new item_path(get_appropriate_vend_turf())
			IT.add_fingerprint(usr)
			LAZYADD(id_card.vended_items, item_path)
			return TRUE

//A clothing vendor for admins and devs to test all the items in the game
/obj/structure/machinery/cm_vending/clothing/super_snowflake
	name = "\improper 超级雪花供应商"
	desc = "警告：内部物品数量可能导致现实延迟。"
	icon_state = "snowflake"
	use_points = TRUE //"use points", but everything is free
	show_points = FALSE
	use_snowflake_points = FALSE
	vendor_theme = VENDOR_THEME_COMPANY
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_TO_HAND | VEND_UNIFORM_AUTOEQUIP
	vend_delay = 1 SECONDS
	var/list/items
	var/list/obj/item/item_types

/obj/structure/machinery/cm_vending/clothing/super_snowflake/get_listed_products(mob/user)
	//If we don't have an object type, we ask the user to supply it
	if(!item_types)
		var/obj/item/chosen = get_item_category_from_user()
		if(!chosen)
			return
		item_types = list(chosen)

	if(!items)
		items = list()
		for(var/obj/item/item_type as anything in item_types)
			add_items(item_type)

	return items

/obj/structure/machinery/cm_vending/clothing/super_snowflake/proc/get_item_category_from_user()
	var/item = tgui_input_text(usr,"补充何种物品？", "Stock Vendor","")
	if(!item)
		return
	var/list/types = typesof(/obj/item)
	var/list/matches = new()

	//Figure out which object they might be trying to fetch
	for(var/path in types)
		if(findtext("[path]", item))
			matches += path

	if(length(matches)==0)
		return

	var/obj/item/chosen
	if(length(matches)==1)
		chosen = matches[1]
	else
		//If we have multiple options, let them select which one they meant
		chosen = tgui_input_list(usr, "选择对象类型", "Select Object", matches)

	return chosen

/obj/structure/machinery/cm_vending/clothing/super_snowflake/proc/add_items(obj/item/item_type)
	for(var/obj/item/I as anything in typesof(item_type))
		items += list(list(initial(I.name), 0, I, null, VENDOR_ITEM_REGULAR))

/obj/structure/machinery/cm_vending/clothing/super_snowflake/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "----SNOWFLAKE VENDOR-----")
	VV_DROPDOWN_OPTION(VV_HK_ADD_ITEMS_TO_VENDOR, "Add Items to Vendor")

/obj/structure/machinery/cm_vending/clothing/super_snowflake/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_ADD_ITEMS_TO_VENDOR])
		var/obj/structure/machinery/cm_vending/clothing/super_snowflake/vendor = locate(href_list["add_items_to_vendor"])
		if(!istype(vendor))
			return
		vendor.add_items_to_vendor()

/obj/structure/machinery/cm_vending/clothing/super_snowflake/proc/add_items_to_vendor()
	if(!check_rights(R_MOD))
		to_chat(usr, SPAN_WARNING("此选项不适合你。"))
		return

	var/obj/item/chosen = get_item_category_from_user()
	if(!chosen)
		return
	add_items(chosen)

	log_admin("[key_name(usr)] added an item [chosen] to [src].")
	msg_admin_niche("[key_name(usr)] added an item [chosen] to [src].")

//Vendor types

/obj/structure/machinery/cm_vending/clothing/super_snowflake/accessory
	name = "\improper 超级雪花供应商，配件"
	item_types = list(/obj/item/clothing/accessory)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/ammo
	name = "\improper 超级雪花供应商，弹药"
	item_types = list(/obj/item/ammo_magazine)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/backpack
	name = "\improper 超级雪花供应商，背包"
	item_types = list(/obj/item/storage/backpack)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/belt
	name = "\improper 超级雪花供应商，腰带"
	item_types = list(/obj/item/storage/belt)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/glasses
	name = "\improper 超级雪花供应商，眼镜"
	item_types = list(/obj/item/clothing/glasses)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/gloves
	name = "\improper 超级雪花供应商，手套"
	item_types = list(/obj/item/clothing/gloves)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/helmet
	name = "\improper 超级雪花供应商，头盔"
	item_types = list(/obj/item/clothing/head)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/mask
	name = "\improper 超级雪花供应商，面具"
	item_types = list(/obj/item/clothing/mask)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/pouch
	name = "\improper 超级雪花供应商，小袋"
	item_types = list(/obj/item/storage/pouch)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/shoes
	name = "\improper 超级雪花供应商，鞋子"
	item_types = list(/obj/item/clothing/shoes)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/suit
	name = "\improper 超级雪花供应商，套装"
	item_types = list(/obj/item/clothing/suit)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/uniform
	name = "\improper 超级雪花供应商，制服"
	item_types = list(/obj/item/clothing/under)

/obj/structure/machinery/cm_vending/clothing/super_snowflake/weapon
	name = "\improper 超级雪花供应商，武器"
	item_types = list(/obj/item/weapon)
