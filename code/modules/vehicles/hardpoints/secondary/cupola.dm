/obj/item/hardpoint/secondary/m56cupola
	name = "\improper M56 Cupola"
	desc = "坦克的副武器。这是一挺经过改装、永久固定在底座上的M56D。你发誓还能看到一些焊接痕迹。"

	icon_state = "m56_cupola"
	disp_icon = "tank"
	disp_icon_state = "m56cupola"
	activation_sounds = list('sound/weapons/gun_smartgun1.ogg', 'sound/weapons/gun_smartgun2.ogg', 'sound/weapons/gun_smartgun3.ogg', 'sound/weapons/gun_smartgun4.ogg')

	health = 350
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/m56_cupola
	max_clips = 1

	muzzle_flash_pos = list(
		"1" = list(8, -1),
		"2" = list(-7, -15),
		"4" = list(6, -10),
		"8" = list(-5, 7)
	)

	scatter = 3
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.3 SECONDS
