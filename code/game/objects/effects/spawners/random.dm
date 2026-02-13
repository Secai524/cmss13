/obj/effect/spawner/random
	name = "随机物品"
	desc = "此物品类型用于在回合开始时生成随机物品。"
	icon = 'icons/landmarks.dmi'
	icon_state = "x3"
	var/spawn_nothing_percentage = 0 // this variable determines the likelyhood that this random object will not spawn anything
	var/spawn_on_roundstart = FALSE

// creates a new object and deletes itself
/obj/effect/spawner/random/Initialize()
	. = ..()

	if(!prob(spawn_nothing_percentage))
		if(spawn_on_roundstart)
			alpha = 0
			return INITIALIZE_HINT_ROUNDSTART
		else
			spawn_item()

	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/random/LateInitialize()
	spawn_item()
	qdel(src)

// this function should return a specific item to spawn
/obj/effect/spawner/random/proc/item_to_spawn()
	return 0


// creates the random item
/obj/effect/spawner/random/proc/spawn_item()
	var/build_path = item_to_spawn()
	if(!ispath(build_path))
		return
	return (new build_path(src.loc))


/obj/effect/spawner/random/tool
	name = "随机工具"
	desc = "这是一件随机工具。"
	icon_state = "random_tool"

/obj/effect/spawner/random/tool/item_to_spawn()
	return pick(/obj/item/tool/screwdriver,\
				/obj/item/tool/wirecutters,\
				/obj/item/tool/weldingtool,\
				/obj/item/tool/crowbar,\
				/obj/item/tool/wrench,\
				/obj/item/device/flashlight)


/obj/effect/spawner/random/technology_scanner
	name = "随机扫描仪"
	desc = "这是一个随机科技扫描仪。"
	icon = 'icons/obj/items/devices.dmi'
	icon_state = "atmos"

/obj/effect/spawner/random/technology_scanner/item_to_spawn()
	return pick_weight(list(
		"none" = 10,
		/obj/item/device/t_scanner = 10,
		/obj/item/device/radio = 8,
		/obj/item/device/analyzer = 10,
		/obj/item/device/black_market_hacking_device = 2,
	))

/obj/effect/spawner/random/powercell
	name = "随机电池"
	desc = "这是一个随机电池。"
	icon_state = "random_cell_battery"

/obj/effect/spawner/random/powercell/item_to_spawn()
	return pick(prob(10);/obj/item/cell/crap,\
				prob(40);/obj/item/cell,\
				prob(40);/obj/item/cell/high,\
				prob(9);/obj/item/cell/super,\
				prob(1);/obj/item/cell/hyper)


/obj/effect/spawner/random/bomb_supply
	name = "炸弹补给"
	desc = "这是一个随机炸弹补给。"
	icon = 'icons/obj/items/new_assemblies.dmi'
	icon_state = "signaller"

/obj/effect/spawner/random/bomb_supply/item_to_spawn()
	return pick(/obj/item/device/assembly/igniter,\
				/obj/item/device/assembly/prox_sensor,\
				/obj/item/device/assembly/signaller,\
				/obj/item/device/multitool)


/obj/effect/spawner/random/toolbox
	name = "随机工具箱"
	desc = "这是一个随机工具箱。"
	icon_state = "random_toolbox"

/obj/effect/spawner/random/toolbox/item_to_spawn()
	return pick(prob(3);/obj/item/storage/toolbox/mechanical,\
				prob(2);/obj/item/storage/toolbox/electrical,\
				prob(2);/obj/item/storage/toolbox/mechanical/green,\
				prob(1);/obj/item/storage/toolbox/emergency)


/obj/effect/spawner/random/tech_supply
	name = "随机科技补给"
	desc = "这是一件随机科技补给品。"
	icon = 'icons/obj/structures/machinery/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 50

/obj/effect/spawner/random/tech_supply/item_to_spawn()
	return pick(prob(3);/obj/effect/spawner/random/powercell,\
				prob(2);/obj/effect/spawner/random/technology_scanner,\
				prob(1);/obj/item/packageWrap,\
				prob(2);/obj/effect/spawner/random/bomb_supply,\
				prob(1);/obj/item/tool/extinguisher,\
				prob(1);/obj/item/clothing/gloves/fyellow,\
				prob(3);/obj/item/stack/cable_coil,\
				prob(2);/obj/effect/spawner/random/toolbox,\
				prob(2);/obj/item/storage/belt/utility,\
				prob(5);/obj/effect/spawner/random/tool)


/obj/effect/spawner/random/attachment
	name = "随机配件"
	desc = "这是一个随机配件。"
	icon_state = "random_attachment"

/obj/effect/spawner/random/attachment/item_to_spawn()
	return pick(prob(3);/obj/item/attachable/flashlight,\
				prob(3);/obj/item/attachable/reddot,\
				prob(3);/obj/item/attachable/extended_barrel,\
				prob(3);/obj/item/attachable/magnetic_harness,\
				prob(2);/obj/item/attachable/flashlight/grip,\
				prob(2);/obj/item/attachable/suppressor,\
				prob(2);/obj/item/attachable/burstfire_assembly,\
				prob(2);/obj/item/attachable/compensator,\
				prob(1);/obj/item/attachable/alt_iff_scope,\
				prob(1);/obj/item/attachable/heavy_barrel,\
				prob(1);/obj/item/attachable/scope/mini)

/obj/effect/spawner/random/balaclavas
	name = "随机巴拉克拉瓦头套"
	desc = "这是一个随机选择的巴拉克拉瓦头套。"
	icon_state = "loot_goggles"
	spawn_nothing_percentage = 50

/obj/effect/spawner/random/balaclavas/item_to_spawn()
	return pick(prob(100);/obj/item/clothing/mask/balaclava,\
				prob(50);/obj/item/clothing/mask/balaclava/tactical,\
				prob(25);/obj/item/clothing/mask/rebreather/scarf/green,\
				prob(25);/obj/item/clothing/mask/rebreather/scarf/gray,\
				prob(25);/obj/item/clothing/mask/rebreather/scarf/tan,\
				prob(10);/obj/item/clothing/mask/rebreather/skull,\
				prob(10);/obj/item/clothing/mask/rebreather/skull/black)

///If anyone wants to make custom sprites for this and the bala random spawner, be my guest.
/obj/effect/spawner/random/facepaint
	name = "随机面部迷彩"
	desc = "这是一个随机选择的面部迷彩。"
	icon_state = "loot_goggles"
	spawn_nothing_percentage = 50

/obj/effect/spawner/random/facepaint/item_to_spawn()
	return pick(prob(100);/obj/item/facepaint/black,\
				prob(50);/obj/item/facepaint/green,\
				prob(25);/obj/item/facepaint/brown,\
				prob(25);/obj/item/facepaint/sunscreen_stick,\
				prob(10);/obj/item/facepaint/sniper,\
				prob(10);/obj/item/facepaint/skull)

/obj/effect/spawner/random/supply_kit
	name = "随机补给包"
	desc = "这是一个随机补给包。"
	icon_state = "random_kit"

/obj/effect/spawner/random/supply_kit/item_to_spawn()
	return pick(prob(3);/obj/item/storage/box/kit/pursuit,\
				prob(3);/obj/item/storage/box/kit/self_defense,\
				prob(3);/obj/item/storage/box/kit/mini_medic,\
				prob(2);/obj/item/storage/box/kit/mou53_sapper,\
				prob(1);/obj/item/storage/box/kit/heavy_support)

/obj/effect/spawner/random/supply_kit/market/item_to_spawn()
	return pick(prob(3);/obj/item/storage/box/kit/pursuit,\
				prob(3);/obj/item/storage/box/kit/mini_intel,\
				prob(3);/obj/item/storage/box/kit/mini_jtac,\
				prob(2);/obj/item/storage/box/kit/mou53_sapper,\
				prob(1);/obj/item/storage/box/kit/heavy_support)

/obj/effect/spawner/random/toy
	name = "随机玩具"
	desc = "这是一个随机玩具。"
	icon_state = "ipool"

/obj/effect/spawner/random/toy/item_to_spawn()
	return pick(/obj/item/storage/wallet,\
				/obj/item/storage/photo_album,\
				/obj/item/storage/box/snappops,\
				/obj/item/storage/fancy/crayons,\
				/obj/item/storage/belt/champion,\
				/obj/item/tool/soap/deluxe,\
				/obj/item/tool/pickaxe/silver,\
				/obj/item/tool/pen/white,\
				/obj/item/explosive/grenade/smokebomb,\
				/obj/item/corncob,\
				/obj/item/poster,\
				/obj/item/toy/bikehorn,\
				/obj/item/toy/beach_ball,\
				/obj/item/toy/balloon,\
				/obj/item/toy/blink,\
				/obj/item/toy/crossbow,\
				/obj/item/toy/gun,\
				/obj/item/toy/katana,\
				/obj/item/toy/prize/deathripley,\
				/obj/item/toy/prize/durand,\
				/obj/item/toy/prize/fireripley,\
				/obj/item/toy/prize/gygax,\
				/obj/item/toy/prize/honk,\
				/obj/item/toy/prize/marauder,\
				/obj/item/toy/prize/mauler,\
				/obj/item/toy/prize/odysseus,\
				/obj/item/toy/prize/phazon,\
				/obj/item/toy/prize/ripley,\
				/obj/item/toy/prize/seraph,\
				/obj/item/toy/spinningtoy,\
				/obj/item/toy/sword,\
				/obj/item/reagent_container/food/snacks/grown/ambrosiadeus,\
				/obj/item/reagent_container/food/snacks/grown/ambrosiavulgaris,\
				/obj/item/clothing/accessory/tie/horrible,\
				/obj/item/clothing/shoes/slippers,\
				/obj/item/clothing/shoes/slippers_worn,\
				/obj/item/clothing/head/collectable/tophat/super)

/obj/effect/spawner/random/pills
	name = "药瓶战利品生成器" // 60% chance for strong loot
	desc = "这是一个为幸存者准备的随机药瓶。请记得在实例化中设置无生成物的百分比几率。"
	icon_state = "loot_pills"

/obj/effect/spawner/random/pills/item_to_spawn()
	return pick(prob(4);/obj/item/storage/pill_bottle/inaprovaline/skillless,\
				prob(4);/obj/item/storage/pill_bottle/mystery/skillless,\
				prob(3);/obj/item/storage/pill_bottle/alkysine/skillless,\
				prob(3);/obj/item/storage/pill_bottle/imidazoline/skillless,\
				prob(3);/obj/item/storage/pill_bottle/tramadol/skillless,\
				prob(3);/obj/item/storage/pill_bottle/bicaridine/skillless,\
				prob(3);/obj/item/storage/pill_bottle/kelotane/skillless,\
				prob(3);/obj/item/storage/pill_bottle/peridaxon/skillless,\
				prob(2);/obj/item/storage/pill_bottle/oxycodone/skillless,\
				prob(2);/obj/item/storage/pill_bottle/packet/oxycodone)

/obj/effect/spawner/random/pills/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_pills_20"

/obj/effect/spawner/random/pills/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_pills_50"

/obj/effect/spawner/random/pills/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_pills_80"

/obj/effect/spawner/random/goggles
	name = "护目镜战利品生成器"
	desc = "这是一套为幸存者准备的随机护目镜。记得在实例化中设置不生成物品的百分比几率。"
	icon_state = "loot_goggles"

/obj/effect/spawner/random/goggles/item_to_spawn()
	return pick(prob(4);/obj/item/clothing/glasses/welding/superior,\
				prob(4);/obj/item/clothing/glasses/hud/security/jensenshades,\
				prob(4);/obj/item/clothing/glasses/meson/refurbished,\
				prob(4);/obj/item/clothing/glasses/science,\
				prob(4);/obj/item/clothing/glasses/hud/sensor,\
				prob(4);/obj/item/clothing/glasses/hud/security)

/obj/effect/spawner/random/goggles/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_goggles_20"

/obj/effect/spawner/random/goggles/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_goggles_50"

/obj/effect/spawner/random/goggles/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_goggles_80"

/obj/effect/spawner/random/sentry
	name = "哨戒炮战利品生成器"
	desc = "这是一台为幸存者准备的随机哨戒炮。记得在实例化中设置不生成物品的百分比几率。"
	icon_state = "loot_sentry"

/obj/effect/spawner/random/sentry/item_to_spawn()
	return pick(/obj/item/defenses/handheld/tesla_coil,\
				/obj/item/defenses/handheld/planted_flag,\
				/obj/item/defenses/handheld/sentry,\
				/obj/item/defenses/handheld/sentry/flamer)

/obj/effect/spawner/random/sentry/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_sentry_20"

/obj/effect/spawner/random/sentry/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_sentry_50"

/obj/effect/spawner/random/sentry/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_sentry_80"

/*
// Gun subtype spawners
// these spawn a gun and some ammo for it, can be configured and messed around with
// presets for maps - pistol, shotgun, smg, rifle
*/

/obj/effect/spawner/random/gun
	name = "父类型"
	desc = "不要生成这个。"
	icon_state = "map_hazard"
	var/scatter = TRUE
	var/mags_max = 5
	var/mags_min = 1
	var/list/guns = list(
		/obj/item/weapon/gun/pistol/b92fs = /obj/item/ammo_magazine/pistol/b92fs,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower,
		/obj/item/weapon/gun/pistol/m1911 = /obj/item/ammo_magazine/pistol/m1911,
		/obj/item/weapon/gun/revolver/small = /obj/item/ammo_magazine/revolver/small,
		/obj/item/weapon/gun/pistol/heavy = /obj/item/ammo_magazine/pistol/heavy
		)



/obj/effect/spawner/random/gun/spawn_item()
	var/gunpath = pick(guns)
	var/ammopath
	if(ispath(gunpath, /obj/item/weapon/gun/shotgun))
		ammopath = pick(GLOB.shotgun_boxes_12g)
		mags_min = 1
		mags_max = 2
	else if(ispath(gunpath, /obj/item/weapon/gun/launcher/grenade))
		ammopath = pick(GLOB.grenade_packets)
	else
		ammopath = guns[gunpath]
	spawn_weapon_on_floor(gunpath, ammopath, rand(mags_min, mags_max))

/obj/effect/spawner/random/gun/proc/spawn_weapon_on_floor(gunpath, ammopath, ammo_amount = 1)

	var/turf/spawnloc = get_turf(src)
	var/obj/gun
	var/obj/ammo

	if(gunpath)
		gun = new gunpath(spawnloc)
		if(scatter)
			var/direction = pick(GLOB.alldirs)
			var/turf/turf = get_step(gun, direction)
			if(!turf || turf.density)
				return
			gun.forceMove(turf)
	if(ammopath)
		for(var/i in 0 to ammo_amount-1)
			ammo = new ammopath(spawnloc)
			if(scatter)
				var/direction = pick(GLOB.alldirs)
				var/turf/turf = get_step(ammo, direction)
				if(!turf || turf.density)
					return
				ammo.forceMove(turf)

/*
// the actual spawners themselves
*/

/obj/effect/spawner/random/gun/pistol
	name = "手枪战利品生成器"
	desc = "生成一把幸存者手枪和一些弹药。"
	icon_state = "loot_pistol"
	mags_max = 4
	mags_min = 1
	guns = list(
		/obj/item/weapon/gun/pistol/b92fs = /obj/item/ammo_magazine/pistol/b92fs,
		/obj/item/weapon/gun/pistol/b92fs = /obj/item/ammo_magazine/pistol/b92fs,
		/obj/item/weapon/gun/pistol/b92fs = /obj/item/ammo_magazine/pistol/b92fs,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower,
		/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower,
		/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower,
		/obj/item/weapon/gun/pistol/kt42 = /obj/item/ammo_magazine/pistol/kt42,
		/obj/item/weapon/gun/pistol/kt42 = /obj/item/ammo_magazine/pistol/kt42,
		/obj/item/weapon/gun/pistol/kt42 = /obj/item/ammo_magazine/pistol/kt42,
		/obj/item/weapon/gun/pistol/m1911 = /obj/item/ammo_magazine/pistol/m1911,
		/obj/item/weapon/gun/revolver/small = /obj/item/ammo_magazine/revolver/small,
		/obj/item/weapon/gun/pistol/heavy = /obj/item/ammo_magazine/pistol/heavy,
		/obj/item/weapon/gun/pistol/skorpion = /obj/item/ammo_magazine/pistol/skorpion,
		)

/obj/effect/spawner/random/gun/pistol/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_pistol_20"

/obj/effect/spawner/random/gun/pistol/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_pistol_50"

/obj/effect/spawner/random/gun/pistol/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_pistol_80"

/obj/effect/spawner/random/gun/rifle
	name = "步枪战利品生成器"
	desc = "生成一把幸存者步枪和一些弹药。"
	icon_state = "loot_rifle"
	guns = list(
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16,
		/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/mar40 = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/mar40 = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/ar10 = /obj/item/ammo_magazine/rifle/ar10,
		/obj/item/weapon/gun/rifle/l42a/abr40 = /obj/item/ammo_magazine/rifle/l42a/abr40,
		/obj/item/weapon/gun/rifle/nsg23/no_lock/stripped = /obj/item/ammo_magazine/rifle/nsg23
		)

/obj/effect/spawner/random/gun/rifle/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_rifle_20"

/obj/effect/spawner/random/gun/rifle/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_rifle_50"

/obj/effect/spawner/random/gun/rifle/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_rifle_80"

/obj/effect/spawner/random/gun/shotgun
	name = "霰弹枪战利品生成器"
	desc = "生成一把幸存者霰弹枪和一些弹药。"
	icon_state = "loot_shotgun"
	mags_min = 1
	mags_max = 2
	guns = list(
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/lever_action/r4t = /obj/item/ammo_magazine/lever_action,
		/obj/item/weapon/gun/lever_action/r4t = /obj/item/ammo_magazine/lever_action,
		/obj/item/weapon/gun/lever_action/r4t = /obj/item/ammo_magazine/lever_action,
		/obj/item/weapon/gun/shotgun/double/with_stock = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717 = null,
	) //no ammotypes needed as it spawns random 12g boxes. Apart from the r4t. why is the r4t in the shotgun pool? fuck you, that's why.

/obj/effect/spawner/random/gun/shotgun/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_shotgun_20"

/obj/effect/spawner/random/gun/shotgun/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_shotgun_50"

/obj/effect/spawner/random/gun/shotgun/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_shotgun_80"

/obj/effect/spawner/random/gun/smg
	name = "冲锋枪战利品生成器"
	desc = "生成一把幸存者冲锋枪和一些弹药。"
	icon_state = "loot_smg"
	guns = list(
		/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/smg/mp27 = /obj/item/ammo_magazine/smg/mp27,
		/obj/item/weapon/gun/smg/mp27 = /obj/item/ammo_magazine/smg/mp27,
		/obj/item/weapon/gun/smg/mp27 = /obj/item/ammo_magazine/smg/mp27,
		/obj/item/weapon/gun/smg/mp27 = /obj/item/ammo_magazine/smg/mp27,
		/obj/item/weapon/gun/smg/mac15 = /obj/item/ammo_magazine/smg/mac15,
		/obj/item/weapon/gun/smg/mac15 = /obj/item/ammo_magazine/smg/mac15,
		/obj/item/weapon/gun/smg/uzi = /obj/item/ammo_magazine/smg/uzi,
		/obj/item/weapon/gun/smg/uzi = /obj/item/ammo_magazine/smg/uzi,
		/obj/item/weapon/gun/smg/fp9000 = /obj/item/ammo_magazine/smg/fp9000
		)

/obj/effect/spawner/random/gun/smg/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_smg_20"

/obj/effect/spawner/random/gun/smg/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_smg_50"

/obj/effect/spawner/random/gun/smg/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_smg_80"

/obj/effect/spawner/random/gun/special
	name = "特殊武器战利品生成器"
	desc = "生成一把幸存者特殊武器和一些弹药。"
	icon_state = "loot_special"
	guns = list(
		/obj/item/weapon/gun/rifle/mar40/lmg = /obj/item/ammo_magazine/rifle/mar40/lmg,
		/obj/item/weapon/gun/shotgun/merc = null,
		/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable = null,
		/obj/item/weapon/gun/flamer = null,
		/obj/item/weapon/gun/shotgun/combat = null,
		/obj/item/weapon/gun/pistol/vp78 = /obj/item/ammo_magazine/pistol/vp78,
		/obj/item/weapon/gun/launcher/grenade/m81/m85a1 = null
		)

/obj/effect/spawner/random/gun/special/lowchance
	spawn_nothing_percentage = 80
	icon_state = "loot_special_20"

/obj/effect/spawner/random/gun/special/midchance
	spawn_nothing_percentage = 50
	icon_state = "loot_special_50"

/obj/effect/spawner/random/gun/special/highchance
	spawn_nothing_percentage = 20
	icon_state = "loot_special_80"

/obj/effect/spawner/random/gun/cmb
	name = "战斗刀战利品生成器"
	desc = "生成一把幸存者战斗刀和一些弹药"
	//icon_state = "loot_cmb"
	icon_state = "loot_shotgun"
	//TODO: re-add icons after removing for ASS test
	guns = list(
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717 = null,
		/obj/item/weapon/gun/smg/mp5/mp5a5 = /obj/item/ammo_magazine/smg/mp5,
		/obj/item/weapon/gun/revolver/cmb/custom = /obj/item/ammo_magazine/revolver/cmb


		)

/obj/effect/spawner/random/gun/cmb/lowchance
	spawn_nothing_percentage = 80
	//icon_state = "loot_cmb_20"
	icon_state = "loot_shotgun_20"

/obj/effect/spawner/random/gun/cmb/midchance
	spawn_nothing_percentage = 50
	//icon_state = "loot_cmb_50"
	icon_state = "loot_shotgun_50"

/obj/effect/spawner/random/gun/cmb/highchance
	spawn_nothing_percentage = 20
	//icon_state = "loot_cmb_80"
	icon_state = "loot_shotgun_80"

/obj/effect/spawner/random/gun/corporate
	name = "公司武器战利品生成器"
	desc = "生成一把幸存者公司武器和一些弹药"
	//icon_state = "loot_corporate"
	icon_state = "loot_smg"
	guns = list(
		/obj/item/weapon/gun/rifle/m41a/corporate/no_lock = /obj/item/ammo_magazine/rifle,
		/obj/item/weapon/gun/rifle/m41a/corporate/no_lock = /obj/item/ammo_magazine/rifle,
		/obj/item/weapon/gun/rifle/nsg23/no_lock/stripped = /obj/item/ammo_magazine/rifle/nsg23,
		/obj/item/weapon/gun/rifle/nsg23/no_lock/stripped = /obj/item/ammo_magazine/rifle/nsg23,
		/obj/item/weapon/gun/smg/m39/corporate/no_lock = /obj/item/ammo_magazine/smg/m39,
		/obj/item/weapon/gun/smg/m39/corporate/no_lock = /obj/item/ammo_magazine/smg/m39,
		/obj/item/weapon/gun/smg/p90 = /obj/item/ammo_magazine/smg/p90,
		/obj/item/weapon/gun/pistol/mod88 = /obj/item/ammo_magazine/pistol/mod88,
		/obj/item/weapon/gun/pistol/mod88 = /obj/item/ammo_magazine/pistol/mod88,
		/obj/item/weapon/gun/pistol/vp78 = /obj/item/ammo_magazine/pistol/vp78
		)

/obj/effect/spawner/random/gun/corporate/lowchance
	spawn_nothing_percentage = 80
	//icon_state = "loot_corporate_20"
	icon_state = "loot_smg_20"

/obj/effect/spawner/random/gun/corporate/midchance
	spawn_nothing_percentage = 50
	//icon_state = "loot_corporate_50"
	icon_state = "loot_smg_50"

/obj/effect/spawner/random/gun/corporate/highchance
	spawn_nothing_percentage = 20
	//icon_state = "loot_corporate_80"
	icon_state = "loot_smg_80"

/obj/effect/spawner/random/gun/civ
	name = "民用武器战利品生成器"
	desc = "生成一把幸存者民用武器和一些弹药"
	mags_min = 1
	mags_max = 3
	//icon_state = "loot_civ"
	icon_state = "loot_rifle"
	guns = list(
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/boltaction = /obj/item/ammo_magazine/rifle/boltaction,
		/obj/item/weapon/gun/shotgun/double = null,
		/obj/item/weapon/gun/shotgun/double/sawn = null,
		/obj/item/weapon/gun/shotgun/double/with_stock = null,
		/obj/item/weapon/gun/shotgun/double/with_stock = null,
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = null,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/lever_action/r4t = /obj/item/ammo_magazine/lever_action
		)

/obj/effect/spawner/random/gun/civ/lowchance
	spawn_nothing_percentage = 80
	//icon_state = "loot_civ_20"
	icon_state = "loot_rifle_20"

/obj/effect/spawner/random/gun/civ/midchance
	spawn_nothing_percentage = 50
	//icon_state = "loot_civ_50"
	icon_state = "loot_rifle_50"

/obj/effect/spawner/random/gun/civ/highchance
	spawn_nothing_percentage = 20
	//icon_state = "loot_civ_80"
	icon_state = "loot_rifle_80"

/*
// claymore spawners
*/

/obj/effect/spawner/random/claymore
	name = "随机阔剑地雷"
	desc = "这是一个随机部署并激活的阔剑地雷。"
	icon_state = "claymore"

/obj/effect/spawner/random/claymore/item_to_spawn()
	return pick(/obj/item/explosive/mine/active/no_iff,\
				/obj/item/explosive/mine/pmc/active)

/obj/effect/spawner/random/claymore/spawn_item()
	var/build_path = item_to_spawn()
	var/obj/item/explosive/mine/M = new build_path(src.loc)
	M.dir = src.dir
	return

/obj/effect/spawner/random/claymore/lowchance
	spawn_nothing_percentage = 80
	icon_state = "claymore_20"

/obj/effect/spawner/random/claymore/midchance
	spawn_nothing_percentage = 50
	icon_state = "claymore_50"

/obj/effect/spawner/random/claymore/highchance
	spawn_nothing_percentage = 20
	icon_state = "claymore_80"


/*
// OB spawners
*/

/obj/effect/spawner/random/warhead
	name = "随机轨道弹头"
	desc = "这是一枚随机轨道弹头。"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "ob_warhead_1"
	spawn_on_roundstart = TRUE

/obj/effect/spawner/random/warhead/item_to_spawn()
	var/list/spawnables = list(
		/obj/structure/ob_ammo/warhead/explosive,
		/obj/structure/ob_ammo/warhead/incendiary,
		/obj/structure/ob_ammo/warhead/cluster
	)
	return pick(spawnables)
