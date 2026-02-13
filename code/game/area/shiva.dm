//Areas for Shiva's Snowball, aka Ice LZ1, above ground revamp.

/area/shiva
	name = "湿婆雪球"
	icon = 'icons/turf/area_shiva.dmi'
	//ambience = list('figuresomethingout.ogg')
	icon_state = "shiva"
	can_build_special = TRUE //T-Comms structure
	powernet_name = "ground"
	temperature = ICE_COLONY_TEMPERATURE
	minimap_color = MINIMAP_AREA_COLONY

/area/shuttle/drop1/shiva
	name = "湿婆雪球 - 阿拉莫运输机着陆区"
	icon_state = "shuttle"
	icon = 'icons/turf/area_shiva.dmi'
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_LZ

/area/shuttle/drop2/shiva
	name = "湿婆雪球 - 诺曼底运输机着陆区"
	icon_state = "shuttle2"
	icon = 'icons/turf/area_shiva.dmi'
	linked_lz = DROPSHIP_LZ2
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/lz1_console
	name = "湿婆雪球 - 阿拉莫运输机控制台"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/lz1_console/two
	name = "湿婆雪球 - 诺曼底运输机控制台"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior
	name = "湿婆雪球 - 外部"
	ceiling = CEILING_NONE


/area/shiva/interior
	name = "湿婆雪球 - 内部"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	requires_power = TRUE

/area/shiva/interior/oob
	name = "湿婆雪球 - 禁区"
	ceiling = CEILING_MAX
	icon_state = "oob"
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW|AREA_UNWEEDABLE

/area/shiva/interior/oob/dev_room
	name = "湿婆雪球 - 密室"
	icon_state = "shiva"

//telecomms areas - exterior
/area/shiva/exterior/telecomm
	name = "湿婆雪球 - 通讯中继站"
	icon_state = "ass_line"

/area/shiva/exterior/telecomm/lz1_north
	name = "湿婆雪球 - 北部LZ1通讯中继站"
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ1

/area/shiva/exterior/telecomm/lz2_southeast
	name = "湿婆雪球 - 东南部LZ2通讯中继站"
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ2

/area/shiva/exterior/telecomm/lz2_northeast
	name = "湿婆雪球 - 东北部LZ2通讯中继站"
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ2

//telecomms areas - interior
/area/shiva/interior/telecomm
	name = "湿婆雪球 - 通讯中继站"
	icon_state = "ass_line"

/area/shiva/interior/telecomm/lz1_biceps
	name = "湿婆雪球 - 二头肌堡垒通讯中继站"
	icon_state = "hangars0"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/interior/telecomm/lz1_flight
	name = "湿婆雪球 - LZ1机场通讯中继站"
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ1

/area/shiva/interior/telecomm/lz2_research
	name = "湿婆雪球 - 阿根廷通讯中继站"
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ2

//telecomms areas - caves
/area/shiva/caves/telecomm
	name = "湿婆雪球 - 通讯中继站"
	icon_state = "ass_line"

/area/shiva/caves/telecomm/lz2_south
	name = "湿婆雪球 - 备用通讯中继站"
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ2

//exterior areas

/area/shiva/exterior/lz1_valley
	name = "湿婆雪球 - 着陆谷"
	icon_state = "landing_valley"
	linked_lz = DROPSHIP_LZ1
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/lz2_fortress
	name = "湿婆雪球 - 着陆壁垒"
	icon_state = "lz2_fortress"
	linked_lz = DROPSHIP_LZ2
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/valley
	name = "湿婆雪球 - 存储掩体谷"
	icon_state = "junkyard1"
	unoviable_timer = FALSE

/area/shiva/exterior/southwest_valley
	name = "湿婆雪球 - 西南谷"
	icon_state = "sw"
	linked_lz = DROPSHIP_LZ1

/area/shiva/exterior/cp_colony_grounds
	name = "湿婆雪球 - 殖民地场地"
	icon_state = "junkyard2"
	unoviable_timer = FALSE

/area/shiva/exterior/junkyard
	name = "湿婆雪球 - 废料场"
	icon_state = "junkyard0"

/area/shiva/exterior/junkyard/fortbiceps
	name = "湿婆雪球 - 二头肌堡垒"
	icon_state = "junkyard1"

/area/shiva/exterior/junkyard/cp_bar
	name = "湿婆雪球 - 酒吧场地"
	icon_state = "bar0"
	unoviable_timer = FALSE

/area/shiva/exterior/cp_s_research
	name = "湿婆雪球 - 研究居住区外部"
	icon_state = "junkyard1"
	unoviable_timer = FALSE

/area/shiva/exterior/cp_lz2
	name = "湿婆雪球 - 北部殖民地场地"
	icon_state = "junkyard3"
	linked_lz = DROPSHIP_LZ2

/area/shiva/exterior/research_alley
	name = "湿婆雪球 - 南部研究巷道"
	icon_state = "junkyard2"
	minimap_color = MINIMAP_AREA_RESEARCH



//interior areas

/area/shiva/interior/caves
	name = "湿婆雪球 - 洞穴"
	icon_state = "caves0"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/shiva/interior/caves/right_spiders
	name = "湿婆雪球 - 被遗忘的通道"
	icon_state = "caves1"
	unoviable_timer = FALSE

/area/shiva/interior/caves/left_spiders
	name = "湿婆雪球 - 裂隙通道"
	icon_state = "caves2"

/area/shiva/interior/caves/s_lz2
	name = "湿婆雪球 - 南部LZ2洞穴"
	icon_state = "caves3"
	minimap_color = MINIMAP_AREA_LZ
	linked_lz = DROPSHIP_LZ2

/area/shiva/interior/caves/cp_camp
	name = "湿婆雪球 - 洞穴营地"
	icon_state = "bar3"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/shiva/interior/caves/research_caves
	name = "湿婆雪球 - 南部研究居住区洞穴"
	icon_state = "caves2"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE
	unoviable_timer = FALSE

/area/shiva/interior/caves/medseceng_caves
	name = "湿婆雪球 - 南部医疗-安保-工程综合设施洞穴"
	icon_state = "caves3"
	unoviable_timer = FALSE

/area/shiva/interior/colony
	name = "湿婆雪球 - 殖民地巨型结构(TM)"
	icon_state = "res0"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/shiva/interior/colony/botany
	name = "湿婆雪球 - 巨型结构(TM)植物园宿舍"
	icon_state = "res1"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/shiva/interior/colony/clf_shuttle
	name = "湿婆雪球 - 故障的货运穿梭机"
	icon_state = "res0"

/area/shiva/interior/colony/s_admin
	name = "湿婆雪球 - 巨型结构(TM)危机中心"
	icon_state = "res2"

/area/shiva/interior/colony/n_admin
	name = "湿婆雪球 - 巨型结构(TM)行政中心"
	icon_state = "res3"
	minimap_color = MINIMAP_AREA_COMMAND

/area/shiva/interior/colony/central
	name = "湿婆雪球 - 巨型结构(TM)居住生活区"
	icon_state = "res4"

/area/shiva/interior/colony/research_hab
	name = "湿婆雪球 - 研究居住区内部"
	icon_state = "res2"
	unoviable_timer = FALSE

/area/shiva/interior/colony/medseceng
	name = "湿婆雪球 - 殖民地巨型结构(TM)医疗-安保-工程区段"
	icon_state = "res0"
	unoviable_timer = FALSE

/area/shiva/interior/aerodrome
	name = "湿婆雪球 - 机场"
	icon_state = "hangars0"
	linked_lz = DROPSHIP_LZ1

/area/shiva/interior/bar
	name = "湿婆雪球 - 防冻酒吧"
	icon_state = "hangars0"

/area/shiva/interior/fort_biceps
	name = "湿婆雪球 - 二头肌堡垒内部"
	icon_state = "hangars0"

/area/shiva/interior/warehouse
	name = "湿婆雪球 - 蓝色仓库"
	icon_state = "hangars1"
	linked_lz = DROPSHIP_LZ1

/area/shiva/interior/warehouse/caves
	name = "湿婆雪球 - 蓝色仓库冰洞"
	icon_state = "caves1"

/area/shiva/interior/valley_huts
	name = "湿婆雪球 - 山谷地堡1"
	icon_state = "hangars1"
	unoviable_timer = FALSE

/area/shiva/interior/valley_huts/no2
	name = "湿婆雪球 - 山谷地堡2"
	icon_state = "hangars2"
	unoviable_timer = FALSE

/area/shiva/interior/valley_huts/disposals
	name = "湿婆雪球 - 山谷废物处理"
	icon_state = "hangars3"
	unoviable_timer = FALSE

/area/shiva/interior/garage
	name = "湿婆雪球 - 货运拖船维修站"
	icon_state = "hangars2"
	unoviable_timer = FALSE

/area/shiva/interior/lz2_habs
	name = "湿婆雪球 - 阿根廷研究总部"
	icon_state = "bar1"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ2

/area/shiva/interior/aux_power
	name = "湿婆雪球 - 辅助发电站"
	icon_state = "hangars0"
