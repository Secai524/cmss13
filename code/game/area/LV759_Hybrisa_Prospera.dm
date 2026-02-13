//lv759 AREAS--------------------------------------//

/area/lv759
	name = "LV-759 希布里萨繁荣地"
	icon = 'icons/turf/hybrisareas.dmi'
	icon_state = "hybrisa"
	can_build_special = TRUE
	powernet_name = "ground"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

//parent types

/area/lv759/indoors
	name = "希布里萨 - 室内"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR

/area/lv759/outdoors
	name = "希布里萨 - 室外"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV759_OUTDOORS
	ambience_exterior = AMBIENCE_CITY
	soundscape_interval = 25

/area/lv759/oob
	name = "禁区"
	icon_state = "oob"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB
	requires_power = FALSE

/area/lv759/bunker
	name = "禁区"
	icon_state = "oob"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB

/area/lv759/bunker/gonzo
	name = "冈佐的藏身处"
	icon_state = "cliff_blocked"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR
	requires_power = FALSE

/area/lv759/bunker/checkpoint
	name = "检查站与隐藏掩体 - 入口"
	icon_state = "cliff_blocked"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR

// Landing Zone 1

/area/lv759/outdoors/landing_zone_1
	name = "诺瓦医疗医院综合体 - 应急响应 - 一号着陆区"
	icon_state = "medical_lz1"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/landing_zone_1/flight_control_room
	name = "诺瓦医疗医院综合体 - 应急响应 - 一号着陆区 - 飞行控制室"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/landing_zone_1/lz1_console
	name = "诺瓦医疗医院综合体 - 应急响应 - 一号着陆区 - 阿拉莫运输机控制台"
	icon_state = "hybrisa"
	requires_power = FALSE
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

// Landing Zone 2

/area/lv759/outdoors/landing_zone_2
	name = "KMCC星际货运枢纽 - 二号着陆区"
	icon_state = "mining_lz2"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_flight_control_room
	name = "KMCC星际货运枢纽 - 飞行控制室"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_security
	name = "KMCC星际货运枢纽 - 安全检查站办公室"
	icon_state = "security_checkpoint"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_lounge_north
	name = "KMCC星际货运枢纽 - 乘客出发区 - 北休息室"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_fuel
	name = "KMCC星际货运枢纽 - 燃料储存与维护区 - 北部"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_lounge_south
	name = "KMCC星际货运枢纽 - 乘客出发区 - 南休息室"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_lounge_hallway
	name = "KMCC星际货运枢纽 - 乘客出发区 - 走廊"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_south_office
	name = "KMCC星际货运枢纽 - 乘客出发区 - 南办公室"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_maintenance
	name = "KMCC星际货运枢纽 - 乘客出发区 - 维护区"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub/lz2_console
	name = "KMCC星际货运枢纽 - 诺曼底号运输机控制台"
	icon_state = "hybrisa"
	requires_power = FALSE
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_cargo
	name = "KMCC星际货运枢纽 - 货物处理中心"
	icon_state = "mining_cargo"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/landing_zone_2/kmcc_hub_maintenance_north
	name = "KMCC星际货运枢纽 - 货物处理中心 - 维护区"
	icon_state = "mining"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ2

/area/lv759/outdoors/landing_zone_2/kmcc_hub_cargo_entrance_south
	name = "KMCC星际货运枢纽 - 货物处理中心 - 主入口及南侧卸货平台"
	icon_state = "mining"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY
	linked_lz = DROPSHIP_LZ2

// Derelict Ship

/area/lv759/indoors/derelict_ship
	name = "废弃飞船"
	icon_state = "derelictship"
	ceiling = CEILING_REINFORCED_METAL
	flags_area = AREA_NOBURROW
	ambience_exterior = AMBIENCE_DERELICT
	soundscape_playlist = SCAPE_PL_LV759_DERELICTSHIP
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = FALSE

// Caves

/area/lv759/indoors/caves
	name = "洞穴"
	icon_state = "caves_plateau"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES_ALARM
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = FALSE

/area/lv759/indoors/caves/wy_research_complex_entrance
	name = "维兰德-汤谷 - 先进生物基因组研究设施 - 北主入口"
	icon_state = "wylab"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES_ALARM
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = FALSE

/area/lv759/indoors/caves/west_caves
	name = "洞穴 - 西区"
	icon_state = "caves_west"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = 25 MINUTES
	always_unpowered = TRUE

/area/lv759/indoors/caves/electric_fence1
	name = "电网 - 西侧洞穴"
	icon_state = "power0"

/area/lv759/indoors/caves/electric_fence2
	name = "电网 - 东侧洞穴"
	icon_state = "power0"

/area/lv759/indoors/caves/electric_fence3
	name = "电网 - 中央洞穴"
	icon_state = "power0"

/area/lv759/indoors/caves/electric_fence2
	name = "电网 - 东侧洞穴"
	icon_state = "power0"

/area/lv759/indoors/caves/comms_tower
	name = "通讯塔 - 中央洞穴"
	icon_state = "power0"

/area/lv759/indoors/caves/sensory_tower
	name = "感应塔 - 高原洞穴"
	icon_state = "power0"

/area/lv759/indoors/caves/west_caves_alarm
	name = "洞穴 - 西区"
	icon_state = "caves_west"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES_ALARM
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES

/area/lv759/indoors/caves/east_caves
	name = "洞穴 - 东区"
	icon_state = "caves_east"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	always_unpowered = TRUE

/area/lv759/indoors/caves/east_caves/north
	name = "洞穴 - 东区"
	icon_state = "caves_east"
	unoviable_timer = FALSE

/area/lv759/indoors/caves/south_caves
	name = "洞穴 - 南区"
	icon_state = "caves_south"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	always_unpowered = TRUE

/area/lv759/indoors/caves/south_caves/derelict_ship
	name = "洞穴 - 南区"
	icon_state = "caves_south"
	unoviable_timer = FALSE
	always_unpowered = TRUE

/area/lv759/indoors/caves/south_east_caves
	name = "洞穴 - 东南区"
	icon_state = "caves_southeast"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	always_unpowered = TRUE

/area/lv759/indoors/caves/south_west_caves
	name = "洞穴 - 西南区"
	icon_state = "caves_southwest"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	always_unpowered = TRUE

/area/lv759/indoors/caves/south_west_caves_alarm
	name = "洞穴 - 西南区"
	icon_state = "wylab"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES_ALARM
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISARESEARCH

/area/lv759/indoors/caves/north_west_caves
	name = "洞穴 - 西北区"
	icon_state = "caves_northwest"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = 25 MINUTES

/area/lv759/outdoors/caves/north_west_caves_outdoors
	name = "洞穴 - 西北区"
	icon_state = "caves_northwest"
	ceiling = CEILING_NONE
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = 25 MINUTES

/area/lv759/indoors/caves/north_east_caves
	name = "洞穴 - 东北区"
	icon_state = "caves_northeast"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	linked_lz = DROPSHIP_LZ1
	always_unpowered = TRUE

/area/lv759/indoors/caves/north_east_caves/south
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/lv759/indoors/caves/north_caves
	name = "洞穴 - 北区"
	icon_state = "caves_north"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	always_unpowered = TRUE

/area/lv759/indoors/caves/north_caves/east
	linked_lz = DROPSHIP_LZ1
	always_unpowered = TRUE

/area/lv759/indoors/caves/central_caves
	name = "洞穴 - 中央区"
	icon_state = "caves_central"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = FALSE
	always_unpowered = TRUE

/area/lv759/indoors/caves/central_caves_north
	name = "洞穴 - 中央区"
	icon_state = "caves_central"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	always_unpowered = TRUE

/area/lv759/indoors/caves/north_east_caves_comms
	name = "KMCC - 采矿前哨站 - 东区 - 子空间通讯"
	icon_state = "comms_1"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COMMS
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/lv759/indoors/caves/north_east_caves_comms_2
	name = "NMHC - 应急响应 - 一号着陆区 - 洞穴 - 东北区 - 子空间通讯"
	icon_state = "comms_1"
	minimap_color = MINIMAP_AREA_COMMS
	linked_lz = DROPSHIP_LZ1

// Caves Central Plateau

/area/lv759/outdoors/caveplateau
	name = "洞穴 - 高原区"
	icon_state = "caves_plateau"
	ceiling = CEILING_NONE
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_PLATEAU_OUTDOORS
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = FALSE
	always_unpowered = TRUE

// Colony Streets

/area/lv759/outdoors/colony_streets
	name = "殖民地街道"
	icon_state = "colonystreets_north"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY_STREETS

/area/lv759/outdoors/colony_streets/central_streets
	name = "中央街道 - 西段"
	icon_state = "colonystreets_west"

/area/lv759/outdoors/colony_streets/east_central_street
	name = "中央街道 - 东段"
	icon_state = "colonystreets_east"
	linked_lz = DROPSHIP_LZ1

/area/lv759/outdoors/colony_streets/east_central_street_left
	name = "中央街道 - 东段"
	icon_state = "colonystreets_east"

/area/lv759/outdoors/colony_streets/south_street
	name = "殖民地街道 - 南区"
	icon_state = "colonystreets_south"

/area/lv759/outdoors/colony_streets/south_east_street
	name = "殖民地街道 - 东南区"
	icon_state = "colonystreets_southeast"
	linked_lz = DROPSHIP_LZ2

/area/lv759/outdoors/colony_streets/south_west_street
	name = "殖民地街道 - 西南 - 维兰德检查点通道"
	icon_state = "colonystreets_southwest"
	ceiling = CEILING_NONE
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES

/area/lv759/outdoors/colony_streets/south_east_street_comms
	name = "殖民地街道 - 东南 - 子空间通讯站"
	icon_state = "comms_1"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COMMS
	linked_lz = DROPSHIP_LZ2

/area/lv759/outdoors/colony_streets/north_west_street
	name = "殖民地街道 - 西北区"
	icon_state = "colonystreets_northwest"

/area/lv759/outdoors/colony_streets/north_east_street
	name = "殖民地街道 - 东北区"
	icon_state = "colonystreets_northeast"
	linked_lz = DROPSHIP_LZ1

/area/lv759/outdoors/colony_streets/north_east_street_LZ
	name = "殖民地街道 - 东北区"
	icon_state = "colonystreets_northeast"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv759/outdoors/colony_streets/north_street
	name = "殖民地街道 - 北区"
	icon_state = "colonystreets_north"

//Spaceport Indoors

/area/lv759/indoors/spaceport
	minimap_color = MINIMAP_AREA_COLONY_SPACE_PORT
	unoviable_timer = FALSE

/area/lv759/indoors/spaceport/hallway_northeast
	name = "维兰德-汤谷天界之门太空港 - 走廊 - 东北"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/hallway_north
	name = "维兰德-汤谷天界之门太空港 - 走廊 - 北"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/hallway_northwest
	name = "维兰德-汤谷天界之门太空港 - 走廊 - 西北"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/hallway_east
	name = "维兰德-汤谷天界之门太空港 - 走廊 - 东"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/heavyequip
	name = "维兰德-汤谷天界之门太空港 - 重型设备仓库"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/engineering
	name = "维兰德-汤谷天界之门太空港 - 燃料储存与处理"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/janitor
	name = "维兰德-汤谷天界之门太空港 - 清洁工具储藏室"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/maintenance_east
	name = "维兰德-汤谷天界之门太空港 - 维护区 - 东"
	icon_state = "WYSpaceport"

/area/lv759/indoors/spaceport/communications_office
	name = "维兰德-汤谷天界之门太空港 - 通讯与行政办公室"
	icon_state = "WYSpaceportadmin"

/area/lv759/indoors/spaceport/flight_control_room
	name = "维兰德-汤谷天界之门太空港 - 飞行控制室"
	icon_state = "WYSpaceportadmin"

/area/lv759/indoors/spaceport/security
	name = "维兰德-汤谷天界之门太空港 - 安保观察室与办公室"
	icon_state = "security_checkpoint"

/area/lv759/indoors/spaceport/security_office
	name = "维兰德-汤谷天界之门太空港 - 办公室"
	icon_state = "security_checkpoint"

/area/lv759/indoors/spaceport/cargo
	name = "维兰德-汤谷天界之门太空港 - 货舱"
	icon_state = "WYSpaceportcargo"

/area/lv759/indoors/spaceport/cargo_maintenance
	name = "维兰德-汤谷天界之门太空港 - 货舱维护区"
	icon_state = "WYSpaceportcargo"

/area/lv759/indoors/spaceport/baggagehandling
	name = "维兰德-汤谷天界之门太空港 - 行李储存与处理区"
	icon_state = "WYSpaceportbaggage"

/area/lv759/indoors/spaceport/cuppajoes
	name = "维兰德-汤谷天界之门太空港 - 乔氏咖啡"
	icon_state = "cuppajoes"

/area/lv759/indoors/spaceport/kitchen
	name = "维兰德-汤谷天界之门太空港 - 厨房"
	icon_state = "WYSpaceportblue"

/area/lv759/indoors/spaceport/docking_bay_2
	name = "维兰德-汤谷天界之门太空港 - 2号对接舱 - 燃料补给与维护"
	icon_state = "WYSpaceportblue"

/area/lv759/indoors/spaceport/docking_bay_1
	name = "维兰德-汤谷天界之门太空港 - 1号对接舱"
	icon_state = "WYSpaceport"

// Ships

/area/lv759/indoors/spaceport/starglider
	name = "WY-LWI 星梭 SG-200"
	icon_state = "wydropship"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

/area/lv759/indoors/spaceport/horizon_runner
	name = "WY-LWI 地平线奔跑者 HR-150"
	icon_state = "wydropship"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

/area/lv759/indoors/spaceport/clf_dropship
	name = "UD-9M '犬牙'"
	icon_state = "wydropship"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

// Garage

/area/lv759/indoors/garage_reception
	name = "车库 - 接待处"
	icon_state = "garage"

/area/lv759/indoors/garage_workshop
	name = "车库 - 车间"
	icon_state = "garage"

/area/lv759/indoors/garage_workshop_storage
	name = "车库 - 车间 - 储藏室"
	icon_state = "garage"

/area/lv759/indoors/garage_managersoffice
	name = "车库 - 经理办公室"
	icon_state = "garage"

/area/lv759/indoors/garage_restroom
	name = "车库 - 洗手间"
	icon_state = "garage"

// Meridian Offices & Factory Floor

/area/lv759/indoors/meridian/meridian_foyer
	name = "子午线 - 门厅"
	icon_state = "meridian"

/area/lv759/indoors/meridian/meridian_showroom
	name = "子午线 - 展厅"
	icon_state = "meridian"

/area/lv759/indoors/meridian/meridian_office
	name = "子午线 - 办公室"
	icon_state = "meridian"

/area/lv759/indoors/meridian/meridian_managersoffice
	name = "子午线 - 经理办公室"
	icon_state = "meridian"

/area/lv759/indoors/meridian/meridian_factory
	name = "子午线 - 工厂车间"
	icon_state = "meridian_factory"

/area/lv759/indoors/meridian/meridian_restroom
	name = "子午线 - 洗手间"
	icon_state = "meridian"

/area/lv759/indoors/meridian/meridian_maintenance
	name = "子午线 - 维护区"
	icon_state = "meridian"

/area/lv759/indoors/meridian/meridian_maintenance_east
	name = "子午线 - 工厂车间 - 维护区"
	icon_state = "meridian"

// Apartments (Dorms)

/area/lv759/indoors/apartment
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

/area/lv759/indoors/apartment/westfoyer
	name = "西港公寓楼 - 西侧 - 门厅"
	icon_state = "apartments"

/area/lv759/indoors/apartment/westhallway
	name = "西港公寓楼 - 西侧 - 走廊"
	icon_state = "apartments"

/area/lv759/indoors/apartment/westbedrooms
	name = "西港公寓楼 - 西侧 - 公寓"
	icon_state = "apartments"

/area/lv759/indoors/apartment/westshowers
	name = "西港公寓楼 - 西侧 - 淋浴间"
	icon_state = "apartments"

/area/lv759/indoors/apartment/westrestroom
	name = "西港公寓楼 - 西侧 - 洗手间"
	icon_state = "apartments"

/area/lv759/indoors/apartment/westentertainment
	name = "西港公寓楼 - 西侧 - 娱乐中心"
	icon_state = "apartments"

/area/lv759/indoors/apartment/eastentrance
	name = "西港公寓楼 - 东侧 - 入口房间"
	icon_state = "apartments"

/area/lv759/indoors/apartment/eastfoyer
	name = "西港公寓楼 - 东侧 - 门厅"
	icon_state = "apartments"

/area/lv759/indoors/apartment/eastrestroomsshower
	name = "西港公寓楼 - 东侧 - 洗手间与淋浴间"
	icon_state = "apartments"

/area/lv759/indoors/apartment/eastbedrooms
	name = "西港公寓楼 - 东侧 - 卧室"
	icon_state = "apartments"

/area/lv759/indoors/apartment/eastbedroomsstorage
	name = "西港公寓楼 - 东侧 - 卧室 - 储藏室"
	icon_state = "apartments"

/area/lv759/indoors/apartment/northfoyer
	name = "西港公寓楼 - 北侧 - 门厅"
	icon_state = "apartments"

/area/lv759/indoors/apartment/northhallway
	name = "西港公寓楼 - 北侧 - 走廊"
	icon_state = "apartments"

/area/lv759/indoors/apartment/northapartments
	name = "西港公寓楼 - 北区 - 公寓"
	icon_state = "apartments"

// Weyland-Yutani Offices

/area/lv759/indoors/weyyu_office
	name = "维兰德-汤谷办公室 - 接待走廊"
	icon_state = "wyoffice"
	minimap_color = MINIMAP_AREA_COMMAND

/area/lv759/indoors/weyyu_office/hallway
	name = "维兰德-汤谷办公室 - 西侧门厅"
	icon_state = "wyoffice"

/area/lv759/indoors/weyyu_office/floor
	name = "维兰德-汤谷办公室 - 主办公楼层"

/area/lv759/indoors/weyyu_office/breakroom
	name = "维兰德-汤谷办公室 - 休息室"

/area/lv759/indoors/weyyu_office/vip
	name = "维兰德-汤谷办公室 - 会议室"

/area/lv759/indoors/weyyu_office/pressroom
	name = "维兰德-汤谷办公室 - 大会堂"

/area/lv759/indoors/weyyu_office/supervisor
	name = "维兰德-汤谷办公室 - 殖民地主管办公室"

// Weyland-Yutani Offices

/area/lv759/indoors/twe_souter_outpost
	name = "IASF哨站索特 - 入口"
	icon_state = "security_hub"
	minimap_color = MINIMAP_AREA_COMMAND

/area/lv759/indoors/twe_souter_outpost/reception
	name = "IASF哨站索特 - 接待办公室"

/area/lv759/indoors/twe_souter_outpost/hallway
	name = "IASF哨站索特 - 主厅"

/area/lv759/indoors/twe_souter_outpost/dorm
	name = "IASF哨站索特 - 宿舍"

/area/lv759/indoors/twe_souter_outpost/maint
	name = "IASF哨站索特 - 飞行维护室"

/area/lv759/indoors/twe_souter_outpost/hangar
	name = "IASF哨站索特 - 机库"

/area/lv759/indoors/twe_souter_outpost/flight
	name = "IASF哨站索特 - 飞行控制室"

/area/lv759/indoors/twe_souter_outpost/armoury
	name = "IASF哨站索特 - 军械库"
// Using 'armoury' is correct here since its for a base controlled by future British people, not Americans

/area/lv759/indoors/twe_souter_outpost/twe_gunship
	name = "TWE UD4-UK运输机"
	icon_state = "wydropship"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

// Bar & Entertainment Complex

/area/lv759/indoors/bar
	name = "酒吧"
	icon_state = "bar"

/area/lv759/indoors/bar/entertainment
	name = "酒吧 - 娱乐分区"

/area/lv759/indoors/bar/bathroom
	name = "酒吧 - 洗手间"

/area/lv759/indoors/bar/maintenance
	name = "酒吧 - 维护区"

/area/lv759/indoors/bar/kitchen
	name = "酒吧 - 厨房"

//Botany

/area/lv759/indoors/botany/botany_greenhouse
	name = "植物学 - 温室"
	icon_state = "botany"

/area/lv759/indoors/botany/botany_hallway
	name = "植物学 - 走廊"
	icon_state = "botany"

/area/lv759/indoors/botany/botany_maintenance
	name = "植物学 - 维护区"
	icon_state = "botany"

/area/lv759/indoors/botany/botany_mainroom
	name = "植物学 - 主房间"
	icon_state = "botany"

// Hotel

/area/lv759/indoors/hotel
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

/area/lv759/indoors/hotel/hotel_hallway
	name = "普罗斯佩拉大酒店 - 走廊"
	icon_state = "apartments"

/area/lv759/indoors/hotel/hotel_rooms
	name = "普罗斯佩拉大酒店 - 房间"
	icon_state = "apartments"

// Hosptial

/area/lv759/indoors/hospital
	icon_state = "medical"
	minimap_color = MINIMAP_AREA_MEDBAY
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/hospital/paramedics_garage
	name = "新星医疗中心 - 急救车库"

/area/lv759/indoors/hospital/cryo_room
	name = "新星医疗中心 - 冷冻病房"

/area/lv759/indoors/hospital/emergency_room
	name = "新星医疗中心 - 急诊室"

/area/lv759/indoors/hospital/reception
	name = "新星医疗中心 - 接待处"

/area/lv759/indoors/hospital/cmo_office
	name = "新星医疗中心 - 首席医疗官办公室"

/area/lv759/indoors/hospital/maintenance
	name = "新星医疗中心 - 子空间通讯与电力系统"
	icon_state = "comms_1"
	minimap_color = MINIMAP_AREA_COMMS

/area/lv759/indoors/hospital/break_room
	name = "新星医疗中心 - 休息室"

/area/lv759/indoors/hospital/pharmacy
	name = "新星医疗中心 - 药房与外送大厅"

/area/lv759/indoors/hospital/outgoing
	name = "新星医疗中心 - 外送病房"

/area/lv759/indoors/hospital/central_hallway
	name = "新星医疗中心 - 中央走廊"

/area/lv759/indoors/hospital/east_hallway
	name = "新星医疗中心 - 东侧走廊"

/area/lv759/indoors/hospital/medical_storage
	name = "新星医疗中心 - 医疗物资储藏室"

/area/lv759/indoors/hospital/operation
	name = "新星医疗中心 - 手术室与观察区"

/area/lv759/indoors/hospital/patient_ward
	name = "新星医疗中心 - 普通病房"

/area/lv759/indoors/hospital/virology
	name = "新星医疗中心 - 病毒学实验室"

/area/lv759/indoors/hospital/morgue
	name = "新星医疗中心 - 停尸房"

/area/lv759/indoors/hospital/icu
	name = "新星医疗中心 - 重症监护病房"

/area/lv759/indoors/hospital/storage
	name = "新星医疗中心 - 办公室"

/area/lv759/indoors/hospital/maintenance_north
	name = "新星医疗中心 - 北侧维护区"

/area/lv759/indoors/hospital/maintenance_south
	name = "新星医疗中心 - 无性别洗手间"

/area/lv759/indoors/hospital/janitor
	name = "新星医疗中心 - 清洁工具间"

// Mining

/area/lv759/indoors/mining_outpost
	icon_state = "mining"
	minimap_color = MINIMAP_AREA_MINING

/area/lv759/indoors/mining_outpost/north
	name = "KMCC - 采矿前哨站 - 北区"
	icon_state = "mining"

/area/lv759/indoors/mining_outpost/north_maint
	name = "KMCC - 采矿前哨站 - 北区 - 维护区"
	icon_state = "mining"

/area/lv759/indoors/mining_outpost/northeast
	name = "KMCC - 采矿前哨 - 东北区"
	icon_state = "mining"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/mining_outpost/south
	name = "KMCC - 采矿前哨 - 东南区"
	icon_state = "mining"

/area/lv759/indoors/mining_outpost/vehicledeployment
	name = "KMCC - 采矿前哨 - 南区 - 载具部署区"
	icon_state = "mining"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/mining_outpost/processing
	name = "KMCC - 采矿前哨 - 南区 - 加工与储存区"
	icon_state = "mining"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/mining_outpost/east
	name = "KMCC - 采矿前哨 - 东区"
	icon_state = "mining"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/lv759/indoors/mining_outpost/east_dorms
	name = "KMCC - 采矿前哨 - 东区 - 宿舍"
	icon_state = "mining"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/mining_outpost/east_deploymentbay
	name = "KMCC - 采矿前哨 - 东区 - 部署舱"
	icon_state = "mining"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/mining_outpost/east_command
	name = "KMCC - 采矿前哨 - 东区 - 指挥中心"
	icon_state = "mining"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/mining_outpost/cargo_maint
	name = "KMCC - 采矿前哨 - 东区 - 维护区"
	icon_state = "mining"

/area/lv759/outdoors/mining_outpost/south_entrance
	name = "KMCC - 采矿前哨 - 南区 - 载具部署入口"
	icon_state = "mining"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY
	linked_lz = DROPSHIP_LZ2

// Electrical Substations

/area/lv759/indoors/electical_systems
	minimap_color = MINIMAP_AREA_COLONY_ENGINEERING

/area/lv759/indoors/electical_systems/substation1
	name = "电力系统 - 一号变电站 - 控制室"
	icon_state = "power0"

/area/lv759/indoors/electical_systems/substation2
	name = "电力系统 - 二号变电站"
	icon_state = "power0"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/electical_systems/substation3
	name = "电力系统 - 三号变电站"
	icon_state = "power0"
	linked_lz = DROPSHIP_LZ1

// Power-Plant (Engineering)

/area/lv759/indoors/power_plant
	name = "维兰德-汤谷动力网枢纽 - 中央走廊"
	icon_state = "power0"
	minimap_color = MINIMAP_AREA_COLONY_ENGINEERING

/area/lv759/indoors/power_plant/Hallway_East
	name = "维兰德-汤谷动力网枢纽 - 东侧走廊"
	icon_state = "power0"
	minimap_color = MINIMAP_AREA_COLONY_ENGINEERING
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/power_plant/south_hallway
	name = "维兰德-汤谷动力网枢纽 - 南侧走廊"

/area/lv759/indoors/power_plant/geothermal_generators
	name = "维兰德-汤谷动力网枢纽 - 地热发电机室"

/area/lv759/indoors/power_plant/power_storage
	name = "维兰德-汤谷动力网枢纽 - 电力储存室"

/area/lv759/outdoors/power_plant/transformers_north
	name = "维兰德-汤谷动力网枢纽 - 变压器 - 北区"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ1

/area/lv759/outdoors/power_plant/transformers_south
	name = "维兰德-汤谷动力网枢纽 - 变压器 - 南区"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/power_plant/transformers_north
	name = "维兰德-汤谷动力网枢纽 - 变压器 - 北区"

/area/lv759/indoors/power_plant/transformers_south
	name = "维兰德-汤谷动力网枢纽 - 变压器 - 南区"

/area/lv759/indoors/power_plant/gas_generators
	name = "维兰德-汤谷动力网枢纽 - 气体混合与储存室"

/area/lv759/indoors/power_plant/fusion_generators
	name = "维兰德-汤谷动力网枢纽 - 控制中心"

/area/lv759/indoors/power_plant/telecomms
	icon_state = "comms_1"
	name = "维兰德-汤谷动力网枢纽 - 电信室"
	minimap_color = MINIMAP_AREA_COMMS
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/power_plant/workers_canteen
	name = "维兰德-汤谷动力网枢纽 - 员工食堂"
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/power_plant/workers_canteen_kitchen
	name = "维兰德-汤谷动力网枢纽 - 员工食堂 - 厨房"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/power_plant/equipment_east
	name = "维兰德-汤谷动力网枢纽 - 装备储藏室 - 东侧"

/area/lv759/indoors/power_plant/equipment_west
	name = "维兰德-汤谷动力网枢纽 - 装备储藏室 - 西侧"

// Marshalls (NSPA)

/area/lv759/indoors/colonial_marshals
	name = "NSPA - 铁桥区警局"
	icon_state = "security_hub"
	minimap_color = MINIMAP_AREA_COLONY_MARSHALLS

/area/lv759/indoors/colonial_marshals/prisoners_cells
	name = "NSPA - 铁桥区警局 - 最高安全区 - 牢房"

/area/lv759/indoors/colonial_marshals/prisoners_foyer
	name = "NSPA - 铁桥区警局 - 最高安全区 - 前厅"

/area/lv759/indoors/colonial_marshals/prisoners_recreation_area
	name = "NSPA - 铁桥区警局 - 最高安全区 - 娱乐区与淋浴间"

/area/lv759/indoors/colonial_marshals/garage
	name = "NSPA - 铁桥区警局 - 车辆部署与维护区"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/armory_foyer
	name = "NSPA - 铁桥区警局 - 军械库前厅"

/area/lv759/indoors/colonial_marshals/armory
	name = "NSPA - 铁桥区警局 - 军械库"

/area/lv759/indoors/colonial_marshals/armory_firingrange
	name = "NSPA - 铁桥区警局 - 射击场"

/area/lv759/indoors/colonial_marshals/armory_evidenceroom
	name = "NSPA - 铁桥区警局 - 证物室"

/area/lv759/indoors/colonial_marshals/office
	name = "NSPA - 铁桥区警局 - 办公室"

/area/lv759/indoors/colonial_marshals/reception
	name = "NSPA - 铁桥区警局 - 接待办公室"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/hallway_central
	name = "NSPA - 铁桥区警局 - 中央走廊"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/hallway_south
	name = "NSPA - 铁桥区警局 - 南侧走廊"

/area/lv759/indoors/colonial_marshals/hallway_reception
	name = "NSPA - 铁桥区警局 - 接待走廊"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/hallway_north
	name = "NSPA - 铁桥区警局 - 北侧走廊"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/hallway_north_locker
	name = "NSPA - 铁桥区警局 - 北侧走廊 - 更衣室"

/area/lv759/indoors/colonial_marshals/holding_cells
	name = "NSPA - 铁桥区警局 - 拘留室"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/head_office
	name = "NSPA - 铁桥区警局 - 法证办公室"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/north_office
	name = "NSPA - 铁桥区警局 - 北侧办公室"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/wardens_office
	name = "NSPA - 铁桥区警局 - 典狱长办公室"

/area/lv759/indoors/colonial_marshals/interrogation
	name = "NSPA - 铁桥区警局 - 审讯室"

/area/lv759/indoors/colonial_marshals/press_room
	name = "NSPA - 铁桥区警局 - 法庭"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/changing_room
	name = "NSPA - 铁桥区警局 - 更衣室"

/area/lv759/indoors/colonial_marshals/restroom
	name = "NSPA - 铁桥区警局 - 洗手间与淋浴间"

/area/lv759/indoors/colonial_marshals/south_maintenance
	name = "NSPA - 铁桥区警局 - 维护区 - 南侧"
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/colonial_marshals/north_maintenance
	name = "NSPA - 铁桥区警局 - 维护区 - 北侧"

/area/lv759/indoors/colonial_marshals/southwest_maintenance
	name = "NSPA - 铁桥区警局 - 维护区 - 西南侧"


// Jack's Surplus

/area/lv759/indoors/jacks_surplus
	name = "杰克军用剩余物资店"
	icon_state = "jacks"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ2

//Weyland-Yutani - Resource Recovery Facility

/area/lv759/indoors/recycling_plant
	name = "维兰德-汤谷 - 资源回收设施"
	icon_state = "recycling"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/recycling_plant/garage
	name = "维兰德-汤谷 - 资源回收设施 - 车库"
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/recycling_plant/synthetic_storage
	name = "合成人存储区"
	icon_state = "synthetic"
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/recycling_plant_office
	name = "维兰德-汤谷 - 资源回收设施 - 办公室"
	icon_state = "recycling"
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/recycling_plant_waste_disposal_incinerator
	name = "维兰德-汤谷 - 资源回收设施 - 废物处理焚烧室"
	icon_state = "recycling"
	linked_lz = DROPSHIP_LZ1

// Restrooms

/area/lv759/indoors/south_public_restroom
	name = "公共洗手间 - 南侧"
	icon_state = "restroom"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ2

/area/lv759/indoors/southwest_public_restroom
	name = "公共洗手间 - 西南侧"
	icon_state = "restroom"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	linked_lz = DROPSHIP_LZ2

//Nightgold Casino

/area/lv759/indoors/casino
	name = "夜金赌场"
	icon_state = "nightgold"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

/area/lv759/indoors/casino/casino_office
	name = "夜金赌场 - 经理办公室"
	icon_state = "nightgold"

/area/lv759/indoors/casino/casino_restroom
	name = "夜金赌场 - 洗手间"
	icon_state = "nightgold"

/area/lv759/indoors/casino/casino_vault
	name = "夜金赌场 - 金库"
	icon_state = "nightgold"

// Pizza

/area/lv759/indoors/pizzaria
	name = "披萨银河 - 泽塔前哨"
	icon_state = "pizza"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

//T-comms

/area/lv759/indoors/tcomms_northwest
	name = "电信变电站 - 西侧"
	icon_state = "comms_1"
	minimap_color = MINIMAP_AREA_COMMS

// Weymart

/area/lv759/indoors/weymart
	name = "维玛特超市"
	icon_state = "weymart"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM
	ambience_exterior = AMBIENCE_WEYMART

/area/lv759/indoors/weymart/backrooms
	name = "维玛特超市 - 后室"
	icon_state = "weymartbackrooms"

/area/lv759/indoors/weymart/maintenance
	name = "维玛特超市 - 维护区"
	icon_state = "weymartbackrooms"

// WY Security Checkpoints

/area/lv759/indoors/wy_security
	minimap_color = MINIMAP_AREA_COLONY_MARSHALLS

/area/lv759/indoors/wy_security/checkpoint_northeast
	name = "维兰德-汤谷安全检查站 - 东北侧"
	icon_state = "security_checkpoint_northeast"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv759/indoors/wy_security/checkpoint_east
	name = "维兰德-汤谷安全检查站 - 东侧"
	icon_state = "security_checkpoint_east"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/lv759/indoors/wy_security/checkpoint_central
	name = "维兰德-汤谷安全检查站 - 中央"
	icon_state = "security_checkpoint_central"

/area/lv759/indoors/wy_security/checkpoint_west
	name = "维兰德-汤谷安全检查站 - 西侧"
	icon_state = "security_checkpoint_west"

/area/lv759/indoors/wy_security/checkpoint_northwest
	name = "维兰德-汤谷安全检查站 - 西北"
	icon_state = "security_checkpoint_northwest"

// Misc

/area/lv759/indoors/hobosecret
	name = "隐秘流浪者庇护所"
	icon_state = "hobo"
	ceiling = CEILING_REINFORCED_METAL
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	linked_lz = DROPSHIP_LZ2

// Weyland-Yutani Advanced Bio-Genomic Research Complex

/area/lv759/indoors/wy_research_complex
	name = "维兰德-汤谷 - 先进生物基因组研究综合体"
	icon_state = "wylab"
	minimap_color = MINIMAP_AREA_HYBRISARESEARCH
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	unoviable_timer = FALSE
	ceiling_muffle = FALSE

/area/lv759/indoors/wy_research_complex/medical_annex
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 医疗附属楼"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/reception
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 接待与行政"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/cargo
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 补给与货运"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/researchanddevelopment
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 技术研发实验室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/mainlabs
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 先进化学测试与研究实验室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/xenobiology
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 先进异形生物学实验室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_2
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/weaponresearchlab
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 先进武器研究实验室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/weaponresearchlabtesting
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 先进武器研究实验室 - 武器测试场"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/xenoarcheology
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 异形考古学研究实验室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/vehicledeploymentbay
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 载具部署与维护舱"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/janitor
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 清洁用品储藏室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/cafeteria
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 食堂"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/cafeteriakitchen
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 食堂 - 厨房"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/dormsfoyer
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 宿舍门厅"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/dormsbedroom
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 宿舍"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/securitycommand
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 安全指挥中心与部署区"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/securityarmory
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 军械库"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/hangarbay
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 机库舱"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/hangarbayshuttle
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 机库舱 - 维兰德-汤谷PMC应急反应小组穿梭机"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	minimap_color = MINIMAP_AREA_COLONY
	requires_power = FALSE

/area/lv759/indoors/wy_research_complex/hallwaynorth
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 北走廊"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/hallwaynorthexit
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 北走廊 - 人员东出口"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/hallwayeast
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 东走廊"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/hallwaycentral
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 中央走廊"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/hallwaysouthwest
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 西南走廊"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/hallwaysoutheast
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 东南走廊"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/southeastexit
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 东南维护区及紧急出口"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/changingroom
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 更衣室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv759/indoors/wy_research_complex/head_research_office
	name = "维兰德-汤谷 - 先进生物基因组研究综合体 - 研究主管办公室"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
