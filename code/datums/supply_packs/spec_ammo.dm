//------------------------Specialists ammunition crates----------------

//M5 RPG

/datum/supply_packs/ammo_rpg_regular
	name = "M5火箭筒火箭弹箱（高爆弹 x1，穿甲弹 x1，白磷弹 x1）"
	contains = list(
		/obj/item/ammo_magazine/rocket,
		/obj/item/ammo_magazine/rocket/ap,
		/obj/item/ammo_magazine/rocket/wp,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/explosives
	containername = "\improper M5 RPG Rocket Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_rpg_he
	name = "M5火箭筒高爆火箭弹箱（x3）"
	contains = list(
		/obj/item/ammo_magazine/rocket,
		/obj/item/ammo_magazine/rocket,
		/obj/item/ammo_magazine/rocket,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/explosives
	containername = "M5 RPG HE Rocket Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_rpg_ap
	name = "M5火箭筒穿甲火箭弹箱（x3）"
	contains = list(
		/obj/item/ammo_magazine/rocket/ap,
		/obj/item/ammo_magazine/rocket/ap,
		/obj/item/ammo_magazine/rocket/ap,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/explosives
	containername = "M5 RPG AP Rockets Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_rpg_wp
	name = "M5火箭筒白磷火箭弹箱（x3）"
	contains = list(
		/obj/item/ammo_magazine/rocket/wp,
		/obj/item/ammo_magazine/rocket/wp,
		/obj/item/ammo_magazine/rocket/wp,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/explosives
	containername = "M5 RPG WP Rocket Crate"
	group = "Weapons Specialist Ammo"

//M42A

/datum/supply_packs/ammo_sniper_mix
	name = "M42A狙击步枪混合弹匣箱（射手弹 x2，破片弹 x2，燃烧弹 x2）"
	contains = list(
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/sniper/flak,
		/obj/item/ammo_magazine/sniper/flak,
		/obj/item/ammo_magazine/sniper/incendiary,
		/obj/item/ammo_magazine/sniper/incendiary,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "M42A Mixed Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_sniper_marksman
	name = "M42A狙击步枪标准弹匣箱（x5）"
	contains = list(
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/sniper,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "M42A Marksman Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_sniper_flak
	name = "M42A狙击步枪破片弹匣箱（x5）"
	contains = list(
		/obj/item/ammo_magazine/sniper/flak,
		/obj/item/ammo_magazine/sniper/flak,
		/obj/item/ammo_magazine/sniper/flak,
		/obj/item/ammo_magazine/sniper/flak,
		/obj/item/ammo_magazine/sniper/flak,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "M42A Flak Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_sniper_incendiary
	name = "M42A狙击步枪燃烧弹匣箱（x5）"
	contains = list(
		/obj/item/ammo_magazine/sniper/incendiary,
		/obj/item/ammo_magazine/sniper/incendiary,
		/obj/item/ammo_magazine/sniper/incendiary,
		/obj/item/ammo_magazine/sniper/incendiary,
		/obj/item/ammo_magazine/sniper/incendiary,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "M42A Incendiary Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_amr_marksman
	name = "XM43E1反器材步枪射手弹匣箱（x3）"
	contains = list(
		/obj/item/ammo_magazine/sniper/anti_materiel,
		/obj/item/ammo_magazine/sniper/anti_materiel,
		/obj/item/ammo_magazine/sniper/anti_materiel,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "XM43E1 Marksman Magazine Crate"
	group = "Weapons Specialist Ammo"

//M4RA

/datum/supply_packs/ammo_scout_mix
	name = "M4RA侦察步枪混合弹匣箱（常规弹 x2，燃烧弹 x2，冲击弹 x2）"
	contains = list(
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/custom/impact,
		/obj/item/ammo_magazine/rifle/m4ra/custom/impact,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "M4RA Scout Mixed Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_scout_regular
	name = "M4RA侦察步枪弹匣箱（x5）"
	contains = list(
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "M4RA Scout Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_scout_incendiary
	name = "M4RA侦察步枪燃烧弹匣箱（x3）"
	contains = list(
		/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "M4RA Scout Incendiary Magazine"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_scout_impact
	name = "M4RA侦察步枪冲击弹匣箱（x3）"
	contains = list(
		/obj/item/ammo_magazine/rifle/m4ra/custom/impact,
		/obj/item/ammo_magazine/rifle/m4ra/custom/impact,
		/obj/item/ammo_magazine/rifle/m4ra/custom/impact,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "M4RA Scout Impact Magazine Crate"
	group = "Weapons Specialist Ammo"

//SHARP

/datum/supply_packs/ammo_grenadier_sharp_mix
	name = "SHARP操作员混合弹匣箱（爆炸弹 x2，箭形弹 x2，燃烧弹 x2）"
	contains = list(
		/obj/item/ammo_magazine/rifle/sharp/explosive,
		/obj/item/ammo_magazine/rifle/sharp/explosive,
		/obj/item/ammo_magazine/rifle/sharp/flechette,
		/obj/item/ammo_magazine/rifle/sharp/flechette,
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "SHARP Operator Mixed Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_grenadier_sharp_explosive
	name = "SHARP操作员爆炸弹匣箱（x5）"
	contains = list(
		/obj/item/ammo_magazine/rifle/sharp/explosive,
		/obj/item/ammo_magazine/rifle/sharp/explosive,
		/obj/item/ammo_magazine/rifle/sharp/explosive,
		/obj/item/ammo_magazine/rifle/sharp/explosive,
		/obj/item/ammo_magazine/rifle/sharp/explosive,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "SHARP Operator Explosive Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_grenadier_sharp_flechette
	name = "SHARP操作员箭形弹匣箱（x5）"
	contains = list(
		/obj/item/ammo_magazine/rifle/sharp/flechette,
		/obj/item/ammo_magazine/rifle/sharp/flechette,
		/obj/item/ammo_magazine/rifle/sharp/flechette,
		/obj/item/ammo_magazine/rifle/sharp/flechette,
		/obj/item/ammo_magazine/rifle/sharp/flechette,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "SHARP Operator Flechette Magazine Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_grenadier_sharp_incendiary
	name = "SHARP操作员燃烧弹匣箱（x5）"
	contains = list(
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "SHARP Operator incendiary Magazine Crate"
	group = "Weapons Specialist Ammo"

//M240-T

/datum/supply_packs/ammo_pyro_mix
	name = "M240-T混合燃料罐箱（扩展型 x1，B型 x1，X型 x1）"
	contains = list(
		/obj/item/ammo_magazine/flamer_tank/large,
		/obj/item/ammo_magazine/flamer_tank/large/B,
		/obj/item/ammo_magazine/flamer_tank/large/X,
	)
	cost = 60
	containertype = /obj/structure/closet/crate/ammo/alt/flame
	containername = "\improper M240-T Mixed Fuel Tank Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_pyro_extended
	name = "M240-T扩展燃料罐箱（扩展型 x3）"
	contains = list(
		/obj/item/ammo_magazine/flamer_tank/large,
		/obj/item/ammo_magazine/flamer_tank/large,
		/obj/item/ammo_magazine/flamer_tank/large,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo/alt/flame
	containername = "M240-T Extended Fuel Tank Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_pyro_b
	name = "M240-T B型燃料罐箱（x1）"
	contains = list(
		/obj/item/ammo_magazine/flamer_tank/large/B,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo/alt/flame
	containername = "M240-T Type-B Fuel Tank Crate"
	group = "Weapons Specialist Ammo"

/datum/supply_packs/ammo_pyro_x
	name = "M240-T X型燃料罐箱（x1）"
	contains = list(
		/obj/item/ammo_magazine/flamer_tank/large/X,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo/alt/flame
	containername = "M240-T Type-X Fuel Tank Crate"
	group = "Weapons Specialist Ammo"
