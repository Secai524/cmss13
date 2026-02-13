/obj/item/hardpoint/secondary/frontalcannon
	name = "\improper Bleihagel RE-RE700 Frontal Cannon"
	desc = "布莱哈格尔的营销部门会让你相信RE-RE700是原创设计。然而，撬开炮塔外壳的专家发现了一个与流行的M56炮塔惊人相似的物体。目前仍不清楚为何这门炮有两个炮管。"
	icon = 'icons/obj/vehicles/hardpoints/apc.dmi'

	icon_state = "front_cannon"
	disp_icon = "apc"
	disp_icon_state = "frontalcannon"
	activation_sounds = list('sound/weapons/gun_smartgun1.ogg', 'sound/weapons/gun_smartgun2.ogg', 'sound/weapons/gun_smartgun3.ogg')

	damage_multiplier = 0.11

	health = 350
	firing_arc = 120

	origins = list(0, -1)

	ammo = new /obj/item/ammo_magazine/hardpoint/m56_cupola/frontal_cannon
	max_clips = 1

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash_double"

	muzzle_flash_pos = list(
		"1" = list(-14, 46),
		"2" = list(15, -76),
		"4" = list(62, -26),
		"8" = list(-62, -26)
	)

	scatter = 4
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.3 SECONDS

/obj/item/hardpoint/secondary/frontalcannon/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/secondary/frontalcannon/pmc
	icon_state = "front_cannon_wy"
	disp_icon_state = "frontalcannon_wy"
