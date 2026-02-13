/*
Shotguns always start with an ammo buffer and they work by alternating ammo and ammo_buffer1
in order to fire off projectiles. This is only done to enable burst fire for the shotgun.
Consequently, the shotgun should never fire more than three projectiles on burst as that
can cause issues with ammo types getting mixed up during the burst.
*/

/obj/item/weapon/gun/shotgun
	w_class = SIZE_LARGE
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/shotguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/shotguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/shotguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/shotguns_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/shotgun_mouse.dmi'

	accuracy_mult = 1.15
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG
	gun_category = GUN_CATEGORY_SHOTGUN
	aim_slowdown = SLOWDOWN_ADS_SHOTGUN
	wield_delay = WIELD_DELAY_NORMAL //Shotguns are as hard to pull up as a rifle. They're quite bulky afterall
	has_empty_icon = FALSE
	has_open_icon = FALSE
	fire_delay_group = list(FIRE_DELAY_GROUP_SHOTGUN)

	fire_sound = 'sound/weapons/gun_shotgun.ogg'
	reload_sound = "shell_load"
	cocked_sound = 'sound/weapons/gun_shotgun_reload.ogg'
	var/break_sound = 'sound/weapons/handling/gun_mou_open.ogg'
	var/seal_sound = 'sound/weapons/handling/gun_mou_close.ogg'

	var/gauge = "12g"

/obj/item/weapon/gun/shotgun/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag)
		replace_tube(current_mag.current_rounds) //Populate the chamber.

/obj/item/weapon/gun/shotgun/get_examine_text(mob/user)
	. = ..()
	if(flags_gun_features & GUN_AMMO_COUNTER && user)
		var/chambered = in_chamber ? TRUE : FALSE
		. += "It has [current_mag.current_rounds][chambered ? "+1" : ""] / [current_mag.max_rounds] rounds remaining."

/obj/item/weapon/gun/shotgun/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_BASE)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/shotgun/proc/replace_tube(number_to_replace)
	if(!current_mag)
		return
	current_mag.chamber_contents = list()
	current_mag.chamber_contents.len = current_mag.max_rounds
	var/i
	for(i = 1 to current_mag.max_rounds) //We want to make sure to populate the tube.
		current_mag.chamber_contents[i] = i > number_to_replace ? "empty" : current_mag.default_ammo
	current_mag.chamber_position = current_mag.current_rounds //The position is always in the beginning [1]. It can move from there.

/obj/item/weapon/gun/shotgun/proc/add_to_tube(mob/user,selection) //Shells are added forward.
	if(!current_mag)
		return
	current_mag.chamber_position++ //We move the position up when loading ammo. New rounds are always fired next, in order loaded.
	current_mag.chamber_contents[current_mag.chamber_position] = selection //Just moves up one, unless the mag is full.
	if(current_mag.current_rounds == 1 && !in_chamber) //The previous proc in the reload() cycle adds ammo, so the best workaround here,
		update_icon() //This is not needed for now. Maybe we'll have loaded sprites at some point, but I doubt it. Also doesn't play well with double barrel.
		ready_in_chamber()
		cock_gun(user)
	if(user)
		playsound(user, reload_sound, 25, TRUE)
		if(flags_gun_features & GUN_AMMO_COUNTER)
			var/chambered = in_chamber ? TRUE : FALSE
			to_chat(user, SPAN_DANGER("[current_mag.current_rounds][chambered ? "+1" : ""] / [current_mag.max_rounds] ROUNDS REMAINING."))
	return TRUE

/obj/item/weapon/gun/shotgun/proc/empty_chamber(mob/user, silent = FALSE, only_chamber = FALSE)
	if(!current_mag)
		return
	if(only_chamber || current_mag.current_rounds <= 0)
		if(in_chamber)
			in_chamber = null
			var/obj/item/ammo_magazine/handful/new_handful = retrieve_shell(ammo.type)
			playsound(user, reload_sound, 25, TRUE)
			new_handful.forceMove(get_turf(src))
			if(flags_gun_features & GUN_AMMO_COUNTER && user)
				var/chambered = in_chamber ? TRUE : FALSE //useless, but for consistency
				if(!silent)
					to_chat(user, SPAN_DANGER("[current_mag.current_rounds][chambered ? "+1" : ""] / [current_mag.max_rounds] ROUNDS REMAINING."))
		else
			if(user && !silent)
				to_chat(user, SPAN_WARNING("[src]已经是空的。"))
		return

	unload_shell(user)
	if(!current_mag.current_rounds && !in_chamber)
		update_icon()

/obj/item/weapon/gun/shotgun/proc/unload_shell(mob/user)
	if(isnull(current_mag) || !length(current_mag.chamber_contents))
		return
	var/obj/item/ammo_magazine/handful/new_handful = retrieve_shell(current_mag.chamber_contents[current_mag.chamber_position])

	if(user)
		user.put_in_hands(new_handful)
		playsound(user, reload_sound, 25, 1)
	else
		new_handful.forceMove(get_turf(src))

	current_mag.current_rounds--
	current_mag.chamber_contents[current_mag.chamber_position] = "empty"
	current_mag.chamber_position--
	return 1

		//While there is a much smaller way to do this,
		//this is the most resource efficient way to do it.
/obj/item/weapon/gun/shotgun/proc/retrieve_shell(selection)
	var/datum/ammo/A = GLOB.ammo_list[selection]
	var/obj/item/ammo_magazine/handful/new_handful = new A.handful_type()
	new_handful.generate_handful(selection, gauge, 5, 1, /obj/item/weapon/gun/shotgun)
	return new_handful

/obj/item/weapon/gun/shotgun/proc/check_chamber_position()
	return 1


/obj/item/weapon/gun/shotgun/reload(mob/user, obj/item/ammo_magazine/magazine)
	if(flags_gun_features & GUN_BURST_FIRING)
		return

	if(!magazine || !istype(magazine,/obj/item/ammo_magazine/handful)) //Can only reload with handfuls.
		to_chat(user, SPAN_WARNING("你不能用那个来装填！"))
		return

	if(!check_chamber_position()) //For the double barrel.
		to_chat(user, SPAN_WARNING("[src]必须处于打开状态！"))
		return

	//From here we know they are using shotgun type ammo and reloading via handful.
	//Makes some of this a lot easier to determine.

	var/mag_caliber = magazine.default_ammo //Handfuls can get deleted, so we need to keep this on hand for later.
	if(current_mag.transfer_ammo(magazine,user,1))
		add_to_tube(user,mag_caliber) //This will check the other conditions.

/obj/item/weapon/gun/shotgun/unload(mob/user)
	if(flags_gun_features & GUN_BURST_FIRING)
		return
	empty_chamber(user)

/obj/item/weapon/gun/shotgun/proc/ready_shotgun_tube()
	if(isnull(current_mag) || !length(current_mag.chamber_contents))
		return
	if(current_mag.current_rounds > 0)
		ammo = GLOB.ammo_list[current_mag.chamber_contents[current_mag.chamber_position]]
		in_chamber = create_bullet(ammo, initial(name))
		current_mag.current_rounds--
		current_mag.chamber_contents[current_mag.chamber_position] = "empty"
		current_mag.chamber_position--
		apply_traits(in_chamber)
		return in_chamber


/obj/item/weapon/gun/shotgun/ready_in_chamber()
	return ready_shotgun_tube()

/obj/item/weapon/gun/shotgun/reload_into_chamber(mob/user)
	if(!active_attachable)
		in_chamber = null

		//Time to move the tube position.
		ready_in_chamber() //We're going to try and reload. If we don't get anything, icon change.
		if(!current_mag.current_rounds && !in_chamber) //No rounds, nothing chambered.
			update_icon()

	return 1


//-------------------------------------------------------
//GENERIC MERC SHOTGUN //Not really based on anything.

/obj/item/weapon/gun/shotgun/merc
	name = "定制霰弹枪"
	desc = "一堆胡乱拼凑的废料和异星木材。把枪口对准你想干掉的东西。具备连发功能，好像它真需要似的。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/shotguns.dmi'
	icon_state = "cshotgun"
	item_state = "cshotgun"

	fire_sound = 'sound/weapons/gun_shotgun_automatic.ogg'
	current_mag = /obj/item/ammo_magazine/internal/shotgun/merc
	attachable_allowed = list(
		/obj/item/attachable/compensator,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG

/obj/item/weapon/gun/shotgun/merc/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()


/obj/item/weapon/gun/shotgun/merc/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 21, "under_x" = 17, "under_y" = 14, "stock_x" = 17, "stock_y" = 14)


/obj/item/weapon/gun/shotgun/merc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_COMBAT) // 2 tick nerf, but brings it in line with other combat shotties.
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_11) // Still has its wacky burst fire mode
	accuracy_mult = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_4
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/shotgun/merc/get_examine_text(mob/user)
	. = ..()
	if(in_chamber) . += "It has a chambered round."

/obj/item/weapon/gun/shotgun/merc/damaged
	name = "损坏的定制霰弹枪"
	desc = "一堆胡乱拼凑的废料和异星木材。把枪口对准你想干掉的东西。具备连发功能，好像它真需要似的。好吧，它曾经有，这把的枪管显然像过熟的葡萄一样向外炸开了。看来这就是DIY霰弹枪的下场。"
	icon_state = "cshotgun_bad"

/obj/item/weapon/gun/shotgun/merc/damaged/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_BASE)
	set_burst_amount(BURST_AMOUNT_TIER_1)
	accuracy_mult = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_5
	burst_scatter_mult = SCATTER_AMOUNT_TIER_3
	scatter_unwielded = SCATTER_AMOUNT_TIER_1
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_3
	recoil_unwielded = RECOIL_AMOUNT_TIER_1

//-------------------------------------------------------------
//SHOCKGUN - Non-Lethal Fast firing shotgun
/obj/item/weapon/gun/shotgun/es7
	name = "\improper ES-7 Supernova Electrostatic Shockgun"
	desc = "一种基于旧地球设计的古老静电式20号径霰弹枪，尽管在其时代经过了现代化改造。作为双模式系统，它能够进行半自动和泵动模式射击，不过此特定型号严格限定为仅半自动。它只能使用X21独头弹。"
	desc_lore = "Despite receiving very little upgrades over its service period both within the Weyland Corporation and later the Weyland-Yutani Corporation, it remains popular with mercenaries and security firms because it was designed with security and law enforcement use in mind."
	icon_state = "es7"
	item_state = "es7"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/WY/shotguns.dmi'
	gauge = "20g"
	hud_offset = -5
	pixel_x = -5
	muzzle_flash = "muzzle_energy"
	muzzle_flash_color = COLOR_MUZZLE_BLUE
	flags_equip_slot = SLOT_BACK
	fire_sound = "gun_shockgun"
	firesound_volume = 20
	current_mag = /obj/item/ammo_magazine/internal/shotgun/combat/es7
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/attached_gun/extinguisher,
	)

/obj/item/weapon/gun/shotgun/es7/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/shotgun/es7/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 41, "muzzle_y" = 19, "rail_x" = 17, "rail_y" = 21, "under_x" = 34, "under_y" = 13, "stock_x" = 11, "stock_y" = 13.)

/obj/item/weapon/gun/shotgun/es7/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11*2)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/shotgun/es7/get_examine_text(mob/user)
	. = ..()
	if(in_chamber) . += "It has a chambered round."

/obj/item/weapon/gun/shotgun/es7/tactical
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/verticalgrip)

//-------------------------------------------------------
//TACTICAL SHOTGUN

/obj/item/weapon/gun/shotgun/combat
	name = "\improper MK221 tactical shotgun"
	desc = "维兰德-汤谷MK221霰弹枪，一款射速快的半自动霰弹枪。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/WY/shotguns.dmi'
	icon_state = "mk221"
	item_state = "mk221"

	fire_sound = "gun_shotgun_tactical"
	firesound_volume = 20
	current_mag = /obj/item/ammo_magazine/internal/shotgun
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/tactical,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/tactical)

/obj/item/weapon/gun/shotgun/combat/Initialize(mapload, spawn_empty)
	. = ..()
	AddElement(/datum/element/corp_label/wy)
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/shotgun/combat/handle_starting_attachment()
	..()
	var/obj/item/attachable/attached_gun/grenade/ugl = new(src)
	ugl.flags_attach_features &= ~ATTACH_REMOVABLE
	ugl.hidden = TRUE
	ugl.Attach(src)
	update_attachable(ugl.slot)

/obj/item/weapon/gun/shotgun/combat/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 21, "under_x" = 14, "under_y" = 16, "stock_x" = 11, "stock_y" = 13.)



/obj/item/weapon/gun/shotgun/combat/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_COMBAT)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2


/obj/item/weapon/gun/shotgun/combat/get_examine_text(mob/user)
	. = ..()
	if(in_chamber) . += "It has a chambered round."


/obj/item/weapon/gun/shotgun/combat/riot
	name = "\improper MK221 riot shotgun"
	icon_state = "mp220"
	item_state = "mp220"
	desc = "维兰德-汤谷MK221霰弹枪，一款射速快的半自动霰弹枪。配备钢蓝色涂装，表明用于防暴控制。经过改装，只能发射20号径豆袋弹。"
	current_mag = /obj/item/ammo_magazine/internal/shotgun/combat/riot
	gauge = "20g"

/obj/item/weapon/gun/shotgun/combat/guard
	desc = "维兰德-汤谷MK221霰弹枪，一款射速快的半自动霰弹枪。配备红色握把，表明其用于宪兵仪仗队。"
	icon_state = "mp221"
	item_state = "mp221"
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet)
	current_mag = /obj/item/ammo_magazine/internal/shotgun/buckshot

/obj/item/weapon/gun/shotgun/combat/covert
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/extended_barrel)
	current_mag = /obj/item/ammo_magazine/internal/shotgun/buckshot

//SOF MK210, an earlier developmental variant of the MK211 tactical used by USCM SOF.
/obj/item/weapon/gun/shotgun/combat/marsoc
	name = "\improper XM38 tactical shotgun"
	desc = "早在2168年，维兰德-汤谷就开始测试MK221。USCM获得了一个早期原型，后来通过一份有限的军事合同采用了它。但USCM特种作战部队并不满意，并对他们能接触到的早期原型进行了迭代；最终，他们内部的军械师和修补匠制造出了MK210，命名为XM38，一款可折叠到腰带上的轻型霰弹枪。而且，它是全自动的，由冲压金属制成，并保留了枪挂榴弹发射器。真是个工程奇迹。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/shotguns.dmi'
	icon_state = "mk210"
	item_state = "mk210"

	current_mag = /obj/item/ammo_magazine/internal/shotgun/buckshot

	flags_equip_slot = SLOT_WAIST|SLOT_BACK
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG
	auto_retrieval_slot = WEAR_J_STORE
	start_automatic = TRUE

	starting_attachment_types = list()

/obj/item/weapon/gun/shotgun/combat/marsoc/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/shotgun/combat/marsoc/retrieve_to_slot(mob/living/carbon/human/user, retrieval_slot, check_loc, silent)
	if(retrieval_slot == WEAR_J_STORE) //If we are using a magharness...
		if(..(user, WEAR_WAIST, check_loc, silent)) //...first try to put it onto the waist.
			return TRUE
	return ..()

/*obj/item/weapon/gun/shotgun/combat/marsoc/handle_starting_attachment()
	return */ //we keep the UGL

/obj/item/weapon/gun/shotgun/combat/marsoc/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 21, "under_x" = 14, "under_y" = 16, "stock_x" = 14, "stock_y" = 16)

/obj/item/weapon/gun/shotgun/combat/marsoc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_DEATHSQUAD)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 - HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_2 - SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2 - SCATTER_AMOUNT_TIER_10
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

//-------------------------------------------------------
//TYPE 23. SEMI-AUTO UPP SHOTGUN, BASED ON KS-23

/obj/item/weapon/gun/shotgun/type23
	name = "\improper Type 23 riot shotgun"
	desc = "由于UPP士兵经常报告在战斗中处于劣势，UPP最高统帅部采购了大量23型霰弹枪，该枪最初用于镇压叛逃殖民地骚乱。这款缓慢的半自动霰弹枪使用8号径弹药，威力巨大。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/shotguns.dmi'
	icon_state = "type23"
	item_state = "type23"
	fire_sound = 'sound/weapons/gun_type23.ogg' //not perfect, too small
	current_mag = /obj/item/ammo_magazine/internal/shotgun/type23
	attachable_allowed = list(
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bayonet, // Muzzle
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/verticalgrip, // Underbarrel
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/stock/type23, // Stock
		)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_INTERNAL_MAG
	flags_equip_slot = SLOT_BACK
	map_specific_decoration = FALSE
	gauge = "8g"
	starting_attachment_types = list(/obj/item/attachable/stock/type23)

/obj/item/weapon/gun/shotgun/type23/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/weapon/gun/shotgun/type23/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 13, "rail_y" = 21, "under_x" = 24, "under_y" = 15, "stock_x" = -1, "stock_y" = 17)

/obj/item/weapon/gun/shotgun/type23/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_SLOW)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_4
	scatter_unwielded = SCATTER_AMOUNT_TIER_1
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_1
	recoil_unwielded = RECOIL_AMOUNT_TIER_1

/obj/item/weapon/gun/shotgun/type23/breacher
	random_spawn_chance = 100
	random_rail_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
	)
	random_muzzle_chance = 100
	random_spawn_muzzle = list(
		/obj/item/attachable/bayonet/upp,
	)
	random_under_chance = 40
	random_spawn_under = list(
		/obj/item/attachable/verticalgrip,
	)

/obj/item/weapon/gun/shotgun/type23/breacher/slug
	current_mag = /obj/item/ammo_magazine/internal/shotgun/type23/slug

/obj/item/weapon/gun/shotgun/type23/breacher/flechette
	current_mag = /obj/item/ammo_magazine/internal/shotgun/type23/flechette

/obj/item/weapon/gun/shotgun/type23/dual
	random_spawn_chance = 100
	random_rail_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/magnetic_harness,
	)
	random_muzzle_chance = 80
	random_spawn_muzzle = list(
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/heavy_barrel,
	)
	random_under_chance = 100
	random_spawn_under = list(
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/verticalgrip,
	)

/obj/item/weapon/gun/shotgun/type23/dragon
	current_mag = /obj/item/ammo_magazine/internal/shotgun/type23/dragonsbreath
	random_spawn_chance = 100
	random_rail_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/magnetic_harness,
	)
	random_muzzle_chance = 70
	random_spawn_muzzle = list(
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/heavy_barrel,
	)
	random_under_chance = 100
	random_spawn_under = list(
		/obj/item/attachable/attached_gun/extinguisher,
	)

/obj/item/weapon/gun/shotgun/type23/riot_control
	name = "\improper Type 23-R riot control shotgun"
	desc = "这款缓慢的半自动霰弹枪使用8号径弹药，威力巨大。-R型专为UPP殖民地安保人员设计，用于处理殖民地骚乱，配有集成垂直握把，但缺少附件选择。"
	current_mag = /obj/item/ammo_magazine/internal/shotgun/type23/beanbag
	attachable_allowed = list(
		/obj/item/attachable/reddot, //Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/verticalgrip, //Underbarrel
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/stock/type23, //Stock
	)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_INTERNAL_MAG
	flags_equip_slot = SLOT_BACK
	map_specific_decoration = FALSE
	gauge = "8g"
	starting_attachment_types = list(/obj/item/attachable/stock/type23)

/obj/item/weapon/gun/shotgun/type23/riot_control/handle_starting_attachment()
	. = ..()
	var/obj/item/attachable/verticalgrip/integrated_grip = new(src)
	integrated_grip.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated_grip.Attach(src)
	update_attachable(integrated_grip.slot)

//-------------------------------------------------------
//DOUBLE SHOTTY
//
/obj/item/weapon/gun/shotgun/double
	name = "\improper Spearhead Rival 78"
	desc = "矛头公司生产的双管霰弹枪。古老、坚固、实惠。一次只能装填两发12号径霰弹。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/shotguns.dmi'
	icon_state = "dshotgun"
	item_state = "dshotgun"

	current_mag = /obj/item/ammo_magazine/internal/shotgun/double
	fire_sound = 'sound/weapons/gun_shotgun_heavy.ogg'
	break_sound = 'sound/weapons/handling/gun_mou_open.ogg'
	seal_sound = 'sound/weapons/handling/gun_mou_close.ogg'//replace w/ uniques
	cocked_sound = null //We don't want this.
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/double,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG
	has_open_icon = TRUE
	civilian_usable_override = TRUE // Come on. It's THE survivor shotgun.
	additional_fire_group_delay = 1.5 SECONDS

/obj/item/weapon/gun/shotgun/double/Initialize()
	. = ..()
	if(istype(src, /obj/item/weapon/gun/shotgun/double/mou53))
		AddElement(/datum/element/corp_label/henjin_garcia)
	else
		AddElement(/datum/element/corp_label/spearhead)

/obj/item/weapon/gun/shotgun/double/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 19,"rail_x" = 11, "rail_y" = 20, "under_x" = 15, "under_y" = 14, "stock_x" = 13, "stock_y" = 14)

/obj/item/weapon/gun/shotgun/double/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_COMBAT) // Fires .6 seconds faster than an m37, but only two bullets. Same as MK221.
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/shotgun/double/get_examine_text(mob/user)
	. = ..()
	if(!current_mag)
		return
	if(current_mag.chamber_closed) . += "It's closed."
	else . += "It's open with [current_mag.current_rounds] shell\s loaded."

/obj/item/weapon/gun/shotgun/double/unique_action(mob/user)
	if(flags_item & WIELDED)
		unwield(user)
	open_chamber(user)

/obj/item/weapon/gun/shotgun/double/check_chamber_position()
	if(!current_mag)
		return
	if(current_mag.chamber_closed)
		return
	return 1

/obj/item/weapon/gun/shotgun/double/add_to_tube(mob/user,selection) //Load it on the go, nothing chambered.
	if(!current_mag)
		return
	current_mag.chamber_position++
	current_mag.chamber_contents[current_mag.chamber_position] = selection
	playsound(user, reload_sound, 25, 1)
	return 1

/obj/item/weapon/gun/shotgun/double/able_to_fire(mob/user)
	. = ..()
	if(. && istype(user))
		if(!current_mag)
			return
		if(!current_mag.chamber_closed)
			to_chat(user, SPAN_DANGER("关闭枪膛！"))
			return 0

/obj/item/weapon/gun/shotgun/double/empty_chamber(mob/user)
	if(!current_mag)
		return
	if(current_mag.chamber_closed)
		open_chamber(user)
	else
		..()

/obj/item/weapon/gun/shotgun/double/load_into_chamber()
	//Trimming down the unnecessary stuff.
	//This doesn't chamber, creates a bullet on the go.

	if(!current_mag)
		return
	if(current_mag.current_rounds > 0)
		ammo = GLOB.ammo_list[current_mag.chamber_contents[current_mag.chamber_position]]
		in_chamber = create_bullet(ammo, initial(name))
		current_mag.current_rounds--
		return in_chamber
	//We can't make a projectile without a mag or active attachable.


/obj/item/weapon/gun/shotgun/double/delete_bullet(obj/projectile/projectile_to_fire, refund = 0)
	qdel(projectile_to_fire)
	if(!current_mag)
		return
	if(refund)
		current_mag.current_rounds++
	return TRUE

/obj/item/weapon/gun/shotgun/double/reload_into_chamber(mob/user)
	if(!current_mag)
		return
	in_chamber = null
	current_mag.chamber_contents[current_mag.chamber_position] = "empty"
	current_mag.chamber_position--
	return 1

/obj/item/weapon/gun/shotgun/double/proc/open_chamber(mob/user, override)
	if(!current_mag)
		return
	current_mag.chamber_closed = !current_mag.chamber_closed
	update_icon()

	if (current_mag.chamber_closed)
		playsound(user, break_sound, 25, 1)
	else
		playsound(user, seal_sound, 25, 1)


/obj/item/weapon/gun/shotgun/double/with_stock/handle_starting_attachment()
	. = ..()
	var/obj/item/attachable/stock/double/S = new(src)
	S.hidden = FALSE
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)

/obj/item/weapon/gun/shotgun/double/damaged
	name = "半截短型矛头竞争者78"
	desc = "一支由矛头公司生产的双管霰弹枪。古老、坚固、廉价。不知为何，似乎有人曾试图锯断枪管，但中途放弃了。这恐怕不是最理想的战斗用枪。"
	icon_state = "dshotgun_bad"

/obj/item/weapon/gun/shotgun/double/damaged/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_SLOW)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_1
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_7
	recoil = RECOIL_AMOUNT_TIER_3
	recoil_unwielded = RECOIL_AMOUNT_TIER_1

/obj/item/weapon/gun/shotgun/double/sawn
	name = "\improper sawn-off Spearhead Rival 78"
	desc = "一支由矛头公司生产的双管霰弹枪。古老、坚固、廉价。枪管已被人为截短，以降低射程，但增加了伤害和弹丸散布。"
	icon_state = "sshotgun"
	item_state = "sshotgun"
	flags_equip_slot = SLOT_WAIST
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG

/obj/item/weapon/gun/shotgun/double/sawn/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 19, "rail_x" = 11, "rail_y" = 20, "under_x" = 15, "under_y" = 14,  "stock_x" = 18, "stock_y" = 16)

/obj/item/weapon/gun/shotgun/double/sawn/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_COMBAT)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3 - HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_2
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT // Less barrel = less velocity
	recoil = RECOIL_AMOUNT_TIER_1
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	wield_delay = WIELD_DELAY_FAST

// COULDN'T THINK OF ANOTHER WAY SORRY!!!! SOMEONE ADD A GUN COMPONENT!!

/obj/item/weapon/gun/shotgun/double/cane
	name = "花式手杖"
	desc = "一根乌木手杖，杖头装饰华丽，看似黄金。触摸感觉中空。"
	icon = 'icons/obj/items/weapons/melee/canes.dmi'
	icon_state = "fancy_cane"
	item_state = "fancy_cane"
	pickup_sound = null
	drop_sound = null
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/canes_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/canes_righthand.dmi',
	)
	caliber = ".44"
	gauge = ".44" // misery
	force = 15 // hollow. also too hollow to support one's weight like normal canes
	attack_speed = 1.5 SECONDS
	current_mag = /obj/item/ammo_magazine/internal/shotgun/double/cane
	fire_sound = null
	fire_sounds = list('sound/weapons/gun_silenced_oldshot1.ogg', 'sound/weapons/gun_silenced_oldshot2.ogg') // Uses the old sounds because they're more 'James Bond'-y
	break_sound = 'sound/weapons/handling/pkd_open_chamber.ogg'
	seal_sound = 'sound/weapons/handling/pkd_close_chamber.ogg'
	attachable_allowed = list()

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG|GUN_TRIGGER_SAFETY|GUN_ONE_HAND_WIELDED|GUN_ANTIQUE|GUN_NO_DESCRIPTION|GUN_UNUSUAL_DESIGN
	flags_item = NO_FLAGS

	inherent_traits = list(TRAIT_GUN_SILENCED)

/obj/item/weapon/gun/shotgun/double/cane/Initialize(mapload, spawn_empty)
	. = ..()
	AddElement(/datum/element/traitbound/gun_silenced)

/obj/item/weapon/gun/shotgun/double/cane/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	set_fire_delay(FIRE_DELAY_TIER_7)
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil = RECOIL_AMOUNT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/shotgun/double/cane/gun_safety_handle(mob/user)
	if(flags_gun_features & GUN_TRIGGER_SAFETY)
		to_chat(user, SPAN_NOTICE("你将[src]恢复为正常的手杖姿态。"))
		playsound(user, 'sound/weapons/handling/nsg23_unload.ogg', 25, 1)
	else
		to_chat(user, SPAN_DANGER("你解开保险，将[src]切换为射击姿态！"))
		playsound(user, 'sound/weapons/handling/smg_reload.ogg', 25, 1)

	if(current_mag.chamber_closed == FALSE) // close the chamber
		open_chamber(user, TRUE)

	update_desc()
	update_icon()

	playsound(user, 'sound/weapons/handling/safety_toggle.ogg', 25, 1)

/obj/item/weapon/gun/shotgun/double/cane/proc/update_desc()
	if(flags_gun_features & GUN_TRIGGER_SAFETY)
		name = initial(name)
		desc = initial(desc)
	else
		name = "手杖左轮枪"
		desc = initial(desc) + " Apparently, because it's a large revolver. Who'da thunk it?"

/obj/item/weapon/gun/shotgun/double/cane/open_chamber(mob/user, override)
	if(flags_gun_features & GUN_TRIGGER_SAFETY && !override)
		to_chat(user, SPAN_WARNING("保险还开着呢！"))
		return
	return ..()

/obj/item/weapon/gun/shotgun/double/cane/update_icon()
	if(flags_gun_features & GUN_TRIGGER_SAFETY)
		icon_state = initial(icon_state)

	else if(current_mag.chamber_closed == FALSE)
		icon_state = initial(icon_state) + "_gun_open"
	else
		icon_state = initial(icon_state) + "_gun"

//M-OU53 SHOTGUN | Marine mid-range slug/flechette only coach gun (except its an over-under). Support weapon for slug stuns / flechette DOTS (when implemented). Buckshot in this thing is just stupidly strong, hence the denial.

/obj/item/weapon/gun/shotgun/double/mou53
	name = "\improper MOU53 break action shotgun"
	desc = "一款限量生产的Henjin-Garcia MOU53三折式经典枪型。在中距离拥有可观的伤害输出。如果说Armat M37是近身格斗之王，那么Henjin-Garcia MOU53就是能打中谷仓侧墙的利器。此特定型号无法安全发射鹿弹。"
	icon_state = "mou"
	item_state = "mou"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/shotguns.dmi'
	fire_sound = 'sound/weapons/gun_mou53.ogg'
	reload_sound = 'sound/weapons/handling/gun_mou_reload.ogg'//unique shell insert
	flags_equip_slot = SLOT_BACK
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG
	current_mag = /obj/item/ammo_magazine/internal/shotgun/double/mou53 //Take care, she comes loaded!
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/mou53,
	)
	map_specific_decoration = TRUE
	civilian_usable_override = FALSE
	var/max_rounds = 3
	var/current_rounds = 0
	COOLDOWN_DECLARE(breach_action_cooldown)

/obj/item/weapon/gun/shotgun/double/mou53/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 11, "rail_y" = 21, "under_x" = 17, "under_y" = 15, "stock_x" = 10, "stock_y" = 9) //Weird stock values, make sure any new stock matches the old sprite placement in the .dmi

/obj/item/weapon/gun/shotgun/double/mou53/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	set_fire_delay(FIRE_DELAY_TIER_11)
	if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
		set_fire_delay(FIRE_DELAY_TIER_1)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_3
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/shotgun/double/mou53/reload(mob/user, obj/item/ammo_magazine/magazine)
	if(ispath(magazine.default_ammo, /datum/ammo/bullet/shotgun/buckshot)) // No buckshot in this gun
		to_chat(user, SPAN_WARNING("\the [src] cannot safely fire this type of shell!"))
		return
	..()

/obj/item/weapon/gun/shotgun/double/mou53/unique_action(mob/user)
	if(!COOLDOWN_FINISHED(src, breach_action_cooldown))
		to_chat(user, SPAN_WARNING("你必须等待[current_mag.chamber_closed ? "opening" : "closing"] the chamber again."))
		return
	COOLDOWN_START(src, breach_action_cooldown, MOU_ACTION_COOLDOWN)
	. = ..()




//TWO BORE - Van Bandolier's ginormous elephant gun.
/datum/action/item_action/specialist/twobore_brace
	ability_primacy = SPEC_PRIMARY_ACTION_1

/datum/action/item_action/specialist/twobore_brace/New(mob/living/user, obj/item/holder)
	..()
	name = "准备承受后坐力"
	action_icon_state = "twobore_brace"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/specialist/twobore_brace/can_use_action()
	var/mob/living/carbon/human/H = owner
	if(H.is_mob_incapacitated() || H.get_active_hand() != holder_item)
		return
	if(H.action_busy)
		to_chat(H, SPAN_WARNING("你正在做其他事情！"))
		return
	return TRUE

/datum/action/item_action/specialist/twobore_brace/action_cooldown_check()
	var/obj/item/weapon/gun/shotgun/double/twobore/G = holder_item
	if(G.braced)
		return TRUE

/datum/action/item_action/specialist/twobore_brace/action_activate()
	. = ..()
	var/obj/item/weapon/gun/shotgun/double/twobore/G = holder_item
	if(G.braced)
		return
	var/mob/living/carbon/human/H = owner
	if(!do_after(H, 0.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE)) //Takes a moment to brace to fire.
		to_chat(H, SPAN_WARNING("你被打断了！"))
		return
	H.visible_message(SPAN_WARNING("[H]稳住身体，准备射击[initial(G.name)]。"),
			SPAN_WARNING("You brace yourself to fire the [initial(G.name)]."))
	G.brace(H)
	update_button_icon()

/obj/item/weapon/gun/shotgun/double/twobore
	name = "双膛步枪"
	desc = "一支极其沉重的双管步枪，其口径大到足以发射月球。如果你想获得完整的战利品，别瞄准头部。\n其后坐力堪称毁灭性：如果你经验不足，且未使用专家技能进行稳固准备，你将无法开出第二枪。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/event.dmi'
	icon_state = "twobore"
	item_state = "twobore"
	unacidable = TRUE
	explo_proof = TRUE
	force = 20 //Big heavy elephant gun.
	current_mag = /obj/item/ammo_magazine/internal/shotgun/double/twobore
	gauge = "2 bore"
	fire_sound = 'sound/weapons/gun_mateba.ogg'
	break_sound = 'sound/weapons/handling/gun_mou_open.ogg'
	seal_sound = 'sound/weapons/handling/gun_mou_close.ogg'//replace w/ uniques
	cocked_sound = null //We don't want this.
	attachable_allowed = list()
	delay_style = WEAPON_DELAY_NO_FIRE //This is a heavy, bulky weapon, and tricky to snapshot with.
	flags_equip_slot = SLOT_BACK
	actions_types = list(/datum/action/item_action/specialist/twobore_brace)
	hud_offset = 10 //A sprite long enough to touch the Moon.
	aim_slowdown = SLOWDOWN_ADS_LMG //Quite slow, but VB has light-armor slowdown and doesn't feel pain.
	civilian_usable_override = FALSE
	var/braced = FALSE
	var/fired_shots = 0 //How many shots were fired since it was last closed, for casing ejection purposes.
	var/image/fired_casing

/obj/item/weapon/gun/shotgun/double/twobore/Initialize(mapload, spawn_empty)
	. = ..()
	fired_casing = image('icons/obj/items/weapons/projectiles.dmi', "casing_twobore", ABOVE_BLOOD_LAYER)
	fired_casing.appearance_flags = PIXEL_SCALE

/obj/item/weapon/gun/shotgun/double/twobore/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	set_fire_delay(2 SECONDS )//Less than the stun time, but you still have to brace to fire safely.
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_OFF //This is done manually.
	recoil_unwielded = RECOIL_OFF

/obj/item/weapon/gun/shotgun/double/twobore/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 21,"rail_x" = 15, "rail_y" = 22, "under_x" = 21, "under_y" = 16, "stock_x" = 0, "stock_y" = 16)

/obj/item/weapon/gun/shotgun/double/twobore/proc/brace(mob/living/carbon/human/user)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(unbrace), user)
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(unbrace), user)
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(unbrace), user)
	braced = TRUE

///Returns TRUE if the gun was braced.
/obj/item/weapon/gun/shotgun/double/twobore/proc/unbrace(mob/living/carbon/human/user)
	SIGNAL_HANDLER
	if(braced)
		to_chat(user, SPAN_NOTICE("你放松了姿态。"))
		braced = FALSE
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(src, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
		for(var/X in actions)
			var/datum/action/A = X
			A.update_button_icon()
		return TRUE

/obj/item/weapon/gun/shotgun/double/twobore/item_action_slot_check(mob/user, slot)
	if(HAS_TRAIT(user, TRAIT_TWOBORE_TRAINING)) //Only the hunter himself knows how to use this weapon properly.
		return TRUE

/obj/item/weapon/gun/shotgun/double/twobore/open_chamber(mob/user)
	..()
	if(!fired_shots) //No empty shells. Means it wasn't fired or is being closed.
		return

	var/turf/floor = get_turf(src)
	if(fired_shots == 1)
		to_chat(user, SPAN_NOTICE("当你打开[initial(name)]时，一个空弹壳掉落在[floor]上。"))
	else
		to_chat(user, SPAN_NOTICE("当你打开[initial(name)]时，两个空弹壳掉落在[floor]上。"))

	playsound(user, "gun_casing_shotgun", 25, TRUE)

	for(var/I in 1 to fired_shots)
		fired_casing.transform = matrix(rand(0,359), MATRIX_ROTATE)*matrix(rand(-14,14), rand(-14,14), MATRIX_TRANSLATE)
		floor.overlays += fired_casing
	fired_shots = 0

/obj/item/weapon/gun/shotgun/double/twobore/Fire(atom/target, mob/living/carbon/human/user, params, reflex = 0, dual_wield) //Using this instead of apply_bullet_effects() as RPG does so I get more granular angles than just user direction.
	var/prefire_rounds = current_mag.current_rounds //How many rounds do we have before we fire?
	. = ..()
	if(current_mag.current_rounds == prefire_rounds) //We didn't fire a shot.
		return NONE
	var/target_angle = Get_Compass_Dir(user, target) //More precise than get_dir().
	fired_shots++
	twobore_recoil(user, target_angle)

/obj/item/weapon/gun/shotgun/double/twobore/attack(mob/living/M, mob/living/user, def_zone)
	var/target_angle
	if(M != user && get_turf(M) != get_turf(user))
		target_angle = get_dir(user, M)

	var/prefire_rounds = current_mag.current_rounds //How many rounds do we have before we fire?
	. = ..()
	if(current_mag.current_rounds == prefire_rounds) //We didn't fire a shot.
		return
	fired_shots++
	twobore_recoil(user, target_angle)

/obj/item/weapon/gun/shotgun/double/twobore/proc/twobore_recoil(mob/living/carbon/human/user, target_angle)
	var/turf/start_turf = get_turf(user)
	//Muzzle smoke. Black powder is messy.
	var/obj/effect/particle_effect/smoke/newsmoke = new(get_step(start_turf, target_angle), 1, src, user)
	newsmoke.time_to_live = 3

	var/suicide //Target is or is on the same tile as the shooter. Means the gun goes one way and the shooter stays.
	var/behind_angle
	if(target_angle)
		behind_angle = REVERSE_DIR(target_angle)
	else
		suicide = TRUE
		behind_angle = pick(CARDINAL_ALL_DIRS) //Random angle

	if(flags_item & WIELDED)
		if(braced && !suicide) //Recoil and brief stun but nothing more. Gun is huge and you can't brace properly when shooting at extreme (same tile) close range.
			user.visible_message(SPAN_WARNING("[user]在[initial(name)]的巨大后坐力下向后踉跄。"),
				SPAN_DANGER("The [initial(name)] kicks like an elephant!"))
			unbrace(user)
			user.apply_effect(1, STUN) //Van Bandolier is a human/hero and stuns last half as long for him.
			shake_camera(user, RECOIL_AMOUNT_TIER_2 * 0.5, RECOIL_AMOUNT_TIER_2)
			return
	else //You *do not* fire this one-handed.
		var/obj/limb/shoulder
		if(user.hand) //They're using their left hand.
			shoulder = user.get_limb("l_arm")
			user.apply_damage(15, BRUTE, "l_arm")
		else
			shoulder = user.get_limb("r_arm")
			user.apply_damage(15, BRUTE, "r_arm")
		shoulder.fracture(100)
		if(!(shoulder.status & LIMB_SPLINTED_INDESTRUCTIBLE) && (shoulder.status & LIMB_SPLINTED)) //If they have it splinted, the splint won't hold.
			shoulder.status &= ~LIMB_SPLINTED
			playsound(get_turf(loc), 'sound/items/splintbreaks.ogg', 20)
			to_chat(user, SPAN_DANGER("你[shoulder.display_name]上的夹板在后坐力作用下崩开了！"))
			user.pain.apply_pain(PAIN_BONE_BREAK_SPLINTED)
			user.update_med_icon()

	//Ruh roh.
	user.visible_message(SPAN_WARNING("[user]被[initial(name)]的后坐力掀翻在地！"),
		SPAN_HIGHDANGER("The world breaks in half!"))
	shake_camera(user, RECOIL_AMOUNT_TIER_1 * 0.5, RECOIL_AMOUNT_TIER_1)

	var/turf/behind_turf = get_step(user, behind_angle)
	if(suicide || !behind_turf) //in case of map edge or w/e. If firing at something on the same tile, we don't throw the gun as far away.
		behind_turf = start_turf

	//Assemble a list of target turfs in a rough cone behind us.
	var/list/throw_turfs = list(
		get_step(behind_turf, behind_angle),
		get_step(behind_turf, turn(behind_angle, 45)),
		get_step(behind_turf, turn(behind_angle, -45))
		)

	//Sift through the turfs to remove ones that don't exist, and move ones that we can't throw the whole way into to a last-resort list.
	var/list/bad_turfs = list()
	add_temp_pass_flags(PASS_OVER_THROW_ITEM) //We'll be using the gun to test objects to see if it can pass over, so we set throw flags on.
	for(var/turf/T in throw_turfs)
		if(!T) //Off edge of map.
			throw_turfs.Remove(T)
			continue
		var/list/turf/path = get_line(get_step_towards(src, T), T) //Same path throw code will calculate from.
		if(!length(path))
			throw_turfs.Remove(T)
			continue
		var/prev_turf = start_turf
		for(var/turf/P in path)
			if(P.density || LinkBlocked(src, prev_turf, P))
				throw_turfs.Remove(T)
				bad_turfs.Add(T)
				break
			prev_turf = P
	remove_temp_pass_flags(PASS_OVER_THROW_ITEM)

	//Pick a turf to throw into.
	var/throw_turf
	var/throw_strength = 1
	if(length(throw_turfs)) //If there's any ideal throwpaths, pick one.
		throw_turf = pick(throw_turfs)
		throw_strength = suicide ? 1 : 2
	else if(length(bad_turfs)) //Otherwise, pick from blocked paths.
		throw_turf = pick(bad_turfs)
	else //If there's nowhere to put it, throw it to the same place we're putting the shooter.
		throw_turf = behind_turf

	user.drop_inv_item_on_ground(src)
	throw_atom(throw_turf, throw_strength, SPEED_AVERAGE, src, TRUE)

	user.apply_effect(2, WEAKEN)
	user.apply_effect(3, DAZE)
	if(!suicide && !step(user, behind_angle))
		user.animation_attack_on(behind_turf)
		playsound(user.loc, "punch", 25, TRUE)
		var/blocker = LinkBlocked(user, start_turf, behind_turf) //returns any objects blocking the user from moving back.
		if(blocker)
			user.visible_message(SPAN_DANGER("[user]撞上了[blocker]！"),
				SPAN_DANGER("The [initial(name)]'s recoil hammers you against [blocker]!"))
		else
			user.visible_message(SPAN_DANGER("[user]撞上了障碍物！"),
				SPAN_DANGER("The [initial(name)]'s recoil hammers you against an obstacle!"))
		user.apply_damage(5, BRUTE)


//-------------------------------------------------------
//PUMP SHOTGUN
//Shotguns in this category will need to be pumped each shot.

/obj/item/weapon/gun/shotgun/pump
	name = "\improper M37 pump shotgun"
	desc = "Armat战场系统公司的经典设计，M37将近距离火力与长期可靠性相结合。需要泵动上膛，这是一个独特动作。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/shotguns.dmi'
	icon_state = "m37"
	item_state = "m37"
	current_mag = /obj/item/ammo_magazine/internal/shotgun
	flags_equip_slot = SLOT_BACK
	fire_sound = 'sound/weapons/gun_shotgun.ogg'
	firesound_volume = 60
	var/pump_sound = "shotgunpump"
	var/pump_delay //Higher means longer delay.
	var/recent_pump //world.time to see when they last pumped it.
	var/pumped = FALSE //Used to see if the shotgun has already been pumped.
	var/message //To not spam the above.
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/shotgun_choke,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/stock/shotgun,
	)
	map_specific_decoration = TRUE

/obj/item/weapon/gun/shotgun/pump/Initialize(mapload, spawn_empty)
	. = ..()
	pump_delay = FIRE_DELAY_TIER_5*2
	additional_fire_group_delay += pump_delay

	if(istype(src, /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb))
		AddElement(/datum/element/corp_label/henjin_garcia)
	else
		AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/shotgun/pump/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 20, "under_x" = 20, "under_y" = 14, "stock_x" = 20, "stock_y" = 14)

//
/obj/item/weapon/gun/shotgun/pump/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_BASE)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/shotgun/pump/unique_action(mob/user)
	pump_shotgun(user)

/obj/item/weapon/gun/shotgun/pump/ready_in_chamber() //If there wasn't a shell loaded through pump, this returns null.
	return

//Same as double barrel. We don't want to do anything else here.
/obj/item/weapon/gun/shotgun/pump/add_to_tube(mob/user, selection) //Load it on the go, nothing chambered.
	if(!current_mag)
		return
	current_mag.chamber_position++
	current_mag.chamber_contents[current_mag.chamber_position] = selection
	playsound(user, reload_sound, 25, 1)
	return 1
	/*
	Moves the ready_in_chamber to it's own proc.
	If the Fire() cycle doesn't find a chambered round with no active attachable, it will return null.
	Which is what we want, since the gun shouldn't fire unless something was chambered.
	*/

//More or less chambers the round instead of load_into_chamber().
/obj/item/weapon/gun/shotgun/pump/proc/pump_shotgun(mob/user) //We can't fire bursts with pumps.
	if(world.time < (recent_pump + pump_delay) )
		return //Don't spam it.
	if(pumped)
		if (world.time > (message + pump_delay))
			to_chat(usr, SPAN_WARNING("<i>[src]的枪膛里已经有一发霰弹了！<i>"))
			message = world.time
		return
	if(in_chamber) //eject the chambered round
		in_chamber = null
		var/obj/item/ammo_magazine/handful/new_handful = retrieve_shell(ammo.type)
		new_handful.forceMove(get_turf(src))

	ready_shotgun_tube()

	playsound(user, pump_sound, 10, 1)
	recent_pump = world.time
	if (in_chamber)
		pumped = TRUE


/obj/item/weapon/gun/shotgun/pump/reload_into_chamber(mob/user)
	if(!current_mag)
		return
	if(!active_attachable)
		pumped = FALSE //It was fired, so let's unlock the pump.
		in_chamber = null
		//Time to move the tube position.
		if(!current_mag.current_rounds && !in_chamber)
			update_icon()//No rounds, nothing chambered.

	return 1

/obj/item/weapon/gun/shotgun/pump/unload(mob/user) //We can't pump it to get rid of the shells, so we'll make it work via the unloading mechanism.
	if(pumped)
		to_chat(user, SPAN_WARNING("你解开了[src]的锁定机构。"))
		pumped = FALSE
	return ..()

//-------------------------------------------------------

/obj/item/weapon/gun/shotgun/pump/m37a
	name = "\improper M37A2 pump shotgun"
	desc = "Armat战场系统公司对永恒经典的现代诠释，将近距离火力与长期可靠性相结合。需要泵动上膛，这是一个独特动作。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/shotguns.dmi'
	icon_state = "m37a"
	item_state = "m37a"
	current_mag = /obj/item/ammo_magazine/internal/shotgun
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/shotgun_choke,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/stock/synth/collapsible,
	)

/obj/item/weapon/gun/shotgun/pump/dual_tube
	name = "通用双管泵动式霰弹枪"
	desc = "一把二十发容量的泵动式霰弹枪，配备双内置管状弹仓。你可以通过切换霰弹枪管来切换激活的内置弹仓。"
	current_mag = /obj/item/ammo_magazine/internal/shotgun
	var/obj/item/ammo_magazine/internal/shotgun/primary_tube
	var/obj/item/ammo_magazine/internal/shotgun/secondary_tube
	var/chamber_swap = FALSE

/obj/item/weapon/gun/shotgun/pump/dual_tube/Initialize(mapload, spawn_empty)
	LAZYADD(actions_types, /datum/action/item_action/dual_tube/toggle_chamber_swap)
	. = ..()
	primary_tube = current_mag
	secondary_tube = new current_mag.type(src, spawn_empty ? TRUE : FALSE)
	current_mag = secondary_tube
	replace_tube(current_mag.current_rounds)

/obj/item/weapon/gun/shotgun/pump/dual_tube/get_examine_text(mob/user)
	. = ..()
	var/has_chamber_swap = locate(/datum/action/item_action/dual_tube/toggle_chamber_swap) in actions
	if(has_chamber_swap)
		. += SPAN_NOTICE("Use <b>toggle firemode</b> to toggle chamber-swapping.</b>")

/obj/item/weapon/gun/shotgun/pump/dual_tube/do_toggle_firemode(datum/source, datum/keybinding, new_firemode)
	var/datum/action/item_action/dual_tube/toggle_chamber_swap/chamber_swap_ability = locate() in actions
	if(chamber_swap_ability)
		//do_toggle_firemode is a signal handler. needs async to stop sleep override warnings
		INVOKE_ASYNC(chamber_swap_ability, TYPE_PROC_REF(/datum/action/item_action/dual_tube/toggle_chamber_swap, action_activate))
		return

	. = ..()

/obj/item/weapon/gun/shotgun/pump/dual_tube/Destroy()
	QDEL_NULL(primary_tube)
	QDEL_NULL(secondary_tube)
	. = ..()

/obj/item/weapon/gun/shotgun/pump/dual_tube/proc/swap_tube(mob/user)
	if(!ishuman(user) || user.is_mob_incapacitated())
		return FALSE
	var/obj/item/weapon/gun/shotgun/pump/dual_tube/shotgun = user.get_active_hand()
	if(shotgun != src)
		to_chat(user, SPAN_WARNING("你必须将\the [src]握在手中才能切换激活的内置弹仓！")) // currently this warning can't show up, but this is incase you get an action button or similar for it instead of current implementation
		return
	if(!current_mag)
		return

	///The currently chambered shell in the gun before the tube gets swapped.
	var/obj/item/ammo_magazine/chambered_shell
	if(chamber_swap && in_chamber)
		if(current_mag.current_rounds == current_mag.max_rounds)
			to_chat(user, SPAN_WARNING("当前弹管过载！[src]吐出了已上膛的弹壳！"))
			empty_chamber(user, TRUE, TRUE)
		else
			chambered_shell = retrieve_shell(ammo.type)
			in_chamber = null

	if(chambered_shell)
		add_to_tube(user, chambered_shell.default_ammo)
		current_mag.current_rounds++

	if(current_mag == primary_tube)
		current_mag = secondary_tube
	else
		current_mag = primary_tube

	//Chamber swaps require the gun to be pumped afterwards. We'll force the gun to be pumped as it would be pretty annoying otherwise.
	if(!in_chamber && chamber_swap)
		ready_shotgun_tube()
		if(in_chamber)
			pumped = TRUE

	to_chat(user, SPAN_NOTICE("[icon2html(src, user)] 你将\the [src]的激活弹仓切换至[(current_mag == primary_tube) ? "<b>first</b>" : "<b>second</b>"] magazine."))
	playsound(src, 'sound/machines/switch.ogg', 15, TRUE)
	return TRUE

/obj/item/weapon/gun/shotgun/pump/dual_tube/verb/toggle_tube()
	set category = "Weapons"
	set name = "切换霰弹枪弹管"
	set desc = "Toggles which shotgun tube your gun loads from."
	set src = usr.contents

	var/obj/item/weapon/gun/shotgun/pump/dual_tube/shotgun = get_active_firearm(usr)
	if(shotgun == src)
		swap_tube(usr)

//item action for handling switching chambered shells when swapping tubes.
/datum/action/item_action/dual_tube/toggle_chamber_swap/New(Target, obj/item/holder)
	. = ..()
	name = "切换弹膛交换"
	action_icon_state = "chamber_swap"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/dual_tube/toggle_chamber_swap/action_activate()
	. = ..()
	var/obj/item/weapon/gun/shotgun/pump/dual_tube/holder_gun = holder_item
	holder_gun.chamber_swap = !holder_gun.chamber_swap

	playsound(owner, 'sound/weapons/handling/gun_burst_toggle.ogg', 15, 1)

	if(holder_gun.chamber_swap)
		to_chat(owner, SPAN_NOTICE("[icon2html(holder_gun, owner)] 你将<b>开始交换</b>已上膛的弹壳与另一弹管。<b>你当前的弹管必须处于未满载状态，否则将强制将弹壳从弹膛中弹出。</b>"))
		action_icon_state = "chamber_swap_off"
	else
		to_chat(owner, SPAN_NOTICE("[icon2html(holder_gun, owner)] 你将<b>停止交换</b>已上膛的弹壳与另一弹管。"))
		action_icon_state = "chamber_swap"

	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

//SHOTGUN FROM ISOLATION

/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb
	name = "\improper HG 37-12 pump shotgun"
	desc = "一把亨金-加西亚军械公司的八发泵动式霰弹枪，配备四发容量的双内置管状弹仓，可实现快速装填和高精度射击。你可以通过切换霰弹枪管来切换激活的内置弹仓。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/shotguns.dmi'
	icon_state = "hg3712"
	item_state = "hg3712"
	fire_sound = 'sound/weapons/gun_shotgun_small.ogg'
	current_mag = /obj/item/ammo_magazine/internal/shotgun/cmb
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/extinguisher,
	)

	pixel_x = -5
	hud_offset = -5

	map_specific_decoration = FALSE
	civilian_usable_override = TRUE // Come on. It's THE, er, other, survivor shotgun.


/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 37, "muzzle_y" = 17, "rail_x" = 14, "rail_y" = 21, "under_x" = 28, "under_y" = 15, "stock_x" = 24, "stock_y" = 10)

/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_COLONY)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/swat
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/gyro)

/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717
	name = "\improper M37-17 pump shotgun"
	desc = "标志性HG 37-12的军用版本，此设计可在其双管内置弹仓中各多容纳一发弹药，并以更高的初速发射弹丸，造成更大伤害。配发给外域特定USCM舰船和空间站。侧面的按钮可切换内置弹管。"
	icon_state = "m3717"
	item_state = "m3717"
	current_mag = /obj/item/ammo_magazine/internal/shotgun/cmb/m3717

/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_3

/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717/harness
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)

//-------------------------------------------------------
