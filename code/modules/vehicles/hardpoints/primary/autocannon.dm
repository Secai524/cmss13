/obj/item/hardpoint/primary/autocannon
	name = "\improper AC3-E Autocannon"
	desc = "坦克的主武器，一门自动机炮，发射高爆弹。"

	icon_state = "ace_autocannon"
	disp_icon = "tank"
	disp_icon_state = "ace_autocannon"
	activation_sounds = list('sound/weapons/vehicles/autocannon_fire.ogg')

	health = 500
	firing_arc = 60

	ammo = new /obj/item/ammo_magazine/hardpoint/ace_autocannon
	max_clips = 2

	px_offsets = list(
		"1" = list(0, 22),
		"2" = list(0, -32),
		"4" = list(32, 0),
		"8" = list(-32, 0)
	)

	scatter = 1
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.7 SECONDS
