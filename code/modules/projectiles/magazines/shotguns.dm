//-------------------------------------------------------
//Generic shotgun magazines. Only three of them, since all shotguns can use the same ammo unless we add other gauges.

/*
Shotguns don't really use unique "ammo" like other guns. They just load from a pool of ammo and generate the projectile
on the go. There's also buffering involved. But, we do need the ammo to check handfuls type, and it's nice to have when
you're looking back on the different shotgun projectiles available. In short of it, it's not needed to have more than
one type of shotgun ammo, but I think it helps in referencing it. ~N
*/

GLOBAL_LIST_INIT(shotgun_boxes_12g, list(
	/obj/item/ammo_magazine/shotgun/buckshot,
	/obj/item/ammo_magazine/shotgun/flechette,
	/obj/item/ammo_magazine/shotgun/slugs
	))

/obj/item/ammo_magazine/shotgun
	name = "盒装独头弹"
	desc = "一盒装满重型霰弹枪弹的弹药盒。永恒的经典。12号口径。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/shotguns.dmi'
	icon_state = "slugs"
	item_state = "slugs"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	default_ammo = /datum/ammo/bullet/shotgun/slug
	caliber = "12g"
	gun_type = /obj/item/weapon/gun/shotgun
	max_rounds = 25 // Real shotgun boxes are usually 5 or 25 rounds. This works with the new system, five handfuls.
	w_class = SIZE_LARGE // Can't throw it in your pocket, friend.
	flags_magazine = AMMUNITION_REFILLABLE|AMMUNITION_HANDFUL_BOX
	handful_state = "slug_shell"
	transfer_handful_amount = 5
	description_ammo = "shells"

/obj/item/ammo_magazine/shotgun/attack_self(mob/user)
	if(current_rounds == 0)
		new /obj/item/stack/sheet/cardboard(user.loc)
		qdel(src)
	else
		return ..()

/obj/item/ammo_magazine/shotgun/slugs//for distinction on weapons that can't take child objects but still take slugs.

/obj/item/ammo_magazine/shotgun/incendiary
	name = "盒装燃烧独头弹"
	desc = "一盒装满自爆燃烧霰弹枪弹的弹药盒。12号口径。"
	icon_state = "incendiary"
	item_state = "incendiary"
	default_ammo = /datum/ammo/bullet/shotgun/incendiary
	handful_state = "incendiary_slug"

/obj/item/ammo_magazine/shotgun/incendiarybuck
	name = "盒装燃烧鹿弹"
	desc = "一盒装满自爆鹿弹燃烧霰弹枪弹的弹药盒。12号口径。"
	icon_state = "incendiarybuck"
	item_state = "incendiarybuck"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot/incendiary
	handful_state = "incen_buckshot"

/obj/item/ammo_magazine/shotgun/buckshot
	name = "盒装鹿弹"
	desc = "一盒装满鹿弹散布霰弹枪弹的弹药盒。12号口径。"
	icon_state = "buckshot"
	item_state = "buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	handful_state = "buckshot_shell"

/obj/item/ammo_magazine/shotgun/flechette
	name = "盒装箭弹"
	desc = "一盒装满箭弹霰弹枪弹的弹药盒。12号口径。"
	icon_state = "flechette"
	item_state = "flechette"
	default_ammo = /datum/ammo/bullet/shotgun/flechette
	handful_state = "flechette_shell"

/obj/item/ammo_magazine/shotgun/beanbag
	name = "盒装豆袋弹"
	desc = "一盒装满用于非致命人群控制的豆袋霰弹枪弹的弹药盒。12号口径。"
	icon_state = "beanbag"
	item_state = "beanbag"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag
	handful_state = "beanbag_slug"

/obj/item/ammo_magazine/shotgun/beanbag/riot
	name = "盒装防暴豆袋弹"
	desc = "一盒装满用于非致命人群控制的豆袋霰弹枪弹的弹药盒。仅供防暴控制使用。"
	icon_state = "beanbag"
	item_state = "beanbag"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag
	handful_state = "beanbag_slug"
	caliber = "20g"

/obj/item/ammo_magazine/shotgun/beanbag/es7
	name = "盒装X21电击弹"
	desc = "一盒装满用于非致命人群控制的X21弹药的弹药盒。仅供防暴控制使用。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/shotguns.dmi'
	icon_state = "electric"
	item_state = "incendiary"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag/es7
	handful_state = "elec_slug"
	caliber = "20g"

/obj/item/ammo_magazine/shotgun/beanbag/es7/slug
	name = "一盒X21致命独头弹"
	desc = "一个装满X21战斗静电致命霰弹的盒子，专为ES-7超新星设计。"
	icon_state = "slug"
	default_ammo = /datum/ammo/bullet/shotgun/slug/es7
	handful_state = "es7_slug"

/obj/item/ammo_magazine/shotgun/light/breaching
	name = "一盒破门弹"
	desc = "一个装满破门霰弹的盒子。16号口径。"
	icon_state = "breaching"
	item_state = "breaching"
	max_rounds = 30 //6 handfuls of 6 shells, 12 rounds in a XM51 mag
	transfer_handful_amount = 6
	default_ammo = /datum/ammo/bullet/shotgun/light/breaching
	handful_state = "breaching_shell"
	caliber = "16g"

// --- UPP Shotgun Box --- //

GLOBAL_LIST_INIT(shotgun_boxes_8g, list(
	/obj/item/ammo_magazine/shotgun/heavy/buckshot,
	/obj/item/ammo_magazine/shotgun/heavy/flechette,
	/obj/item/ammo_magazine/shotgun/heavy/slug
	))

/obj/item/ammo_magazine/shotgun/heavy
	name = "一盒霰弹枪重型独头弹"
	desc = "一个装满重型霰弹的盒子。永恒的经典。8号口径。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/shotguns.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	default_ammo = /datum/ammo/bullet/shotgun/heavy/slug
	caliber = "8g"
	gun_type = /obj/item/weapon/gun/shotgun
	max_rounds = 20
	handful_state = "slug_shell"
	transfer_handful_amount = 4

/obj/item/ammo_magazine/shotgun/heavy/slug

/obj/item/ammo_magazine/shotgun/heavy/buckshot
	name = "一盒重型鹿弹"
	desc = "一个装满鹿弹散布霰弹的盒子。8号口径。"
	icon_state = "buckshot"
	item_state = "buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/buckshot
	handful_state = "buckshot_shell"

/obj/item/ammo_magazine/shotgun/heavy/flechette
	name = "一盒重型箭形弹"
	desc = "一个装满箭形霰弹的盒子。8号口径。"
	icon_state = "flechette"
	item_state = "flechette"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/flechette
	handful_state = "flechette_shell"

/obj/item/ammo_magazine/shotgun/heavy/incendiary
	name = "一盒重型燃烧独头弹"
	desc = "一个装满自爆燃烧霰弹的盒子。8号口径。"
	icon_state = "incendiary"
	item_state = "incendiary"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath
	handful_state = "incendiary_slug"

/obj/item/ammo_magazine/shotgun/heavy/beanbag
	name = "一盒重型豆袋弹"
	desc = "一个装满豆袋霰弹的盒子，用于非致命人群控制。8号口径。"
	icon_state = "beanbag"
	item_state = "beanbag"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/beanbag
	handful_state = "beanbag_slug"

//-------------------------------------------------------

/*
Generic internal magazine. All shotguns will use this or a variation with different ammo number.
Since all shotguns share ammo types, the gun path is going to be the same for all of them. And it
also doesn't really matter. You can only reload them with handfuls.
*/
/obj/item/ammo_magazine/internal/shotgun
	name = "霰弹枪管状弹仓"
	desc = "一个内置弹仓。它本不应被看到或移除。"
	default_ammo = /datum/ammo/bullet/shotgun/slug
	caliber = "12g"
	max_rounds = 9
	chamber_closed = 0

/obj/item/ammo_magazine/internal/shotgun/double //For a double barrel.
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	max_rounds = 2
	chamber_closed = 1 //Starts out with a closed tube.

/obj/item/ammo_magazine/internal/shotgun/double/cane
	default_ammo = /datum/ammo/bullet/revolver/marksman
	max_rounds = 6
	caliber = ".44"

/obj/item/ammo_magazine/internal/shotgun/double/mou53
	default_ammo = /datum/ammo/bullet/shotgun/flechette
	max_rounds = 3

/obj/item/ammo_magazine/internal/shotgun/double/twobore //Van Bandolier's superheavy double-barreled hunting rifle.
	caliber = "2 bore"
	default_ammo = /datum/ammo/bullet/shotgun/twobore

/obj/item/ammo_magazine/internal/shotgun/combat/riot
	caliber = "20g"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag

/obj/item/ammo_magazine/internal/shotgun/combat/es7
	caliber = "20g"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag/es7
	max_rounds = 7

/obj/item/ammo_magazine/internal/shotgun/merc
	max_rounds = 5

/obj/item/ammo_magazine/internal/shotgun/buckshot
	default_ammo = /datum/ammo/bullet/shotgun/buckshot

/obj/item/ammo_magazine/internal/shotgun/type23
	default_ammo = /datum/ammo/bullet/shotgun/heavy/buckshot
	caliber = "8g"
	max_rounds = 4

/obj/item/ammo_magazine/internal/shotgun/type23/slug
	default_ammo = /datum/ammo/bullet/shotgun/heavy/slug

/obj/item/ammo_magazine/internal/shotgun/type23/flechette
	default_ammo = /datum/ammo/bullet/shotgun/heavy/flechette

/obj/item/ammo_magazine/internal/shotgun/type23/dragonsbreath
	default_ammo = /datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath

/obj/item/ammo_magazine/internal/shotgun/type23/beanbag
	default_ammo = /datum/ammo/bullet/shotgun/heavy/beanbag

/obj/item/ammo_magazine/internal/shotgun/cmb
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	max_rounds = 4

/obj/item/ammo_magazine/internal/shotgun/cmb/m3717
	max_rounds = 5

//-------------------------------------------------------

/*
Handfuls of shotgun rounds. For spawning directly on mobs in roundstart, ERTs, etc
*/

GLOBAL_LIST_INIT(shotgun_handfuls_8g, list(
	/obj/item/ammo_magazine/handful/shotgun/heavy/slug,
	/obj/item/ammo_magazine/handful/shotgun/heavy/buckshot,
	/obj/item/ammo_magazine/handful/shotgun/heavy/flechette,
	/obj/item/ammo_magazine/handful/shotgun/heavy/beanbag,
	/obj/item/ammo_magazine/handful/shotgun/heavy/dragonsbreath
	))

GLOBAL_LIST_INIT(shotgun_handfuls_12g, list(
	/obj/item/ammo_magazine/handful/shotgun/slug,
	/obj/item/ammo_magazine/handful/shotgun/buckshot,
	/obj/item/ammo_magazine/handful/shotgun/flechette,
	/obj/item/ammo_magazine/handful/shotgun/incendiary,
	/obj/item/ammo_magazine/handful/shotgun/buckshot/incendiary,
	/obj/item/ammo_magazine/handful/shotgun/beanbag
	))

/obj/item/ammo_magazine/handful/shotgun
	name = "一把霰弹枪独头弹（12号口径）"
	icon_state = "slug_shell_5"
	default_ammo = /datum/ammo/bullet/shotgun/slug
	caliber = "12g"
	max_rounds = 5
	current_rounds = 5
	gun_type = /obj/item/weapon/gun/shotgun
	handful_state = "slug_shell"
	transfer_handful_amount = 5

/obj/item/ammo_magazine/handful/shotgun/slug

/obj/item/ammo_magazine/handful/shotgun/incendiary
	name = "一把燃烧独头弹（12号口径）"
	icon_state = "incendiary_slug_5"
	default_ammo = /datum/ammo/bullet/shotgun/incendiary
	handful_state = "incendiary_slug"

/obj/item/ammo_magazine/handful/shotgun/slug/es7
	name = "一把X21实心独头弹（20号口径）"
	icon_state = "es7_slug_5"
	default_ammo = /datum/ammo/bullet/shotgun/slug/es7
	handful_state = "es7_slug"
	caliber = "20g"

/obj/item/ammo_magazine/handful/shotgun/buckshot
	name = "一把霰弹枪鹿弹（12号口径）"
	icon_state = "buckshot_shell_5"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	handful_state = "buckshot_shell"

/obj/item/ammo_magazine/handful/shotgun/buckshot/incendiary
	name = "一把燃烧鹿弹（12号口径）"
	icon_state = "incen_buckshot_5"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot/incendiary
	handful_state = "incen_buckshot"

/obj/item/ammo_magazine/handful/shotgun/custom_color
	name = "抽象自定义类型弹药"
	icon_state = "shell_greyscale_5"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	handful_state = "shell_greyscale" //unneeded

//updates on init
/obj/item/ammo_magazine/handful/shotgun/custom_color/update_icon()
	overlays.Cut()
	. = ..()
	icon_state = "shell_greyscale" + "_[current_rounds]"
	var/image/I = image(icon, src, "+shell_base_[src.current_rounds]")
	I.color = "#ffffff"
	I.appearance_flags = RESET_COLOR|KEEP_APART
	overlays += I

/obj/item/ammo_magazine/handful/shotgun/flechette
	name = "一把霰弹枪箭形弹（12号口径）"
	icon_state = "flechette_shell_5"
	default_ammo = /datum/ammo/bullet/shotgun/flechette
	handful_state = "flechette_shell"

/obj/item/ammo_magazine/handful/shotgun/beanbag
	name = "一把豆袋弹（12号口径）"
	icon_state = "beanbag_slug_5"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag
	handful_state = "beanbag_slug"

/obj/item/ammo_magazine/handful/shotgun/beanbag/riot
	name = "一把豆袋弹（20号口径）"
	caliber = "20g"

/obj/item/ammo_magazine/handful/shotgun/beanbag/es7
	name = "一把X21静电独头弹（20号口径）"
	icon_state = "shock_slug_5"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag/es7
	handful_state = "shock_slug"
	caliber = "20g"

/obj/item/ammo_magazine/handful/shotgun/heavy
	name = "一把重型独头弹 (8号口径)"
	icon_state = "heavy_slug_4"
	handful_state = "heavy_slug"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/slug
	caliber = "8g"
	max_rounds = 4
	current_rounds = 4
	transfer_handful_amount = 4
	gun_type = /obj/item/weapon/gun/shotgun

/obj/item/ammo_magazine/handful/shotgun/heavy/slug

/obj/item/ammo_magazine/handful/shotgun/heavy/buckshot
	name = "一把重型鹿弹 (8号口径)"
	icon_state = "heavy_buckshot_4"
	handful_state = "heavy_buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/buckshot

/obj/item/ammo_magazine/handful/shotgun/heavy/dragonsbreath
	name = "一把龙息弹 (8号口径)"
	desc = "这种弹壳发射的是镁（而非通常的铅）弹丸，与空气接触即会点燃，引燃任何被击中的目标。其定制设计也增加了最大射程。"
	icon_state = "heavy_dragonsbreath_4"
	handful_state = "heavy_dragonsbreath"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath

/obj/item/ammo_magazine/handful/shotgun/heavy/flechette
	name = "一把重型箭弹 (8号口径)"
	icon_state = "heavy_flechette_4"
	handful_state = "heavy_flechette"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/flechette

/obj/item/ammo_magazine/handful/shotgun/heavy/beanbag
	name = "一把重型豆袋弹 (8号口径)"
	icon_state = "heavy_beanbag_4"
	handful_state = "heavy_beanbag"
	default_ammo = /datum/ammo/bullet/shotgun/heavy/beanbag

/obj/item/ammo_magazine/handful/shotgun/light/breaching
	name = "一把破门弹 (16号口径)"
	icon_state = "breaching_shell_6"
	handful_state = "breaching_shell"
	max_rounds = 6 //XM51 magazines are 12 rounds total, two handfuls should be enough to reload a mag
	current_rounds = 6
	transfer_handful_amount = 6
	default_ammo = /datum/ammo/bullet/shotgun/light/breaching
	caliber = "16g"
	gun_type = /obj/item/weapon/gun/rifle/xm51

/obj/item/ammo_magazine/handful/shotgun/light/breaching/rubber
	name = "一把橡胶鹿弹 (16号口径)"
	icon_state = "rubbershot_shell_6"
	handful_state = "rubbershot_shell"
	default_ammo = /datum/ammo/bullet/shotgun/light/rubber

/obj/item/ammo_magazine/handful/shotgun/twobore
	name = "一把霰弹枪独头弹 (2号口径)"
	icon_state = "twobore_3"
	default_ammo = /datum/ammo/bullet/shotgun/twobore
	caliber = "2 bore"
	max_rounds = 3
	current_rounds = 3
	gun_type = /obj/item/weapon/gun/shotgun/double/twobore
	handful_state = "twobore"
	transfer_handful_amount = 3

// i fucking hate gun code

/obj/item/ammo_magazine/handful/revolver
	name = "一把左轮手枪子弹 (.44口径)"
	default_ammo = /datum/ammo/bullet/revolver
	caliber = ".44"
	max_rounds = 8
	current_rounds = 8
	gun_type = /obj/item/weapon/gun/shotgun/double/cane

/obj/item/ammo_magazine/handful/revolver/marksman
	name = "一把神射手左轮手枪子弹 (.44口径)"
	default_ammo = /datum/ammo/bullet/revolver/marksman
	gun_type = /obj/item/weapon/gun/shotgun/double/cane

/obj/item/ammo_magazine/handful/revolver/marksman/six_rounds
	name = "一把神射手左轮手枪子弹 (.44口径)"
	default_ammo = /datum/ammo/bullet/revolver/marksman
	current_rounds = 6
	gun_type = /obj/item/weapon/gun/shotgun/double/cane
