//ROSTOCK AREAS (Different to Almayer)--------------------------------------//
// Fore = East  | Aft = West //
// Port = North | Starboard = South //
// Bow = Eastern |Stern = Western //(those are the front and back small sections)
// Naming convention is to start by port or starboard then put eitheir (bow,fore,midship,aft,stern)

/area/rostock
	name = "SSV罗斯托克号"
	icon = 'icons/turf/area_almayer.dmi'
	// ambience = list('sound/ambience/shipambience.ogg')
	icon_state = "almayer"
	flags_area = AREA_NOBURROW
//	requires_power = TRUE
//	unlimited_power = TRUE
	ceiling = CEILING_METAL
	powernet_name = "rostock"
	sound_environment = SOUND_ENVIRONMENT_ROOM
	soundscape_interval = 30
	// soundscape_playlist = list('sound/effects/xylophone1.ogg', 'sound/effects/xylophone2.ogg', 'sound/effects/xylophone3.ogg')
	ambience_exterior = AMBIENCE_ALMAYER
	ceiling_muffle = FALSE

// Upper Deck Misc
/area/rostock/upper_deck
	fake_zlevel = 1 // upperdeck

/area/rostock/upper_deck/hallway
	name = "SSV罗斯托克号 - 上层甲板中部走廊"
	icon_state = "stern"

// Hanger Deck

/area/rostock/hangar
	fake_zlevel = 1 // upperdeck

/area/rostock/hangar/hangarbay
	name = "SSV罗斯托克号 - 机库"
	icon_state = "hangar"
	soundscape_playlist = SCAPE_PL_HANGAR
	soundscape_interval = 50

/area/rostock/hangar/pilotbunk
	name = "SSV罗斯托克号 - 飞行员冷冻舱"
	icon_state = "livingspace"

/area/rostock/hangar/repairbay
	name = "SSV罗斯托克号 - 运输机维修舱"
	icon_state = "dropshiprepair"

// Medical Deck (Upper/Lower)

/area/rostock/medical

/area/rostock/medical/lobby
	name = "SSV罗斯托克号 - 医疗舱大厅"
	icon_state = "medical"
	fake_zlevel = 1 // upperdeck
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC
	soundscape_interval = 120

/area/rostock/medical/storage
	name = "SSV罗斯托克号 - 部署物资仓库"
	icon_state = "medical"
	fake_zlevel = 1 // upperdeck
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC
	soundscape_interval = 120

/area/rostock/medical/surgery
	name = "SSV罗斯托克号 - 手术室"
	icon_state = "operating"
	fake_zlevel = 1 // upperdeck
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC
	soundscape_interval = 120

/area/rostock/medical/chemistry
	name = "SSV罗斯托克号 - 化学实验室"
	icon_state = "chemistry"
	fake_zlevel = 1 // upperdeck
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC
	soundscape_interval = 120

/area/rostock/medical/accessway
	name = "SSV罗斯托克号 - 后部走廊"
	icon_state = "medical"
	fake_zlevel = 1 // upperdeck
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC
	soundscape_interval = 120

/area/rostock/medical/prep
	name = "SSV罗斯托克号 - 医疗准备室"
	icon_state = "medical"
	fake_zlevel = 2 // lowerdeck
	soundscape_playlist = SCAPE_PL_ELEVATOR_MUSIC
	soundscape_interval = 120

/area/rostock/medical/morgue
	name = "SSV罗斯托克号 - 停尸房"
	icon_state = "medical"
	fake_zlevel = 2 // lowerdeck

// Military Police Deck (Upper/Lower)

/area/rostock/security

/area/rostock/security/brig_accessway
	name = "SSV罗斯托克号 - 禁闭室通道"
	icon_state = "brig"
	fake_zlevel = 1 //upperdeck

/area/rostock/security/brig_entryway
	name = "SSV罗斯托克号 - 禁闭室观察区"
	icon_state = "brig"
	fake_zlevel = 1 //upperdeck

/area/rostock/security/brig_holding_area
	name = "SSV罗斯托克号 - 囚犯关押区"
	icon_state = "brigcells"
	fake_zlevel = 1 //upperdeck

/area/rostock/security/execution_room
	name = "SSV罗斯托克号 - 处决室"
	icon_state = "brigcells"
	fake_zlevel = 1 //upperdeck

/area/rostock/security/execution_storage
	name = "SSV罗斯托克号 - 处决物品储藏室"
	icon_state = "brigcells"
	fake_zlevel = 1 //upperdeck

/area/rostock/security/brig_office
	name = "SSV罗斯托克号 - 禁闭室办公室"
	icon_state = "brig"
	fake_zlevel = 1 //upperdeck

/area/rostock/security/headquarters_lobby
	name = "SSV罗斯托克号 - 警察总局大厅"
	icon_state = "brig"
	fake_zlevel = 2 //upperdeck

/area/rostock/security/headquarters_interrogation
	name = "SSV 罗斯托克号 - 审讯室"
	icon_state = "brig"
	fake_zlevel = 2 //upperdeck

/area/rostock/security/headquarters_bunk
	name = "SSV 罗斯托克号 - 警察宿舍"
	icon_state = "brig"
	fake_zlevel = 2 //upperdeck

/area/rostock/security/headquarters_storage
	name = "SSV 罗斯托克号 - 警察装备库"
	icon_state = "brig"
	fake_zlevel = 2 //upperdeck

/area/rostock/security/headquarters_armory
	name = "SSV 罗斯托克号 - 警察军械库"
	icon_state = "brig"
	fake_zlevel = 2 //upperdeck

// Vehicle Storage

/area/rostock/vehiclehangar
	name = "SSV 罗斯托克号 - 载具机库"
	icon_state = "exoarmor"
	fake_zlevel = 2 //upperdeck

// Engineering Deck

/area/rostock/engineering

/area/rostock/engineering/main_area
	name = "SSV 罗斯托克号 - 工程部"
	icon_state = "upperengineering"
	fake_zlevel = 1 //upperdeck

/area/rostock/engineering/reactor
	name = "SSV 罗斯托克号 - 反应堆核心"
	icon_state = "upperengineering"
	fake_zlevel = 1 //upperdeck

/area/rostock/engineering/lower_aft_corridor
	name = "SSV 罗斯托克号 - 上层船尾入口走廊"
	icon_state = "upperengineering"
	fake_zlevel = 1 //upperdeck

/area/rostock/engineering/port_aft_accessway
	name = "SSV 罗斯托克号 - 左舷船尾通道"
	icon_state = "upperengineering"
	fake_zlevel = 1 //upperdeck

/area/rostock/engineering/starboard_aft_accessway
	name = "SSV 罗斯托克号 - 右舷船尾通道"
	icon_state = "upperengineering"
	fake_zlevel = 1 //upperdeck

// Upperdeck Maintenance

/area/rostock/upperdeck_maint
	fake_zlevel = 1 //upperdeck

/area/rostock/upperdeck_maint/p_a
	name = "SSV 罗斯托克号 - 上层左舷-船尾维护区"
	icon_state = "upperhull"

/area/rostock/upperdeck_maint/p_m
	name = "SSV 罗斯托克号 - 上层左舷-船中维护区"
	icon_state = "upperhull"

/area/rostock/upperdeck_maint/p_f
	name = "SSV 罗斯托克号 - 上层左舷-船首维护区"
	icon_state = "upperhull"

/area/rostock/upperdeck_maint/s_a
	name = "SSV 罗斯托克号 - 上层右舷-船尾维护区"
	icon_state = "upperhull"

/area/rostock/upperdeck_maint/s_m
	name = "SSV 罗斯托克号 - 上层右舷-船中维护区"
	icon_state = "upperhull"

/area/rostock/upperdeck_maint/s_f
	name = "SSV 罗斯托克号 - 上层右舷-船首维护区"
	icon_state = "upperhull"

// ERT Docking Ports

/area/rostock/ert_dock

/area/rostock/ert_dock/port
	name = "SSV 罗斯托克号 - 左舷紧急对接舱"
	icon_state = "starboardpd"
	fake_zlevel = 1 // upperdeck

/area/rostock/ert_dock/starboard
	name = "SSV 罗斯托克号 - 右舷紧急对接舱"
	icon_state = "starboardpd"
	fake_zlevel = 1 // upperdeck

// Stairs
/area/rostock/stair_clone
	name = "SSV 罗斯托克号 - 下层甲板楼梯"
	icon_state = "stairs_lowerdeck"
	fake_zlevel = 2 // lowerdeck
	resin_construction_allowed = FALSE
	requires_power = FALSE

/area/rostock/stair_clone/upper
	name = "SSV 罗斯托克号 - 上层甲板楼梯"
	icon_state = "stairs_upperdeck"
	fake_zlevel = 1 // upperdeck

// Command

/area/rostock/command

/area/rostock/command/astronavigation
	name = "SSV 罗斯托克号 - 天文导航甲板"
	icon_state = "astronavigation"
	fake_zlevel = 2 // lowerdeck

/area/rostock/command/cic
	name = "SSV 罗斯托克号 - 作战信息中心"
	icon_state = "cic"
	fake_zlevel = 2 // lowerdeck
	soundscape_playlist = SCAPE_PL_CIC
	soundscape_interval = 50
	flags_area = AREA_NOBURROW

/area/rostock/command/armory
	name = "SSV 罗斯托克号 - 指挥军械库"
	icon_state = "cic"
	fake_zlevel = 2 // lowerdeck

/area/rostock/command/hallway
	name = "SSV 罗斯托克号 - 指挥走廊"
	icon_state = "cic"
	fake_zlevel = 2 // lowerdeck

/area/rostock/command/dining
	name = "SSV 罗斯托克号 - 指挥餐厅"
	icon_state = "cic"
	fake_zlevel = 2 // lowerdeck

/area/rostock/command/co
	name = "SSV 罗斯托克号 - 指挥官舱室"
	icon_state = "officerrnr"
	fake_zlevel = 2 // lowerdeck

/area/rostock/command/xo
	name = "SSV 罗斯托克号 - 舰长舱室"
	icon_state = "officerrnr"
	fake_zlevel = 2 // lowerdeck

/area/rostock/command/polcom
	name = "SSV 罗斯托克号 - 政委舱室"
	icon_state = "officerrnr"
	fake_zlevel = 2 // lowerdeck

/area/rostock/command/so
	name = "SSV 罗斯托克号 - 参谋军官铺位"
	icon_state = "officerrnr"
	fake_zlevel = 2 // lowerdeck

// Lower Deck Misc

/area/rostock/lower_deck
	fake_zlevel = 2 // lowerdeck

/area/rostock/lower_deck/m_hallway
	name = "SSV 罗斯托克号 - 下层甲板中部走廊"
	icon_state = "stern"

/area/rostock/lower_deck/p_hallway
	name = "SSV 罗斯托克号 - 下层甲板左舷走廊"
	icon_state = "port"

/area/rostock/lower_deck/s_a_hallway
	name = "SSV 罗斯托克号 - 下层甲板右舷-后部走廊"
	icon_state = "starboard"

/area/rostock/lower_deck/p_a_hallway
	name = "SSV 罗斯托克号 - 下层甲板左舷-后部走廊"
	icon_state = "port"

/area/rostock/lower_deck/engineering_lower_access
	name = "SSV 罗斯托克号 - 下层甲板工程部右舷后部通道"
	icon_state = "port"

/area/rostock/lower_deck/cryogenics
	name = "SSV 罗斯托克号 - 低温休眠舱"
	icon_state = "cryo"

/area/rostock/lower_deck/prep
	name = "SSV 罗斯托克号 - 部队准备区"
	icon_state = "gruntrnr"

/area/rostock/lower_deck/bunk
	name = "SSV 罗斯托克号 - 长期任务铺位"
	icon_state = "gruntrnr"

/area/rostock/lower_deck/kitchen
	name = "SSV 罗斯托克号 - 餐厅"
	icon_state = "gruntrnr"

/area/rostock/lower_deck/bathroom
	name = "SSV 罗斯托克号 - 无性别卫生间"
	icon_state = "missionplanner"

/area/rostock/lower_deck/ammunition_storage
	name = "SSV 罗斯托克号 - 重型军械库"
	icon_state = "missionplanner"

/area/rostock/lower_deck/briefing
	name = "SSV 罗斯托克号 - 简报厅"
	icon_state = "briefing"

/area/rostock/lower_deck/starboard_umbilical
	name = "\improper Lower Deck Starboard Umbilical Hallway"
	icon_state = "portumbilical"

// Lower Deck Maintenance

/area/rostock/lowerdeck_maint
	fake_zlevel = 2 //lowerdeck

/area/rostock/lowerdeck_maint/p_a
	name = "SSV 罗斯托克号 - 下层左舷-后部维护区"
	icon_state = "lowerhull"

/area/rostock/lowerdeck_maint/p_m
	name = "SSV 罗斯托克号 - 下层左舷-中部维护区"
	icon_state = "lowerhull"

/area/rostock/lowerdeck_maint/p_f
	name = "SSV 罗斯托克号 - 下层左舷-前部维护区"
	icon_state = "lowerhull"

/area/rostock/lowerdeck_maint/s_a
	name = "SSV 罗斯托克号 - 下层右舷-后部维护区"
	icon_state = "lowerhull"

/area/rostock/lowerdeck_maint/s_m
	name = "SSV 罗斯托克号 - 下层右舷-中部维护区"
	icon_state = "lowerhull"

/area/rostock/lowerdeck_maint/s_f
	name = "SSV 罗斯托克号 - 下层右舷-前部维护区"
	icon_state = "lowerhull"

// Railguns

/area/rostock/railgun
	name = "SSV 罗斯托克号 - 左舷磁轨炮控制室"
	icon_state = "weaponroom"

/area/rostock/railgun/starboard
	name = "SSV 罗斯托克号 - 右舷磁轨炮控制室"
	icon_state = "weaponroom"

// AI Core - 1VAN/3

/area/rostock/airoom
	name = "SSV 罗斯托克号 - AI核心"
	icon_state = "airoom"
	fake_zlevel = 2 // lowerdeck
	soundscape_playlist = SCAPE_PL_ARES
	soundscape_interval = 120
	flags_area = AREA_NOBURROW|AREA_UNWEEDABLE
	can_build_special = FALSE
	is_resin_allowed = FALSE
	resin_construction_allowed = FALSE

// Requisitions Bay

/area/rostock/req
	name = "SSV 罗斯托克号 - 补给处"
	icon_state = "req"
	fake_zlevel = 2 // lowerdeck

// Lifeboat

/area/rostock/lifeboat
	name = "SSV 罗斯托克号 - 救生艇对接舱口"
	icon_state = "selfdestruct"
	fake_zlevel = 2 // lowerdeck

