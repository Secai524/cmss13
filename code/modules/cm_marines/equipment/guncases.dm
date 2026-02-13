/obj/item/storage/box/guncase
	name = "\improper gun case"
	desc = "它有空间放置枪械。有时也能放弹匣或其他弹药。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "guncase"
	item_state = "guncase"
	w_class = SIZE_HUGE
	max_w_class = SIZE_HUGE //shouldn't be a problem since we can only store the guns and ammo.
	storage_slots = 1
	slowdown = 1
	can_hold = list()//define on a per case basis for the original firearm.
	foldable = TRUE
	foldable = /obj/item/stack/sheet/mineral/plastic//it makes sense
	ground_offset_y = 5

/obj/item/storage/box/guncase/update_icon()
	if(LAZYLEN(contents))
		icon_state = "guncase"
	else
		icon_state = "guncase_e"

/obj/item/storage/box/guncase/Initialize()
	. = ..()
	update_icon()

//------------
/obj/item/storage/box/guncase/vp78
	name = "\improper VP78 pistol case"
	desc = "一个装有VP78的枪盒。附带两个弹匣。"
	can_hold = list(/obj/item/weapon/gun/pistol/vp78, /obj/item/ammo_magazine/pistol/vp78)
	storage_slots = 3

/obj/item/storage/box/guncase/vp78/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/vp78(src)
	new /obj/item/ammo_magazine/pistol/vp78(src)
	new /obj/item/ammo_magazine/pistol/vp78(src)

//------------
/obj/item/storage/box/guncase/smartpistol
	name = "\improper SU-6 pistol case"
	desc = "一个装有SU-6智能手枪的枪盒。附带一个全腰带枪套。"
	can_hold = list(/obj/item/storage/belt/gun/smartpistol, /obj/item/weapon/gun/pistol/smart, /obj/item/ammo_magazine/pistol/smart)
	storage_slots = 2

/obj/item/storage/box/guncase/smartpistol/fill_preset_inventory()
	new /obj/item/storage/belt/gun/smartpistol/full_nogun(src)
	new /obj/item/weapon/gun/pistol/smart(src)

//------------
/obj/item/storage/box/guncase/mou53
	name = "\improper MOU53 shotgun case"
	desc = "一个装有MOU53霰弹枪的枪盒。它确实是装填好的，但你仍然需要边走边找弹药。"
	storage_slots = 2
	can_hold = list(/obj/item/weapon/gun/shotgun/double/mou53, /obj/item/attachable/stock/mou53)

/obj/item/storage/box/guncase/mou53/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/double/mou53(src)
	new /obj/item/attachable/stock/mou53(src)

//------------
/obj/item/storage/box/guncase/lmg
	name = "\improper M41AE2 heavy pulse rifle case"
	desc = "一个装有M41AE2重型脉冲步枪的枪盒。你可以在补给处获取额外弹药。"
	storage_slots = 5
	can_hold = list(/obj/item/weapon/gun/rifle/lmg, /obj/item/ammo_magazine/rifle/lmg)

/obj/item/storage/box/guncase/lmg/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/lmg(src)
	new /obj/item/ammo_magazine/rifle/lmg(src)
	new /obj/item/ammo_magazine/rifle/lmg/holo_target(src)
	new /obj/item/attachable/flashlight

//------------
/obj/item/storage/box/guncase/m41aMK1
	name = "\improper M41A pulse rifle MK1 case"
	desc = "一个装有M41A脉冲步枪MK1的枪盒。它只能使用专用的MK1弹匣。"
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/rifle/m41aMK1, /obj/item/ammo_magazine/rifle/m41aMK1)

/obj/item/storage/box/guncase/m41aMK1/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)


/obj/item/storage/box/guncase/m41aMK1AP
	name = "\improper M41A pulse rifle MK1 AP case"
	desc = "一个装有M41A脉冲步枪MK1的枪盒，已装填穿甲弹。它只能使用专用的MK1弹匣。"
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/rifle/m41aMK1, /obj/item/ammo_magazine/rifle/m41aMK1)

/obj/item/storage/box/guncase/m41aMK1AP/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/m41aMK1/ap(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1/ap(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1/ap(src)

//------------
//M85A1 grenade launcher
/obj/item/storage/box/guncase/m85a1
	name = "\improper M85A1 grenade launcher case"
	desc = "一个装有现代化M85A1榴弹发射器的枪盒。附带3发警棍弹、3发黄蜂弹和3发星照明弹。"
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/launcher/grenade/m81/m85a1, /obj/item/storage/box/packet)

/obj/item/storage/box/guncase/m85a1/fill_preset_inventory()
	new /obj/item/weapon/gun/launcher/grenade/m81/m85a1(src)
	new /obj/item/storage/box/packet/flare(src)
	new /obj/item/storage/box/packet/baton_slug(src)
	new /obj/item/storage/box/packet/hornet(src)

//------------
//R4T lever action rifle
/obj/item/storage/box/guncase/r4t_scout
	name = "\improper R4T lever action rifle case"
	desc = "一个枪箱，内含R4T杠杆式步枪，用于侦察任务。附带一条弹药带、可选配的左轮手枪附件、两盒弹药、一条枪带以及步枪枪托。"
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/lever_action/r4t, /obj/item/attachable/stock/r4t, /obj/item/attachable/magnetic_harness/lever_sling, /obj/item/ammo_magazine/lever_action, /obj/item/ammo_magazine/lever_action/training, /obj/item/storage/belt/shotgun/lever_action, /obj/item/storage/belt/gun/m44/lever_action/attach_holster, /obj/item/device/motiondetector/m717)

/obj/item/storage/box/guncase/r4t_scout/fill_preset_inventory()
	new /obj/item/weapon/gun/lever_action/r4t(src)
	new /obj/item/attachable/stock/r4t(src)
	new /obj/item/attachable/magnetic_harness/lever_sling(src)
	new /obj/item/ammo_magazine/lever_action(src)
	new /obj/item/ammo_magazine/lever_action(src)
	new /obj/item/storage/belt/shotgun/lever_action(src)
	new /obj/item/storage/belt/gun/m44/lever_action/attach_holster(src)

/obj/item/storage/box/guncase/xm88
	name = "\improper XM88 heavy rifle case"
	desc = "一个枪箱，内含XM88重型步枪，一种为对抗重甲步兵目标和轻型载具而设计的原型武器。包含一条弹药带、两盒弹药、XS-9目标中继附件以及步枪枪托。"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/lever_action/xm88, /obj/item/attachable/stock/xm88, /obj/item/attachable/scope/mini/xm88, /obj/item/ammo_magazine/lever_action/xm88, /obj/item/storage/belt/shotgun/xm88)

/obj/item/storage/box/guncase/xm88/fill_preset_inventory()
	new /obj/item/weapon/gun/lever_action/xm88(src)
	new /obj/item/attachable/stock/xm88(src)
	new /obj/item/attachable/scope/mini/xm88(src)
	new /obj/item/ammo_magazine/lever_action/xm88(src)
	new /obj/item/ammo_magazine/lever_action/xm88(src)
	new /obj/item/storage/belt/shotgun/xm88(src)

//------------
/obj/item/storage/box/guncase/flamer
	name = "\improper M240 incinerator case"
	desc = "一个枪箱，内含M240A1焚烧器单元。它已装填完毕，但你仍需在行动中寻找额外的燃料罐。"
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/flamer/m240, /obj/item/ammo_magazine/flamer_tank, /obj/item/attachable/attached_gun/extinguisher)

/obj/item/storage/box/guncase/flamer/fill_preset_inventory()
	new /obj/item/weapon/gun/flamer/m240(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/attachable/attached_gun/extinguisher(src)

//------------
/obj/item/storage/box/guncase/m56d
	name = "\improper M56D heavy machine gun case"
	desc = "一个枪箱，内含M56D重机枪。你需要从补给处申请补给或在战场上搜刮。他们是怎么把所有东西塞进一个箱子里的？难道不应该需要一个板条箱吗？"
	storage_slots = 8
	can_hold = list(/obj/item/device/m56d_gun, /obj/item/ammo_magazine/m56d, /obj/item/device/m56d_post, /obj/item/tool/wrench, /obj/item/tool/screwdriver, /obj/item/ammo_magazine/m56d, /obj/item/pamphlet/skill/machinegunner, /obj/item/storage/belt/marine/m2c)

/obj/item/storage/box/guncase/m56d/fill_preset_inventory()
	new /obj/item/device/m56d_gun(src)
	new /obj/item/ammo_magazine/m56d(src)
	new /obj/item/ammo_magazine/m56d(src)
	new /obj/item/device/m56d_post(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/screwdriver(src)
	new /obj/item/pamphlet/skill/machinegunner(src)
	new /obj/item/storage/belt/marine/m2c(src)

//------------
/obj/item/storage/box/guncase/m2c
	name = "\improper M2C heavy machine gun case"
	desc = "一个枪箱，内含M2C重机枪。它未装弹，但备有备用弹药。你需要从补给处申请额外补给。"
	storage_slots = 7
	can_hold = list(/obj/item/pamphlet/skill/machinegunner, /obj/item/device/m2c_gun, /obj/item/ammo_magazine/m2c, /obj/item/storage/belt/marine/m2c, /obj/item/pamphlet/skill/machinegunner)

/obj/item/storage/box/guncase/m2c/fill_preset_inventory()
	new /obj/item/pamphlet/skill/machinegunner(src)
	new /obj/item/device/m2c_gun(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/storage/belt/marine/m2c(src)

//------------
/obj/item/storage/box/guncase/m41a
	name = "\improper M41A pulse rifle MK2 case"
	desc = "一个枪箱，内含M41A脉冲步枪MK2。"
	storage_slots = 5
	can_hold = list(/obj/item/weapon/gun/rifle/m41a, /obj/item/ammo_magazine/rifle)

/obj/item/storage/box/guncase/m41a/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/m41a(src)
	for(var/i = 1 to 4)
		new /obj/item/ammo_magazine/rifle(src)


//------------
/obj/item/storage/box/guncase/pumpshotgun
	name = "\improper M37A2 Pump Shotgun case"
	desc = "一个枪箱，内含M37A2泵动式霰弹枪。"
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/shotgun/pump/m37a, /obj/item/ammo_magazine/shotgun/buckshot, /obj/item/ammo_magazine/shotgun/flechette, /obj/item/ammo_magazine/shotgun/slugs)

/obj/item/storage/box/guncase/pumpshotgun/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/pump(src)
	for(var/i = 1 to 3)
		var/random_pick = rand(1, 3)
		switch(random_pick)
			if(1)
				new /obj/item/ammo_magazine/shotgun/buckshot(src)
			if(2)
				new /obj/item/ammo_magazine/shotgun/flechette(src)
			if(3)
				new /obj/item/ammo_magazine/shotgun/slugs(src)

/obj/item/storage/box/guncase/mk45_automag
	name = "\improper MK-45 Automagnum case"
	desc = "一个枪箱，内含MK-45“高功率”自动马格南手枪。虽然这款武器未被选为M44战斗左轮手枪的替代品，但它常被重新配发给那些偏爱其强大威力而非更常见副武器的部队。"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/pistol/highpower, /obj/item/ammo_magazine/pistol/highpower)

/obj/item/storage/box/guncase/mk45_automag/fill_preset_inventory()
	if(prob(30))
		new /obj/item/weapon/gun/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
	else
		new /obj/item/weapon/gun/pistol/highpower/black(src)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)


/obj/item/storage/box/guncase/nsg23_marine
	name = "\improper NSG-23 assault rifle case"
	desc = "一个枪箱，内含NSG 23突击步枪。虽然通常见于PMC人员手中，但这款武器有时也会配发给USCM人员。"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/rifle/nsg23/no_lock, /obj/item/ammo_magazine/rifle/nsg23)

/obj/item/storage/box/guncase/nsg23_marine/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/nsg23/no_lock(src)
	new /obj/item/ammo_magazine/rifle/nsg23/ap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/extended(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)

/obj/item/storage/box/guncase/m3717
	name = "\improper M37-17 pump shotgun case"
	desc = "一个枪箱，内含M37-17泵动式霰弹枪。这款武器很少配发给位于有人居住空间边缘的USCM舰船，这些舰船需要M37-17提供的额外火力（字面意思）。就像这一把！嗯，如果预算允许的话。"
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717, /obj/item/ammo_magazine/shotgun/buckshot)

/obj/item/storage/box/guncase/m3717/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)

/obj/item/storage/box/guncase/m1911
	name = "\improper M1911 service pistol case"
	desc = "一个枪箱，内含M1911制式手枪。它可能已有三个世纪的历史，但依然是一把该死的好枪。不过，仅限于重新配发。"
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/pistol/m1911, /obj/item/ammo_magazine/pistol/m1911)

/obj/item/storage/box/guncase/m1911/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/box/guncase/m1911/socom
	name = "\improper SOCOM M1911 service pistol case"
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/pistol/m1911/socom, /obj/item/ammo_magazine/pistol/m1911)

/obj/item/storage/box/guncase/m1911/socom/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/m1911/socom(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/box/guncase/cane_gun_kit
	name = "间谍特工手杖箱"
	desc = "一个枪箱，内含一把使用.44口径的绝密枪杖，以及两把备用同口径弹药。使用后务必将其折叠好！"
	can_hold = list(/obj/item/weapon/gun/shotgun/double/cane, /obj/item/ammo_magazine/handful/revolver)
	storage_slots = 3

/obj/item/storage/box/guncase/cane_gun_kit/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/double/cane(src)
	new /obj/item/ammo_magazine/handful/revolver/marksman/six_rounds(src)
	new /obj/item/ammo_magazine/handful/revolver/marksman/six_rounds(src)

/obj/item/storage/box/guncase/vulture
	name = "\improper M707 anti-materiel rifle case"
	desc = "一个枪箱，内含M707 \"Vulture\" anti-materiel rifle and its requisite spotting tools."
	icon_state = "guncase_blue"
	item_state = "guncase_blue"
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/boltaction/vulture,
		/obj/item/ammo_magazine/rifle/boltaction/vulture,
		/obj/item/device/vulture_spotter_tripod,
		/obj/item/device/vulture_spotter_scope,
		/obj/item/tool/screwdriver,
		/obj/item/pamphlet/trait/vulture,
	)

/obj/item/storage/box/guncase/vulture/update_icon()
	if(LAZYLEN(contents))
		icon_state = "guncase_blue"
	else
		icon_state = "guncase_blue_e"

/obj/item/storage/box/guncase/vulture/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src) // Spotter scope needs a screwdriver to disassemble
	new /obj/item/pamphlet/trait/vulture(src) //both pamphlets give use of the scope and the rifle
	new /obj/item/pamphlet/trait/vulture(src)

/obj/item/storage/box/guncase/vulture/skillless
	storage_slots = 5

/obj/item/storage/box/guncase/vulture/skillless/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/skillless/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope/skillless(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src) // Spotter scope needs a screwdriver to disassemble

/obj/item/storage/box/guncase/vulture/holo_target
	name = "\improper M707 holo-targetting anti-materiel rifle case"
	desc = "一个枪箱，内含M707 \"Vulture\" anti-materiel rifle and its requisite spotting tools. This variant is pre-loaded with <b>IFF-CAPABLE</b> holo-targeting rounds."

/obj/item/storage/box/guncase/vulture/holo_target/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/holo_target/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture/holo_target(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src)
	new /obj/item/pamphlet/trait/vulture(src)
	new /obj/item/pamphlet/trait/vulture(src)

/obj/item/storage/box/guncase/vulture/holo_target/skillless
	storage_slots = 5

/obj/item/storage/box/guncase/vulture/holo_target/skillless/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/holo_target/skillless/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture/holo_target(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope/skillless(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src)


/obj/item/storage/box/guncase/xm51
	name = "\improper XM51 breaching scattergun case"
	desc = "一个枪箱，内含XM51破门霰弹枪。附带两个备用弹匣、两盒备用霰弹、一个可选枪托以及一条用于携带武器的腰带。"
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/rifle/xm51, /obj/item/ammo_magazine/rifle/xm51, /obj/item/storage/belt/gun/xm51, /obj/item/attachable/stock/xm51)

/obj/item/storage/box/guncase/xm51/fill_preset_inventory()
	new /obj/item/attachable/stock/xm51(src)
	new /obj/item/weapon/gun/rifle/xm51(src)
	new /obj/item/ammo_magazine/rifle/xm51(src)
	new /obj/item/ammo_magazine/rifle/xm51(src)
	new /obj/item/ammo_magazine/shotgun/light/breaching(src)
	new /obj/item/ammo_magazine/shotgun/light/breaching(src)
	new /obj/item/storage/belt/gun/xm51(src)

//Handgun case for Military police vendor three mag , a railflashligh and the handgun.

//88 Mod 4 Combat Pistol
/obj/item/storage/box/guncase/mod88
	name = "\improper 88 Mod 4 Combat Pistol case"
	desc = "一个枪箱，内含一把88型4号战斗手枪。"
	storage_slots = 8
	can_hold = list(/obj/item/attachable/flashlight, /obj/item/weapon/gun/pistol/mod88, /obj/item/ammo_magazine/pistol/mod88)

/obj/item/storage/box/guncase/mod88/fill_preset_inventory()
	new /obj/item/attachable/flashlight(src)
	new /obj/item/weapon/gun/pistol/mod88(src)
	new /obj/item/ammo_magazine/pistol/mod88(src)
	new /obj/item/ammo_magazine/pistol/mod88(src)
	new /obj/item/ammo_magazine/pistol/mod88(src)
	new /obj/item/ammo_magazine/pistol/mod88(src)
	new /obj/item/ammo_magazine/pistol/mod88(src)
	new /obj/item/ammo_magazine/pistol/mod88(src)

//M44 Combat Revolver
/obj/item/storage/box/guncase/m44
	name = "\improper M44 Combat Revolver case"
	desc = "一个枪箱，内含一把装填了射手弹药的M44战斗左轮手枪。"
	storage_slots = 8
	can_hold = list(/obj/item/attachable/flashlight, /obj/item/weapon/gun/revolver/m44, /obj/item/ammo_magazine/revolver)

/obj/item/storage/box/guncase/m44/fill_preset_inventory()
	new /obj/item/attachable/flashlight(src)
	new /obj/item/weapon/gun/revolver/m44/mp(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)

/obj/item/storage/box/guncase/m2049
	name = "\improper M2049 Blaster case"
	desc = "一个枪箱，内含M2049爆能枪。附带一条满装弹腰带枪套。"
	can_hold = list(/obj/item/storage/belt/gun/m44, /obj/item/weapon/gun/revolver/m44/custom/pkd_special/k2049)
	storage_slots = 2

/obj/item/storage/box/guncase/m2049/fill_preset_inventory()
	new /obj/item/storage/belt/gun/m44/m2049/nogun(src)
	new /obj/item/weapon/gun/revolver/m44/custom/pkd_special/k2049(src)

//M4A4 Service Pistol
/obj/item/storage/box/guncase/m4a4
	name = "\improper M4A4 Service Pistol case"
	desc = "一个枪箱，内含一把M4A4制式手枪。"
	storage_slots = 8
	can_hold = list(/obj/item/attachable/flashlight, /obj/item/weapon/gun/pistol/m4a3/m4a4, /obj/item/ammo_magazine/pistol)

/obj/item/storage/box/guncase/m4a4/fill_preset_inventory()
	new /obj/item/attachable/flashlight(src)
	new /obj/item/weapon/gun/pistol/m4a3/m4a4(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)

// -------- UPP Gun Kits --------

/obj/item/storage/box/guncase/type19
	name = "\improper Type-19 submachinegun case"
	desc = "一个枪箱，内含Type-19冲锋枪，这是UPP的一款过时枪械，但在更偏远的联盟部队中仍有少量服役。"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/smg/pps43, /obj/item/ammo_magazine/smg/pps43, /obj/item/ammo_magazine/smg/pps43/extended)

/obj/item/storage/box/guncase/type19/fill_preset_inventory()
	new /obj/item/weapon/gun/smg/pps43(src)
	new /obj/item/ammo_magazine/smg/pps43(src)
	new /obj/item/ammo_magazine/smg/pps43(src)
	new /obj/item/ammo_magazine/smg/pps43(src)
	new /obj/item/ammo_magazine/smg/pps43(src)
	new /obj/item/ammo_magazine/smg/pps43(src)

/obj/item/storage/box/guncase/ppsh
	name = "\improper PPSh-17b submachinegun case"
	desc = "一个枪箱，内含PPSh-17b冲锋枪，一款古老枪械的复制品，对于现代战争来说严重不足，但深受收藏家追捧。"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/smg/ppsh, /obj/item/ammo_magazine/smg/ppsh, /obj/item/ammo_magazine/smg/ppsh/extended)

/obj/item/storage/box/guncase/ppsh/fill_preset_inventory()
	new /obj/item/weapon/gun/smg/ppsh(src)
	new /obj/item/ammo_magazine/smg/ppsh/extended(src)
	new /obj/item/ammo_magazine/smg/ppsh/extended(src)
	new /obj/item/ammo_magazine/smg/ppsh(src)
	new /obj/item/ammo_magazine/smg/ppsh(src)
	new /obj/item/ammo_magazine/smg/ppsh(src)

//------------ M10 - Special Kits ------------ //

/obj/item/storage/box/guncase/m10_custom_kit
	name = "\improper M10 auto-pistol case"
	desc = "一个枪箱，内含组装一把定制M10自动手枪所需的必要附件。附带两个扩容弹匣和两个扩容（穿甲）弹匣。"
	storage_slots = 11

	can_hold = list(/obj/item/weapon/gun/pistol/m10, /obj/item/ammo_magazine/pistol/m10/extended, /obj/item/ammo_magazine/pistol/m10/ap/extended, /obj/item/attachable/reddot/small, /obj/item/attachable/suppressor/sleek, /obj/item/attachable/compensator/m10/spiked, /obj/item/attachable/lasersight/micro, /obj/item/attachable/stock/m10_solid, /obj/item/storage/belt/gun/m10)

/obj/item/storage/box/guncase/m10_custom_kit/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/m10(src)
	new /obj/item/ammo_magazine/pistol/m10/extended(src)
	new /obj/item/ammo_magazine/pistol/m10/extended(src)
	new /obj/item/ammo_magazine/pistol/m10/ap/extended(src)
	new /obj/item/ammo_magazine/pistol/m10/ap/extended(src)
	new /obj/item/attachable/reddot/small(src)
	new /obj/item/attachable/suppressor/sleek(src)
	new /obj/item/attachable/compensator/m10/spiked(src)
	new /obj/item/attachable/lasersight/micro(src)
	new /obj/item/attachable/stock/m10_solid(src)
	new /obj/item/storage/belt/gun/m10(src)
