
//Areas for the Kutjevo Refinery

/area/kutjevo
	name = "库特耶沃精炼厂"
	icon = 'icons/turf/area_kutjevo.dmi'
	//ambience = list('figuresomethingout.ogg')
	icon_state = "kutjevo"
	can_build_special = TRUE //T-Comms structure
	powernet_name = "ground"
	temperature = 308.7 //kelvin, 35c, 95f
	minimap_color = MINIMAP_AREA_ENGI

/area/shuttle/drop1/kutjevo
	name = "库特耶沃 - 运输机'阿拉莫'着陆区"
	icon_state = "shuttle"
	icon = 'icons/turf/area_kutjevo.dmi'
	linked_lz = DROPSHIP_LZ1

/area/shuttle/drop2/kutjevo
	name = "库特耶沃 - 运输机'诺曼底'着陆区"
	icon_state = "shuttle2"
	icon = 'icons/turf/area_kutjevo.dmi'
	linked_lz = DROPSHIP_LZ2

/area/kutjevo/exterior
	name = "库特耶沃 - 外部"
	ceiling = CEILING_NONE
	icon_state = "ext"


/area/kutjevo/interior
	name = "库特耶沃 - 内部"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	icon_state = "int"
	requires_power = 1

/area/kutjevo/interior/oob
	name = "库特耶沃 - 界外区域"
	ceiling = CEILING_MAX
	icon_state = "oob"
	requires_power = FALSE
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW|AREA_UNWEEDABLE

/area/kutjevo/interior/oob/dev_room
	name = "库特耶沃 - 积分室"
	icon_state = "kutjevo"

//exterior map areas

/area/kutjevo/exterior/lz_pad
	name = "库特耶沃辅助着陆区"
	icon_state = "lz_pad"
	weather_enabled = FALSE
	unlimited_power = 1 //ds computer
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ2

/area/kutjevo/exterior/lz_dunes
	name = "库特耶沃 - 着陆区沙丘"
	icon_state = "lz_dunes"
	weather_enabled =  FALSE
	unlimited_power = 1 //DS Computer
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/kutjevo/exterior/lz_river
	name = "库特耶沃 - 发电站河流"
	icon_state = "lz_river"
	linked_lz = DROPSHIP_LZ1

/area/kutjevo/exterior/spring
	name = "库特耶沃 - 南部泉眼"
	icon_state = "lz_river"
	unoviable_timer = FALSE

/area/kutjevo/exterior/scrubland
	name = "库特耶沃 - 北部灌木地"
	icon_state = "scrubland"
	linked_lz = DROPSHIP_LZ2

/area/kutjevo/exterior/scrubland/south
	name = "库特耶沃 - 南部灌木地"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/kutjevo/exterior/stonyfields
	name = "库特耶沃 - 石质原野"
	icon_state = "stone_fields"
	linked_lz = DROPSHIP_LZ1

/area/kutjevo/exterior/Northwest_Colony
	name = "库特耶沃 - 西北殖民地场地"
	icon_state = "rf_dunes"
	linked_lz = DROPSHIP_LZ2

/area/kutjevo/exterior/runoff_dunes
	name = "库特耶沃 - 径流沙丘"
	icon_state = "rf_dunes"
	linked_lz = DROPSHIP_LZ1

/area/kutjevo/exterior/runoff_river
	name = "库特耶沃 - 径流河"
	icon_state = "rf_river"

/area/kutjevo/exterior/runoff_bridge
	name = "库特耶沃 - 径流桥"
	icon_state = "rf_bridge"

/area/kutjevo/exterior/overlook
	name = "库特耶沃 - 径流河俯瞰点"
	icon_state = "rf_overlook"

/area/kutjevo/exterior/botany_bay_ext
	name = "库特耶沃 - 太空杂草农场外部"
	icon_state = "weed_ext"

/area/kutjevo/exterior/construction
	name = "库特耶沃 - 废弃建筑工地"
	icon_state = "construction"
	unoviable_timer = FALSE

/area/kutjevo/exterior/complex_border
	name = "库特耶沃综合设施 - 外部"
	icon_state = "kutjevo"

/area/kutjevo/exterior/complex_border/botany_medical_cave
	name = "库特耶沃综合设施 - 植物学 - 医疗洞穴"
	icon_state = "med_ext"

/area/kutjevo/exterior/complex_border/med_park
	name = "库特耶沃综合区 - 医疗园区"
	icon_state = "med_ext"

/area/kutjevo/exterior/complex_border/med_rec
	name = "库特耶沃综合区 - 水罐洞穴"
	icon_state = "construction2"

//telecomms areas
/area/kutjevo/exterior/telecomm
	name = "库特耶沃 - 通讯中继站"
	icon_state = "ass_line"
	ceiling_muffle = FALSE
	base_muffle = MUFFLE_LOW

/area/kutjevo/exterior/telecomm/lz1_north
	name = "库特耶沃 - 北部LZ1通讯中继站"
	linked_lz = DROPSHIP_LZ1

/area/kutjevo/exterior/telecomm/lz1_south
	name = "库特耶沃 - 南部LZ1通讯中继站"
	linked_lz = DROPSHIP_LZ1

/area/kutjevo/exterior/telecomm/lz2_north
	name = "库特耶沃 - 北部LZ2通讯中继站"
	linked_lz = DROPSHIP_LZ2

/area/kutjevo/exterior/telecomm/lz2_south
	name = "库特耶沃 - 南部LZ2通讯中继站"
	linked_lz = DROPSHIP_LZ2

//interior areas + caves

//Primary Colony Buildings
/area/kutjevo/interior/complex
	name = "库特耶沃综合区"
	ceiling = CEILING_METAL
	icon_state = "kutjevo"

/area/kutjevo/interior/complex/botany
	name = "库特耶沃综合区 - 植物湾"
	icon_state = "botany0"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/kutjevo/interior/complex/botany/east
	name = "库特耶沃综合区 - 植物湾东厅"
	icon_state = "botany1"

/area/kutjevo/interior/complex/botany/east_tech
	name = "库特耶沃综合区 - 发电厂通道"
	icon_state = "botany1"

/area/kutjevo/interior/complex/botany/locks
	name = "库特耶沃综合区 - 植物湾风暴隔离舱"
	icon_state = "botany0"

/area/kutjevo/interior/complex/med
	name = "库特耶沃综合区 - 医疗大厅"
	icon_state = "med0"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/kutjevo/interior/complex/med/auto_doc
	name = "库特耶沃综合区 - 医疗自动诊疗走廊"
	icon_state = "med2"

/area/kutjevo/interior/complex/med/operating
	name = "库特耶沃综合区 - 医疗手术走廊"
	icon_state = "med3"

/area/kutjevo/interior/complex/med/triage
	name = "库特耶沃综合区 - 医疗分诊走廊"
	icon_state = "med4"

/area/kutjevo/interior/complex/med/cells
	name = "库特耶沃综合区 - 医疗冷冻舱室"
	icon_state = "med5"

/area/kutjevo/interior/complex/med/pano
	name = "库特耶沃综合区 - 医疗全景监控室"
	icon_state = "med3"

/area/kutjevo/interior/complex/med/locks
	name = "库特耶沃综合区 - 医疗风暴隔离舱"
	icon_state = "med1"

/area/kutjevo/interior/complex/Northwest_Dorms
	name = "库特耶沃综合区 - 西北部殖民地宿舍"
	icon_state = "Colony_int"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2
	is_landing_zone = TRUE

/area/kutjevo/interior/complex/Northwest_Flight_Control
	name =  "库特耶沃综合区 - 西北部飞行控制室"
	icon_state = "Colony_int"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2
	is_landing_zone = TRUE

/area/kutjevo/interior/complex/Northwest_Security_Checkpoint
	name = "库特耶沃综合区 - 西北部安全检查站"
	icon_state = "Colony_int"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2
	minimap_color = MINIMAP_AREA_SEC
	is_landing_zone = TRUE

//Out buildings + foremans
/area/kutjevo/interior/power
	name = "库特耶沃 - 水力发电大坝变电站"
	ceiling = CEILING_METAL
	icon_state = "power"
	minimap_color = MINIMAP_AREA_ENGI
	linked_lz = DROPSHIP_LZ1

/area/kutjevo/interior/power/comms
	name = "库特耶沃 - 水力发电大坝通讯中继站"
	ceiling = CEILING_METAL
	icon_state = "power"

/area/kutjevo/interior/construction
	name = "库特耶沃 - 废弃建筑内部"
	ceiling = CEILING_METAL
	icon_state = "construction_int"
	unoviable_timer = FALSE

/area/kutjevo/interior/construction/north
	name = "库特耶沃 - 北部废弃建筑内部"
	icon_state = "construction"

/area/kutjevo/interior/construction/east
	name = "库特耶沃 - 东部废弃建筑内部"
	icon_state = "construction"

/area/kutjevo/interior/construction/signal_tower
	name = "库特耶沃 - 废弃信号塔"
	icon_state = "construction2"

/area/kutjevo/interior/foremans_office
	name = "库特耶沃 - 工头办公室"
	ceiling = CEILING_METAL
	icon_state = "foremans"
	unoviable_timer = FALSE

/area/kutjevo/interior/botany_bay_int
	name = "库特耶沃 - 太空杂草农场内部"
	ceiling = CEILING_METAL
	icon_state = "weed_int"

/area/kutjevo/interior/power_pt2_electric_boogaloo
	name = "库特耶沃 - 发电厂"
	ceiling = CEILING_METAL
	icon_state = "power_2"

/area/kutjevo/interior/colony
	name = "库特耶沃 - 殖民地建筑内部"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS
	icon_state = "colony_int"

/area/kutjevo/interior/colony_central
	name = "库特耶沃 - 中央殖民地洞穴"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	icon_state = "colony_caves_0"
	minimap_color = MINIMAP_AREA_CAVES
	unoviable_timer = FALSE

/area/kutjevo/interior/colony_central/mine_elevator
	name = "库特耶沃 - 中央殖民地电梯"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	icon_state = "colony_caves_0"
	unoviable_timer = FALSE

/area/kutjevo/interior/colony_north
	name = "库特耶沃 - 北部殖民地洞穴"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "colony_caves_1"
	unoviable_timer = FALSE

/area/kutjevo/interior/colony_southeast
	name = "库特耶沃 - 东南部殖民地洞穴"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "colony_caves_2"
	unoviable_timer = FALSE

/area/kutjevo/interior/colony_northeast
	name = "库特耶沃 - 东北部殖民地洞穴"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "colony_caves_2"
	unoviable_timer = FALSE

/area/kutjevo/interior/colony_south
	name = "库特耶沃 - 南部殖民地洞穴"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "colony_caves_3"

/area/kutjevo/interior/colony_south/power2
	name = "库特耶沃 - 南部殖民地处理厂 - 北区"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "colony_caves_3"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	unoviable_timer = FALSE

/area/kutjevo/interior/colony_south/power2/south
	name = "库特耶沃 - 南部殖民地处理厂 - 南区"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "colony_caves_3"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	unoviable_timer = FALSE

//CLF insert areas
/area/kutjevo/interior/colony/landing_zone_checkpoint
	name = "库特耶沃 - 着陆区检查站"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS
	icon_state = "colony_int"

/area/kutjevo/interior/colony/clf_shuttle
	name = "库特耶沃 - 未注册货船"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS
	icon_state = "colony_int"

/area/kutjevo/exterior/clf_lz
	name = "库特耶沃 - 第三着陆区"
	ceiling = CEILING_NONE
	icon_state = "ext"
