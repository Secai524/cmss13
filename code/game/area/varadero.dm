
//areas for New  Varadero (waterworld), aka Ice Underground revamped.

/area/varadero
	name = "新瓦拉德罗"
	icon = 'icons/turf/area_varadero.dmi'
	ambience_exterior = AMBIENCE_NV
	icon_state = "varadero"
	can_build_special = TRUE //T-Comms structure
	powernet_name = "ground"
	temperature = TROPICAL_TEMP
	minimap_color = MINIMAP_AREA_COLONY

//shuttle stuff

/area/shuttle/drop1/varadero
	name = "新瓦拉德罗 - 运输机‘阿拉莫’着陆区"
	icon_state = "shuttle"
	icon = 'icons/turf/area_varadero.dmi'
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_LZ


/area/shuttle/drop2/varadero
	name = "新瓦拉德罗 - 运输机‘诺曼底’着陆区"
	icon_state = "shuttle2"
	icon = 'icons/turf/area_varadero.dmi'
	linked_lz = DROPSHIP_LZ2
	minimap_color = MINIMAP_AREA_LZ

//Parent areas

/area/varadero/exterior
	name = "新瓦拉德罗 - 外部"
	ceiling = CEILING_NONE
	ambience_exterior = AMBIENCE_NV
	//soundscape_playlist

/area/varadero/interior
	name = "新瓦拉德罗 - 内部"
	ceiling = CEILING_GLASS
	ambience_exterior = AMBIENCE_PRISON
	//soundscape_playlist
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/varadero/interior_protected
	name = "新瓦拉德罗 - 内部"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	sound_environment = SOUND_ENVIRONMENT_AUDITORIUM
	icon_state = "NV_no_CAS"

/area/varadero/interior/comms1
	name = "新瓦拉德罗 - 货舱发电机"
	linked_lz = DROPSHIP_LZ1
	icon_state = "comms1"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/varadero/interior/comms2
	name = "新瓦拉德罗 - 通讯项目现场"
	icon_state = "comms2"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	linked_lz = DROPSHIP_LZ2

/area/varadero/interior/comms3
	name = "新瓦拉德罗 - 工程通讯站"
	icon_state = "comms3"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	linked_lz = DROPSHIP_LZ2

/area/varadero/exterior/comms4
	name = "新瓦拉德罗 - 步道延伸段"
	linked_lz = DROPSHIP_LZ1
	icon_state = "comms4"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/varadero/interior/oob
	name = "新瓦拉德罗 - 禁区"
	ceiling = CEILING_MAX
	icon_state = "oob"
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW|AREA_UNWEEDABLE

//landing zone computers

/area/varadero/exterior/lz1_console
	name = "新瓦拉德罗 - 浮筒码头"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_LZ
	is_landing_zone = TRUE

/area/varadero/exterior/lz1_console/two
	name = "新瓦拉德罗 - 棕榈机场"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_LZ

//exterior areas

/area/varadero/exterior/lz1_near
	name = "新瓦拉德罗 - 浮筒机场"
	icon_state = "lz1"
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_LZ
	is_landing_zone = TRUE

/area/varadero/exterior/lz2_near
	name = "新瓦拉德罗 - 棕榈机场"
	icon_state = "lz2"
	linked_lz = DROPSHIP_LZ2
	minimap_color = MINIMAP_AREA_LZ
	is_landing_zone = TRUE

/area/varadero/exterior/pontoon_beach
	name = "新瓦拉德罗 - 摇滚海滩"
	icon_state = "varadero0"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)
	minimap_color = MINIMAP_AREA_JUNGLE

/area/varadero/exterior/pontoon_beach/lz
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/varadero/exterior/eastbeach
	name = "新瓦拉德罗 - 东滩"
	linked_lz = DROPSHIP_LZ2
	icon_state = "varadero1"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/varadero/exterior/monsoon
	name = "新瓦拉德罗 - 季风区"
	icon_state = "varadero1"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/varadero/exterior/pool
	name = "新瓦拉德罗 - 室内泳池"
	icon_state = "varadero1"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/varadero/exterior/eastocean
	name = "新瓦拉德罗 - 东部海洋"
	linked_lz = DROPSHIP_LZ2
	flags_area = AREA_NOBURROW
	icon_state = "varadero2"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/varadero/exterior/farocean
	name = "新瓦拉德罗 - 远海"
	flags_area = AREA_NOBURROW
	icon_state = "varadero3"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/varadero/exterior/islands
	name = "新瓦拉德罗 - 群岛"
	icon_state = "varadero1"
	allow_construction = FALSE
	always_unpowered = 1


//interior areas


/area/varadero/interior/beach_bar
	name = "新瓦拉德罗 - 海滩酒吧"
	icon_state = "varadero4"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)
	minimap_color = MINIMAP_AREA_JUNGLE
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/varadero/interior/dock_control
	name = "新瓦拉德罗 - 码头控制室"
	icon_state = "varadero3"
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_JUNGLE
	sound_environment = SOUND_ENVIRONMENT_ROOM
	is_landing_zone = TRUE

/area/varadero/interior/cargo
	name = "新瓦拉德罗 - 货舱"
	icon_state = "req0"
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_ENGI

/area/varadero/interior/hall_NW
	name = "新瓦拉德罗 - 西北走廊"
	icon_state = "hall0"

/area/varadero/interior/hall_N
	name = "新瓦拉德罗 - 北走廊"
	icon_state = "hall2"
	linked_lz = DROPSHIP_LZ1

/area/varadero/interior/hall_SE
	name = "新瓦拉德罗 - 东南走廊"
	icon_state = "hall1"

/area/varadero/interior/chapel
	name = "新瓦拉德罗 - 教堂"
	icon_state = "offices1"
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/varadero/interior/morgue
	name = "新瓦拉德罗 - 停尸房"
	icon_state = "offices0"
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_MEDBAY_CAVE

/area/varadero/interior/medical
	name = "新瓦拉德罗 - 医疗室"
	icon_state = "offices2"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/varadero/interior/maintenance
	name = "新瓦拉德罗 - 中央维护区"
	icon_state = "tunnels0"

/area/varadero/interior/maintenance/north
	name = "新瓦拉德罗 - 北部维护区"
	icon_state = "tunnels1"
	linked_lz = DROPSHIP_LZ1

/area/varadero/interior/maintenance/research
	name = "新瓦拉德罗 - 研究维护区"
	icon_state = "tunnels1"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/varadero/interior/maintenance/security
	name = "新瓦拉德罗 - 安保维护区"
	icon_state = "tunnels2"
	minimap_color = MINIMAP_AREA_SEC_CAVE

/area/varadero/interior/maintenance/security/north
	name = "新瓦拉德罗 - 北安保维护区"
	linked_lz = DROPSHIP_LZ2

/area/varadero/interior/maintenance/security/south
	name = "新瓦拉德罗 - 南安保维护区"

/area/varadero/interior/research
	name = "新瓦拉德罗 - 研究办公室"
	icon_state = "offices4"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/varadero/interior/electrical
	name = "新瓦拉德罗 - 电气附属设施"
	icon_state = "req4"
	minimap_color = MINIMAP_AREA_ENGI
	linked_lz = DROPSHIP_LZ2

/area/varadero/interior/toilets
	name = "新瓦拉德罗 - 洗手间"
	icon_state = "req0"

/area/varadero/interior/technical_storage
	name = "新瓦拉德罗 - 技术储藏室"
	icon_state = "req3"
	minimap_color = MINIMAP_AREA_ENGI

/area/varadero/interior/laundry
	name = "新瓦拉德罗 - 洗衣房"
	icon_state = "req2"

/area/varadero/interior/disposals
	name = "新瓦拉德罗 - 废物处理区"
	icon_state = "offices4"
	minimap_color = MINIMAP_AREA_ENGI

/area/varadero/interior/administration
	name = "新瓦拉德罗 - 行政办公室"
	icon_state = "offices2"
	minimap_color = MINIMAP_AREA_COMMAND

/area/varadero/interior/library
	name = "新瓦拉德罗 - 图书馆"
	icon_state = "offices0"
	linked_lz = DROPSHIP_LZ1
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/varadero/interior/library/restaraunt
	name = "新瓦拉德罗餐厅"
	icon = 'icons/turf/hybrisareas.dmi'
	icon_state ="pizza"

/area/varadero/interior/court
	name = "新瓦拉德罗 - 篮球场"
	icon_state = "req4"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/varadero/interior/mess
	name = "新瓦拉德罗 - 食堂"
	icon_state = "req2"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/varadero/interior/bunks
	name = "新瓦拉德罗 - 一级居住区"
	icon_state = "req3"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/varadero/interior/security
	name = "新瓦拉德罗 - 安保办公室"
	icon_state = "offices0"
	minimap_color = MINIMAP_AREA_SEC

/area/varadero/interior/records
	name = "新瓦拉德罗 - 档案室"
	icon_state = "offices2"

/area/varadero/interior/rear_elevator
	name = "新瓦拉德罗 - 主升降梯"
	icon_state = "req3"

/area/varadero/interior/caves
	name = "新瓦拉德罗 - 母体洞穴"
	icon_state = "tunnels0"
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	sound_environment = SOUND_ENVIRONMENT_AUDITORIUM
	minimap_color = MINIMAP_AREA_CAVES

/area/varadero/interior/caves/north_research
	name = "新瓦拉德罗 - 北部研究洞穴"
	icon_state = "tunnels4"

/area/varadero/interior/caves/east
	name = "新瓦拉德罗 - 海滩洞穴"
	icon_state = "tunnels2"

/area/varadero/interior_protected/caves
	name = "新瓦拉德罗 - 南部研究洞穴"
	icon_state = "deepcaves0"
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE
	unoviable_timer = FALSE

/area/varadero/interior_protected/caves/central
	name = "新瓦拉德罗 - 草地洞穴"
	icon_state = "deepcaves2"
	minimap_color = MINIMAP_AREA_CAVES

/area/varadero/interior_protected/caves/digsite
	name = "新瓦拉德罗 - 挖掘场"
	icon_state = "deepcaves3"

/area/varadero/interior_protected/caves/makeshift_tent
	name = "新瓦拉德罗 - 临时帐篷"
	icon_state = "offices4"

/area/varadero/interior_protected/caves/swcaves
	name = "新瓦拉德罗 - 西南洞穴"
	icon_state = "deepcaves3"

/area/varadero/interior_protected/maintenance/south
	name = "新瓦拉德罗 - 南部维护区"
	icon_state = "deepcaves4"
	minimap_color = MINIMAP_AREA_CAVES
	unoviable_timer = FALSE

/area/varadero/interior_protected/vessel
	name = "新瓦拉德罗 - 未知飞船"
	icon_state = "predship"
	minimap_color = MINIMAP_AREA_SHIP
	unoviable_timer = FALSE

/area/varadero/interior/research/clfship
	name = "新瓦拉德罗 - 未注册穿梭机"
	icon_state = "offices0"
