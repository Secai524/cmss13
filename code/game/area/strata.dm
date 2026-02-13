
// Areas for the Sorokyne Strata

/area/strata
	name = "索罗金地层"
	icon = 'icons/turf/area_strata.dmi'
	icon_state = "strata"
	can_build_special = TRUE //T-Comms structure
	powernet_name = "ground"
	temperature = TROPICAL_TEMP
	minimap_color = MINIMAP_AREA_COLONY

/area/strata/interior/out_of_bounds
	name = "界外区域"
	icon_state = "ag_i"
	soundscape_playlist = FALSE
	ambience_exterior = FALSE
	requires_power = FALSE
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW|AREA_UNWEEDABLE
	ceiling = CEILING_MAX

//////////////////////////////////////////

/area/strata/exterior
	name = "外部"
	icon_state = "ag_e"
	ceiling = CEILING_NONE
	ambience_exterior = AMBIENCE_JUNGLE_ALT

/area/strata/interior
	name = "内部"
	icon_state = "ag_i"
	ceiling = CEILING_METAL
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR
	temperature = T20C //Nice and room temp

////////////////////////////////////////

//-Landing Zones

/area/strata/exterior/landing_zones
	name = "请勿使用。"
	icon_state = "landingzone_2"
	minimap_color = MINIMAP_AREA_LZ

/area/strata/interior/landing_zones
	name = "请勿使用。"
	icon_state = "landingzone_1"
	minimap_color = MINIMAP_AREA_LZ

/area/strata/exterior/landing_zones/lz2
	name = "着陆区2平台 - 岩石地"
	unlimited_power = 1 //So the DS computer always works for the Queen
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ2

/area/strata/exterior/landing_zones/near_lz2
	name = "着陆区2 - 岩石地"
	icon_state = "nearlz2"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ2

/area/strata/interior/landing_zones/lz1
	name = "着陆区1平台 - 采矿机场"
	unlimited_power = 1 //So the DS computer always works for the Queen
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/strata/interior/landing_zones/near_lz1
	name = "着陆区1 - 采矿机场"
	icon_state = "nearlz1"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

//-Caves (how are these caves?)

/area/strata/exterior/shed_five_caves
	name = "五号航站楼上层通道"
	icon_state = "lzcaves"

/area/strata/exterior/lz_caves
	name = "外部采矿机场通道"
	linked_lz = DROPSHIP_LZ1
	icon_state = "lzcaves"

//-Marsh

/area/strata/exterior/marsh
	name = "请勿使用。"
	icon_state = "marsh"

/area/strata/exterior/marsh/spring_marshes
	name = "地热泉沼泽"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/strata/exterior/marsh/water_marshes
	name = "地热水沼泽"
	linked_lz = DROPSHIP_LZ2

/area/strata/exterior/marsh/island_marshes
	name = "地热岛沼泽"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ2

/area/strata/exterior/marsh/relay_marshes
	name = "地热中继站沼泽"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ2

/area/strata/exterior/marsh/center
	name = "地热泉"
	icon_state = "marshcenter"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/strata/exterior/marsh/river
	name = "地热河"
	icon_state = "marshriver"
	linked_lz = DROPSHIP_LZ1

/area/strata/exterior/marsh/crash
	name = "地热区坠毁运输机"
	icon_state = "marshship"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/strata/exterior/marsh/water
	name = "地热水域"
	icon_state = "marshwater"
	linked_lz = DROPSHIP_LZ2

//-Outside "interiors"

/area/strata/interior/vanyard
	name = "飞行控制车辆场"
	icon_state = "garage"
	linked_lz = DROPSHIP_LZ2

/area/strata/exterior/tcomms_mining_caves
	name = "采矿通道中继站"
	icon_state = "tcomms1"
/area/strata/exterior/tcomms_vehicle_yard
	name = "车辆场中继站"
	icon_state = "tcomms1"
	linked_lz = DROPSHIP_LZ2

/area/strata/exterior/tcomms_geosprings
	name = "地热泉中继站"
	icon_state = "tcomms1"

/area/strata/exterior/tcomms_crashed_dropship
	name = "坠毁运输机中继站"
	icon_state = "tcomms1"

/area/strata/exterior/tcomms_engineering_parts_storage
	name = "工程部 - 零件储存平台中继站"
	icon_state = "tcomms1"

//-Outpost

/area/strata/exterior/outpost_decks
	name = "前哨站 - 甲板区"
	icon_state = "rdecks"
	minimap_color = MINIMAP_AREA_CAVES

//-Paths

/area/strata/exterior/flight_control_exterior
	name = "飞行控制外部"
	linked_lz = DROPSHIP_LZ1
	icon_state = "path"

/area/strata/exterior/mining_outpost_exterior
	name = "采矿前哨站 - 外部"
	linked_lz = DROPSHIP_LZ1
	icon_state = "path"

/area/strata/exterior/north_outpost
	name = "前哨站 - 北部接入通道"
	icon_state = "outpost_gen_2"
	icon_state = "path"

/area/strata/exterior/far_north_outpost
	name = "前哨站极北区域"
	icon_state = "cabin"
	unoviable_timer = FALSE
	icon_state = "path"

/area/strata/exterior/south_outpost
	name = "前哨站以南"
	icon_state = "path"

////////////////////////////////////////

//-Outpost

/area/strata/interior/outpost
	name = "索罗金前哨站"
	icon_state = "shed_x_ag"
	minimap_color = MINIMAP_AREA_CAVES

/area/strata/interior/outpost/foyer
	name = "前哨站 - 主门厅"
	icon_state = "outpost_gen_1"

/area/strata/interior/outpost/maint
	name = "前哨站 - 食堂 - 东部维护区"
	icon_state = "outpost_maint"

/area/strata/interior/outpost/med
	name = "前哨站 - 医疗站"
	icon_state = "outpost_med"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/strata/interior/outpost/engi
	name = "前哨站 - 工程站"
	icon_state = "outpost_engi_0"
	minimap_color = MINIMAP_AREA_ENGI

/area/strata/interior/outpost/engi/drome
	name = "前哨站 - 停机坪"
	icon_state = "outpost_engi_4"

/area/strata/interior/outpost/engi/drome/shuttle
	name = "已拆解的VDVK鹰式Mk 4"
	icon_state = "outpost_engi_3"

/area/strata/interior/outpost/engi/drome/shuttle_MK3
	name = "VDVK鹰式Mk 3"
	icon_state = "outpost_engi_3"

/area/strata/interior/shuttle_sof
	name = "UPP-DS-3 '乌鸦'"
	icon_state = "outpost_engi_3"
	ambience_exterior = AMBIENCE_SHIP_ALT

/area/strata/interior/supply_shuttle_sof
	name = "UPP-DS-3 '狼'"
	icon_state = "outpost_engi_3"
	ambience_exterior = AMBIENCE_SHIP_ALT

/area/strata/interior/outpost/security
	name = "前哨站 - 安保站"
	icon_state = "outpost_sec_0"
	minimap_color = MINIMAP_AREA_SEC

/area/strata/interior/outpost/admin
	name = "前哨站 - 行政站"
	icon_state = "outpost_admin_0"
	minimap_color = MINIMAP_AREA_COMMAND
	ceiling = CEILING_GLASS

/area/strata/interior/outpost/canteen
	name = "前哨站 - 食堂"
	icon_state = "outpost_canteen_0"
	ceiling = CEILING_GLASS

/area/strata/interior/outpost/canteen/bar
	name = "前哨站 - 酒吧"
	icon_state = "outpost_canteen_2"

//-Mining Outpost

/area/strata/interior/mining_outpost
	name = "采矿前哨站 - 中央区"
	icon_state = "dorms_0"
	minimap_color = MINIMAP_AREA_MINING
	linked_lz = DROPSHIP_LZ1

/area/strata/interior/mining_outpost/south_dormitories
	name = "采矿前哨站 - 南部宿舍"
	icon_state = "dorms_3"
	ceiling = CEILING_GLASS

/area/strata/interior/mining_outpost/maintenance
	name = "采矿前哨站 - 宿舍维护区"
	icon_state = "outpost_maint"

/area/strata/interior/mining_outpost/hive
	name = "采矿前哨站 - 宿舍地热储存区"
	icon_state = "dorms_beno"

/area/strata/interior/mining_outpost/canteen
	name = "采矿前哨站 - 宿舍食堂"
	icon_state = "dorms_canteen"
	ceiling = CEILING_GLASS

/area/strata/interior/mining_outpost/flight_control
	name = "采矿前哨站 - 飞行控制中心"
	icon_state = "dorms_lobby"
	is_landing_zone = TRUE

/area/strata/interior/administration
	name = "飞行控制办公室"
	icon_state = "offices"
	minimap_color = MINIMAP_AREA_COMMAND
	linked_lz = DROPSHIP_LZ1

/area/strata/interior/wooden_hospital
	name = "木结构医院 - 医院主体"
	icon_state = "cabin3"
	minimap_color = MINIMAP_AREA_CAVES
	unoviable_timer = FALSE

/area/strata/interior/wooden_ruins
	name = "老旧木结构建筑"
	icon_state = "cabin3"
	minimap_color = MINIMAP_AREA_CAVES
	unoviable_timer = FALSE

// Sec Checkpoints

/area/strata/interior/checkpoints
	name= "请勿使用。"
	icon_state = "security_station"
	minimap_color = MINIMAP_AREA_SEC

/area/strata/interior/checkpoints/north_armor
	name = "北部安保装甲检查站"

/area/strata/interior/checkpoints/north
	name = "着陆区北部安保检查站"

/area/strata/interior/checkpoints/west
	name = "着陆区西部安保检查站"

/area/strata/interior/checkpoints/south
	name = "着陆区南部安保检查站"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ2

/area/strata/interior/checkpoints/outpost
	name = "前哨站 - 甲板安保检查站"
	icon_state = "rdecks_sec"

// Engi Storage

/area/strata/interior/parts_storage
	name = "工程部 - 零件仓库"
	icon_state = "outpost_engi_1"
	linked_lz = DROPSHIP_LZ2

/area/strata/interior/generator_substation
	name = "工程部 - 发电机变电站"
	icon_state = "outpost_engi_1"

/area/strata/exterior/parts_storage_exterior
	name = "工程部 - 零件仓库外部"
	icon_state = "outpost_engi_4"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE
	linked_lz = DROPSHIP_LZ2

/area/strata/exterior/parts_storage_cave
	name = "工程部 - 零件仓库外部"
	icon_state = "outpost_engi_4"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	ceiling =  CEILING_UNDERGROUND_ALLOW_CAS
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE

// BBall, Caves & Secure Checkpoint

/area/strata/interior/bball //come on and SLAM.
	name = "前哨站 - 篮球场"
	icon_state = "outpost_gen_4"
	minimap_color = MINIMAP_AREA_CAVES

/area/strata/interior/bball_cave //come on BURST AND DIE.
	name = "前哨站 - 篮球场洞穴"
	icon_state = "hive_1"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	minimap_color = MINIMAP_AREA_CAVES_DEEP
	unoviable_timer = FALSE
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE

/area/strata/interior/secure_checkpoint
	name = "安全检查站通道"
	icon_state = "outpost_engi_0"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	minimap_color = MINIMAP_AREA_CAVES_DEEP
	unoviable_timer = FALSE
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE

//-Deep Jungle Dorms

/area/strata/interior/underground_dorms
	name = "请勿使用。"
	icon_state = "ug_jung_dorm"
	minimap_color = MINIMAP_AREA_CAVES_STRUCTURE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	ceiling_muffle = FALSE

/area/strata/interior/underground_dorms/sec1
	name = "丛林深处 - 安保宿舍 #1"
	unoviable_timer = FALSE

/area/strata/interior/underground_dorms/sec2
	name = "丛林深处 - 安保宿舍 #2"
	unoviable_timer = FALSE

/area/strata/interior/underground_dorms/admin1
	name = "丛林深处 - 普通人员宿舍 #1"

/area/strata/interior/underground_dorms/admin2
	name = "丛林深处 - 普通人员宿舍 #2"
	unoviable_timer = FALSE

/area/strata/interior/underground_dorms/admin3
	name = "丛林深处 - 普通人员宿舍 #3"
	unoviable_timer = FALSE

/area/strata/interior/underground_dorms/admin4
	name = "丛林深处 - 普通人员宿舍 #4"
	unoviable_timer = FALSE

/area/strata/interior/underground_dorms/med1
	name = "丛林深处 - 医疗宿舍 #1"
	requires_power = 1

/area/strata/interior/underground_dorms/med2
	name = "丛林深处 - 医疗宿舍 #2"
	requires_power = TRUE

/area/strata/interior/underground_dorms/botany
	name = "植物研究站"
	requires_power = TRUE

//-Platform

/area/strata/exterior/outpost_platform
	name = "丛林深处 - 平台"
	icon_state = "ug_jung_1"
	minimap_color = MINIMAP_AREA_MEDBAY_CAVE

//-Jungle

/area/strata/exterior/carplake_center
	name = "丛林深处 - 湖心岛"
	icon_state = "ug_jung_1"
	unoviable_timer = FALSE

/area/strata/exterior/deep_jungle
	name = "请勿使用。"
	icon_state = "ug_jung_0"
	minimap_color = MINIMAP_AREA_JUNGLE
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ceiling_muffle = FALSE

/area/strata/exterior/deep_jungle/carplake_north
	name = "丛林深处 - 鲤鱼湖以北"
	icon_state = "ug_jung_6"

/area/strata/exterior/deep_jungle/carplake_east
	name = "丛林深处 - 鲤鱼湖以东"
	icon_state = "ug_jung_5"

/area/strata/exterior/deep_jungle/platform
	name = "丛林深处 - 平台以南"
	icon_state = "ug_jung_4"
	unoviable_timer = FALSE

/area/strata/exterior/deep_jungle/platform_east
	name = "丛林深处 - 平台以东"
	icon_state = "ug_jung_0"
	unoviable_timer = FALSE
	ceiling = CEILING_NONE

/area/strata/exterior/deep_jungle/hot_springs
	icon_state = "ug_jung_4"
	name = "丛林深处 - 温泉"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/strata/exterior/deep_jungle/old_tunnels
	icon_state = "ug_jung_mine_1"
	name = "丛林深处 - 旧路 - 机密研究站以西"
	minimap_color = MINIMAP_AREA_JUNGLE
	ceiling = CEILING_NONE

/area/strata/exterior/deep_jungle/north
	icon_state = "ug_jung_6"
	name = "丛林深处 - 机密研究站以南"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/strata/exterior/deep_jungle/west
	icon_state = "ug_jung_6"
	name = "丛林深处 - 行星核心监测站以西"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/strata/exterior/deep_jungle/south
	icon_state = "ug_jung_7"
	name = "丛林深处 - 行星核心监测站以南"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/strata/exterior/deep_jungle/east
	icon_state = "ug_jung_8"
	name = "丛林深处 - 行星核心监测站以东"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/strata/exterior/deep_jungle/planet_core_research_station_exterior
	icon_state = "ug_jung_8"
	name = "丛林深处 - 行星核心监测研究站"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/strata/exterior/deep_jungle/ruin
	icon_state = "ug_jung_mine_4"
	name = "丛林深处 - 古老宿舍"
	unoviable_timer = FALSE
	weather_enabled = FALSE

/area/strata/exterior/deep_jungle/tearlake
	name = "丛林深处 - 哭泣之池"
	icon_state = "ug_jung_3"
	unoviable_timer = FALSE

// Deep Jungle Structure

/area/strata/interior/planet_core_research_station
	icon_state = "ug_jung_5"
	name = "丛林深处 - 行星核心监测研究站"
	minimap_color = MINIMAP_AREA_CAVES_STRUCTURE
	unoviable_timer = FALSE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	ceiling_muffle = FALSE

/area/strata/interior/research
	icon_state = "ug_jung_2"
	name = "丛林深处 - 机密研究站"
	minimap_color = MINIMAP_AREA_RESEARCH
	unoviable_timer = FALSE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	ceiling_muffle = FALSE

//-Others

/area/strata/exterior/restricted
	name = "超级机密致谢室"
	icon_state = "marshwater"
	requires_power = FALSE
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW|AREA_UNWEEDABLE

// CLF Insert

/area/strata/interior/checkpoints/clf
	name = "极北装甲检查站"

/area/strata/interior/outpost/clf_dorms
	name = "极北宿舍区"

/area/strata/interior/outpost/clf_office
	name = "极北办公室"
