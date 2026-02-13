//Base Instance
/area/desert_dam
	name = "沙漠大坝"
	icon_state = "cliff_blocked"
	can_build_special = TRUE
	powernet_name = "ground"
	ambience_exterior = AMBIENCE_TRIJENT
	minimap_color = MINIMAP_AREA_COLONY

//INTERIOR
// areas under rock
/area/desert_dam/interior
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

//NorthEastern Lab Section
/area/desert_dam/interior/lab_northeast
	name = "东北实验室"
	icon_state = "purple"
	minimap_color = MINIMAP_AREA_RESEARCH
	unoviable_timer = FALSE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/desert_dam/interior/lab_northeast/east_lab_lobby
	name = "东部实验室大厅"
	icon_state = "green"

/area/desert_dam/interior/lab_northeast/east_lab_west_hallway
	name = "东实验室西侧走廊"
	icon_state = "blue"

/area/desert_dam/interior/lab_northeast/east_lab_central_hallway
	name = "东实验室中央走廊"
	icon_state = "green"

/area/desert_dam/interior/lab_northeast/east_lab_east_hallway
	name = "东实验室东侧走廊"
	icon_state = "yellow"

/area/desert_dam/interior/lab_northeast/east_lab_workshop
	name = "东实验室工坊"
	icon_state = "ass_line"

/area/desert_dam/interior/lab_northeast/east_lab_maintenence
	name = "东实验室维护间"
	icon_state = "maintcentral"
	unoviable_timer = 25 MINUTES

/area/desert_dam/interior/lab_northeast/east_lab_containment
	name = "东实验室收容区"
	icon_state = "purple"

/area/desert_dam/interior/lab_northeast/east_lab_RND
	name = "东实验室研发部"
	icon_state = "purple"

/area/desert_dam/interior/lab_northeast/east_lab_biology
	name = "东实验室生物部"
	icon_state = "purple"

/area/desert_dam/interior/lab_northeast/east_lab_excavation
	name = "东实验室挖掘准备区"
	icon_state = "blue"

/area/desert_dam/interior/lab_northeast/east_lab_west_entrance
	name = "东实验室西入口"
	icon_state = "purple"

/area/desert_dam/interior/lab_northeast/east_lab_east_entrance
	name = "东实验室入口"
	icon_state = "purple"

/area/desert_dam/interior/lab_northeast/east_lab_security_armory
	name = "东实验室军械库"
	icon_state = "armory"

//Dam Interior
/area/desert_dam/interior/dam_interior
	minimap_color = MINIMAP_AREA_ENGI
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/desert_dam/interior/dam_interior/engine_room
	name = "工程部发电机房"
	icon_state = "yellow"

/area/desert_dam/interior/dam_interior/control_room
	name = "工程部控制室"
	icon_state = "red"

/area/desert_dam/interior/dam_interior/smes_main
	name = "工程部主变电站"
	icon_state = "purple"

/area/desert_dam/interior/dam_interior/lower_stairwell
	name = "工程部下层楼梯间"
	icon_state = "purple"

/area/desert_dam/interior/dam_interior/upper_stairwell
	name = "工程部上层楼梯间"
	icon_state = "purple"

/area/desert_dam/interior/dam_interior/upper_walkway
	name = "工程部上层走道"
	icon_state = "yellow"

/area/desert_dam/interior/dam_interior/break_room/upper
	name = "工程部上层休息室"
	icon_state = "purple"

/area/desert_dam/interior/dam_interior/smes_backup
	name = "工程部二级备用变电站"
	icon_state = "green"

/area/desert_dam/interior/dam_interior/engine_east_wing
	name = "工程部东引擎舱"
	icon_state = "blue-red"

/area/desert_dam/interior/dam_interior/engine_west_wing
	name = "工程部西引擎舱"
	icon_state = "yellow"

/area/desert_dam/interior/dam_interior/lobby
	name = "工程部大厅"
	icon_state = "purple"

/area/desert_dam/interior/dam_interior/atmos_storage
	name = "工程部大气存储室"
	icon_state = "purple"

/area/desert_dam/interior/dam_interior/northwestern_tunnel
	name = "工程部西北道路"
	icon_state = "green"
	ceiling = CEILING_NONE

/area/desert_dam/interior/dam_interior/north_tunnel
	name = "工程部北侧道路"
	icon_state = "blue-red"
	ceiling = CEILING_NONE

/area/desert_dam/interior/dam_interior/west_tunnel
	name = "工程部西侧隧道"
	icon_state = "yellow"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/desert_dam/interior/dam_interior/south_tunnel_research
	name = "研究部南侧隧道"
	icon_state = "purple"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/desert_dam/interior/dam_interior/central_tunnel
	name = "工程部中央道路"
	icon_state = "red"
	ceiling = CEILING_NONE

/area/desert_dam/interior/dam_interior/south_tunnel
	name = "工程部南侧道路"
	icon_state = "purple"
	ceiling = CEILING_NONE

/area/desert_dam/interior/dam_interior/northeastern_tunnel
	name = "工程部东北隧道"
	icon_state = "green"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/desert_dam/interior/dam_interior/CE_office
	name = "工程部总工程师办公室"
	icon_state = "yellow"

/area/desert_dam/interior/dam_interior/workshop
	name = "工程部车间"
	icon_state = "purple"
	ceiling = CEILING_METAL

/area/desert_dam/interior/dam_interior/hanger
	name = "工程部机库"
	ceiling = CEILING_METAL
	icon_state = "hangar"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/interior/dam_interior/hanger/roof
	name = "工程部机库顶部"
	icon_state = "hangar"
	ceiling = CEILING_NONE

/area/desert_dam/interior/dam_interior/hanger/waiting
	name = "工程部机库大门"
	icon_state = "purple"

/area/desert_dam/interior/dam_interior/hanger/control
	name = "工程部机库空中交通管制"
	icon_state = "blue"

/area/desert_dam/interior/dam_interior/hangar_storage
	name = "工程部机库仓库"
	icon_state = "storage"
	ceiling = CEILING_METAL

/area/desert_dam/interior/dam_interior/auxilary_tool_storage
	name = "工程部辅助工具仓库"
	icon_state = "red"
	ceiling = CEILING_METAL

/area/desert_dam/interior/dam_interior/primary_tool_storage
	name = "工程部主要工具仓库"
	icon_state = "blue"

/area/desert_dam/interior/dam_interior/primary_tool_storage/upper
	name = "工程部上层主要工具仓库"

/area/desert_dam/interior/dam_interior/primary_tool_storage/solar
	name = "工程部太阳能监控室"
	icon_state = "yellow"

/area/desert_dam/interior/dam_interior/primary_tool_storage/server
	name = "工程部服务器机房"
	icon_state = "green"


/area/desert_dam/interior/dam_interior/tech_storage
	name = "工程部安全技术仓库"
	icon_state = "dark"
	ceiling = CEILING_METAL

/area/desert_dam/interior/dam_interior/break_room
	name = "工程部休息室"
	icon_state = "yellow"
	ceiling = CEILING_METAL

/area/desert_dam/interior/dam_interior/disposals
	name = "工程部废弃物处理"
	icon_state = "disposal"

/area/desert_dam/interior/dam_interior/western_dam_cave
	name = "工程部西入口"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	icon_state = "red"

/area/desert_dam/interior/dam_interior/office
	name = "工程部办公室"
	icon_state = "red"

/area/desert_dam/interior/dam_interior
	name = "工程部"
	icon_state = ""

/area/desert_dam/interior/dam_interior/north_tunnel_entrance
	name = "工程部北隧道入口"
	icon_state = "yellow"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/desert_dam/interior/dam_interior/east_tunnel_entrance
	name = "工程部东侧隧道入口"
	icon_state = "yellow"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/desert_dam/interior/dam_interior/south_tunnel_entrance
	name = "工程部南侧隧道入口"
	icon_state = "red"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/desert_dam/interior/dam_interior/garage
	name = "车库"
	icon_state = "green"
	ceiling = CEILING_METAL

/area/desert_dam/interior/caves
	name = "洞穴"
	ceiling = CEILING_DEEP_UNDERGROUND
	icon_state = "red"
	ambience_exterior = AMBIENCE_CAVE
	soundscape_playlist = SCAPE_PL_CAVE
	soundscape_interval = 25
	sound_environment = SOUND_ENVIRONMENT_AUDITORIUM
	minimap_color = MINIMAP_AREA_CAVES
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/desert_dam/interior/caves/east_caves
	name = "东部洞穴"
	icon_state = "red"

/area/desert_dam/interior/caves/west_caves
	name = "西部洞穴"
	icon_state = "red"

/area/desert_dam/interior/caves/central_caves
	name = "中央洞穴"
	icon_state = "yellow"
	unoviable_timer = FALSE

/area/desert_dam/interior/caves/temple
	name = "沙之神庙"
	icon_state = "green"

/area/desert_dam/interior/caves/pred_ship
	name = "未知飞船"
	icon_state = "red"

//BUILDING
//areas not under rock
// ceiling = CEILING_METAL
/area/desert_dam/building
	ceiling = CEILING_METAL

//Substations
/area/desert_dam/building/substation
	name = "变电站"
	icon = 'icons/turf/dam_areas.dmi'
	minimap_color = MINIMAP_AREA_ENGI

/area/desert_dam/building/substation/northwest
	name = "指挥变电站"
	icon_state = "northewestern_ss"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/substation/northeast
	name = "指挥变电站"
	icon_state = "northeastern_ss"
	unoviable_timer = FALSE

/area/desert_dam/building/substation/central
	name = "指挥变电站"
	icon_state = "central_ss"
	unoviable_timer = FALSE

/area/desert_dam/building/substation/southwest
	name = "指挥变电站"
	icon_state = "southwestern_ss"

/area/desert_dam/building/substation/southwest/solar
	name = "西南变电站太阳能监控室"

/area/desert_dam/building/substation/southwest/solar/walkway
	name = "西南变电站太阳能监控通道"
	icon = 'icons/turf/areas.dmi'
	icon_state = "yellow"

/area/desert_dam/building/substation/west
	name = "指挥变电站"
	icon_state = "western_ss"
	linked_lz = DROPSHIP_LZ2

//Administration
/area/desert_dam/building/administration
	minimap_color = MINIMAP_AREA_COMMAND

/area/desert_dam/building/administration/control_room
	name = "行政着陆控制室"
	icon_state = "yellow"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/lobby
	name = "行政大厅"
	icon_state = "green"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/hallway
	name = "行政走廊"
	icon_state = "purple"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/office
	name = "行政办公室"
	icon_state = "blue-red"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/overseer_office
	name = "行政主管办公室"
	icon_state = "red"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/meetingrooom
	name = "行政会议室"
	icon_state = "yellow"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/archives
	name = "行政档案室"
	icon_state = "green"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/gate
	name = "行政离港闸口"
	icon_state = "purple"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/breakroom
	name = "行政休息室"
	icon_state = "yellow"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/stairwell
	name = "行政楼梯间"
	icon_state = "purple"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/stairwell/upper
	name = "行政上层楼梯间"

/area/desert_dam/building/administration/upper_hallway
	name = "行政上层走廊"
	icon_state = "purple"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/panic_room
	name = "行政部安全屋"
	icon_state = "blue"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/janitor
	name = "行政部清洁间"
	icon_state = "blue"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/maint
	name = "行政部维护区"
	icon_state = "yellow"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/building/administration/balcony
	name = "行政部阳台"
	icon_state = "yellow"
	linked_lz = DROPSHIP_LZ1
	ceiling = CEILING_NONE


//Bar
/area/desert_dam/building/bar/bar
	name = "酒吧"
	icon_state = "yellow"

/area/desert_dam/building/bar/backroom
	name = "酒吧后室"
	icon_state = "green"

/area/desert_dam/building/bar/bar_restroom
	name = "酒吧洗手间"
	icon_state = "purple"


//Cafe
/area/desert_dam/building/cafeteria
	name = "请勿使用"
	icon_state = "purple"
	unoviable_timer = FALSE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/desert_dam/building/cafeteria/cafeteria
	name = "食堂"
	icon_state = "yellow"

/area/desert_dam/building/cafeteria/backroom
	name = "食堂后室"
	icon_state = "green"

/area/desert_dam/building/cafeteria/loading
	name = "食堂装卸室"
	icon_state = "blue-red"

/area/desert_dam/building/cafeteria/cold_room
	name = "食堂冷藏室"
	icon_state = "red"


//Dorms
/area/desert_dam/building/dorms
	name = "请勿使用"
	icon_state = "purple"
	unoviable_timer = FALSE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/desert_dam/building/dorms/hallway_northwing
	name = "宿舍北翼"
	icon_state = "yellow"

/area/desert_dam/building/dorms/hallway_westwing
	name = "宿舍西翼"
	icon_state = "green"

/area/desert_dam/building/dorms/restroom
	name = "宿舍淋浴间"
	icon_state = "blue-red"

/area/desert_dam/building/dorms/pool
	name = "宿舍台球室"
	icon_state = "red"


//Medical
/area/desert_dam/building/medical
	minimap_color = MINIMAP_AREA_MEDBAY
	unoviable_timer = FALSE

/area/desert_dam/building/medical/garage
	name = "医疗车库"
	icon_state = "garage"

/area/desert_dam/building/medical/emergency_room
	name = "医疗急诊室"
	icon_state = "medbay"

/area/desert_dam/building/medical/helipad_triage
	name = "医疗停机坪接诊处"
	icon_state = "medbay"

/area/desert_dam/building/medical/outgoing
	name = "医疗转出区"
	icon_state = "medbay2"

/area/desert_dam/building/medical/lobby
	name = "医疗大厅"
	icon_state = "medbay3"

/area/desert_dam/building/medical/chemistry
	name = "医疗药房"
	icon_state = "medbay"

/area/desert_dam/building/medical/west_wing_hallway
	name = "医疗西翼"
	icon_state = "medbay2"

/area/desert_dam/building/medical/north_wing_hallway
	name = "医疗北翼"
	icon_state = "medbay3"

/area/desert_dam/building/medical/east_wing_hallway
	name = "医疗东翼"
	icon_state = "medbay"

/area/desert_dam/building/medical/upper_hallway
	name = "医疗区上层翼区"
	icon_state = "medbay"

/area/desert_dam/building/medical/stairwell
	name = "医疗区南侧楼梯间"
	icon_state = "medbay2"

/area/desert_dam/building/medical/stairwell/north
	name = "医疗区北侧楼梯间"
	icon_state = "medbay2"

/area/desert_dam/building/medical/stairwell/upper
	name = "医疗区上层南侧楼梯间"
	icon_state = "medbay2"

/area/desert_dam/building/medical/stairwell/upper_north
	name = "医疗区上层北侧楼梯间"
	icon_state = "medbay2"

/area/desert_dam/building/medical/primary_storage
	name = "医疗区主储藏室"
	icon_state = "red"

/area/desert_dam/building/medical/surgery_room_one
	name = "医疗区一号手术室"
	icon_state = "yellow"

/area/desert_dam/building/medical/surgery_room_two
	name = "医疗区二号手术室"
	icon_state = "purple"

/area/desert_dam/building/medical/surgury_observation
	name = "医疗区手术观察室"
	icon_state = "medbay2"

/area/desert_dam/building/medical/morgue
	name = "医疗区停尸房"
	icon_state = "blue"

/area/desert_dam/building/medical/break_room
	name = "医疗区休息室"
	icon_state = "medbay"

/area/desert_dam/building/medical/CMO
	name = "医疗区首席医官办公室"
	icon_state = "CMO"

/area/desert_dam/building/medical/office1
	name = "医疗区一号办公室"
	icon_state = "red"

/area/desert_dam/building/medical/office2
	name = "医疗区二号办公室"
	icon_state = "blue"

/area/desert_dam/building/medical/office3
	name = "医疗区共享办公室"
	icon_state = "blue"

/area/desert_dam/building/medical/virology_wing
	name = "医疗区病毒学翼区"
	icon_state = "medbay3"

/area/desert_dam/building/medical/virology_isolation
	name = "医疗区病毒学隔离室"
	icon_state = "medbay"

/area/desert_dam/building/medical
	name = "医疗区"
	icon_state = "medbay2"

/area/desert_dam/building/medical/maint
	name = "维护通道"
	icon_state = "yellow"

/area/desert_dam/building/medical/maint/north
	name = "医疗区北侧维护通道"

/area/desert_dam/building/medical/maint/south
	name = "医疗区南侧维护通道"

/area/desert_dam/building/medical/maint/east
	name = "医疗区东侧维护通道"

/area/desert_dam/building/medical/maint/cent
	name = "医疗区中央维护通道"

//Warehouse
/area/desert_dam/building/warehouse/warehouse
	name = "仓库"
	icon_state = "yellow"
	linked_lz = DROPSHIP_LZ2

/area/desert_dam/building/warehouse/loading
	name = "仓库装卸室"
	icon_state = "red"
	linked_lz = DROPSHIP_LZ2

/area/desert_dam/building/warehouse/breakroom
	name = "仓库休息室"
	icon_state = "green"
	linked_lz = DROPSHIP_LZ2

/area/desert_dam/building/warehouse/office
	name = "仓库监控办公室"
	icon_state = "green"
	linked_lz = DROPSHIP_LZ2


//Hydroponics
/area/desert_dam/building/hydroponics
	minimap_color = MINIMAP_AREA_RESEARCH

/area/desert_dam/building/hydroponics/hydroponics
	name = "水培区"
	icon_state = "hydro"

/area/desert_dam/building/hydroponics/hydroponics_storage
	name = "水培储藏室"
	icon_state = "green"

/area/desert_dam/building/hydroponics/hydroponics_loading
	name = "水培装卸室"
	icon_state = "garage"

/area/desert_dam/building/hydroponics/hydroponics_breakroom
	name = "水培休息室"
	icon_state = "red"

/area/desert_dam/building/hydroponics/stairwell
	name = "水培楼梯间"
	icon_state = "purple"

/area/desert_dam/building/hydroponics/maint
	name = "水培维护室"
	icon_state = "yellow"

/area/desert_dam/building/hydroponics/growroom
	name = "水培上层储藏室"
	icon_state = "green"

/area/desert_dam/building/hydroponics/offices
	name = "水培办公室"
	icon_state = "bluenew"

/area/desert_dam/building/hydroponics/walkway
	name = "水培通道"
	icon_state = "yellow"

//Water Treatment Plant 1
/area/desert_dam/building/water_treatment_one
	minimap_color = MINIMAP_AREA_ENGI

/area/desert_dam/building/water_treatment_one
	name = "一号水处理厂"
	icon_state = "yellow"

//Water Treatment Plant 1
/area/desert_dam/building/water_treatment_one/lobby
	name = "一号水处理厂大厅"
	icon_state = "red"

/area/desert_dam/building/water_treatment_one/breakroom
	name = "一号水处理厂休息室"
	icon_state = "green"

/area/desert_dam/building/water_treatment_one/garage
	name = "一号水处理厂车库"
	icon_state = "garage"

/area/desert_dam/building/water_treatment_one/equipment
	name = "一号水处理厂设备间"
	icon_state = "red"

/area/desert_dam/building/water_treatment_one/hallway
	name = "一号水处理厂走廊"
	icon_state = "purple"

/area/desert_dam/building/water_treatment_one/control_room
	name = "一号水处理厂控制室"
	icon_state = "yellow"

/area/desert_dam/building/water_treatment_one/overlook
	name = "一号水处理厂观察室"
	icon_state = "yellow"

/area/desert_dam/building/water_treatment_one/purification
	name = "一号水处理厂净化室"
	icon_state = "green"

/area/desert_dam/building/water_treatment_one/floodgate_control
	name = "一号水处理厂水闸控制室"
	icon_state = "green"

//Water Treatment Plant 2
/area/desert_dam/building/water_treatment_two
	minimap_color = MINIMAP_AREA_ENGI
	unoviable_timer = FALSE

/area/desert_dam/building/water_treatment_two
	name = "二号水处理厂"
	icon_state = "yellow"

/area/desert_dam/building/water_treatment_two/lobby
	name = "二号水处理厂大厅"
	icon_state = "red"

/area/desert_dam/building/water_treatment_two/equipment
	name = "二号水处理厂设备间"
	icon_state = "red"

/area/desert_dam/building/water_treatment_two/hallway
	name = "二号水处理厂走廊"
	icon_state = "purple"

/area/desert_dam/building/water_treatment_two/control_room
	name = "水处理二区控制室"
	icon_state = "yellow"

/area/desert_dam/building/water_treatment_two/overlook
	name = "水处理二区观察室"
	icon_state = "yellow"

/area/desert_dam/building/water_treatment_two/purification
	name = "水处理二区净化室"
	icon_state = "green"

/area/desert_dam/building/water_treatment_two/floodgate_control
	name = "水处理二区泄洪闸控制室"
	icon_state = "green"

/area/desert_dam/building/water_treatment_two/floodgate_control/lobby
	name = "水处理二区泄洪闸控制大厅"


//Library UNUSED
/*
/area/desert_dam/building/library/library
	name = "图书馆"
	icon_state = "library"
/area/desert_dam/building/library/restroom
	name = "图书馆洗手间"
	icon_state = "green"
/area/desert_dam/building/library/studyroom
	name = "图书馆自习室"
	icon_state = "purple"
*/

//Security
/area/desert_dam/building/security
	minimap_color = MINIMAP_AREA_SEC

/area/desert_dam/building/security/prison
	name = "安保监狱"
	icon_state = "sec_prison"

/area/desert_dam/building/security/marshals_office
	name = "安保主管办公室"
	icon_state = "sec_hos"

/area/desert_dam/building/security/armory
	name = "安保军械库"
	icon_state = "armory"

/area/desert_dam/building/security/warden
	name = "安保典狱长办公室"
	icon_state = "Warden"

/area/desert_dam/building/security/interrogation
	name = "安保审讯室"
	icon_state = "interrogation"

/area/desert_dam/building/security/observation
	name = "安保观察室"
	icon_state = "observatory"

/area/desert_dam/building/security/detective
	name = "安保侦探办公室"
	icon_state = "detective"

/area/desert_dam/building/security/office
	name = "安保办公室"
	icon_state = "yellow"

/area/desert_dam/building/security/lobby
	name = "安保大厅"
	icon_state = "green"

/area/desert_dam/building/security/northern_hallway
	name = "安保北走廊"
	icon_state = "purple"

/area/desert_dam/building/security/courtroom
	name = "安保法庭"
	icon_state = "courtroom"

/area/desert_dam/building/security/evidence
	name = "安保证物室"
	icon_state = "red"

/area/desert_dam/building/security/holding
	name = "安保拘留室"
	icon_state = "yellow"

/area/desert_dam/building/security/southern_hallway
	name = "安保南走廊"
	icon_state = "green"

/area/desert_dam/building/security/deathrow
	name = "安保死囚区"
	icon_state = "cells_max_n"

/area/desert_dam/building/security/execution_chamber
	name = "安保行刑室"
	icon_state = "red"

/area/desert_dam/building/security/staffroom
	name = "安保员工休息室"
	icon_state = "security"

/area/desert_dam/building/security/maint
	name = "安保维护区"
	icon_state = "yellow"

/area/desert_dam/building/security/maint/north
	name = "安保北部维护区"

/area/desert_dam/building/security/maint/South
	name = "安保南部维护区"

/area/desert_dam/building/security/maint/north
	name = "安保北部维护区"

/area/desert_dam/building/security/maint/west
	name = "安保西部维护区"

/area/desert_dam/building/security/maint/east
	name = "安保东部维护区"

/area/desert_dam/building/security/maint/central
	name = "安保中央维护区"

/area/desert_dam/building/security/stairwell
	name = "安保楼梯间"
	icon_state = "purple"

/area/desert_dam/building/security/stairwell/upper
	name = "安保上层楼梯间"

/area/desert_dam/building/security/workshop
	name = "安保工坊"
	icon_state = "yellow"

/area/desert_dam/building/security/riot_armory
	name = "安保防暴军械库"
	icon_state = "armory"

/area/desert_dam/building/security/waiting
	name = "安保探访等候区"
	icon_state = "green"

/area/desert_dam/building/security/yard
	name = "安保娱乐场"
	icon_state = "red"

/area/desert_dam/building/security/upper_hallway
	name = "安保上层走廊"
	icon_state = "purple"

/area/desert_dam/building/security/break_room
	name = "安保休息室"
	icon_state = "red"

//Church
/area/desert_dam/building/church
	name = "教堂"
	icon_state = "courtroom"
	linked_lz = DROPSHIP_LZ2

//Mining area
/area/desert_dam/building/mining
	name = "请勿使用"
	icon_state = "purple"
	unoviable_timer = FALSE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/desert_dam/building/mining/workshop
	name = "采矿工坊"
	icon_state = "yellow"

/area/desert_dam/building/mining/workshop_foyer
	name = "采矿工坊前厅"
	icon_state = "purple"

//NorthWest Lab Buildings
/area/desert_dam/building/lab_northwest
	minimap_color = MINIMAP_AREA_RESEARCH

/area/desert_dam/building/lab_northwest/west_lab_xenoflora
	name = "西部实验室-异星植物区"
	icon_state = "purple"

//EXTERIOR
//under open sky
/area/desert_dam/exterior
	requires_power = 1
	always_unpowered = 1
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE

	//ambience = list('sound/ambience/ambiatm1.ogg')

/area/desert_dam/exterior/rock //OOB
	name = "岩石区"
	icon_state = "cave"
	ceiling = CEILING_DEEP_UNDERGROUND

/area/desert_dam/exterior/rock/level1
	name = "下层岩石区"

/area/desert_dam/exterior/rock/level3
	name = "上层岩石区"

/area/desert_dam/exterior/rock/level4
	name = "山岩区"

/area/desert_dam/exterior/rock/level5
	name = "上层山岩区"

/area/desert_dam/exterior/roof
	name = "下层屋顶"
	always_unpowered = 1
	icon_state = "dark128"

/area/desert_dam/exterior/roof/level4
	name = "上层屋顶"

//Landing Pad for the Alamo. THIS IS NOT THE SHUTTLE AREA
/area/desert_dam/exterior/landing_pad_one
	name = "简易机场着陆坪"
	icon_state = "landing_pad"
	linked_lz = DROPSHIP_LZ1
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	always_unpowered = FALSE
	power_light = TRUE
	power_equip = TRUE
	power_environ = TRUE

//Landing Pad for the Normandy. THIS IS NOT THE SHUTTLE AREA
/area/desert_dam/exterior/landing_pad_two
	name = "航空站着陆坪"
	icon_state = "landing_pad"
	linked_lz = DROPSHIP_LZ2
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	always_unpowered = FALSE
	power_light = TRUE
	power_equip = TRUE
	power_environ = TRUE

//Valleys
//Near LZ
//TODO: incorporate valleys and substrations for floodlight coverage

/area/desert_dam/exterior/valley
	name = "山谷"
	icon_state = "red"

/area/desert_dam/exterior/valley/valley_northwest
	name = "西北山谷"
	icon_state = "valley_north_west"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/exterior/valley/valley_cargo
	name = "货运山谷"
	icon_state = "valley_south_west"
	linked_lz = DROPSHIP_LZ2

/area/desert_dam/exterior/valley/valley_telecoms
	name = "电信山谷"
	icon_state = "valley_west"
	linked_lz = DROPSHIP_LZ2

/area/desert_dam/exterior/valley/valley_security
	name = "安保山谷"
	icon_state = "valley_west"

// Generic bridge used in nightmare inserts... Can in fact be different places (sigh)
/area/desert_dam/exterior/valley/valley_bridge
	name = "山谷桥梁"
	icon_state = "valley"

//telecomms areas
/area/desert_dam/exterior/telecomm
	name = "\improper Trijent Dam Communications Relay"
	icon_state = "ass_line"
	ceiling_muffle = FALSE
	base_muffle = MUFFLE_LOW
	always_unpowered = 0

/area/desert_dam/exterior/telecomm/lz2_containers
	name = "\improper Containers Communications Relay"
	linked_lz = DROPSHIP_LZ2

/area/desert_dam/exterior/telecomm/lz2_tcomms
	name = "\improper Telecomms Communications Relay"
	linked_lz = DROPSHIP_LZ2


/area/desert_dam/exterior/telecomm/lz2_storage
	name = "\improper East LZ2 Communications Relay"
	linked_lz = DROPSHIP_LZ2


/area/desert_dam/exterior/telecomm/lz1_south
	name = "\improper South LZ1 Communications Relay"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/exterior/telecomm/lz1_valley
	name = "\improper LZ1 Valley Communications Relay"
	linked_lz = DROPSHIP_LZ1

/area/desert_dam/exterior/telecomm/lz1_xenoflora
	name = "\improper Xenoflora Communications Relay"
	linked_lz = DROPSHIP_LZ1

//Away from LZ

/area/desert_dam/exterior/valley/valley_labs
	name = "实验室山谷"
	icon_state = "valley_north"

/area/desert_dam/exterior/valley/valley_mining
	name = "采矿山谷"
	icon_state = "valley_east"
	unoviable_timer = FALSE

/area/desert_dam/exterior/valley/valley_civilian
	name = "平民山谷"
	icon_state = "valley_south_excv"
	unoviable_timer = FALSE
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/desert_dam/exterior/valley/valley_medical
	name = "医疗山谷"
	icon_state = "valley"
	unoviable_timer = FALSE

/area/desert_dam/exterior/valley/valley_hydro
	name = "水培山谷"
	icon_state = "valley"

/area/desert_dam/exterior/valley/valley_crashsite
	name = "坠机点山谷"
	icon_state = "yellow"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/desert_dam/exterior/valley/north_valley_dam
	name = "北坝山谷"
	icon_state = "valley"

/area/desert_dam/exterior/valley/south_valley_dam
	name = "南坝山谷"
	icon_state = "valley"

/area/desert_dam/exterior/valley/bar_valley_dam
	name = "酒吧山谷"
	icon_state = "yellow"

/area/desert_dam/exterior/valley/valley_wilderness
	name = "荒野山谷"
	icon_state = "central"

//Rivers
/area/desert_dam/exterior/river
	name = "河流"
	icon_state = "bluenew"
	var/filtered = 0
	var/list/Next_areas = list()//The next river to update - that is, unless...
	var/obj/structure/machinery/console/toggle/Floodgate = null //If there's a floodgate at the end of us, this is it's ID

/area/desert_dam/exterior/river/proc/check_filtered()
	var/turf/open/gm/river/desert/R
	if(filtered)
		for(R in src)
			R.toxic = 0
	else
		for(R in src)
			R.toxic = 1
	R.update_icon()
	if(Next_areas && !(src in Next_areas)) //Shouldn't ever happen but just to be safe
		for(var/area/desert_dam/exterior/river/A in Next_areas)
			A.check_filtered()


//End of the river areas, no Next
/area/desert_dam/exterior/river/riverside_central_north
	name = "中北部河床"
	icon_state = "purple"

/area/desert_dam/exterior/river/riverside_central_south
	name = "中南部河床"
	icon_state = "purple"

/area/desert_dam/exterior/river/riverside_south
	name = "南部河床"
	icon_state = "bluenew"

/area/desert_dam/exterior/river/riverside_east
	name = "东部河床"
	icon_state = "bluenew"

//The filtration plants - This area isn't for the WHOLE plant, but the areas that have water in them, so the water changes color as well.

/area/desert_dam/exterior/river/filtration_a
	name = "过滤厂A"

//Areas that are rivers, but will not change because they're before the floodgates
/area/desert_dam/exterior/river_mouth/southern
	name = "南部河口"
	icon_state = "purple"

/area/desert_dam/landing/console
	name = "LZ1 '管理区'"
	icon_state = "tcomsatcham"
	requires_power = 0

/area/desert_dam/landing/console2
	name = "LZ2 '补给区'"
	icon_state = "tcomsatcham"
	requires_power = 0


//Transit Shuttle
/area/shuttle/tri_trans1/alpha
	icon_state = "shuttle"

/area/shuttle/tri_trans1/away
	icon_state = "away1"

/area/shuttle/tri_trans1/omega
	icon_state = "shuttle2"

/area/shuttle/tri_trans2/alpha
	icon_state = "shuttlered"

/area/shuttle/tri_trans2/away
	icon_state = "away2"

/area/shuttle/tri_trans2/omega
	icon_state = "shuttle2"
