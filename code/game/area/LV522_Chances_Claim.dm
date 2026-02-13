//lv522 AREAS--------------------------------------//

/area/lv522
	icon_state = "lv-626"
	can_build_special = TRUE
	powernet_name = "ground"
	minimap_color = MINIMAP_AREA_COLONY

//parent types

/area/lv522/indoors
	name = "钱斯领地 - 户外"
	icon_state = "cliff_blocked" //because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	soundscape_playlist = SCAPE_PL_LV522_INDOORS


/area/lv522/outdoors
	name = "钱斯领地 - 户外"
	icon_state = "cliff_blocked" //because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV522_OUTDOORS

/area/lv522/oob
	name = "LV522 - 禁区"
	icon_state = "unknown"
	requires_power = FALSE
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW|AREA_UNWEEDABLE

/area/lv522/oob/w_y_vault
	name = "LV522 - 维兰德安全金库"
	icon_state = "blue"

//Landing Zone 1

/area/lv522/landing_zone_1
	name = "钱斯领地 - 一号着陆区"
	icon_state = "explored"
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ1

/area/lv522/landing_zone_1/ceiling
	ceiling = CEILING_METAL

/area/lv522/landing_zone_1/tunnel
	name = "钱斯领地 - 一号着陆区隧道"
	ceiling = CEILING_METAL

/area/lv522/landing_zone_1/tunnel/far
	name = "钱斯领地 - 一号着陆区隧道"
	ceiling = CEILING_METAL
	is_landing_zone = FALSE

/area/shuttle/drop1/lv522
	name = "钱斯领地 - 运输机'阿拉莫'着陆区"
	icon_state = "shuttle"
	icon = 'icons/turf/area_shiva.dmi'
	linked_lz = DROPSHIP_LZ1

/area/lv522/landing_zone_1/lz1_console
	name = "钱斯领地 - 运输机'阿拉莫'控制台"
	icon_state = "tcomsatcham"
	requires_power = FALSE

//Landing Zone 2

/area/lv522/landing_zone_2
	name = "钱斯矿场 - 二号着陆区"
	icon_state = "explored"
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ2

/area/lv522/landing_zone_2/ceiling
	ceiling = CEILING_METAL

/area/shuttle/drop2/lv522
	name = "钱斯矿场 - 诺曼底号运输机着陆区"
	icon_state = "shuttle2"
	icon = 'icons/turf/area_shiva.dmi'
	linked_lz = DROPSHIP_LZ2

/area/lv522/landing_zone_2/lz2_console
	name = "钱斯矿场 - 诺曼底号运输机控制台"
	icon_state = "tcomsatcham"
	requires_power = FALSE

//Landing Zone 3 & 4

/area/lv522/landing_zone_forecon
	name = "钱斯矿场 - 前线侦察穿梭机"
	icon_state = "shuttle"
	ceiling =  CEILING_METAL
	requires_power = FALSE

/area/lv522/landing_zone_forecon/landing_zone_3
	name = "钱斯矿场 - 三号着陆区"
	icon_state = "blue"
	ceiling = CEILING_NONE

/area/lv522/landing_zone_forecon/landing_zone_4
	name = "钱斯矿场 - 四号着陆区"
	icon_state = "blue"
	ceiling = CEILING_NONE

/area/lv522/landing_zone_forecon/UD6_Typhoon
	name = "钱斯矿场 - UD6台风号"

/area/lv522/landing_zone_forecon/UD6_Tornado
	name = "钱斯矿场 - UD6龙卷风号"

//Outdoors areas
/area/lv522/outdoors/colony_streets //WHY IS THIS A SUBTYPE OF BUILDINGS AAAARGGHGHHHH YOU DIDN'T EVEN USE OBJECT INHERITANCE FOR THE CIELINGS I HATE YOU BOBBY
	name = "殖民地街道"
	icon_state = "green"
	ceiling = CEILING_NONE

/area/lv522/outdoors/colony_streets/containers
	name = "殖民地街道 - 集装箱堆场"
	icon_state = "yellow"
	unoviable_timer = FALSE

/area/lv522/outdoors/colony_streets/windbreaker
	name = "殖民地防风带"
	icon_state = "tcomsatcham"
	requires_power = FALSE
	ceiling = CEILING_NONE

/area/lv522/outdoors/colony_streets/windbreaker/observation
	name = "殖民地防风带 - 观察点"
	icon_state = "purple"
	requires_power = FALSE
	ceiling = CEILING_GLASS
	soundscape_playlist = SCAPE_PL_LV522_INDOORS

/area/lv522/outdoors/colony_streets/central_streets
	name = "中央街道 - 西区"
	icon_state = "west"
	linked_lz = DROPSHIP_LZ1

/area/lv522/outdoors/colony_streets/east_central_street
	name = "中央街道 - 东区"
	icon_state = "east"
	linked_lz = DROPSHIP_LZ2

/area/lv522/outdoors/colony_streets/south_street
	name = "殖民地街道 - 南区"
	icon_state = "south"
	linked_lz = list(DROPSHIP_LZ2, DROPSHIP_LZ1)

/area/lv522/outdoors/colony_streets/south_east_street
	name = "殖民地街道 - 东南区"
	icon_state = "southeast"
	linked_lz = DROPSHIP_LZ2

/area/lv522/outdoors/colony_streets/south_west_street
	name = "殖民地街道 - 西南区"
	icon_state = "southwest"
	linked_lz = DROPSHIP_LZ1

/area/lv522/outdoors/colony_streets/north_west_street
	name = "殖民地街道 - 西北区"
	icon_state = "northwest"

/area/lv522/outdoors/colony_streets/north_east_street
	name = "殖民地街道 - 东北区"
	icon_state = "northeast"

/area/lv522/outdoors/colony_streets/north_street
	name = "殖民地街道 - 北区"
	icon_state = "north"

/area/lv522/outdoors/colony_streets/winde
	name = "殖民地街道 - 西北区"
	icon_state = "northwest"

//misc indoors areas

/area/lv522/indoors/lone_buildings
	name = "LV522 - 独立建筑群"
	icon_state = "green"

/area/lv522/indoors/toilet
	name = "LV522 - 户外厕所"
	icon_state = "green"
	linked_lz = DROPSHIP_LZ2
	requires_power = FALSE

/area/lv522/indoors/lone_buildings/engineering
	name = "紧急工程区"
	icon_state = "engine_smes"
	minimap_color = MINIMAP_AREA_ENGI
	linked_lz = DROPSHIP_LZ1

/area/lv522/indoors/lone_buildings/spaceport
	name = "北区一号着陆区 - 太空港"
	icon_state = "red"
	minimap_color = MINIMAP_AREA_LZ

/area/lv522/indoors/lone_buildings/outdoor_bot
	name = "东区一号着陆区 - 户外通讯站"
	icon_state = "yellow"
	ceiling = CEILING_GLASS
	linked_lz = DROPSHIP_LZ1

/area/lv522/indoors/lone_buildings/storage_blocks
	name = "户外仓储区"
	linked_lz = list(DROPSHIP_LZ2, DROPSHIP_LZ1)

/area/lv522/indoors/lone_buildings/storage_blocks/south
	name = "南部户外仓储区"
	icon_state = "red"

/area/lv522/indoors/lone_buildings/storage_blocks/north_west
	name = "西北户外仓储区"
	icon_state = "blue"

/area/lv522/indoors/lone_buildings/storage_blocks/east
	name = "东部户外仓储区"
	icon_state = "yellow"

/area/lv522/indoors/lone_buildings/chunk
	name = "切块处理站"
	icon_state = "blue"
	linked_lz = DROPSHIP_LZ1

//A Block
/area/lv522/indoors/a_block
	name = "A区"
	icon_state = "blue"
	ceiling = CEILING_METAL

/area/lv522/indoors/a_block/admin
	name = "A区 - 殖民地指挥中心"
	icon_state = "mechbay"
	minimap_color = MINIMAP_AREA_COMMAND

/area/lv522/indoors/a_block/dorms
	name = "A区 - 西部宿舍与办公室"
	icon_state = "fitness"

/area/lv522/indoors/a_block/dorms/glass
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/fitness
	name = "A区 - 健身中心"
	icon_state = "fitness"

/area/lv522/indoors/a_block/fitness/glass
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/hallway
	name = "A区 - 南部指挥走廊"
	icon_state = "green"

/area/lv522/indoors/a_block/hallway/damage
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV522_OUTDOORS

/area/lv522/indoors/a_block/medical
	name = "A区 - 医疗室"
	icon_state = "medbay"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/lv522/indoors/a_block/medical/glass
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/security
	name = "A区 - 安保室"
	icon_state = "head_quarters"
	minimap_color = MINIMAP_AREA_SEC

/area/lv522/indoors/a_block/security/glass
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/kitchen
	name = "A区 - 厨房与餐厅"
	icon_state = "kitchen"

/area/lv522/indoors/a_block/kitchen/glass
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/kitchen/damage
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV522_OUTDOORS

/area/lv522/indoors/a_block/executive
	name = "A区 - 行政套房"
	icon_state = "captain"

/area/lv522/indoors/a_block/executive/glass
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/dorm_north
	name = "A区 - 北部公共宿舍"
	icon_state = "fitness"

/area/lv522/indoors/a_block/bridges
	name = "A区 - 西部宿舍至安保室天桥"
	icon_state = "hallC1"
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/bridges/dorms_fitness
	name = "A区 - 公司办公室至健身中心天桥"
	icon_state = "hallC1"
	ceiling = CEILING_GLASS

/area/lv522/indoors/a_block/bridges/corpo_fitness
	name = "A区 - 西部宿舍至健身中心"
	icon_state = "hallC1"
	ceiling = CEILING_GLASS


/area/lv522/indoors/a_block/bridges/corpo
	name = "A区 - 安保室至公司办公室天桥"
	icon_state = "hallC1"

/area/lv522/indoors/a_block/bridges/op_centre
	name = "A区 - 安保室至指挥中心天桥"
	icon_state = "hallC1"

/area/lv522/indoors/a_block/bridges/garden_bridge
	name = "A区 - 花园天桥"
	icon_state = "hallC2"
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC

/area/lv522/indoors/a_block/corpo
	name = "A区 - 公司办公室"
	icon_state = "toxlab"

/area/lv522/indoors/a_block/corpo/glass
	ceiling =  CEILING_GLASS

/area/lv522/indoors/a_block/garden
	name = "A区 - 西部指挥花园"
	icon_state = "green"
	ceiling = CEILING_GLASS
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC

//B Block

/area/lv522/indoors/b_block
	name = "B区"
	icon_state = "red"
	ceiling =  CEILING_METAL
	linked_lz = DROPSHIP_LZ1

/area/lv522/indoors/b_block/hydro
	name = "B区 - 水培室"
	icon_state = "hydro"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/lv522/indoors/b_block/hydro/glass
	ceiling = CEILING_GLASS
	linked_lz = list(DROPSHIP_LZ2, DROPSHIP_LZ1)

/area/lv522/indoors/b_block/bar
	name = "B区 - 酒吧"
	icon_state = "cafeteria"

/area/lv522/indoors/b_block/bridge
	name = "B区 - 水培桥接网络"
	icon_state = "hallC1"
	ceiling = CEILING_GLASS
	linked_lz = list(DROPSHIP_LZ2, DROPSHIP_LZ1)

//C Block

/area/lv522/indoors/c_block
	name = "C区"
	icon_state = "green"
	linked_lz = DROPSHIP_LZ2

/area/lv522/indoors/c_block/cargo
	name = "C区 - 货物区"
	icon_state = "primarystorage"

/area/lv522/indoors/c_block/mining
	name = "C区 - 采矿场"
	icon_state = "yellow"
	linked_lz = DROPSHIP_LZ2

/area/lv522/indoors/c_block/garage
	name = "C区 - 车库"
	icon_state = "storage"

/area/lv522/indoors/c_block/casino
	name = "C区 - 赌场"
	icon_state = "purple"

/area/lv522/indoors/c_block/bridge
	name = "C区 - 货物区至车库桥"
	icon_state = "hallC1"
	ceiling = CEILING_GLASS

/area/lv522/indoors/c_block/t_comm
	name = "C区 - 西车库战术通讯站"
	icon_state = "hallC1"

//Rockies

/area/lv522/outdoors/n_rockies
	name = "殖民地北部 - 落基山区"
	icon_state = "away"

/area/lv522/outdoors/nw_rockies
	name = "殖民地西北部 - 落基山区"
	icon_state = "away1"

/area/lv522/outdoors/w_rockies
	name = "殖民地西部 - 落基山区"
	icon_state = "away2"

/area/lv522/outdoors/p_n_rockies
	name = "北部处理器 - 落基山区"
	icon_state = "away"

/area/lv522/outdoors/p_nw_rockies
	name = "西北部处理器 - 落基山区"
	icon_state = "away1"

/area/lv522/outdoors/p_w_rockies
	name = "西部处理器 - 落基山区"
	icon_state = "away2"

/area/lv522/outdoors/p_e_rockies
	name = "东部处理器 - 落基山区"
	icon_state = "away3"

//ATMOS
/area/lv522/atmos
	name = "大气处理器"
	icon_state = "engineering"
	ceiling = CEILING_REINFORCED_METAL
	ambience_exterior = AMBIENCE_SHIP
	minimap_color = MINIMAP_AREA_ENGI
	unoviable_timer = FALSE

/area/lv522/atmos/outdoor
	name = "大气处理器 - 户外区域"
	icon_state = "quart"
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV522_OUTDOORS

/area/lv522/atmos/east_reactor
	name = "大气处理器 - 东部反应堆"
	icon_state = "blue"

/area/lv522/atmos/east_reactor/north
	name = "大气处理器 - 东部外反应堆 - 北侧"
	icon_state = "yellow"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/east_reactor/south
	name = "大气处理器 - 东部外反应堆 - 南侧"
	icon_state = "red"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/east_reactor/south/cas
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/east_reactor/east
	name = "大气处理器 - 东部外反应堆 - 东侧"
	icon_state = "green"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/east_reactor/west
	name = "大气处理器 - 东部外反应堆 - 西侧"
	icon_state = "purple"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/west_reactor
	name = "大气处理器 - 西部反应堆"
	icon_state = "blue"

/area/lv522/atmos/cargo_intake
	name = "大气处理器 - 货物入口"
	icon_state = "yellow"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/command_centre
	name = "大气处理器 - 中央指挥部"
	icon_state = "red"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/north_command_centre
	name = "大气处理器 - 北部指挥中心检查站"
	icon_state = "green"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/filt
	name = "大气处理器 - 过滤系统"
	icon_state = "mechbay"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/way_in_command_centre
	name = "大气处理器 - 北部科波反应堆入口"
	icon_state = "blue"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/sewer
	name = "大气处理器 - 下水道"
	icon_state = "red"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv522/atmos/reactor_garage
	name = "大气处理器 - 车库"
	icon_state = "green"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
