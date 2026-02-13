//M4RA custom marksman rifle

/obj/item/weapon/gun/rifle/m4ra_custom
	name = "\improper M4RA custom battle rifle"
	desc = "这是对原本就坚如磐石的M4RA的进一步改进。由奇努克空间站上的USCM军械师制造——这款M4RA变体拥有专门铣削的弹匣井以适配A19弹药。它采用了轻质钛合金框架，能更好地应对定制A19弹药产生的强大后坐力。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/marksman_rifles.dmi'
	icon_state = "m4ra_custom"
	item_state = "m4ra_custom"
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

	unacidable = TRUE
	explo_proof = TRUE
	force = 26
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_SPECIALIST|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	map_specific_decoration = TRUE
	aim_slowdown = SLOWDOWN_ADS_QUICK
	flags_item = TWOHANDED|NO_CRYO_STORE

	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/m4ra,
		/obj/item/ammo_magazine/rifle/m4ra/ap,
		/obj/item/ammo_magazine/rifle/m4ra/extended,
		/obj/item/ammo_magazine/rifle/m4ra/rubber,
		/obj/item/ammo_magazine/rifle/m4ra/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/heap,
		/obj/item/ammo_magazine/rifle/m4ra/penetrating,
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/custom/impact,

	)
	current_mag = /obj/item/ammo_magazine/rifle/m4ra/custom
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
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bipod,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/attached_gun/extinguisher,
	)
	pixel_x = -5
	hud_offset = -5


/obj/item/weapon/gun/rifle/m4ra_custom/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 23, "rail_y" = 21, "under_x" = 30, "under_y" = 11, "stock_x" = 24, "stock_y" = 13, "special_x" = 37, "special_y" = 16)

/obj/item/weapon/gun/rifle/m4ra_custom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_6)
	set_burst_amount(0)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/m4ra_custom/able_to_fire(mob/living/user)
	. = ..()
	if (. && istype(user)) //Let's check all that other stuff first.
		if(!skillcheck(user, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL) && user.skills.get_skill_level(SKILL_SPEC_WEAPONS) != SKILL_SPEC_SCOUT)
			to_chat(user, SPAN_WARNING("你似乎不知道如何使用\the [src]……"))
			return FALSE

/obj/item/weapon/gun/rifle/m4ra_custom/tactical
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet, /obj/item/attachable/angledgrip)
