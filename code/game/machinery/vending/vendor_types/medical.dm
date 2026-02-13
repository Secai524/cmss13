//------------SUPPLY LINK FOR MEDICAL VENDORS------------

/obj/structure/medical_supply_link
	name = "医疗链路补给端口"
	desc = "一个由管道和机械组成的复杂网络，连接着甲板下的大型存储系统。连接到此端口的医疗供应商将能无限补充物资。"
	icon = 'icons/effects/warning_stripes.dmi'
	icon_state = "medlink_unclamped"
	var/base_state = "medlink"
	plane = FLOOR_PLANE
	layer = ABOVE_TURF_LAYER //It's the floor, man

	anchored = TRUE
	density = FALSE
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/medical_supply_link/ex_act(severity, direction)
	return FALSE

/obj/structure/medical_supply_link/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_STRUCTURE_WRENCHED, PROC_REF(do_clamp_animation))
	RegisterSignal(src, COMSIG_STRUCTURE_UNWRENCHED, PROC_REF(do_unclamp_animation))
	update_icon()

/// Performs the clamping animation when a structure is anchored in our loc
/obj/structure/medical_supply_link/proc/do_clamp_animation()
	SIGNAL_HANDLER
	flick("[base_state]_clamping", src)
	addtimer(CALLBACK(src, PROC_REF(update_icon), 2.6 SECONDS))
	update_icon()

/// Performs the unclamping animation when a structure is unanchored in our loc
/obj/structure/medical_supply_link/proc/do_unclamp_animation()
	SIGNAL_HANDLER
	flick("[base_state]_unclamping", src)
	addtimer(CALLBACK(src, PROC_REF(update_icon), 2.6 SECONDS))
	update_icon()

/obj/structure/medical_supply_link/update_icon()
	var/obj/structure/machinery/cm_vending/sorted/medical/vendor = locate() in loc
	if(vendor && vendor.anchored)
		icon_state = "[base_state]_clamped"
	else
		icon_state = "[base_state]_unclamped"

/obj/structure/medical_supply_link/green
	icon_state = "medlink_green_unclamped"
	base_state = "medlink_green"


//------------RESTOCK CARTS FOR MEDICAL VENDORS------------

/obj/structure/restock_cart
	name = "补货推车"
	desc = "一辆相当沉重的推车，装满了用于给供应商补货的各种物资。"
	icon = 'icons/obj/structures/restock_carts.dmi'
	icon_state = "medcart"

	density = TRUE
	anchored = FALSE
	drag_delay = 2
	health = 100 // Can be destroyed in 2-4 slashes.
	unslashable = FALSE

	///The quantity of things this can restock
	var/supplies_remaining = 20
	///The max quantity of things this can restock
	var/supplies_max = 20
	///The descriptor for the kind of things being restocked
	var/supply_descriptor = "supplies"
	///The sound to play when attacked
	var/attacked_sound = 'sound/effects/metalhit.ogg'
	///The sound to play when destroyed
	var/destroyed_sound = 'sound/effects/metalhit.ogg'
	///Random loot to spawn if destroyed as assoc list of type_path = max_quantity
	var/list/destroyed_loot = list(
		/obj/item/stack/sheet/metal = 2
	)

/obj/structure/restock_cart/medical
	name = "\improper 维兰德-汤谷补货推车"
	desc = "一辆相当沉重的推车，装满了用于给供应商补货的各种物资。由维兰德-汤谷制药部门提供。"
	icon_state = "medcart"

	supplies_remaining = 20
	supplies_max = 20
	supply_descriptor = "sets of medical supplies"
	destroyed_loot = list(
		/obj/item/stack/medical/advanced/ointment = 3,
		/obj/item/stack/medical/advanced/bruise_pack = 2,
		/obj/item/stack/medical/ointment = 3,
		/obj/item/stack/medical/bruise_pack = 2,
		/obj/item/stack/medical/splint = 2,
		/obj/item/device/healthanalyzer = 1,
	)

/obj/structure/restock_cart/medical/reagent
	name = "\improper 维兰德-汤谷试剂补给车"
	desc = "一辆相当沉重的推车，装满了用于给供应商补货的各种试剂。由维兰德-汤谷制药部门提供。"
	icon_state = "reagentcart" // Temporary

	supplies_remaining = 1200
	supplies_max = 1200
	supply_descriptor = "units of medical reagents"
	destroyed_sound = 'sound/effects/slosh.ogg'
	destroyed_loot = list()

/obj/structure/restock_cart/Initialize(mapload, ...)
	. = ..()
	supplies_remaining = min(supplies_remaining, supplies_max)
	update_icon()

/obj/structure/restock_cart/update_icon()
	overlays.Cut()
	. = ..()
	if(supplies_remaining && supplies_max)
		var/image/filled
		var/percent = floor((supplies_remaining / supplies_max * 100))
		switch(percent)
			if(1 to 25)
				filled = image(icon, src, "[icon_state]_1")
			if(26 to 50)
				filled = image(icon, src, "[icon_state]_2")
			if(51 to 75)
				filled = image(icon, src, "[icon_state]_3")
			if(76 to INFINITY)
				filled = image(icon, src, "[icon_state]_4")
			else
				return

		overlays += filled

/obj/structure/restock_cart/get_examine_text(mob/user)
	. = ..()
	if(get_dist(user, src) > 2 && user != loc)
		return
	. += SPAN_NOTICE("It contains:")
	if(supplies_remaining)
		. += SPAN_NOTICE(" [supplies_remaining] [supply_descriptor].")
	else
		. += SPAN_NOTICE(" Nothing.")

/obj/structure/restock_cart/deconstruct(disassembled)
	if(!disassembled)
		playsound(loc, destroyed_sound, 35, 1)
		visible_message(SPAN_NOTICE("[src]散架了，里面的东西洒得到处都是！"))

	// Assumption: supplies_max is > 0
	if(supplies_remaining > 0 && length(destroyed_loot))
		var/spawned_any = FALSE
		var/probability = (supplies_remaining / supplies_max) * 100
		for(var/type_path in destroyed_loot)
			if(prob(probability))
				for(var/amount in 1 to rand(1, destroyed_loot[type_path]))
					new type_path(loc)
					spawned_any = TRUE
		if(!spawned_any) // It wasn't empty so atleast drop something
			var/type_path = pick(destroyed_loot)
			for(var/amount in 1 to rand(1, destroyed_loot[type_path]))
				new type_path(loc)

	return ..()

/obj/structure/restock_cart/attackby(obj/item/W, mob/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		if(user.action_busy)
			return
		playsound(src, 'sound/items/Ratchet.ogg', 25, 1)
		user.visible_message(SPAN_NOTICE("[user]开始拆解[src]。"),
		SPAN_NOTICE("You start deconstructing [src]."))
		if(!do_after(user, 5 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
			return
		user.visible_message(SPAN_NOTICE("[user]拆解了[src]。"),
		SPAN_NOTICE("你拆除了[src]。"))
		playsound(src, 'sound/items/Crowbar.ogg', 25, 1)
		new /obj/item/stack/sheet/metal(loc)
		if(supplies_remaining)
			msg_admin_niche("[key_name(user)] deconstructed [src] with [supplies_remaining] [supply_descriptor] remaining in [get_area(src)] [ADMIN_JMP(loc)]", loc.x, loc.y, loc.z)
		deconstruct(TRUE)
		return

	return ..()

/obj/structure/restock_cart/proc/healthcheck(mob/user)
	if(health <= 0)
		if(supplies_remaining && ishuman(user))
			msg_admin_niche("[key_name(user)] destroyed [src] with [supplies_remaining] [supply_descriptor] remaining in [get_area(src)] [ADMIN_JMP(loc)]", loc.x, loc.y, loc.z)
		deconstruct(FALSE)

/obj/structure/restock_cart/bullet_act(obj/projectile/Proj)
	health -= Proj.damage
	playsound(src, attacked_sound, 25, 1)
	healthcheck(Proj.firer)
	return TRUE

/obj/structure/restock_cart/attack_alien(mob/living/carbon/xenomorph/user)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	user.animation_attack_on(src)
	health -= (rand(user.melee_damage_lower, user.melee_damage_upper))
	playsound(src, attacked_sound, 25, 1)
	user.visible_message(SPAN_DANGER("[user]劈砍[src]！"),
	SPAN_DANGER("You slash [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	healthcheck(user)
	return XENO_ATTACK_ACTION

/obj/structure/restock_cart/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, attacked_sound, 25, 1)
	health -= xeno.melee_damage_upper
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	healthcheck(xeno)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/restock_cart/ex_act(severity)
	if(explo_proof)
		return

	switch(severity)
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if(prob(5))
				deconstruct(FALSE)
				return
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
				return
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)
			return

//------------SORTED MEDICAL VENDORS------------

/obj/structure/machinery/cm_vending/sorted/medical
	name = "\improper 韦氏增强型医疗包"
	desc = "医疗药品分发机。由维兰德-汤谷制药部门提供。"
	icon_state = "med"
	req_access = list(ACCESS_MARINE_MEDBAY)

	unacidable = TRUE
	unslashable = FALSE
	wrenchable = TRUE
	hackable = TRUE

	vendor_theme = VENDOR_THEME_COMPANY
	vend_delay = 0.5 SECONDS

	/// Whether the vendor can use a medlink to be able to resupply automatically
	var/allow_supply_link_restock = TRUE

	/// Whether this vendor supports health scanning the user via mouse drop
	var/healthscan = TRUE
	var/datum/health_scan/last_health_display

	/// The starting volume of the chem refill tank
	var/chem_refill_volume = 600
	/// The maximum volume of the chem refill tank
	var/chem_refill_volume_max = 600
	/// A list of item types that allow reagent refilling
	var/list/chem_refill = list(
		/obj/item/reagent_container/hypospray/autoinjector/bicaridine,
		/obj/item/reagent_container/hypospray/autoinjector/dexalinp,
		/obj/item/reagent_container/hypospray/autoinjector/antitoxin,
		/obj/item/reagent_container/hypospray/autoinjector/adrenaline,
		/obj/item/reagent_container/hypospray/autoinjector/inaprovaline,
		/obj/item/reagent_container/hypospray/autoinjector/kelotane,
		/obj/item/reagent_container/hypospray/autoinjector/oxycodone,
		/obj/item/reagent_container/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_container/hypospray/autoinjector/tramadol,
		/obj/item/reagent_container/hypospray/autoinjector/tricord,

		/obj/item/reagent_container/hypospray/autoinjector/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol,

		/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/antitoxin/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/tricord/skillless,

		/obj/item/reagent_container/hypospray/tricordrazine,

		/obj/item/reagent_container/glass/bottle/bicaridine,
		/obj/item/reagent_container/glass/bottle/antitoxin,
		/obj/item/reagent_container/glass/bottle/dexalin,
		/obj/item/reagent_container/glass/bottle/inaprovaline,
		/obj/item/reagent_container/glass/bottle/kelotane,
		/obj/item/reagent_container/glass/bottle/oxycodone,
		/obj/item/reagent_container/glass/bottle/peridaxon,
		/obj/item/reagent_container/glass/bottle/tramadol,
	)

/obj/structure/machinery/cm_vending/sorted/medical/Destroy()
	STOP_PROCESSING(SSslowobj, src)
	QDEL_NULL(last_health_display)
	. = ..()

/obj/structure/machinery/cm_vending/sorted/medical/get_examine_text(mob/living/carbon/human/user)
	. = ..()
	if(inoperable())
		return .
	if(healthscan)
		. += SPAN_NOTICE("[src] offers assisted medical scans, for ease of use with minimal training. Present the target in front of the scanner to scan.")
	if(allow_supply_link_restock && get_supply_link())
		. += SPAN_NOTICE("A supply link is connected.")

/obj/structure/machinery/cm_vending/sorted/medical/ui_data(mob/user)
	. = ..()
	if(LAZYLEN(chem_refill))
		.["reagents"] = chem_refill_volume
		.["reagents_max"] = chem_refill_volume_max

/// checks if there is a supply link in our location and we are anchored to it
/obj/structure/machinery/cm_vending/sorted/medical/proc/get_supply_link()
	if(!anchored)
		return FALSE
	var/obj/structure/medical_supply_link/linkpoint = locate() in loc
	if(!linkpoint)
		return FALSE
	return TRUE

/obj/structure/machinery/cm_vending/sorted/medical/additional_restock_checks(obj/item/item_to_stock, mob/user, list/vendspec)
	var/dynamic_metadata = dynamic_stock_multipliers[vendspec]
	if(dynamic_metadata)
		if(vendspec[2] >= dynamic_metadata[2] && (!allow_supply_link_restock || !get_supply_link()))
			if(!istype(item_to_stock, /obj/item/stack))
				to_chat(user, SPAN_WARNING("[src]的[vendspec[1]]已经满了！"))
				return FALSE
			var/obj/item/stack/item_stack = item_to_stock
			if(partial_product_stacks[item_to_stock.type] == 0)
				to_chat(user, SPAN_WARNING("[src]的[vendspec[1]]已经满了！"))
				return FALSE // No partial stack to fill
			if((partial_product_stacks[item_to_stock.type] + item_stack.amount) > item_stack.max_amount)
				to_chat(user, SPAN_WARNING("[src]的[vendspec[1]]已经满了！"))
				return FALSE // Exceeds partial stack to fill
	else
		stack_trace("[src] could not find dynamic_stock_multipliers for [vendspec[1]]!")

	if(istype(item_to_stock, /obj/item/reagent_container))
		if(istype(item_to_stock, /obj/item/reagent_container/syringe) || istype(item_to_stock, /obj/item/reagent_container/dropper))
			var/obj/item/reagent_container/container = item_to_stock
			if(container.reagents.total_volume != 0)
				to_chat(user, SPAN_WARNING("[item_to_stock]必须是空的才能补货！"))
				return FALSE
		else
			return try_deduct_chem(item_to_stock, user)

	return TRUE

/// Attempts to consume our reagents needed for the container (doesn't actually change the container)
/// Will return TRUE if reagents were deducted or no reagents were needed
/obj/structure/machinery/cm_vending/sorted/medical/proc/try_deduct_chem(obj/item/reagent_container/container, mob/user)
	var/missing_reagents = container.reagents.maximum_volume - container.reagents.total_volume
	if(missing_reagents <= 0)
		return TRUE
	if(!LAZYLEN(chem_refill) || !(container.type in chem_refill))
		to_chat(user, SPAN_WARNING("[src]无法补充[container]。"))
		return FALSE
	if(chem_refill_volume < missing_reagents)
		var/auto_refill = allow_supply_link_restock && get_supply_link()
		to_chat(user, SPAN_WARNING("[src]闪烁红光并发出嗡嗡声，拒绝了[container]。看起来它的试剂不足[auto_refill ? "yet" : "left"]."))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 15, TRUE)
		return FALSE

	chem_refill_volume -= missing_reagents
	to_chat(user, SPAN_NOTICE("[src]发出呼呼声，补充了你的[container.name]。"))
	playsound(src, 'sound/effects/refill.ogg', 10, 1, 3)
	return TRUE

/// Performs automatic restocking via medical cart - will set being_restocked true during the action
/obj/structure/machinery/cm_vending/sorted/medical/proc/cart_restock(obj/structure/restock_cart/medical/cart, mob/user)
	if(cart.supplies_remaining <= 0)
		to_chat(user, SPAN_WARNING("[cart]是空的！"))
		return
	if(being_restocked)
		to_chat(user, SPAN_WARNING("[src]已在补货中，你会妨碍工作！"))
		return

	var/restocking_reagents = istype(cart, /obj/structure/restock_cart/medical/reagent)
	if(restocking_reagents && !LAZYLEN(chem_refill))
		to_chat(user, SPAN_WARNING("[src]不使用[cart.supply_descriptor]！"))
		return

	user.visible_message(SPAN_NOTICE("[user]开始将[cart.supply_descriptor]物资装入[src]。"),
	SPAN_NOTICE("You start stocking [cart.supply_descriptor] into [src]."))
	being_restocked = TRUE

	while(cart.supplies_remaining > 0)
		if(!do_after(user, 1 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC, src))
			being_restocked = FALSE
			user.visible_message(SPAN_NOTICE("[user]停止了向[src]装入[cart.supply_descriptor]。"),
			SPAN_NOTICE("You stop stocking [src] with [cart.supply_descriptor]."))
			return
		if(QDELETED(cart) || get_dist(user, cart) > 1)
			being_restocked = FALSE
			user.visible_message(SPAN_NOTICE("[user]停止了向[src]装入[cart.supply_descriptor]。"),
			SPAN_NOTICE("You stop stocking [src] with [cart.supply_descriptor]."))
			return

		if(restocking_reagents)
			var/reagent_added = restock_reagents(min(cart.supplies_remaining, 100))
			if(reagent_added <= 0 || chem_refill_volume == chem_refill_volume_max)
				break // All done
			cart.supplies_remaining -= reagent_added
		else
			if(!restock_supplies(prob_to_skip = 0, can_remove = FALSE))
				break // All done
			cart.supplies_remaining--

		cart.update_icon()

	being_restocked = FALSE
	cart.update_icon()
	user.visible_message(SPAN_NOTICE("[user]完成了向[src]装入[cart.supply_descriptor]。"),
	SPAN_NOTICE("You finish stocking [src] with [cart.supply_descriptor]."))

/obj/structure/machinery/cm_vending/sorted/medical/attackby(obj/item/I, mob/user)
	if(stat != WORKING)
		return ..()

	if(istype(I, /obj/item/reagent_container))
		if(!hacked)
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("权限被拒绝。"))
				return

			if(LAZYLEN(vendor_role) && !vendor_role.Find(user.job))
				to_chat(user, SPAN_WARNING("这台机器不是给你用的。"))
				return

		var/obj/item/reagent_container/container = I
		if(istype(I, /obj/item/reagent_container/syringe) || istype(I, /obj/item/reagent_container/dropper))
			if(!stock(container, user))
				return ..()
			return

		if(container.reagents.total_volume == container.reagents.maximum_volume)
			if(!stock(container, user))
				return ..()
			return

		if(!try_deduct_chem(container, user))
			return ..()

		// Since the reagent is deleted on use it's easier to make a new one instead of snowflake checking
		var/obj/item/reagent_container/new_container = new container.type(src)
		// Preserve transfer amount from the original container
		if(istype(container, /obj/item/reagent_container) && istype(new_container, /obj/item/reagent_container))
			new_container.amount_per_transfer_from_this = container.amount_per_transfer_from_this
		qdel(container)
		user.put_in_hands(new_container)
		return

	if(ishuman(user) && istype(I, /obj/item/grab))
		var/obj/item/grab/grabbed = I
		if(istype(grabbed.grabbed_thing, /obj/structure/restock_cart/medical))
			cart_restock(grabbed.grabbed_thing, user)
			return

	if(hacked || (allowed(user) && (!LAZYLEN(vendor_role) || vendor_role.Find(user.job))))
		if(stock(I, user))
			return

	return ..()

/obj/structure/machinery/cm_vending/sorted/medical/MouseDrop(obj/over_object as obj)
	if(stat == WORKING && over_object == usr && CAN_PICKUP(usr, src))
		var/mob/living/carbon/human/user = usr
		if(!hacked && !allowed(user))
			to_chat(user, SPAN_WARNING("权限被拒绝。"))
			return

		if(!healthscan)
			to_chat(user, SPAN_WARNING("[src]不具备健康扫描功能。"))
			return

		if (!last_health_display)
			last_health_display = new(user)
		else
			last_health_display.target_mob = user

		last_health_display.look_at(user, DETAIL_LEVEL_HEALTHANALYSER, bypass_checks = TRUE)
		return

/obj/structure/machinery/cm_vending/sorted/medical/MouseDrop_T(atom/movable/A, mob/user)
	if(inoperable())
		return
	if(user.stat || user.is_mob_restrained())
		return
	if(get_dist(user, src) > 1 || get_dist(user, A) > 1) // More lenient
		return
	if(!ishuman(user))
		return

	if(istype(A, /obj/structure/restock_cart/medical))
		cart_restock(A, user)
		return

	return ..()

/obj/structure/machinery/cm_vending/sorted/medical/populate_product_list(scale)
	listed_products = list(
		list("FIELD S联合人民阵线LIES", -1, null, null),
		list("烧伤急救包", floor(scale * 10), /obj/item/stack/medical/advanced/ointment, VENDOR_ITEM_REGULAR),
		list("创伤急救包", floor(scale * 10), /obj/item/stack/medical/advanced/bruise_pack, VENDOR_ITEM_REGULAR),
		list("药膏", floor(scale * 10), /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("纱布卷", floor(scale * 10), /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("夹板", floor(scale * 10), /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),

		list("自动注射器", -1, null, null),
		list("自动注射器（比卡瑞丁）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/bicaridine, VENDOR_ITEM_REGULAR),
		list("自动注射器（地塞林+）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/dexalinp, VENDOR_ITEM_REGULAR),
		list("自动注射器（迪洛芬）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/antitoxin, VENDOR_ITEM_REGULAR),
		list("自动注射器（肾上腺素）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/adrenaline, VENDOR_ITEM_REGULAR),
		list("自动注射器（伊纳普洛林）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/inaprovaline, VENDOR_ITEM_REGULAR),
		list("自动注射器（凯洛坦）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/kelotane, VENDOR_ITEM_REGULAR),
		list("自动注射器（羟考酮）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/oxycodone, VENDOR_ITEM_REGULAR),
		list("自动注射器（佩里达松）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/peridaxon, VENDOR_ITEM_REGULAR),
		list("自动注射器（曲马多）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/tramadol, VENDOR_ITEM_REGULAR),
		list("自动注射器（三氯拉嗪）", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/tricord, VENDOR_ITEM_REGULAR),

		list("液体瓶", -1, null, null),
		list("瓶子（比卡雷丁）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/bicaridine, VENDOR_ITEM_REGULAR),
		list("瓶子（地洛文）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/antitoxin, VENDOR_ITEM_REGULAR),
		list("瓶装（德克萨林）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/dexalin, VENDOR_ITEM_REGULAR),
		list("瓶子（伊纳普洛林）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/inaprovaline, VENDOR_ITEM_REGULAR),
		list("瓶子（凯洛坦）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/kelotane, VENDOR_ITEM_REGULAR),
		list("药瓶（羟考酮）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/oxycodone, VENDOR_ITEM_REGULAR),
		list("瓶子（佩里达克松）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/peridaxon, VENDOR_ITEM_REGULAR),
		list("药瓶（曲马多）", floor(scale * 3), /obj/item/reagent_container/glass/bottle/tramadol, VENDOR_ITEM_REGULAR),

		list("药瓶", -1, null, null),
		list("药瓶（比卡里丁）", floor(scale * 4), /obj/item/storage/pill_bottle/bicaridine, VENDOR_ITEM_REGULAR),
		list("药瓶（地塞林）", floor(scale * 4), /obj/item/storage/pill_bottle/dexalin, VENDOR_ITEM_REGULAR),
		list("药瓶（地洛芬）", floor(scale * 4), /obj/item/storage/pill_bottle/antitox, VENDOR_ITEM_REGULAR),
		list("药瓶（伊那普洛林）", floor(scale * 4), /obj/item/storage/pill_bottle/inaprovaline, VENDOR_ITEM_REGULAR),
		list("药瓶（凯洛坦）", floor(scale * 4), /obj/item/storage/pill_bottle/kelotane, VENDOR_ITEM_REGULAR),
		list("药瓶（羟考酮）", floor(scale * 3), /obj/item/storage/pill_bottle/oxycodone, VENDOR_ITEM_REGULAR),
		list("药瓶（佩里达松）", floor(scale * 3), /obj/item/storage/pill_bottle/peridaxon, VENDOR_ITEM_REGULAR),
		list("药瓶（曲马多）", floor(scale * 4), /obj/item/storage/pill_bottle/tramadol, VENDOR_ITEM_REGULAR),

		list("医疗设施", -1, null, null),
		list("紧急除颤器", floor(scale * 3), /obj/item/device/defibrillator, VENDOR_ITEM_REGULAR),
		list("手术线", floor(scale * 2), /obj/item/tool/surgery/surgical_line, VENDOR_ITEM_REGULAR),
		list("合成移植", floor(scale * 2), /obj/item/tool/surgery/synthgraft, VENDOR_ITEM_REGULAR),
		list("皮下注射器", floor(scale * 3), /obj/item/reagent_container/hypospray/tricordrazine, VENDOR_ITEM_REGULAR),
		list("健康分析仪", floor(scale * 5), /obj/item/device/healthanalyzer, VENDOR_ITEM_REGULAR),
		list("M276 型医疗存储装备", floor(scale * 2), /obj/item/storage/belt/medical, VENDOR_ITEM_REGULAR),
		list("医疗HUD眼镜", floor(scale * 3), /obj/item/clothing/glasses/hud/health, VENDOR_ITEM_REGULAR),
		list("停滞袋", floor(scale * 3), /obj/item/bodybag/cryobag, VENDOR_ITEM_REGULAR),
		list("注射器", floor(scale * 7), /obj/item/reagent_container/syringe, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/medical/populate_product_list_and_boxes(scale)
	. = ..()

	// If this is groundside and isn't dynamically changing we will spawn with stock randomly removed from it
	if(vend_flags & VEND_STOCK_DYNAMIC)
		return
	if(Check_WO())
		return
	var/turf/location = get_turf(src)
	if(location && is_ground_level(location.z))
		random_unstock()

/obj/structure/machinery/cm_vending/sorted/medical/Initialize()
	. = ..()

	AddElement(/datum/element/corp_label/wy)
	// If this is a medlinked vendor (that needs a link) and isn't dynamically changing it will periodically restock itself
	if(vend_flags & VEND_STOCK_DYNAMIC)
		return
	if(!allow_supply_link_restock)
		return
	if(!get_supply_link())
		return
	START_PROCESSING(SSslowobj, src)

/obj/structure/machinery/cm_vending/sorted/medical/toggle_anchored(obj/item/W, mob/user)
	. = ..()

	// If the anchor state changed, this is a vendor that needs a link, and isn't dynamically changing, update whether we automatically restock
	if(. && !(vend_flags & VEND_STOCK_DYNAMIC) && allow_supply_link_restock)
		if(get_supply_link())
			START_PROCESSING(SSslowobj, src)
		else
			STOP_PROCESSING(SSslowobj, src)

/obj/structure/machinery/cm_vending/sorted/medical/process()
	if(!get_supply_link())
		STOP_PROCESSING(SSslowobj, src)
		return // Somehow we lost our link
	if(inoperable())
		return
	if(world.time - SSticker.mode.round_time_lobby > 20 MINUTES)
		restock_supplies()
	restock_reagents()

/// Randomly (based on prob_to_skip) adjusts all amounts of listed_products towards their desired values by 1
/// Returns the quantity of items added
/obj/structure/machinery/cm_vending/sorted/medical/proc/restock_supplies(prob_to_skip = 80, can_remove = TRUE)
	. = 0
	for(var/list/vendspec as anything in listed_products)
		if(vendspec[2] < 0)
			continue // It's a section title, not an actual entry
		var/dynamic_metadata = dynamic_stock_multipliers[vendspec]
		if(!dynamic_metadata)
			stack_trace("[src] could not find dynamic_stock_multipliers for [vendspec[1]]!")
			continue
		var/cur_type = vendspec[3]
		if(vendspec[2] == dynamic_metadata[2])
			if((cur_type in partial_product_stacks) && partial_product_stacks[cur_type] > 0)
				partial_product_stacks[cur_type] = 0
				.++
			continue // Already at desired value
		if(vendspec[2] > dynamic_metadata[2])
			if(can_remove)
				vendspec[2]--
				if(cur_type in partial_product_stacks)
					partial_product_stacks[cur_type] = 0
				if(vend_flags & VEND_LOAD_AMMO_BOXES)
					update_derived_ammo_and_boxes(vendspec)
			continue // Returned some items to the void
		if(prob(prob_to_skip))
			continue // 20% chance to restock per entry by default
		vendspec[2]++
		if(vend_flags & VEND_LOAD_AMMO_BOXES)
			update_derived_ammo_and_boxes_on_add(vendspec)
		.++

/// Refills reagents towards chem_refill_volume_max
/// Returns the quantity of reagents added
/obj/structure/machinery/cm_vending/sorted/medical/proc/restock_reagents(additional_volume = 125)
	var/old_value = chem_refill_volume
	chem_refill_volume = min(chem_refill_volume + additional_volume, chem_refill_volume_max)
	return chem_refill_volume - old_value

/// Randomly removes amounts of listed_products and reagents
/obj/structure/machinery/cm_vending/sorted/medical/proc/random_unstock()
	// Random interval of 25 for reagents
	chem_refill_volume = rand(0, chem_refill_volume_max * 0.04) * 25

	for(var/list/vendspec as anything in listed_products)
		var/amount = vendspec[2]
		if(amount <= 0)
			continue

		// Chance to just be empty
		if(prob(25))
			vendspec[2] = 0
			continue

		// Otherwise its some amount between 1 and the original amount
		vendspec[2] = rand(1, amount)

/obj/structure/machinery/cm_vending/sorted/medical/chemistry
	name = "\improper 威化增强版"
	desc = "医疗化学制剂分发机。由维兰德-汤谷制药部门提供。"
	icon_state = "chem"
	req_access = list(ACCESS_MARINE_CHEMISTRY)
	healthscan = FALSE

	chem_refill_volume = 1200
	chem_refill_volume_max = 1200
	chem_refill = list(
		/obj/item/reagent_container/glass/bottle/bicaridine,
		/obj/item/reagent_container/glass/bottle/antitoxin,
		/obj/item/reagent_container/glass/bottle/dexalin,
		/obj/item/reagent_container/glass/bottle/inaprovaline,
		/obj/item/reagent_container/glass/bottle/kelotane,
		/obj/item/reagent_container/glass/bottle/oxycodone,
		/obj/item/reagent_container/glass/bottle/peridaxon,
		/obj/item/reagent_container/glass/bottle/tramadol,
	)

/obj/structure/machinery/cm_vending/sorted/medical/chemistry/populate_product_list(scale)
	listed_products = list(
		list("液体瓶", -1, null, null),
		list("比卡利丁药瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/bicaridine, VENDOR_ITEM_REGULAR),
		list("迪洛芬瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/antitoxin, VENDOR_ITEM_REGULAR),
		list("德萨林瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/dexalin, VENDOR_ITEM_REGULAR),
		list("伊纳普洛林瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/inaprovaline, VENDOR_ITEM_REGULAR),
		list("凯洛坦瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/kelotane, VENDOR_ITEM_REGULAR),
		list("羟考酮药瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/oxycodone, VENDOR_ITEM_REGULAR),
		list("佩里达克松药瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/peridaxon, VENDOR_ITEM_REGULAR),
		list("曲马多药瓶", floor(scale * 6), /obj/item/reagent_container/glass/bottle/tramadol, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("烧杯（60单位）", floor(scale * 3), /obj/item/reagent_container/glass/beaker, VENDOR_ITEM_REGULAR),
		list("烧杯，大型（120单位）", floor(scale * 3), /obj/item/reagent_container/glass/beaker/large, VENDOR_ITEM_REGULAR),
		list("药瓶盒", floor(scale * 2), /obj/item/storage/box/pillbottles, VENDOR_ITEM_REGULAR),
		list("滴管", floor(scale * 3), /obj/item/reagent_container/dropper, VENDOR_ITEM_REGULAR),
		list("注射器", floor(scale * 7), /obj/item/reagent_container/syringe, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/medical/no_access
	req_access = list()

/obj/structure/machinery/cm_vending/sorted/medical/bolted
	wrenchable = FALSE

/obj/structure/machinery/cm_vending/sorted/medical/chemistry/no_access
	req_access = list()

/obj/structure/machinery/cm_vending/sorted/medical/antag
	name = "\improper 医疗设备供应商"
	desc = "一台分发各种医疗设备的自动售货机。"
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null
	vendor_theme = VENDOR_THEME_CLF
	allow_supply_link_restock = FALSE

/obj/structure/machinery/cm_vending/sorted/medical/upp
	name = "\improper 医疗设备供应商"
	desc = "一台分发各种医疗设备的自动售货机。"
	req_one_access = list(ACCESS_UPP_GENERAL)
	req_access = null
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/medical/marinemed
	name = "\improper 科马科技（殖民地海军陆战队科技） 海军陆战队员Med"
	desc = "为陆战队员提供基本医疗用品的药品分发器。"
	icon_state = "marinemed"
	req_access = list()
	req_one_access = list()
	vendor_theme = VENDOR_THEME_USCM

	chem_refill = list(
		/obj/item/reagent_container/hypospray/autoinjector/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol,
	)

/obj/structure/machinery/cm_vending/sorted/medical/marinemed/populate_product_list(scale)
	listed_products = list(
		list("自动注射器", -1, null, null),
		list("急救自动注射器", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/skillless, VENDOR_ITEM_REGULAR),
		list("痛止自动注射器", floor(scale * 5), /obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol, VENDOR_ITEM_REGULAR),

		list("设备", -1, null, null),
		list("健康分析仪", floor(scale * 3), /obj/item/device/healthanalyzer, VENDOR_ITEM_REGULAR),

		list("FIELD S联合人民阵线LIES", -1, null, null),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("药膏", floor(scale * 8), /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("纱布卷", floor(scale * 8), /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("夹板", floor(scale * 8), /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/medical/marinemed/antag
	name = "\improper 基础医疗物资供应商"
	desc = "一台分发基本医疗用品的自动售货机。"
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null
	vendor_theme = VENDOR_THEME_CLF
	allow_supply_link_restock = FALSE

/obj/structure/machinery/cm_vending/sorted/medical/marinemed/upp
	name = "\improper 基础医疗物资供应商"
	desc = "一台分发基本医疗用品的自动售货机。"
	req_one_access = list(ACCESS_UPP_GENERAL)
	req_access = null
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/medical/blood
	name = "\improper MM 血液分配器"
	desc = "MarineMed品牌血液供应站是2105年顶尖的血液分发器！今天就获取你的！" //Don't update this year, the joke is it's old.
	icon_state = "blood"
	wrenchable = TRUE
	hackable = TRUE
	healthscan = FALSE
	allow_supply_link_restock = TRUE
	chem_refill = null

/obj/structure/machinery/cm_vending/sorted/medical/blood/bolted
	wrenchable = FALSE

/obj/structure/machinery/cm_vending/sorted/medical/blood/populate_product_list(scale)
	listed_products = list(
		list("血包", -1, null, null),
		list("A+ 血包", floor(scale * 5), /obj/item/reagent_container/blood/APlus, VENDOR_ITEM_REGULAR),
		list("A型阴性血包", floor(scale * 5), /obj/item/reagent_container/blood/AMinus, VENDOR_ITEM_REGULAR),
		list("B+型血包", floor(scale * 5), /obj/item/reagent_container/blood/BPlus, VENDOR_ITEM_REGULAR),
		list("B- 血包", floor(scale * 5), /obj/item/reagent_container/blood/BMinus, VENDOR_ITEM_REGULAR),
		list("O+ 血包", floor(scale * 5), /obj/item/reagent_container/blood/OPlus, VENDOR_ITEM_REGULAR),
		list("O型阴性血包", floor(scale * 5), /obj/item/reagent_container/blood/OMinus, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("空血包", floor(scale * 5), /obj/item/reagent_container/blood, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/medical/blood/antag
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null
	vendor_theme = VENDOR_THEME_CLF
	allow_supply_link_restock = FALSE

/obj/structure/machinery/cm_vending/sorted/medical/blood/upp
	req_one_access = list(ACCESS_UPP_GENERAL)
	req_access = null
	vendor_theme = VENDOR_THEME_UPP


//------------WALL MED VENDORS------------

/obj/structure/machinery/cm_vending/sorted/medical/wall_med
	name = "\improper 纳米医疗"
	desc = "一台壁挂式医疗设备分发器。"
	icon_state = "wallmed"
	appearance_flags = TILE_BOUND
	req_access = list()
	density = FALSE
	wrenchable = FALSE
	vend_delay = 0.7 SECONDS
	allow_supply_link_restock = FALSE

	listed_products = list(
		list("S联合人民阵线LIES", -1, null, null),
		list("急救自动注射器", 2, /obj/item/reagent_container/hypospray/autoinjector/skillless, VENDOR_ITEM_REGULAR),
		list("疼痛抑制自动注射器", 2, /obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol, VENDOR_ITEM_REGULAR),
		list("纱布卷", 4, /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("药膏", 4, /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("医疗夹板", 4, /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),

		list("实用工具", -1, null, null),
		list("HF2 健康分析仪", 2, /obj/item/device/healthanalyzer, VENDOR_ITEM_REGULAR)
	)

	chem_refill_volume = 250
	chem_refill_volume_max = 250
	chem_refill = list(
		/obj/item/reagent_container/hypospray/autoinjector/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol,
		/obj/item/reagent_container/hypospray/autoinjector/tricord/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/antitoxin/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless,
	)

/obj/structure/machinery/cm_vending/sorted/medical/wall_med/limited
	desc = "一台壁挂式医疗设备分发器。此型号比标准USCM纳米医疗机功能更有限。"

	chem_refill_volume = 150
	chem_refill_volume_max = 150
	chem_refill = list(
		/obj/item/reagent_container/hypospray/autoinjector/skillless,
		/obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol,
	)

/obj/structure/machinery/cm_vending/sorted/medical/wall_med/lifeboat
	name = "救生艇医疗柜"
	icon = 'icons/obj/structures/machinery/lifeboat.dmi'
	icon_state = "medcab"
	desc = "一个装有生存必需医疗用品的壁挂式柜子。虽然装备更精良，但只能补充基本物资。"
	unacidable = TRUE
	unslashable = TRUE
	wrenchable = FALSE
	hackable = FALSE

	listed_products = list(
		list("自动注射器", -1, null, null),
		list("急救自动注射器", 8, /obj/item/reagent_container/hypospray/autoinjector/skillless, VENDOR_ITEM_REGULAR),
		list("痛止自动注射器", 8, /obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol, VENDOR_ITEM_REGULAR),

		list("设备", -1, null, null),
		list("健康分析仪", 8, /obj/item/device/healthanalyzer, VENDOR_ITEM_REGULAR),

		list("FIELD S联合人民阵线LIES", -1, null, null),
		list("烧伤急救包", 8, /obj/item/stack/medical/advanced/ointment, VENDOR_ITEM_REGULAR),
		list("创伤急救包", 8, /obj/item/stack/medical/advanced/bruise_pack, VENDOR_ITEM_REGULAR),
		list("药膏", 8, /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("纱布卷", 8, /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("夹板", 8, /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR)
	)

	chem_refill_volume = 500
	chem_refill_volume_max = 500

/obj/structure/machinery/cm_vending/sorted/medical/wall_med/populate_product_list(scale)
	return

/obj/structure/machinery/cm_vending/sorted/medical/wall_med/souto
	name = "\improper 索托汽水Med"
	desc = "在索托兰（商标待批），你离罐装哈瓦那美味绝不会超过6英尺。今天就喝索托！如需索托全系列产品，请访问授权零售商或自动售货机。同时兼作基本急救站。"
	icon = 'icons/obj/structures/souto_land.dmi'
	icon_state = "soutomed"

	listed_products = list(
		list("急救S联合人民阵线LIES", -1, null, null),
		list("急救自动注射器", 2, /obj/item/reagent_container/hypospray/autoinjector/skillless, VENDOR_ITEM_REGULAR),
		list("痛止自动注射器", 2, /obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol, VENDOR_ITEM_REGULAR),
		list("纱布卷", 4, /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("药膏", 4, /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("医疗夹板", 4, /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),

		list("实用工具", -1, null, null),
		list("HF2 健康分析仪", 2, /obj/item/device/healthanalyzer, VENDOR_ITEM_REGULAR),

		list("SOUTO", -1, null, null),
		list("经典索托汽水", 1, /obj/item/reagent_container/food/drinks/cans/souto/classic, VENDOR_ITEM_REGULAR),
		list("经典索托汽水", 1, /obj/item/reagent_container/food/drinks/cans/souto/diet/classic, VENDOR_ITEM_REGULAR),
		list("索托汽水 蔓越莓", 1, /obj/item/reagent_container/food/drinks/cans/souto/cranberry, VENDOR_ITEM_REGULAR),
		list("饮食 索托汽水 蔓越莓", 1, /obj/item/reagent_container/food/drinks/cans/souto/diet/cranberry, VENDOR_ITEM_REGULAR),
		list("索托汽水 葡萄味", 1, /obj/item/reagent_container/food/drinks/cans/souto/grape, VENDOR_ITEM_REGULAR),
		list("饮食 索托汽水 葡萄味", 1, /obj/item/reagent_container/food/drinks/cans/souto/diet/grape, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/medical/wall_med/souto/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/souta)
