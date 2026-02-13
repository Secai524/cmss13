//*******************************************************************************
//AMMO
//*******************************************************************************/

//------------------------Ammunition Boxes crates----------------

/datum/supply_packs/ammo_rounds_box_smg
	name = "冲锋枪弹药箱 (10x20mm) (x600发)"
	contains = list(/obj/item/ammo_box/rounds/smg)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper SMG ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_rounds_box_smg_ap
	name = "冲锋枪穿甲弹药箱 (10x20mm AP) (x600发)"
	contains = list(/obj/item/ammo_box/rounds/smg/ap)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper SMG AP ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_rounds_box_rifle
	name = "步枪弹药箱 (10x24mm) (x600发)"
	contains = list(/obj/item/ammo_box/rounds)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper rifle ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_rounds_box_rifle_ap
	name = "步枪穿甲弹药箱 (10x24mm AP) (x600发)"
	contains = list(/obj/item/ammo_box/rounds/ap)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper rifle AP ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_rounds_box_xm88
	name = ".458子弹箱 (x300发)"
	contains = list(/obj/item/ammo_box/magazine/lever_action/xm88)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper .458 bullets crate"
	group = "Ammo"

//------------------------Magazine Boxes crates----------------

//------------------------For M41A----------------

/datum/supply_packs/ammo_mag_box
	name = "弹匣箱 (M41A, 10个标准弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M41A magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_mag_box_ap
	name = "弹匣箱 (M41A, 10个穿甲弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/ap,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M41A AP magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_mag_box_ext
	name = "弹匣箱 (M41A, 8个加长弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/ext,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M41A extended magazines crate"
	group = "Ammo"

//------------------------For M4RA----------------

/datum/supply_packs/ammo_dmr_mag_box
	name = "弹匣箱 (M4RA, 16个标准弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m4ra,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M4RA magazines crate"
	group = "Ammo"

//------------------------For M39----------------

/datum/supply_packs/ammo_smg_mag_box
	name = "弹匣箱 (M39, 12个标准弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m39,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M39 HV magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_smg_mag_box_ap
	name = "弹匣箱 (M39, 12个穿甲弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m39/ap,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M39 AP magazines crate"
	group = "Ammo"

//------------------------For M4RA----------------

/datum/supply_packs/ammo_m4ra_mag_box
	name = "弹匣箱 (M4RA, 16个弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m4ra,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M4RA magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_m4ra_mag_box_ap
	name = "弹匣箱 (M4RA, 16个穿甲弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m4ra/ap,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M4RA AP magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_m4ra_mag_box_ext
	name = "弹匣箱 (M4RA, 12个加长弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m4ra/ext,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M4RA extended magazines crate"
	group = "Ammo"

//------------------------For  M44----------------

/datum/supply_packs/ammo_m44_mag_box
	name = "快速装弹器箱 (M44, 16个)"
	contains = list(
		/obj/item/ammo_box/magazine/m44,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M44 speed loaders crate"
	group = "Ammo"

/datum/supply_packs/ammo_m44_mag_box_ap
	name = "快速装弹器箱 (神射手M44, 16个)"
	contains = list(
		/obj/item/ammo_box/magazine/m44/marksman,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M44 Marksman speed loaders crate"
	group = "Ammo"

/datum/supply_packs/ammo_m44_mag_box_heavy
	name = "快速装弹器箱 (重型M44, 16个)"
	contains = list(
		/obj/item/ammo_box/magazine/m44/heavy,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M44 Heavy speed loaders crate"
	group = "Ammo"

//------------------------For  M4A3----------------

/datum/supply_packs/ammo_m4a3_mag_box
	name = "弹匣箱 (M4A3, 16个标准弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m4a3,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M4A3 magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_m4a3_mag_box_ap
	name = "弹匣箱 (M4A3, 16个穿甲弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m4a3/ap,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M4A3 AP magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_m4a3_mag_box_hp
	name = "弹匣箱 (M4A3, 16个空尖弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m4a3/hp,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M4A3 HP magazines crate"
	group = "Ammo"

//------------------------For  Shootgun ammo----------------

/datum/supply_packs/ammo_shell_box
	name = "霰弹箱 (100发独头弹)"
	contains = list(
		/obj/item/ammo_box/magazine/shotgun,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper shotgun slugs crate"
	group = "Ammo"

/datum/supply_packs/ammo_shell_box_buck
	name = "霰弹箱 (100发鹿弹)"
	contains = list(
		/obj/item/ammo_box/magazine/shotgun/buckshot,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper shotgun buckshot crate"
	group = "Ammo"

/datum/supply_packs/ammo_shell_box_flechette
	name = "霰弹箱 (100发箭形弹)"
	contains = list(
		/obj/item/ammo_box/magazine/shotgun/flechette,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper shotgun flechette crate"
	group = "Ammo"

//------------------------For 88M4 ----------------

/datum/supply_packs/ammo_mod88_mag_box_ap
	name = "弹匣箱 (88 Mod 4 穿甲弹, 16个弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/mod88,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper 88 Mod 4 AP magazines crate"
	group = "Ammo"

//------------------------Special or non common magazines----------------

/datum/supply_packs/ammo_vp78_mag_box
	name = "弹匣箱 (VP78, 16个弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/vp78,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper VP78 magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_su6_mag_box
	name = "弹匣箱 (SU-6, 16个弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/su6,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper SU-6 magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_hpr
	contains = list(
		/obj/item/ammo_magazine/rifle/lmg,
		/obj/item/ammo_magazine/rifle/lmg,
	)
	name = "M41AE2 HPR弹匣板条箱 (HPR弹药箱 x2)"
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M41AE2 HPR magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_hpr_holo
	contains = list(
		/obj/item/ammo_magazine/rifle/lmg/holo_target,
		/obj/item/ammo_magazine/rifle/lmg/holo_target,
	)
	name = "M41AE2 HPR全息瞄准弹匣板条箱 (HPR HT弹药箱 x2)"
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M41AE2 HPR holo-target magazines crate"
	group = "Ammo"


//------------------------For M10 Auto Pistol ----------------

/datum/supply_packs/ammo_m10_pistol_mag_box
	name = "弹匣箱 (M10, 22个标准弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m10,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M10 HV magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_m10_pistol_mag_box_extended
	name = "弹匣箱 (M10, 14个加长弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m10/extended,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M10 extended magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_m10_ap_pistol_mag_box
	name = "弹匣箱 (M10 穿甲弹, 22个标准弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m10/ap,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M10 AP magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_m10_ap_pistol_mag_box_extended
	name = "弹匣箱 (M10穿甲弹，14个加长弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/m10/ap/extended,
	)
	cost = 60
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper M10 AP extended magazines crate"
	group = "Ammo"

//------------------------Smartgunner stuff----------------

/datum/supply_packs/ammo_smartgun_battery_pack
	name = "M56智能枪电池箱 (x4)"
	contains = list(
		/obj/item/smartgun_battery,
		/obj/item/smartgun_battery,
		/obj/item/smartgun_battery,
		/obj/item/smartgun_battery,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper smartgun battery crate"
	group = "Ammo"

/datum/supply_packs/ammo_smartgun
	name = "M56智能枪弹鼓箱 (x2)"
	contains = list(
		/obj/item/ammo_magazine/smartgun,
		/obj/item/ammo_magazine/smartgun,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper smartgun drums crate"
	group = "Ammo"

//------------------------Sentries Ammo----------------

/datum/supply_packs/ammo_sentry_shotgun
	name = "UA 12-G哨戒炮霰弹弹药 (x2)"
	contains = list(
		/obj/item/ammo_magazine/sentry/shotgun,
		/obj/item/ammo_magazine/sentry/shotgun,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper sentry shotgun ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_sentry_flamer
	name = "UA 42-F哨戒炮火焰喷射器弹药 (x2)"
	contains = list(
		/obj/item/ammo_magazine/sentry_flamer,
		/obj/item/ammo_magazine/sentry_flamer,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper sentry flamer ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_mini_sentry_flamer
	name = "UA 45-F迷你哨戒炮火焰喷射器弹药 (x2)"
	contains = list(
		/obj/item/ammo_magazine/sentry_flamer/mini,
		/obj/item/ammo_magazine/sentry_flamer/mini,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper mini sentry flamer ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_glob_sentry_flamer
	name = "UA 60-FP哨戒炮等离子焚烧器燃料罐 (x2)"
	contains = list(
		/obj/item/ammo_magazine/sentry_flamer/glob,
		/obj/item/ammo_magazine/sentry_flamer/glob,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper sentry plasma incinerator ammo crate"
	group = "Ammo"

/datum/supply_packs/ammo_sentry
	name = "UA 571-C哨戒炮弹药 (x2)"
	contains = list(
		/obj/item/ammo_magazine/sentry,
		/obj/item/ammo_magazine/sentry,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper sentry ammo crate"
	group = "Ammo"

//------------------------M240 flamer tanks----------------

/datum/supply_packs/ammo_napalm
	name = "M240 UT-萘燃料 (x4)"
	contains = list(
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/ammo_magazine/flamer_tank,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo/alt/flame
	containername = "\improper napthal fuel crate"
	group = "Ammo"

/datum/supply_packs/ammo_napalm_gel
	name = "M240凝固汽油B凝胶 (x4)"
	contains = list(
		/obj/item/ammo_magazine/flamer_tank/gellied,
		/obj/item/ammo_magazine/flamer_tank/gellied,
		/obj/item/ammo_magazine/flamer_tank/gellied,
		/obj/item/ammo_magazine/flamer_tank/gellied,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo/alt/flame
	containername = "\improper napalm gel crate"
	group = "Ammo"

/datum/supply_packs/ammo_flamer_mixed
	name = "M240燃料箱 (x2普通，x2B凝胶)"
	contains = list(
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/ammo_magazine/flamer_tank/gellied,
		/obj/item/ammo_magazine/flamer_tank/gellied,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo/alt/flame
	group = "Ammo"

//------------------------Mounted guns ammo----------------
/datum/supply_packs/ammo_m2c
	name = "M2C弹药箱 (x2)"
	contains = list(
		/obj/item/ammo_magazine/m2c,
		/obj/item/ammo_magazine/m2c,
	)
	cost = 25
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper m2c ammunition crate"
	group = "Ammo"

/datum/supply_packs/ammo_m56d
	name = "M56D弹鼓箱 (x1)"
	contains = list(
		/obj/item/ammo_magazine/m56d,
	)
	cost = 25
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper m56d drum magazine crate"
	group = "Ammo"

//This crate has a little bit of everything, mostly okay stuff, but it does have some really unique picks.
/datum/supply_packs/ammo_surplus
	name = "剩余弹药箱 (多种USCM弹匣 x10)"
	randomised_num_contained = 10
	contains = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle/extended,
		/obj/item/ammo_magazine/rifle/ap,
		/obj/item/ammo_magazine/rifle/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/incendiary,
		/obj/item/ammo_magazine/rifle/m41aMK1,
		/obj/item/ammo_magazine/rifle/m41aMK1/ap,
		/obj/item/ammo_magazine/rifle/m4ra,
		/obj/item/ammo_magazine/rifle/lmg,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/pistol/incendiary,
		/obj/item/ammo_magazine/smg/m39,
		/obj/item/ammo_magazine/smg/m39,
		/obj/item/ammo_magazine/smg/m39,
		/obj/item/ammo_magazine/smg/m39/extended,
		/obj/item/ammo_magazine/smg/m39/ap,
		/obj/item/ammo_magazine/smg/m39/ap,
		/obj/item/ammo_magazine/pistol/m10/extended,
		/obj/item/ammo_magazine/pistol/m10/extended,
		/obj/item/ammo_magazine/pistol/m10/extended,
		/obj/item/ammo_magazine/pistol/m10/extended,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/revolver/marksman,
		/obj/item/ammo_magazine/revolver/heavy,
		/obj/item/ammo_magazine/shotgun,
		/obj/item/ammo_magazine/shotgun,
		/obj/item/ammo_magazine/shotgun/buckshot,
		/obj/item/ammo_magazine/shotgun/buckshot,
		/obj/item/ammo_magazine/shotgun/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/ap,
		/obj/item/ammo_magazine/rifle/m4ra/extended,
		/obj/item/ammo_magazine/rifle/m4ra,
	)
	cost = 60
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper surplus ammo crate"
	group = "Ammo"

//------------------------For  L54----------------

/datum/supply_packs/ammo_l54_mag_box
	name = "弹匣箱 (L54，16个普通弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/l54,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper L54 magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_l54_mag_box_ap
	name = "弹匣箱 (L54，16个穿甲弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/l54/ap,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper L54 AP magazines crate"
	group = "Ammo"

/datum/supply_packs/ammo_l54_mag_box_hp
	name = "弹匣箱 (L54，16个空尖弹匣)"
	contains = list(
		/obj/item/ammo_box/magazine/l54/hp,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "\improper L54 HP magazines crate"
	group = "Ammo"
