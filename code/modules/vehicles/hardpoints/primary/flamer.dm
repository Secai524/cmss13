/obj/item/hardpoint/primary/flamer
	name = "\improper DRG-N Offensive Flamer Unit"
	desc = "坦克的主武器，可在广阔区域内喷射高燃烧性凝固汽油。燃料燃烧剧烈而迅速，使其能被装甲车辆用于进攻。"

	icon_state = "drgn_flamer"
	disp_icon = "tank"
	disp_icon_state = "drgn_flamer"
	activation_sounds = list('sound/weapons/vehicles/flamethrower.ogg')

	health = 400
	firing_arc = 90

	ammo = new /obj/item/ammo_magazine/hardpoint/primary_flamer
	max_clips = 1

	px_offsets = list(
		"1" = list(0, 21),
		"2" = list(0, -32),
		"4" = list(32, 1),
		"8" = list(-32, 1)
	)

	use_muzzle_flash = FALSE

	scatter = 5
	fire_delay = 2.0 SECONDS

/obj/item/hardpoint/primary/flamer/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/primary/flamer/try_fire(atom/target, mob/living/user, params)
	if(get_turf(target) in owner.locs)
		to_chat(user, SPAN_WARNING("目标距离太近。"))
		return NONE

	return ..()
