//-------------------------------------------------------

/obj/item/weapon/gun/rifle
	reload_sound = 'sound/weapons/gun_rifle_reload.ogg'
	cocked_sound = 'sound/weapons/gun_cocked2.ogg'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/assault_rifles.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/assault_rifles.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/assault_rifles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/assault_rifles_righthand.dmi'
	)

	flags_equip_slot = SLOT_BACK
	w_class = SIZE_LARGE
	force = 5
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK
	gun_category = GUN_CATEGORY_RIFLE
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	wield_delay = WIELD_DELAY_NORMAL

/obj/item/weapon/gun/rifle/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/rifle/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/unique_action(mob/user)
	cock(user)


//-------------------------------------------------------
//M41A PULSE RIFLE

/obj/item/weapon/gun/rifle/m41a
	name = "\improper M41A pulse rifle MK2"
	desc = "殖民地海军陆战队的标准制式步枪。大多数战斗人员普遍配备。使用10x24毫米无壳弹药。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/assault_rifles.dmi'
	icon_state = "m41a"
	item_state = "m41a"
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/wy,
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
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/rifle,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/alt_iff_scope,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade, /obj/item/attachable/stock/rifle/collapsible)
	map_specific_decoration = TRUE
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m41a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/m41a/Initialize(mapload, ...)
	. = ..()
	if(istype(src, /obj/item/weapon/gun/rifle/m41a/corporate) || istype(src, /obj/item/weapon/gun/rifle/m41a/elite))
		AddElement(/datum/element/corp_label/wy)
	else
		AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/rifle/m41a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_2


//variant without ugl attachment
/obj/item/weapon/gun/rifle/m41a/stripped
	starting_attachment_types = list()


/obj/item/weapon/gun/rifle/m41a/training
	current_mag = /obj/item/ammo_magazine/rifle/rubber


/obj/item/weapon/gun/rifle/m41a/tactical
	current_mag = /obj/item/ammo_magazine/rifle/ap
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/suppressor, /obj/item/attachable/angledgrip, /obj/item/attachable/stock/rifle/collapsible)
//-------------------------------------------------------
//NSG 23 ASSAULT RIFLE - PMC PRIMARY RIFLE

/obj/item/weapon/gun/rifle/nsg23
	name = "\improper NSG 23 assault rifle"
	desc = "这种步枪十分罕见，最常见于维兰德-汤谷PMC人员手中。与M41A MK2相比，其操控性显著提升，中远距离性能大幅改善，但近战表现相近。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/WY/assault_rifles.dmi'
	icon_state = "nsg23"
	item_state = "nsg23"
	fire_sound = "gun_nsg23"
	reload_sound = 'sound/weapons/handling/nsg23_reload.ogg'
	unload_sound = 'sound/weapons/handling/nsg23_unload.ogg'
	cocked_sound = 'sound/weapons/handling/nsg23_cocked.ogg'
	force = 10
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_VERY_FAST
	current_mag = /obj/item/ammo_magazine/rifle/nsg23
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/suppressor/nsg,
		/obj/item/attachable/attached_gun/shotgun/af13,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WY_RESTRICTED

	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor/nsg,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/extended_barrel,
	)
	starting_attachment_types = list(
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/attached_gun/flamer/advanced,
	)
	start_semiauto = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/nsg23/Initialize(mapload, spawn_empty)
	. = ..()
	update_icon()
	AddElement(/datum/element/corp_label/wy)

/obj/item/weapon/gun/rifle/nsg23/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 37, "muzzle_y" = 16, "rail_x" = 12,"rail_y" = 22, "under_x" = 26, "under_y" = 10, "stock_x" = 5, "stock_y" = 17)

/obj/item/weapon/gun/rifle/nsg23/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10 + FIRE_DELAY_TIER_12/4)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_10 + FIRE_DELAY_TIER_12/4)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil = RECOIL_AMOUNT_TIER_5 + RECOIL_AMOUNT_TIER_5/10
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0
	fa_max_scatter = SCATTER_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/nsg23/cqc
	starting_attachment_types = list(
		/obj/item/attachable/attached_gun/shotgun/af13,
		/obj/item/attachable/suppressor/nsg,
		/obj/item/attachable/reflex,
	)

//has no scope or underbarrel
/obj/item/weapon/gun/rifle/nsg23/stripped
	starting_attachment_types = list() //starts with the stock anyways due to handle_starting_attachment()

/obj/item/weapon/gun/rifle/nsg23/no_lock
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/attached_gun/flamer,//non-op flamer for normal spawns
	)

/obj/item/weapon/gun/rifle/nsg23/no_lock/stripped
	starting_attachment_types = list() //starts with the stock anyways due to handle_starting_attachment()

//-------------------------------------------------------
//M41A PMC VARIANT

/obj/item/weapon/gun/rifle/m41a/elite
	name = "\improper M41A/2 pulse rifle"
	desc = "M41A脉冲步枪MK2的改进型号，经过重新设计以优化重量、操控性和精度。可进行精确的两连发点射。仅配发给精英部队。"
	icon_state = "m41a2"
	item_state = "m41a2"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/WY/assault_rifles.dmi'

	current_mag = /obj/item/ammo_magazine/rifle/ap
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WY_RESTRICTED
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_FAST
	map_specific_decoration = FALSE
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible)

	random_spawn_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/flashlight/under_barrel,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
	)


/obj/item/weapon/gun/rifle/m41a/elite/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5

/obj/item/weapon/gun/rifle/m41a/elite/commando //special version for commandos, has preset attachments.

	starting_attachment_types = list(/obj/item/attachable/stock/rifle, /obj/item/attachable/magnetic_harness, /obj/item/attachable/angledgrip, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/m41a/elite/commando/deathsquad //special version for commandos, has preset attachments.

	starting_attachment_types = list(/obj/item/attachable/stock/rifle, /obj/item/attachable/magnetic_harness, /obj/item/attachable/angledgrip, /obj/item/attachable/heavy_barrel)
	current_mag = /obj/item/ammo_magazine/rifle/heap

/obj/item/weapon/gun/rifle/m41a/elite/whiteout //special version for whiteout, has preset attachments and HEAP mag loaded.
	current_mag = /obj/item/ammo_magazine/rifle/heap
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/magnetic_harness, /obj/item/attachable/angledgrip, /obj/item/attachable/suppressor)

/obj/item/weapon/gun/rifle/m41a/corporate
	desc = "维兰德-汤谷的产物，这款M41A MK2采用公司标志性的白色涂装。使用10x24毫米无壳弹药。"
	icon = 'icons/obj/items/weapons/guns/guns_by_map/snow/guns_obj.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/items/weapons/guns/guns_by_map/snow/guns_lefthand.dmi',
		WEAR_R_HAND = 'icons/obj/items/weapons/guns/guns_by_map/snow/guns_righthand.dmi',
		WEAR_BACK = 'icons/obj/items/weapons/guns/guns_by_map/snow/back.dmi',
		WEAR_J_STORE = 'icons/obj/items/weapons/guns/guns_by_map/snow/suit_slot.dmi'
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WY_RESTRICTED
	map_specific_decoration = FALSE
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible)

/obj/item/weapon/gun/rifle/m41a/corporate/no_lock //for PMC nightmares.
	desc = "维兰德-汤谷的产物，这款M41A MK2采用公司标志性的白色涂装。使用10x24毫米无壳弹药。此型号移除了敌我识别电子元件。"
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER

/obj/item/weapon/gun/rifle/m41a/corporate/commando
	current_mag = /obj/item/ammo_magazine/rifle/ap
	starting_attachment_types = list(/obj/item/attachable/stock/rifle, /obj/item/attachable/magnetic_harness, /obj/item/attachable/angledgrip, /obj/item/attachable/extended_barrel)


/obj/item/weapon/gun/rifle/m41a/corporate/detainer //for chem ert
	current_mag = /obj/item/ammo_magazine/rifle/ap
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/extended_barrel,
	)

	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/lasersight)

//-------------------------------------------------------
//M40-SD AKA SOF RIFLE FROM HELL (It's actually an M41A, don't tell!)

/obj/item/weapon/gun/rifle/m41a/elite/xm40
	name = "\improper XM40 pulse rifle"
	desc = "M41系列步枪的实验性前身之一，除精英陆战单位外从未广泛采用。在USCM仍在生产的步枪中，这是唯一一款配备一体式消音器的型号。它可兼容M41A MK2弹匣，但也拥有自己的专用弹匣系统。在连发模式下极具杀伤力。"
	icon_state = "m40sd"
	item_state = "m40sd"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/assault_rifles.dmi'
	reload_sound = 'sound/weapons/handling/m40sd_reload.ogg'
	unload_sound = 'sound/weapons/handling/m40sd_unload.ogg'
	unacidable = TRUE
	explo_proof = TRUE

	current_mag = /obj/item/ammo_magazine/rifle/xm40/heap
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_FAST
	map_specific_decoration = FALSE
	starting_attachment_types = list()
	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle/extended,
		/obj/item/ammo_magazine/rifle/incendiary,
		/obj/item/ammo_magazine/rifle/explosive,
		/obj/item/ammo_magazine/rifle/le,
		/obj/item/ammo_magazine/rifle/ap,
		/obj/item/ammo_magazine/rifle/xm40,
		/obj/item/ammo_magazine/rifle/xm40/heap,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor/xm40_integral,//no rail attachies
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
		)

	random_spawn_chance = 0

/obj/item/weapon/gun/rifle/m41a/elite/xm40/handle_starting_attachment()
	..()
	var/obj/item/attachable/suppressor/xm40_integral/S = new(src)
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.hidden = FALSE
	S.Attach(src)
	update_attachable(S.slot)

	var/obj/item/attachable/magnetic_harness/H = new(src)//integrated mag harness, no rail attachies
	H.flags_attach_features &= ~ATTACH_REMOVABLE
	H.hidden = TRUE
	H.Attach(src)
	update_attachable(H.slot)

/obj/item/weapon/gun/rifle/m41a/elite/xm40/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 16, "rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/m41a/elite/xm40/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/m41a/elite/xm40/ap
	current_mag = /obj/item/ammo_magazine/rifle/xm40
//-------------------------------------------------------
//M41A TRUE AND ORIGINAL

/obj/item/weapon/gun/rifle/m41aMK1
	name = "\improper M41A pulse rifle"
	desc = "殖民地海军陆战队常用的脉冲步枪旧型号。使用10x24毫米无壳弹药。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/assault_rifles.dmi'
	icon_state = "m41amk1" //Placeholder.
	item_state = "m41amk1" //Placeholder.
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1, /obj/item/attachable/stock/rifle/collapsible)
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m41aMK1/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/rifle/m41aMK1/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18, "rail_x" = 12, "rail_y" = 23, "under_x" = 23, "under_y" = 13, "stock_x" = 24, "stock_y" = 14)

/obj/item/weapon/gun/rifle/m41aMK1/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/m41aMK1/ap //for making it start with ap loaded
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1/ap

/obj/item/weapon/gun/rifle/m41aMK1/tactical
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness, /obj/item/attachable/stock/rifle/collapsible)
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1/ap

/obj/item/weapon/gun/rifle/m41aMK1/anchorpoint
	desc = "一把经典的M41 MK1脉冲步枪，涂有崭新的经典亨伯尔170号迷彩。这把枪似乎由锚点空间站上的殖民地海军陆战队分遣队使用，并配备了下挂式霰弹枪。使用10x24毫米无壳弹药。"
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/attached_gun/shotgun)
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1/ap

/obj/item/weapon/gun/rifle/m41aMK1/anchorpoint/gl
	desc = "一把经典的M41 MK1脉冲步枪，涂有崭新的经典亨伯尔170号迷彩。这把枪似乎由锚点空间站上的殖民地海军陆战队分遣队使用，并配备了下挂式榴弹发射器。使用10x24毫米无壳弹药。"
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/attached_gun/grenade/mk1)

//----------------------------------------------
//Special gun for the CO to replace the smartgun

/obj/item/weapon/gun/rifle/m46c
	name = "\improper M46C pulse rifle"
	desc = "M46C原型枪，一种旨在超越标准M41A的实验性步枪平台。仅限旧版。使用标准MK1和MK2步枪弹匣。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/assault_rifles.dmi'
	icon_state = "m46c"
	item_state = "m46c"
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1

	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle/rubber,
		/obj/item/ammo_magazine/rifle/extended,
		/obj/item/ammo_magazine/rifle/ap,
		/obj/item/ammo_magazine/rifle/incendiary,
		/obj/item/ammo_magazine/rifle/toxin,
		/obj/item/ammo_magazine/rifle/penetrating,
		/obj/item/ammo_magazine/rifle/m41aMK1,
		/obj/item/ammo_magazine/rifle/m41aMK1/ap,
		/obj/item/ammo_magazine/rifle/m41aMK1/incendiary,
		/obj/item/ammo_magazine/rifle/m41aMK1/heap,
		/obj/item/ammo_magazine/rifle/m41aMK1/toxin,
		/obj/item/ammo_magazine/rifle/m41aMK1/penetrating,
	)
	//somewhere in between the mk1 and mk2
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/wy,
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
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	explo_proof = TRUE
	auto_retrieval_slot = WEAR_J_STORE
	map_specific_decoration = TRUE
	start_automatic = TRUE

	var/mob/living/carbon/human/linked_human
	var/is_locked = TRUE
	var/iff_enabled = TRUE

/obj/item/weapon/gun/rifle/m46c/Initialize(mapload, ...)
	LAZYADD(actions_types, /datum/action/item_action/m46c/toggle_lethal_mode)
	. = ..()
	AddElement(/datum/element/corp_label/armat)
	if(iff_enabled)
		LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff)
		))
	recalculate_attachment_bonuses()

/obj/item/weapon/gun/rifle/m46c/Destroy()
	linked_human = null
	. = ..()

/obj/item/weapon/gun/rifle/m46c/handle_starting_attachment()
	..()
	var/obj/item/attachable/stock/rifle/collapsible/S = new(src)
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)


/obj/item/weapon/gun/rifle/m46c/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17, "rail_x" = 11, "rail_y" = 19, "under_x" = 24, "under_y" = 12, "stock_x" = 24, "stock_y" = 13)


/obj/item/weapon/gun/rifle/m46c/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/m46c/able_to_fire(mob/user)
	. = ..()
	if(is_locked && linked_human && linked_human != user)
		if(linked_human.is_revivable() || linked_human.stat != DEAD)
			to_chat(user, SPAN_WARNING("[icon2html(src, usr)] 扳机已被[src]锁定。未授权用户。"))
			playsound(loc,'sound/weapons/gun_empty.ogg', 25, 1)
			return FALSE

		UnregisterSignal(linked_human, COMSIG_PARENT_QDELETING)
		linked_human = null
		is_locked = FALSE

/obj/item/weapon/gun/rifle/m46c/pickup(user)
	. = ..()
	if(!linked_human)
		name_after_co(user)
		to_chat(usr, SPAN_NOTICE("[icon2html(src, usr)] 你拾起了\the [src]，将自己注册为其所有者。"))

//---ability actions--\\

/datum/action/item_action/m46c/action_activate()
	. = ..()
	var/obj/item/weapon/gun/rifle/m46c/protag_gun = holder_item
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/protagonist = owner
	if(protagonist.is_mob_incapacitated() || protag_gun.get_active_firearm(protagonist, FALSE) != holder_item)
		return

/datum/action/item_action/m46c/update_button_icon()
	return

/datum/action/item_action/m46c/toggle_lethal_mode/New(Target, obj/item/holder)
	. = ..()
	name = "切换敌我识别"
	action_icon_state = "iff_toggle_on"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/m46c/toggle_lethal_mode/action_activate()
	. = ..()
	var/obj/item/weapon/gun/rifle/m46c/protag_gun = holder_item
	protag_gun.toggle_iff(usr)
	if(protag_gun.iff_enabled)
		action_icon_state = "iff_toggle_on"
	else
		action_icon_state = "iff_toggle_off"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

// -- ability actions procs -- \\

/obj/item/weapon/gun/rifle/m46c/proc/toggle_lock(mob/user)
	if(linked_human && usr != linked_human)
		to_chat(usr, SPAN_WARNING("[icon2html(src, usr)] 操作被[src]拒绝。未授权用户。"))
		return
	else if(!linked_human)
		name_after_co(usr)

	is_locked = !is_locked
	to_chat(usr, SPAN_NOTICE("[icon2html(src, usr)] 你[is_locked? "lock": "unlock"] [src]."))
	playsound(loc,'sound/machines/click.ogg', 25, 1)

/obj/item/weapon/gun/rifle/m46c/proc/toggle_iff(mob/user)
	if(is_locked && linked_human && usr != linked_human)
		to_chat(usr, SPAN_WARNING("[icon2html(src, usr)] 操作被[src]拒绝。未授权用户。"))
		return

	iff_enabled = !iff_enabled
	to_chat(usr, SPAN_NOTICE("[icon2html(src, usr)] 你[iff_enabled? "enable": "disable"] the IFF on [src]."))
	playsound(loc,'sound/machines/click.ogg', 25, 1)

	recalculate_attachment_bonuses()
	if(iff_enabled)
		add_bullet_trait(BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff))
	else
		remove_bullet_trait("iff")

/obj/item/weapon/gun/rifle/m46c/recalculate_attachment_bonuses()
	. = ..()
	if(iff_enabled)
		modify_fire_delay(FIRE_DELAY_TIER_12)
		modify_burst_delay(FIRE_DELAY_TIER_12)

/obj/item/weapon/gun/rifle/m46c/proc/name_after_co(mob/living/carbon/human/H)
	linked_human = H
	RegisterSignal(linked_human, COMSIG_PARENT_QDELETING, PROC_REF(remove_idlock))

/obj/item/weapon/gun/rifle/m46c/get_examine_text(mob/user)
	. = ..()
	if(linked_human)
		if(is_locked)
			. += SPAN_NOTICE("It is registered to [linked_human].")
		else
			. += SPAN_NOTICE("It is registered to [linked_human] but has its fire restrictions unlocked.")
	else
		. += SPAN_NOTICE("It's unregistered. Pick it up to register yourself as its owner.")
	if(!iff_enabled)
		. += SPAN_WARNING("Its IFF restrictions are disabled.")

/obj/item/weapon/gun/rifle/m46c/proc/remove_idlock()
	SIGNAL_HANDLER
	linked_human = null

/obj/item/weapon/gun/rifle/m46c/stripped
	random_spawn_chance = 0//no extra attachies on spawn, still gets its stock though.

//-------------------------------------------------------
//MAR-40 AK CLONE //AK47 and FN FAL together as one.


/obj/item/weapon/gun/rifle/mar40
	name = "\improper MAR-40 battle rifle"
	desc = "一款廉价可靠的7.62x39毫米口径突击步枪。常见于罪犯或雇佣兵手中，或UPP及CLF成员手中。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/assault_rifles.dmi'
	icon_state = "mar40"
	item_state = "mar40"
	fire_sound = 'sound/weapons/gun_mar40.ogg'
	reload_sound = 'sound/weapons/handling/gun_mar40_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_mar40_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/mar40
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/scope/slavic,
	)
	random_spawn_chance = 38
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/slavic,
		/obj/item/attachable/magnetic_harness,
	)
	random_spawn_under = list(
		/obj/item/attachable/gyro,
		/obj/item/attachable/bipod,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/burstfire_assembly,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK
	start_automatic = TRUE



/obj/item/weapon/gun/rifle/mar40/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 17,"rail_x" = 16, "rail_y" = 20, "under_x" = 24, "under_y" = 15, "stock_x" = 24, "stock_y" = 13)


/obj/item/weapon/gun/rifle/mar40/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/mar40/tactical
	desc = "一款廉价可靠的7.62x39毫米口径突击步枪。常见于罪犯或雇佣兵手中，或UPP及CLF成员手中。此型号配备了售后市场弹药计数器。"
	starting_attachment_types = list(/obj/item/attachable/angledgrip, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness)
	flags_gun_features = GUN_AMMO_COUNTER|GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK

/obj/item/weapon/gun/rifle/mar40/carbine
	name = "\improper MAR-30 battle carbine"
	desc = "一款廉价可靠的卡宾枪，使用7.62x39mm弹药。常见于罪犯或雇佣兵之手。"
	icon_state = "mar30"
	item_state = "mar30"
	fire_sound = 'sound/weapons/gun_mar40.ogg'
	reload_sound = 'sound/weapons/handling/gun_mar40_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_mar40_unload.ogg'

	aim_slowdown = SLOWDOWN_ADS_QUICK //Carbine is more lightweight
	wield_delay = WIELD_DELAY_FAST
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_chance = 35
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/bipod,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/rifle/mar40/carbine/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_2
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/rifle/mar40/carbine/tactical
	desc = "一款廉价可靠的卡宾枪，使用7.62x39mm弹药。常见于罪犯或雇佣兵之手。这把枪加装了售后市场的弹药计数器。"
	starting_attachment_types = list(/obj/item/attachable/verticalgrip, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness)
	flags_gun_features = GUN_AMMO_COUNTER|GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK

/obj/item/weapon/gun/rifle/mar40/lmg
	name = "\improper MAR-50 light machine gun"
	desc = "一款廉价可靠的轻机枪，使用7.62x39mm弹药。常见于资金稍充裕的罪犯之手。"
	icon_state = "mar50"
	item_state = "mar50"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/machineguns.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/machineguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/machineguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/lmg_mouse.dmi'

	fire_sound = 'sound/weapons/gun_mar40.ogg'
	reload_sound = 'sound/weapons/handling/gun_mar40_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_mar40_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/mar40/lmg
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/slavic,
	)
	random_spawn_chance = 38
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/slavic,
		/obj/item/attachable/magnetic_harness,
	)
	random_spawn_under = list() //prevents equipping invalid attachments from base
	random_spawn_muzzle = list()

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY
	hud_offset = -4
	pixel_x = -4

/obj/item/weapon/gun/rifle/mar40/lmg/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 41, "muzzle_y" = 18, "rail_x" = 16, "rail_y" = 20, "under_x" = 30, "under_y" = 16, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/mar40/lmg/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	set_burst_amount(BURST_AMOUNT_TIER_5)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_1
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/mar40/lmg/tactical
	desc = "一款廉价可靠的轻机枪，使用7.62x39mm弹药。常见于资金稍充裕的罪犯之手。这把枪加装了售后市场的弹药计数器。"
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)
	flags_gun_features = GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY
//-------------------------------------------------------
//M16 RIFLE

/obj/item/weapon/gun/rifle/m16
	name = "\improper M16 rifle"
	desc = "一款古老可靠的设计，最初于20世纪60年代被美军采用。这种东西应该放在战争历史博物馆里。使用5.56x45mm弹药。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/assault_rifles.dmi'
	icon_state = "m16"
	item_state = "m16"

	fire_sound = 'sound/weapons/gun_m16.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_m16_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/m16
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
	)
	random_spawn_chance = 42
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/bipod,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ANTIQUE

/obj/item/weapon/gun/rifle/m16/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 17 ,"rail_x" = 13, "rail_y" = 20, "under_x" = 26, "under_y" = 14, "stock_x" = 15, "stock_y" = 14)

/obj/item/weapon/gun/rifle/m16/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_6
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/m16/m16a5
	name = "\improper M16A5 rifle"
	desc = "M16平台步枪的现代化版本，可能源自UA在换装新设计后留下的无尽库存。使用5.56x45mm弹药。"
	desc_lore = "The M16A5, introduced in 2016 has become something of a timeless classic in UA territory. The design rights for the gun and its many related platforms came into Armat ownership after their acquisition of Colt, and it's remained a surprisingly lucrative patent since then. While dated, the weapon's ease of use and more conventional rounds have made it popular among minimally-trained colonists and isolated units alike, being much easier to self-produce replacement parts and ammunition for than more advanced alternatives like pulse rifles and caseless ammunition. Subsequently, it remains a common sight on many colonies, and even in the reserve armories of some USCMC vessels like the Sulaco, partly from tradition and partly because of the sheer surplus supply of rifles that's lasted nearly two centuries."
	icon_state = "m16a5"
	item_state = "m16a5"
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
	)

/obj/item/weapon/gun/rifle/m16/m16a5/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 34, "muzzle_y" = 17 ,"rail_x" = 11, "rail_y" = 20, "under_x" = 24, "under_y" = 14, "stock_x" = 15, "stock_y" = 14)


/obj/item/weapon/gun/rifle/m16/m16a5/tactical
	random_spawn_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
	)

/obj/item/weapon/gun/rifle/m16/grenadier
	name = "\improper M16 grenadier rifle"
	desc = "一款古老可靠的设计，最初于20世纪60年代被美军采用。这种东西应该放在战争历史博物馆里。使用5.56x45mm弹药。这把枪装有一个不可拆卸的M203榴弹发射器，一次可装填一发专用的40mm榴弹，它缺乏现代敌我识别系统，会命中第一个击中的目标；给你的“小朋友”打个招呼吧。"
	icon_state = "m16g"
	item_state = "m16"
	fire_sound = 'sound/weapons/gun_m16.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_m16_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m16
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/compensator,
		/obj/item/attachable/attached_gun/grenade/m203,
	)
	random_spawn_chance = 42
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/rifle/m16/grenadier/handle_starting_attachment()
	..()
	var/obj/item/attachable/attached_gun/grenade/m203/integrated = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated.hidden = FALSE
	integrated.Attach(src)
	update_attachable(integrated.slot)

//-------------------------------------------------------
//XM177 carbine
//awesome vietnam era special forces carbine version of the M16

/obj/item/weapon/gun/rifle/xm177
	name = "\improper XM177E2 carbine"
	desc = "一款老式设计，本质上是带折叠枪托的缩短版M16A1。使用5.56x45mm弹药。短枪身限制了大多数下挂附件的安装，枪管调节器则禁止安装所有枪口装置。"
	desc_lore = "A carbine similar to the M16A1, with a collapsible stock and a distinct flash suppressor. A stamp on the receiver reads: 'COLT AR-15 - PROPERTY OF U.S. GOVT - XM177E2 - CAL 5.56MM' \nA design originating from the Vietnam War, the XM177, also known as the Colt Commando or GAU-5/A, was an improvement on the CAR-15 Model 607, fixing multiple issues found with the limited service of the Model 607 with Special Forces. The XM177 saw primary use with Army Special Forces and Navy Seals operating as commandos. \nHow this got here is a mystery."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/assault_rifles.dmi'
	icon_state = "xm177"
	item_state = "m16"
	current_mag = /obj/item/ammo_magazine/rifle/m16

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ANTIQUE

	fire_sound = 'sound/weapons/gun_m16.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_m16_unload.ogg'
	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/m16,
		/obj/item/ammo_magazine/rifle/m16/ap,
		/obj/item/ammo_magazine/rifle/m16/ext,
	)

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/xm177,
	)

	random_spawn_chance = 75
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)
	random_spawn_under = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under_barrel,
	)

	starting_attachment_types = list(/obj/item/attachable/stock/xm177)

/obj/item/weapon/gun/rifle/xm177/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 18, "rail_x" = 8, "rail_y" = 20, "under_x" = 18, "under_y" = 13, "stock_x" = 14, "stock_y" = 14)

/obj/item/weapon/gun/rifle/xm177/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_SMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_6
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/xm177/car15a3
	name = "\improper CAR-15A3 carbine"
	desc = "XM177的现代化版本，为特种部队和殖民地治安官办公室的有限使用而开发。短枪身限制了大多数下挂附件的安装，枪管调节器则禁止安装所有枪口装置。"
	desc_lore = null
	icon_state = "car15a3"
	item_state = "car15a3"

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/xm177,
		/obj/item/attachable/stock/xm177/car15a3,
	)

	starting_attachment_types = list(/obj/item/attachable/stock/xm177/car15a3)

/obj/item/weapon/gun/rifle/xm177/car15a3/tactical
	random_spawn_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
	)
	random_spawn_under = list(
		/obj/item/attachable/lasersight,
	)


//-------------------------------------------------------
//AR10 rifle
//basically an early M16

/obj/item/weapon/gun/rifle/ar10
	name = "\improper AR10 rifle"
	desc = "更为普及的M16步枪的早期版本。被认为是20世纪步枪之父。这东西怎么会出现在这里本身就是一个谜。使用7.62x51mm弹药。"
	desc_lore = "The AR10 was initially manufactured by the Armalite corporation (bought by Weyland-Yutani in 2002) in the 1950s. It was the first production rifle to incorporate many new and innovative features, such as a gas operated bolt and carrier system. Only 10,000 were ever produced, and the only national entities to use them were Portugal and Sudan. Since the end of the 20th century, these rifles - alongside the far more common M16 and AR15 - have floated around the less civilized areas of space, littering jungles and colony floors with their uncommon cased ammunition - a rarity since the introduction of pulse munitions. This rifle has the word \"Salazar\" engraved on its side."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/assault_rifles.dmi'
	icon_state = "ar10"
	item_state = "ar10"
	fire_sound = 'sound/weapons/gun_ar10.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_ar10_unload.ogg'
	cocked_sound = 'sound/weapons/handling/gun_ar10_cocked.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/ar10
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/compensator,
	)
	random_spawn_chance = 10
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/bipod,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ANTIQUE

/obj/item/weapon/gun/rifle/ar10/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 17, "rail_x" = 12, "rail_y" = 20, "under_x" = 26, "under_y" = 14, "stock_x" = 15, "stock_y" = 14)

/obj/item/weapon/gun/rifle/ar10/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_7)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_8
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

//-------------------------------------------------------
//DUTCH'S GEAR

/obj/item/weapon/gun/rifle/m16/dutch
	name = "\improper Dutch's M16A1"
	desc = "荷兰十二人雇佣兵使用的改装版M16。侧面标签上印有‘CLOAKER KILLER’。使用5.56x45mm弹药。"
	icon_state = "m16a1"
	current_mag = /obj/item/ammo_magazine/rifle/m16/ap
	starting_attachment_types = list(/obj/item/attachable/bayonet)

	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/rifle/m16/dutch/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8

/obj/item/weapon/gun/rifle/m16/grenadier/dutch
	name = "\improper Dutch's Grenadier M16A1"
	desc = "荷兰十二人雇佣兵使用的改装版M16。侧面标签上印有‘CLOAKER KILLER’。使用5.56x45mm弹药。这把枪装有一个不可拆卸的M203榴弹发射器，一次可装填一发专用的40mm榴弹，它缺乏现代敌我识别系统，会命中第一个击中的目标；给你的“小朋友”打个招呼吧。"
	current_mag = /obj/item/ammo_magazine/rifle/m16/ap
	starting_attachment_types = list(/obj/item/attachable/scope/mini, /obj/item/attachable/bayonet)

/obj/item/weapon/gun/rifle/m16/grenadier/dutch/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8

/obj/item/weapon/gun/rifle/xm177/dutch
	name = "\improper Dutch's XM177E2 Carbine"
	desc = "荷兰十二人雇佣兵使用的改装版XM177。侧面标签上印有‘CLOAKER KILLER’。使用5.56x45mm弹药。短枪身限制了大多数下挂附件的安装，枪管调节器则禁止安装所有枪口装置。"
	desc_lore = "A carbine similar to the M16A1, with a collapsible stock and a distinct flash suppressor. A stamp on the receiver reads: 'COLT AR-15 - PROPERTY OF U.S. GOVT - XM177E2 - CAL 5.56MM', above the receiver is a crude sketching of some sort of mask? with the words 'CLOAKER KILLER' and seven tally marks etched on. \nA design originating from the Vietnam War, the XM177, also known as the Colt Commando or GAU-5/A, was an improvement on the CAR-15 Model 607, fixing multiple issues found with the limited service of the Model 607 with Special Forces. The XM177 saw primary use with Army Special Forces and Navy Seals operating as commandos. \nHow this got here is a mystery."
	icon_state = "xm177"
	current_mag = /obj/item/ammo_magazine/rifle/m16/ap

/obj/item/weapon/gun/rifle/xm177/dutch/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_SMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8
	recoil_unwielded = RECOIL_AMOUNT_TIER_2


//-------------------------------------------------------
//M41AE2 HEAVY PULSE RIFLE

/obj/item/weapon/gun/rifle/lmg
	name = "\improper M41AE2 heavy pulse rifle"
	desc = "一种大型班组支援武器，能够从固定阵地进行持续压制射击。虽然不稳定且精度较低，但可以双手携带并射击。与其较小的兄弟M41A MK2和M4RA一样，M41AE2使用10mm弹药。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/machineguns.dmi'
	icon_state = "m41ae2"
	item_state = "m41ae2"
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/machineguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/machineguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/lmg_mouse.dmi'

	reload_sound = 'sound/weapons/handling/hpr_reload.ogg'
	unload_sound = 'sound/weapons/handling/hpr_unload.ogg'
	fire_sound = 'sound/weapons/gun_hpr.ogg'

	aim_slowdown = SLOWDOWN_ADS_LMG
	map_specific_decoration = TRUE
	current_mag = /obj/item/ammo_magazine/rifle/lmg
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/stock/rifle/collapsible/m41ae2,
		/obj/item/attachable/bipod/m41ae2,
	)

	pixel_x = -1

	starting_attachment_types = list(
		/obj/item/attachable/stock/rifle/collapsible/m41ae2,
		/obj/item/attachable/bipod/m41ae2,
	)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY
	gun_category = GUN_CATEGORY_HEAVY
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/lmg/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/rifle/lmg/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 34, "muzzle_y" = 19, "rail_x" = 12, "rail_y" = 23, "under_x" = 27, "under_y" = 13, "stock_x" = 14, "stock_y" = 15)

/obj/item/weapon/gun/rifle/lmg/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	set_burst_amount(BURST_AMOUNT_TIER_5)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	fa_scatter_peak = FULL_AUTO_SCATTER_PEAK_TIER_3
	fa_max_scatter = SCATTER_AMOUNT_TIER_4
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_5
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_1


/obj/item/weapon/gun/rifle/lmg/tactical
	current_mag = /obj/item/ammo_magazine/rifle/lmg/ap
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/suppressor, /obj/item/attachable/angledgrip)
/obj/item/weapon/gun/rifle/lmg/tactical/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2//equal to m41a dmg
//-------------------------------------------------------


//-------------------------------------------------------
//UPP TYPE 71 RIFLE

/obj/item/weapon/gun/rifle/type71
	name = "\improper Type 71 pulse rifle"
	desc = "UPP太空部队的主要制式步枪，71式是一款符合人体工程学、轻量化的脉冲步枪，使用5.45x39mm弹药。根据压制与优势火力的战术原则，该步枪射速高，并配备大容量盒式弹匣。尽管精度平平，但集成的后坐力抑制机制使其在点射时出奇地可控。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/assault_rifles.dmi'
	icon_state = "type71"
	item_state = "type71"

	pixel_x = -6
	hud_offset = -6

	fire_sound = 'sound/weapons/gun_type71.ogg'
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/type71
	wield_delay = WIELD_DELAY_FAST
	attachable_allowed = list(
		/obj/item/attachable/flashlight, // Rail
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/suppressor, // Muzzle
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
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/verticalgrip, // Underbarrel
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	flags_equip_slot = SLOT_BACK
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/type71/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/weapon/gun/rifle/type71/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 39, "muzzle_y" = 17, "rail_x" = 16, "rail_y" = 23, "under_x" = 26, "under_y" = 13, "stock_x" = 11, "stock_y" = 13)

/obj/item/weapon/gun/rifle/type71/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_8)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_9)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT //10~ more damage than m41, as well as higher ap from bullet, slightly higher DPS, 133>137.5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/rifle/type71/rifleman
	//add GL
	random_spawn_chance = 100
	random_rail_chance = 70
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
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

/obj/item/weapon/gun/rifle/type71/dual
	random_spawn_chance = 100
	random_rail_chance = 70
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)
	random_muzzle_chance = 100
	random_spawn_muzzle = list(
		/obj/item/attachable/bayonet/upp,
	)
	random_under_chance = 40
	random_spawn_under = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/verticalgrip,
	)

/obj/item/weapon/gun/rifle/type71/sapper
	current_mag = /obj/item/ammo_magazine/rifle/type71/ap
	random_spawn_chance = 100
	random_rail_chance = 80
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
	)
	random_muzzle_chance = 80
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/upp,
	)
	random_under_chance = 90
	random_spawn_under = list(
		/obj/item/attachable/attached_gun/extinguisher,
	)

/obj/item/weapon/gun/rifle/type71/flamer
	name = "\improper Type 71-F pulse rifle"
	desc = "这似乎是71式的一种较不常见的变体，配备了一个看起来特别强大的集成火焰喷射器。"
	attachable_allowed = list(
		/obj/item/attachable/flashlight, // Rail
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/suppressor, // Muzzle
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
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
	)

/obj/item/weapon/gun/rifle/type71/flamer/handle_starting_attachment()
	..()
	var/obj/item/attachable/attached_gun/flamer/advanced/integrated/S = new(src)
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)

/obj/item/weapon/gun/rifle/type71/flamer/leader
	random_spawn_chance = 100
	random_rail_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/mini,
	)
	random_muzzle_chance = 100
	random_spawn_muzzle = list(
		/obj/item/attachable/bayonet/upp,
	)

/obj/item/weapon/gun/rifle/type71/carbine
	name = "\improper Type 71 pulse carbine"
	desc = "71式的卡宾枪变体，更易于操控，但代价是威力降低。由于士兵评价不佳，它已退出前线使用，仅配发给预备役或预计不会面临激烈战斗的部队。"
	icon_state = "type71c"
	item_state = "type71c"

	pixel_x = 0
	hud_offset = 0

	aim_slowdown = SLOWDOWN_ADS_QUICK //Carbine is more lightweight
	wield_delay = WIELD_DELAY_VERY_FAST
	bonus_overlay_x = 2
	force = 20 //integrated melee mod from stock, which doesn't fit on the gun but is still clearly there on the sprite
	attachable_allowed = list(
		/obj/item/attachable/flashlight, // Rail
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/suppressor, // Muzzle
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
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/verticalgrip, // Underbarrel
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/extinguisher,
		)

	random_spawn_muzzle = list() //no default bayonet

/obj/item/weapon/gun/rifle/type71/carbine/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 17,"rail_x" = 14, "rail_y" = 23, "under_x" = 25, "under_y" = 14, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/type71/carbine/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)//same fire rate as m41
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_4//same damage as m41 reg bullets probably
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
		scatter = SCATTER_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/type71/carbine/dual
	random_spawn_chance = 100
	random_rail_chance = 70
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
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

/obj/item/weapon/gun/rifle/type71/carbine/commando
	name = "\improper Type 71 '突击队员' pulse carbine"
	desc = "71式的一种更为罕见的变体，此版本包含集成消音器、集成瞄准镜和广泛的精细调校。许多部件已被更换、打磨和改进。因此，这种变体很少在突击队单位之外见到。"
	icon_state = "type73"
	item_state = "type73"

	pixel_x = -2
	hud_offset = -2

	fire_sound = "gun_silenced"
	wield_delay = 0 //Ends up being .5 seconds due to scope
	inherent_traits = list(TRAIT_GUN_SILENCED)
	current_mag = /obj/item/ammo_magazine/rifle/type71/ap
	attachable_allowed = list(
		/obj/item/attachable/verticalgrip,
	)
	random_spawn_chance = 0
	random_spawn_rail = list()
	random_spawn_muzzle = list()
	bonus_overlay_x = 1
	bonus_overlay_y = 0

/obj/item/weapon/gun/rifle/type71/carbine/commando/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 17,"rail_x" = 10, "rail_y" = 22, "under_x" = 23, "under_y" = 14, "stock_x" = 21, "stock_y" = 18)

/obj/item/weapon/gun/rifle/type71/carbine/commando/handle_starting_attachment()
	..()
	//scope
	var/obj/item/attachable/scope/mini/scope = new(src)
	scope.hidden = TRUE
	scope.flags_attach_features &= ~ATTACH_REMOVABLE
	scope.Attach(src)
	update_attachable(scope.slot)

/obj/item/weapon/gun/rifle/type71/carbine/commando/set_gun_config_values()
	..()
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_delay(FIRE_DELAY_TIER_12)
	scatter = SCATTER_AMOUNT_TIER_8

	//-------------------------------------------------------

// Norcomm AK-4047 - Space AK47 - UPP Gun - MK2 equivalent

/obj/item/weapon/gun/rifle/ak4047
	name = "\improper AK-4047 pulse assault rifle"
	desc = "UPP版的M41A脉冲步枪，AK-4047是一款廉价可靠的替代品。因此，这种武器常常落入雇佣兵和叛乱分子之手。虽然不如M41精准，但AK-4047比USCMC的武器更坚固。一把AK-4047即使被扔下悬崖并在水下浸泡一个月，依然能正常工作。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/assault_rifles.dmi'
	icon_state = "ak4047"
	item_state = "ak4047"
	fire_sound = 'sound/weapons/gun_ak4047.ogg'
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/ak4047
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
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
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/rifle/collapsible/ak4047,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	map_specific_decoration = FALSE
	start_automatic = TRUE
	flags_equip_slot = SLOT_BACK
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible/ak4047)

	pixel_x = -6
	hud_offset = -6

/obj/item/weapon/gun/rifle/ak4047/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/weapon/gun/rifle/ak4047/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 38, "muzzle_y" = 18,"rail_x" = 20, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 11, "stock_y" = 13, "special_x" = 33, "special_y" = 17)

/obj/item/weapon/gun/rifle/ak4047/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/ak4047/tactical
	current_mag = /obj/item/ammo_magazine/rifle/ak4047
	starting_attachment_types = list(/obj/item/attachable/reflex, /obj/item/attachable/suppressor, /obj/item/attachable/verticalgrip, /obj/item/attachable/stock/rifle/collapsible/ak4047)

	//-------------------------------------------------------

//M4RA Battle Rifle, standard USCM DMR

/obj/item/weapon/gun/rifle/m4ra
	name = "\improper M4RA battle rifle"
	desc = "阿玛特战场系统M4RA战斗步枪是USCM服役的一款指定射手步枪。采用无托结构，M4RA战斗步枪是侦察和火力支援小组的完美选择。\n*仅*可使用非高速M4RA弹匣。"
	icon_state = "m4ra"
	item_state = "m4ra"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/marksman_rifles.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/marksman_rifles.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/marksman_rifles.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/marksman_rifles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/marksman_rifles_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/sniper_mouse.dmi'

	fire_sound = 'sound/weapons/gun_m4ra.ogg'
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/m4ra
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bipod,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/alt_iff_scope,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/flare_launcher,
	)

	starting_attachment_types = list(/obj/item/attachable/attached_gun/flare_launcher)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	map_specific_decoration = TRUE
	pixel_x = -5
	hud_offset = -5

/obj/item/weapon/gun/rifle/m4ra/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/rifle/m4ra/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 22, "rail_y" = 21, "under_x" = 30, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "special_x" = 37, "special_y" = 16)

/obj/item/weapon/gun/rifle/m4ra/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_amount(0)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
		accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_8
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8
	recoil_unwielded = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8

/obj/item/weapon/gun/rifle/m4ra/training
	current_mag = /obj/item/ammo_magazine/rifle/m4ra/rubber

/obj/item/weapon/gun/rifle/m4ra/tactical
	current_mag = /obj/item/ammo_magazine/rifle/m4ra/extended
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/suppressor, /obj/item/attachable/angledgrip)


//-------------------------------------------------------

//L42A Battle Rifle

/obj/item/weapon/gun/rifle/l42a
	name = "\improper L42A battle rifle"
	desc = "阿玛特战场系统L42A战斗步枪，常见于银河系边疆地区。由于其坚固可靠且无需太多训练即可轻松使用，常被殖民者用于自卫，也被许多殖民地民兵（无论他们效忠于谁）所使用。这款步枪曾被USCM考虑采用并测试了一段时间，但最终输给了已在服役的M4RA。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/marksman_rifles.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/marksman_rifles.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/marksman_rifles.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/marksman_rifles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/marksman_rifles_righthand.dmi'
	)
	icon_state = "l42mk1"
	item_state = "l42mk1"
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	fire_sound = 'sound/weapons/gun_carbine.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/l42a
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/carbine,
		/obj/item/attachable/stock/carbine/wood,
		/obj/item/attachable/bipod,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/alt_iff_scope,
		/obj/item/attachable/flashlight/grip,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	starting_attachment_types = list(/obj/item/attachable/stock/carbine)
	map_specific_decoration = TRUE

/obj/item/weapon/gun/rifle/l42a/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/rifle/l42a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 18, "under_y" = 15, "stock_x" = 22, "stock_y" = 10)

/obj/item/weapon/gun/rifle/l42a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_amount(0)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_6
	recoil_unwielded = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8

/obj/item/weapon/gun/rifle/l42a/training
	current_mag = /obj/item/ammo_magazine/rifle/l42a/rubber

//-------------------------------------------------------
//-------------------------------------------------------
//ABR-40 hunting rifle

// Civilian version of the L42A, used for hunting, and also by undersupplied paramilitary groups.

/obj/item/weapon/gun/rifle/l42a/abr40
	name = "\improper ABR-40 hunting rifle"
	desc = "L42A战斗步枪的民用版本。几乎完全相同，甚至与L42弹匣交叉兼容，只是别拆枪托。"
	desc_lore = "The ABR-40 was created along-side the L42A as a hunting rifle for civilians. Sporting faux wooden furniture and a legally-mandated 12 round magazine, it's still highly accurate and deadly, a favored pick of experienced hunters and retired Marines. However, it's very limited in attachment selection, only being able to fit rail attachments, and the differences in design from the L42 force an awkward pose when attempting to hold it one-handed. Removing the stock is not recommended."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/marksman_rifles.dmi'
	icon_state = "abr40"
	item_state = "abr40"
	current_mag = /obj/item/ammo_magazine/rifle/l42a/abr40
	attachable_allowed = list(
		//Barrel,
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
		//Rail,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini/hunting,
		//Stock,
		/obj/item/attachable/stock/carbine,
		/obj/item/attachable/stock/carbine/wood,
		/obj/item/attachable/stock/carbine/wood/tactical,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_FAST
	starting_attachment_types = list(/obj/item/attachable/stock/carbine/wood, /obj/item/attachable/scope/mini/hunting)
	map_specific_decoration = FALSE
	civilian_usable_override = TRUE

// Identical to the L42 in stats, *except* for extra recoil and scatter that are nulled by keeping the stock on.
/obj/item/weapon/gun/rifle/l42a/abr40/set_gun_config_values()
	..()
	accuracy_mult = (BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5) - HIT_ACCURACY_MULT_TIER_10
	recoil = RECOIL_AMOUNT_TIER_4
	scatter = (SCATTER_AMOUNT_TIER_8) + SCATTER_AMOUNT_TIER_5


/obj/item/weapon/gun/rifle/l42a/abr40/tactical
	name = "\improper ABR-40 tactical rifle"
	desc = "L42A战斗步枪的民用版本，常被陆战队员使用。几乎完全相同，甚至与L42弹匣交叉兼容，只是别拆枪托。这把步枪似乎拥有独特的战术蓝黑涂装以及一些杂项的售后改装。"
	desc_lore = "The ABR-40 was created after the striking popularity of the L42 battle rifle as a hunting rifle for civilians, and naturally fell into the hands of many underfunded paramilitary groups and insurrections in turn, due to its smooth and simple handling and cross-compatibility with L42A magazines."
	icon_state = "abr40_tac"
	item_state = "abr40_tac"
	current_mag = /obj/item/ammo_magazine/rifle/l42a/ap
	attachable_allowed = list(
		//Barrel,
		/obj/item/attachable/suppressor,
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
		//Under,
		/obj/item/attachable/flashlight/grip,
		//Stock,
		/obj/item/attachable/stock/carbine/wood,
		/obj/item/attachable/stock/carbine/wood/tactical,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/carbine/wood/tactical, /obj/item/attachable/suppressor)
	random_under_chance = 100
	random_spawn_under = list(/obj/item/attachable/flashlight/grip)

/obj/item/weapon/gun/rifle/l42a/abr40/tactical/handle_starting_attachment()
	..()
	var/obj/item/attachable/magnetic_harness/integrated = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated.hidden = TRUE
	integrated.Attach(src)
	update_attachable(integrated.slot)

/obj/item/weapon/gun/rifle/l42a/abr40/tactical/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10)
	set_burst_amount(0)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_7
	recoil_unwielded = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8

//=ROYAL MARINES=\\

/obj/item/weapon/gun/rifle/rmc_f90
	name = "\improper F903A1 Rifle"
	desc = "皇家海军陆战队的标准制式步枪。独特的是，皇家海军陆战队是唯一不使用脉冲武器的现代军队。使用10x24mm无壳弹药。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/TWE/assault_rifles.dmi'
	icon_state = "aug"
	item_state = "aug"
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/rmc_f90
	flags_equip_slot = NO_FLAGS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	map_specific_decoration = FALSE
	aim_slowdown = SLOWDOWN_ADS_QUICK

/obj/item/weapon/gun/rifle/rmc_f90/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/weapon/gun/rifle/rmc_f90/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 16,"rail_x" = 15, "rail_y" = 21, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/rmc_f90/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	burst_amount = BURST_AMOUNT_TIER_3
	burst_delay = FIRE_DELAY_TIER_11
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/rmc_f90/a_grip
	name = "\improper F903A2 Rifle"
	desc = "皇家海军陆战队的非标准制式步枪，F903A2目前正逐步成为皇家海军陆战队的新主力步枪，但目前仅由单位指挥官使用。独特的是，皇家海军陆战队是唯一不使用脉冲武器的现代军队。使用10x24mm无壳弹药。"
	icon_state = "aug_com"
	item_state = "aug_com"
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
	)

/obj/item/weapon/gun/rifle/rmc_f90/a_grip/handle_starting_attachment()
	..()
	var/obj/item/attachable/angledgrip/f90_agrip = new(src)
	f90_agrip.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_agrip.hidden = TRUE
	f90_agrip.Attach(src)
	update_attachable(f90_agrip.slot)

/obj/item/weapon/gun/rifle/rmc_f90/scope
	name = "\improper F903A1 Marksman Rifle"
	desc = "皇家海军陆战队突击队使用的F903步枪变体。此武器仅兼容较小的10x24毫米20发弹匣。"
	icon_state = "aug_dmr"
	item_state = "aug_dmr"
	attachable_allowed = null
	current_mag = /obj/item/ammo_magazine/rifle/rmc_f90/marksman

/obj/item/weapon/gun/rifle/rmc_f90/scope/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	burst_amount = 0
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_6
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/rmc_f90/scope/handle_starting_attachment()
	..()
	var/obj/item/attachable/scope/mini/f90/f90_scope = new(src)
	var/obj/item/attachable/angledgrip/f90_agrip = new(src)
	f90_scope.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_agrip.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_scope.hidden = TRUE
	f90_agrip.hidden = TRUE
	f90_agrip.Attach(src)
	f90_scope.Attach(src)
	update_attachable(f90_agrip.slot)
	update_attachable(f90_scope.slot)

/obj/item/weapon/gun/rifle/rmc_f90/shotgun
	name = "\improper F903A1/B 'Breacher' Rifle"
	desc = "皇家海军陆战队突击队使用的F903步枪变体。经过改装，可单手配合盾牌使用。使用10x24毫米无壳弹药。"
	icon_state = "aug_mkey"
	item_state = "aug_mkey"
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)

/obj/item/weapon/gun/rifle/rmc_f90/shotgun/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	burst_amount = BURST_AMOUNT_TIER_3
	burst_delay = FIRE_DELAY_TIER_11
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil_unwielded = RECOIL_OFF

/obj/item/weapon/gun/rifle/rmc_f90/shotgun/handle_starting_attachment()
	..()
	var/obj/item/attachable/attached_gun/shotgun/f90_shotgun = new(src)
	f90_shotgun.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_shotgun.hidden = TRUE
	f90_shotgun.Attach(src)
	update_attachable(f90_shotgun.slot)


//NSG 23 ASSAULT RIFLE - RMC VARIANT

/obj/item/weapon/gun/rifle/l23
	name = "\improper L23 assault rifle"
	desc = "这种步枪很罕见，最常见于三世界帝国皇家海军陆战队员手中。与M41A MK2相比，其操控性显著提升，性能也大幅增强。这把涂有皇家海军陆战队的紫蓝色迷彩。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/TWE/assault_rifles.dmi'
	icon_state = "l23"
	item_state = "l23"
	fire_sound = "gun_nsg23"
	reload_sound = 'sound/weapons/handling/nsg23_reload.ogg'
	unload_sound = 'sound/weapons/handling/nsg23_unload.ogg'
	cocked_sound = 'sound/weapons/handling/nsg23_cocked.ogg'
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_VERY_FAST
	current_mag = /obj/item/ammo_magazine/rifle/l23
	force = 10

	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/nsg,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/grenade/u1rmc,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/shotgun/af13,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/variable_zoom/twe,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER

	random_spawn_chance = 100 //L23 always spawns with attachments (for proper NSG underrail offsets it's X=23 Y=13)
	random_spawn_under = list(
		/obj/item/attachable/attached_gun/grenade/u1rmc,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun/af13,
	)
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor/nsg,
	)
	start_semiauto = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/l23/Initialize(mapload, spawn_empty)
	. = ..()
	update_icon()
	AddElement(/datum/element/corp_label/wy)

/obj/item/weapon/gun/rifle/l23/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 37, "muzzle_y" = 16, "rail_x" = 14, "rail_y" = 21, "under_x" = 26, "under_y" = 10, "stock_x" = 5, "stock_y" = 17)

/obj/item/weapon/gun/rifle/l23/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11 + FIRE_DELAY_TIER_12/4)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_SG + FIRE_DELAY_TIER_12/4)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_2_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	damage_falloff_mult = 0
	fa_max_scatter = SCATTER_AMOUNT_TIER_5

//***************************************************************//
/obj/item/weapon/gun/rifle/l23/breacher // One-handed UBS rifle
	name = "\improper L23-B assault rifle"
	desc = "这种步枪很罕见，最常见于三世界帝国皇家海军陆战队员手中。此特定型号经过改装，以便皇家海军陆战队在狭窄空间作战，允许单手射击。然而，为使其紧凑而缩短的枪管严重削弱了其停止作用。连发模式的后坐力依然像骡子踢一样猛。与M41A MK2相比，其操控性显著提升，性能也大幅增强。这把涂有皇家海军陆战队的紫蓝色迷彩。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/TWE/assault_rifles.dmi'
	icon_state = "l23"
	item_state = "l23"
	fire_sound = "gun_nsg23"
	reload_sound = 'sound/weapons/handling/nsg23_reload.ogg'
	unload_sound = 'sound/weapons/handling/nsg23_unload.ogg'
	cocked_sound = 'sound/weapons/handling/nsg23_cocked.ogg'
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_VERY_FAST
	current_mag = /obj/item/ammo_magazine/rifle/l23/extended

	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/attached_gun/shotgun/af13b,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/scope/mini,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	auto_retrieval_slot = WEAR_J_STORE

	random_spawn_chance = 100 //L23 always spawns with attachments (for proper NSG underrail offsets it's X=23 Y=13)

	random_spawn_rail = list(
		/obj/item/attachable/reflex,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/bayonet/rmc,
	)
	start_semiauto = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/l23/breacher/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11 + FIRE_DELAY_TIER_12/4
	burst_amount = BURST_AMOUNT_TIER_3
	burst_delay = FIRE_DELAY_TIER_SG + FIRE_DELAY_TIER_12/4
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/l23/breacher/handle_starting_attachment() //Adds L23-B's breaching shotgun
	..()
	var/obj/item/attachable/attached_gun/shotgun/af13b/S = new(src)
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)

/obj/item/weapon/gun/rifle/l23/leader
	starting_attachment_types = list(
		/obj/item/attachable/attached_gun/flamer/advanced,
	)

//L42A3 Battle Rifle

/obj/item/weapon/gun/rifle/l64a3
	name = "\improper L64A3 battle rifle"
	desc = "由豪沃友精密机械为皇家海军陆战队和帝国太空武装部队开发的轻型精确射手步枪。以其可靠性著称。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/TWE/marksman_rifles.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/marksman_rifles.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/marksman_rifles.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/marksman_rifles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/marksman_rifles_righthand.dmi'
	)
	icon_state = "l42a3"
	item_state = "l42a3"
	reload_sound = 'sound/weapons/handling/rmcdmr_reload.ogg'
	unload_sound = 'sound/weapons/handling/rmcdmr_unload.ogg'
	fire_sound = "gun_l64"
	current_mag = /obj/item/ammo_magazine/rifle/l64

	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/nsg,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bipod,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/scope/variable_zoom/twe,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
	)

	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/l64,
		/obj/item/ammo_magazine/rifle/l64/ap,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK

/obj/item/weapon/gun/rifle/l64a3/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 37, "muzzle_y" = 16, "rail_x" = 17, "rail_y" = 22, "under_x" = 27, "under_y" = 14, "stock_x" = 22, "stock_y" = 10)

/obj/item/weapon/gun/rifle/l64a3/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_amount(0)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_10 + BULLET_DAMAGE_MULT_TIER_4
	recoil = RECOIL_AMOUNT_TIER_3 + RECOIL_AMOUNT_TIER_5/2
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8


/obj/item/weapon/gun/rifle/l64a3/marksman
	name = "\improper L64A3 battle rifle"
	desc = "由豪沃友精密机械为皇家海军陆战队和帝国太空武装部队开发的轻型精确射手步枪。可靠且致命。"

	current_mag = /obj/item/ammo_magazine/rifle/l64/ap

	random_spawn_chance = 100 //L42A3 always spawns with attachments
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor/nsg,
	)

	random_spawn_under = list(
		/obj/item/attachable/bipod,
	)

/obj/item/weapon/gun/rifle/l64a3/marksman/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)

/obj/item/weapon/gun/rifle/l64a3/marksman/handle_starting_attachment() //Adds Marksman DMR's standard attachments.
	..()
	var/obj/item/attachable/scope/variable_zoom/twe/SC = new(src)
	SC.flags_attach_features &= ~ATTACH_REMOVABLE
	SC.Attach(src)
	update_attachable(SC.slot)


//-------------------------------------------------------


//-------------------------------------------------------
//XM51, Breaching Scattergun

/obj/item/weapon/gun/rifle/xm51
	name = "\improper XM51 breaching scattergun"
	desc = "正在USCM进行测试的实验性霰弹枪型号。基于原始民用和CMB版本，XM51是一款弹匣供弹、泵动式霰弹枪。它使用特殊的16号径破门弹，对破坏墙壁和门有效。由于弹丸性能较低，建议用户不要将其用于对付软目标或装甲目标。"
	icon_state = "xm51"
	item_state = "xm51"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/shotguns.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/shotguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/shotguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/shotguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/shotguns_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/shotgun_mouse.dmi'

	fire_sound = 'sound/weapons/gun_shotgun_xm51.ogg'
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/xm51
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
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/xm51,
	)

	flags_equip_slot = SLOT_BACK
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	gun_category = GUN_CATEGORY_SHOTGUN
	aim_slowdown = SLOWDOWN_ADS_SHOTGUN
	map_specific_decoration = TRUE

	var/pump_delay //How long we have to wait before we can pump the shotgun again.
	var/pump_sound = "shotgunpump"
	var/message_delay = 1 SECONDS //To stop message spam when trying to pump the gun constantly.
	var/burst_count = 0 //To detect when the burst fire is near its end.
	COOLDOWN_DECLARE(allow_message)
	COOLDOWN_DECLARE(allow_pump)

/obj/item/weapon/gun/rifle/xm51/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 34, "muzzle_y" = 18, "rail_x" = 12, "rail_y" = 20, "under_x" = 24, "under_y" = 13, "stock_x" = 15, "stock_y" = 16)

/obj/item/weapon/gun/rifle/xm51/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_4*2)
	set_burst_amount(0)
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	accuracy_mult = BASE_ACCURACY_MULT + 2*HIT_ACCURACY_MULT_TIER_8
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_6

/obj/item/weapon/gun/rifle/xm51/Initialize(mapload, spawn_empty)
	. = ..()
	pump_delay = FIRE_DELAY_TIER_8*3
	additional_fire_group_delay += pump_delay
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/rifle/xm51/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY_ID("turfs", /datum/element/bullet_trait_damage_boost, 30, GLOB.damage_boost_turfs), //2550, 2 taps colony walls, 4 taps reinforced walls
		BULLET_TRAIT_ENTRY_ID("xeno turfs", /datum/element/bullet_trait_damage_boost, 0.23, GLOB.damage_boost_turfs_xeno), //2550*0.23 = 586, 2 taps resin walls, 3 taps thick resin
		BULLET_TRAIT_ENTRY_ID("breaching", /datum/element/bullet_trait_damage_boost, 15, GLOB.damage_boost_breaching), //1275, enough to 1 tap airlocks
		BULLET_TRAIT_ENTRY_ID("pylons", /datum/element/bullet_trait_damage_boost, 6, GLOB.damage_boost_pylons) //510, 4 shots to take out a pylon
	))

/obj/item/weapon/gun/rifle/xm51/unique_action(mob/user)
	if(!COOLDOWN_FINISHED(src, allow_pump))
		return
	if(in_chamber)
		if(COOLDOWN_FINISHED(src, allow_message))
			to_chat(usr, SPAN_WARNING("<i>[src]的枪膛里已经有一发霰弹了！<i>"))
			COOLDOWN_START(src, allow_message, message_delay)
		return

	playsound(user, pump_sound, 10, 1)
	COOLDOWN_START(src, allow_pump, pump_delay)
	ready_in_chamber()
	burst_count = 0 //Reset the count for burst mode.

/obj/item/weapon/gun/rifle/xm51/load_into_chamber(mob/user)
	return in_chamber

/obj/item/weapon/gun/rifle/xm51/reload_into_chamber(mob/user) //Don't chamber bullets after firing.
	if(!current_mag)
		update_icon()
		return

	in_chamber = null
	if(current_mag.current_rounds <= 0 && flags_gun_features & GUN_AUTO_EJECTOR)
		if (user.client?.prefs && (user.client?.prefs?.toggle_prefs & TOGGLE_AUTO_EJECT_MAGAZINE_OFF))
			update_icon()
		else if (!(flags_gun_features & GUN_BURST_FIRING) || !in_chamber) // Magazine will only unload once burstfire is over
			var/drop_to_ground = TRUE
			if (user.client?.prefs && (user.client?.prefs?.toggle_prefs & TOGGLE_AUTO_EJECT_MAGAZINE_TO_HAND))
				drop_to_ground = FALSE
				unwield(user)
				user.swap_hand()
			unload(user, TRUE, drop_to_ground) // We want to quickly autoeject the magazine. This proc does the rest based on magazine type. User can be passed as null.
			playsound(src, empty_sound, 25, 1)
	if(gun_firemode == GUN_FIREMODE_BURSTFIRE & burst_count < burst_amount - 1) //Fire two (or more) shots in a burst without having to pump.
		ready_in_chamber()
		burst_count++
		return in_chamber

/obj/item/weapon/gun/rifle/xm51/replace_magazine(mob/user, obj/item/ammo_magazine/magazine) //Don't chamber a round when reloading.
	user.drop_inv_item_to_loc(magazine, src) //Click!
	current_mag = magazine
	replace_ammo(user,magazine)
	user.visible_message(SPAN_NOTICE("[user]将[magazine]装入[src]！"),
		SPAN_NOTICE("You load [magazine] into [src]!"), null, 3, CHAT_TYPE_COMBAT_ACTION)
	if(reload_sound)
		playsound(user, reload_sound, 25, 1, 5)

/obj/item/weapon/gun/rifle/xm51/cmb
	name = "\improper Model 1771 Cobra Max Tactical"
	desc = "由阿玛特战场系统基于M51平台为殖民地执法官办公室设计，作为破门和人群控制武器，1771型是一款弹匣供弹、泵动式霰弹枪。它使用特殊的16号径破门弹，对破坏墙壁和门有效，此外还设计用于发射橡胶鹿弹。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/shotguns.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/shotguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/shotguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/shotguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/shotguns_righthand.dmi'
	)
	icon_state = "m51b"
	item_state = "m51b"
	current_mag = /obj/item/ammo_magazine/rifle/xm51/cmb
	map_specific_decoration = FALSE
	starting_attachment_types = list(/obj/item/attachable/flashlight/grip, /obj/item/attachable/reflex)

