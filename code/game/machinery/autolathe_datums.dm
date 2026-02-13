/datum/autolathe/recipe
	var/name = "object"
	var/path
	var/list/resources
	var/hidden = FALSE
	var/category
	var/power_use = 0
	var/is_stack

/datum/autolathe/recipe/bucket
	name = "bucket"
	path = /obj/item/reagent_container/glass/bucket
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/mopbucket
	name = "拖把桶"
	path = /obj/item/reagent_container/glass/bucket/mopbucket
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/janibucket
	name = "清洁桶"
	path = /obj/item/reagent_container/glass/bucket/janibucket
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/flashlight
	name = "flashlight"
	path = /obj/item/device/flashlight
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/extinguisher
	name = "extinguisher"
	path = /obj/item/tool/extinguisher
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/crowbar
	name = "crowbar"
	path = /obj/item/tool/crowbar
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/multitool
	name = "multitool"
	path = /obj/item/device/multitool
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/t_scanner
	name = "T射线扫描仪"
	path = /obj/item/device/t_scanner
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/weldertool
	name = "blowtorch"
	path = /obj/item/tool/weldingtool/empty
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/screwdriver
	name = "screwdriver"
	path = /obj/item/tool/screwdriver
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/wirecutters
	name = "wirecutters"
	path = /obj/item/tool/wirecutters
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/wrench
	name = "wrench"
	path = /obj/item/tool/wrench
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/lightreplacer
	name = "灯泡更换器"
	path = /obj/item/device/lightreplacer/empty
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/mop
	name = "mop"
	path = /obj/item/tool/mop
	category = AUTOLATHE_CATEGORY_TOOLS

/datum/autolathe/recipe/radio_headset
	name = "无线电耳机"
	path = /obj/item/device/radio/headset
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/radio_bounced
	name = "短波无线电"
	path = /obj/item/device/radio/off
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/weldermask
	name = "焊接面罩"
	path = /obj/item/clothing/head/welding
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/metal
	name = "钢板"
	path = /obj/item/stack/sheet/metal
	category = AUTOLATHE_CATEGORY_GENERAL
	is_stack = 1

/datum/autolathe/recipe/glass
	name = "玻璃板"
	path = /obj/item/stack/sheet/glass
	category = AUTOLATHE_CATEGORY_GENERAL
	is_stack = 1

/datum/autolathe/recipe/rglass
	name = "强化玻璃板"
	path = /obj/item/stack/sheet/glass/reinforced
	category = AUTOLATHE_CATEGORY_GENERAL
	is_stack = 1

/datum/autolathe/recipe/rods
	name = "金属棒"
	path = /obj/item/stack/rods
	category = AUTOLATHE_CATEGORY_GENERAL
	is_stack = 1

/datum/autolathe/recipe/knife
	name = "厨刀"
	path = /obj/item/tool/kitchen/knife
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/taperecorder
	name = "磁带录音机"
	path = /obj/item/device/taperecorder
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/airlockmodule
	name = "气闸电子元件"
	path = /obj/item/circuitboard/airlock
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/firealarm
	name = "火警电子元件"
	path = /obj/item/circuitboard/firealarm
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/powermodule
	name = "电源控制模块"
	path = /obj/item/circuitboard/apc
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/table_parts
	name = "桌子零件"
	path = /obj/item/frame/table
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/table_parts_reinforced
	name = "加固桌部件"
	path = /obj/item/frame/table/reinforced
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/rack_parts
	name = "机架部件"
	path = /obj/item/frame/rack
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/scalpel
	name = "scalpel"
	path = /obj/item/tool/surgery/scalpel
	category = AUTOLATHE_CATEGORY_SURGERY

/datum/autolathe/recipe/circularsaw
	name = "圆锯"
	path = /obj/item/tool/surgery/circular_saw
	category = AUTOLATHE_CATEGORY_SURGERY

/datum/autolathe/recipe/surgicaldrill
	name = "手术钻"
	path = /obj/item/tool/surgery/surgicaldrill
	category = AUTOLATHE_CATEGORY_SURGERY

/datum/autolathe/recipe/retractor
	name = "retractor"
	path = /obj/item/tool/surgery/retractor
	category = AUTOLATHE_CATEGORY_SURGERY

/datum/autolathe/recipe/cautery
	name = "cautery"
	path = /obj/item/tool/surgery/cautery
	category = AUTOLATHE_CATEGORY_SURGERY

/datum/autolathe/recipe/hemostat
	name = "hemostat"
	path = /obj/item/tool/surgery/hemostat
	category = AUTOLATHE_CATEGORY_SURGERY

/datum/autolathe/recipe/beaker
	name = "玻璃烧杯"
	path = /obj/item/reagent_container/glass/beaker
	category = AUTOLATHE_CATEGORY_GLASSWARE

/datum/autolathe/recipe/beaker_large
	name = "大型玻璃烧杯"
	path = /obj/item/reagent_container/glass/beaker/large
	category = AUTOLATHE_CATEGORY_GLASSWARE

/datum/autolathe/recipe/drinkingglass
	name = "玻璃杯"
	path = /obj/item/reagent_container/food/drinks/drinkingglass
	category = AUTOLATHE_CATEGORY_GLASSWARE

/datum/autolathe/recipe/consolescreen
	name = "控制台屏幕"
	path = /obj/item/stock_parts/console_screen
	category = AUTOLATHE_CATEGORY_DEVICES_AND_COMPONENTS

/datum/autolathe/recipe/igniter
	name = "igniter"
	path = /obj/item/device/assembly/igniter
	category = AUTOLATHE_CATEGORY_DEVICES_AND_COMPONENTS

/datum/autolathe/recipe/signaller
	name = "signaller"
	path = /obj/item/device/assembly/signaller
	category = AUTOLATHE_CATEGORY_DEVICES_AND_COMPONENTS

/datum/autolathe/recipe/sensor_infra
	name = "红外传感器"
	path = /obj/item/device/assembly/infra
	category = AUTOLATHE_CATEGORY_DEVICES_AND_COMPONENTS

/datum/autolathe/recipe/timer
	name = "timer"
	path = /obj/item/device/assembly/timer
	category = AUTOLATHE_CATEGORY_DEVICES_AND_COMPONENTS

/datum/autolathe/recipe/sensor_prox
	name = "近程传感器"
	path = /obj/item/device/assembly/prox_sensor
	category = AUTOLATHE_CATEGORY_DEVICES_AND_COMPONENTS

/datum/autolathe/recipe/tube
	name = "灯管"
	path = /obj/item/light_bulb/tube
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/bulb
	name = "灯泡"
	path = /obj/item/light_bulb/bulb
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/ashtray_glass
	name = "玻璃烟灰缸"
	path = /obj/item/ashtray/glass
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/hand_labeler
	name = "手持标签机"
	path = /obj/item/tool/hand_labeler
	category = AUTOLATHE_CATEGORY_GENERAL

/datum/autolathe/recipe/camera_assembly
	name = "摄像头组件"
	path = /obj/item/frame/camera
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/matrix_frame
	name = "矩阵组件"
	path = /obj/item/frame/matrix_frame
	category = AUTOLATHE_CATEGORY_ENGINEERING

/datum/autolathe/recipe/electropack
	name = "electropack"
	path = /obj/item/device/radio/electropack
	hidden = TRUE
	category = AUTOLATHE_CATEGORY_DEVICES_AND_COMPONENTS

/datum/autolathe/recipe/handcuffs
	name = "handcuffs"
	path = /obj/item/restraint/handcuffs
	hidden = TRUE
	category = AUTOLATHE_CATEGORY_GENERAL

//Armylathe recipes
/datum/autolathe/recipe/armylathe

/datum/autolathe/recipe/armylathe/m40
	name = "M40手榴弹弹壳"
	path = /obj/item/explosive/grenade/custom
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/m15
	name = "M15手榴弹弹壳"
	path = /obj/item/explosive/grenade/custom/large
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/m20
	name = "M20地雷弹壳"
	path = /obj/item/explosive/mine/custom
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/c4
	name = "C4塑料弹壳"
	path = /obj/item/explosive/plastic/custom
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/rocket_tube
	name = "88毫米火箭发射管"
	path = /obj/item/ammo_magazine/rocket/custom
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/rocket_warhead
	name = "88毫米火箭弹头"
	path = /obj/item/explosive/warhead/rocket
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/mortar_shell
	name = "80毫米迫击炮弹"
	path = /obj/item/mortar_shell/custom
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/mortar_warhead
	name = "80毫米迫击炮弹头"
	path = /obj/item/explosive/warhead/mortar
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/mortar_camera_warhead
	name = "80毫米迫击炮摄像弹头"
	path = /obj/item/explosive/warhead/mortar/camera
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/flamer_tank
	name = "定制M240A1燃料罐"
	path = /obj/item/ammo_magazine/flamer_tank/custom
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/large_flamer_tank
	name = "定制M240-T燃料罐"
	path = /obj/item/ammo_magazine/flamer_tank/custom/large
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

/datum/autolathe/recipe/armylathe/smoke_tank
	name = "定制M240A1烟雾罐"
	path = /obj/item/ammo_magazine/flamer_tank/smoke
	category = AUTOLATHE_CATEGORY_EXPLOSIVES

//Medilathe recipes
/datum/autolathe/recipe/medilathe
	category = AUTOLATHE_CATEGORY_MEDICAL

/datum/autolathe/recipe/medilathe/syringe
	name = "syringe"
	path = /obj/item/reagent_container/syringe

/datum/autolathe/recipe/medilathe/dropper
	name = "dropper"
	path = /obj/item/reagent_container/dropper

/datum/autolathe/recipe/medilathe/spray
	name = "喷雾瓶"
	path = /obj/item/reagent_container/spray

/datum/autolathe/recipe/medilathe/autoinjector
	name = "自动注射器 (C-T) (5x3)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty
	category = AUTOLATHE_CATEGORY_INJECTORS

/datum/autolathe/recipe/medilathe/autoinjector/s15x3
	name = "自动注射器 (C-S) (15x3)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/small

/datum/autolathe/recipe/medilathe/autoinjector/s30x3
	name = "自动注射器 (C-M) (30x3)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/medium

/datum/autolathe/recipe/medilathe/autoinjector/s60x3
	name = "自动注射器 (C-L) (60x3)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/large

/datum/autolathe/recipe/medilathe/autoinjector/s1x1
	name = "EZ自动注射器 (E-U) (1x1)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/skillless/unit

/datum/autolathe/recipe/medilathe/autoinjector/s5x1
	name = "EZ自动注射器 (E-VS) (5x1)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/skillless/verysmall

/datum/autolathe/recipe/medilathe/autoinjector/s10x1
	name = "EZ自动注射器 (E-S) (10x1)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/skillless/small

/datum/autolathe/recipe/medilathe/autoinjector/s15x1
	name = "EZ自动注射器 (E-T) (15x1)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/skillless

/datum/autolathe/recipe/medilathe/autoinjector/s30x1
	name = "EZ自动注射器 (E-M) (30x1)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/skillless/medium

/datum/autolathe/recipe/medilathe/autoinjector/s45x1
	name = "EZ自动注射器 (E-L) (45x1)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/skillless/large

/datum/autolathe/recipe/medilathe/autoinjector/s60x1
	name = "EZ自动注射器 (E-XL) (60x1)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/skillless/extralarge

/datum/autolathe/recipe/medilathe/autoinjector/s15x6
	name = "医疗兵自动注射器 (M-M) (15x6)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/medic

/datum/autolathe/recipe/medilathe/autoinjector/s30x6
	name = "医疗兵自动注射器 (M-L) (30x6)"
	path = /obj/item/reagent_container/hypospray/autoinjector/empty/medic/large

/datum/autolathe/recipe/medilathe/hypospray
	name = "hypospray"
	path = /obj/item/reagent_container/hypospray

/datum/autolathe/recipe/medilathe/bloodpack
	name = "bloodpack"
	path = /obj/item/reagent_container/blood

/datum/autolathe/recipe/medilathe/bluespace
	name = "高容量烧杯"
	path = /obj/item/reagent_container/glass/beaker/bluespace

/datum/autolathe/recipe/medilathe/bonesetter
	name = "bonesetter"
	path = /obj/item/tool/surgery/bonesetter

/datum/autolathe/recipe/medilathe/fixovein
	name = "菲克索文"
	path = /obj/item/tool/surgery/FixOVein

/datum/autolathe/recipe/medilathe/cryobag
	name = "静滞袋"
	path = /obj/item/bodybag/cryobag

/datum/autolathe/recipe/medilathe/rollerbed
	name = "rollerbed"
	path = /obj/item/roller

/datum/autolathe/recipe/medilathe/pill_bottle
	name = "药瓶"
	path = /obj/item/storage/pill_bottle
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/firstaid_regular
	name = "急救包 (常规)"
	path = /obj/item/storage/firstaid/regular/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/firstaid_fire
	name = "急救包 (烧伤)"
	path = /obj/item/storage/firstaid/fire/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/firstaid_toxin
	name = "急救包 (毒素)"
	path = /obj/item/storage/firstaid/toxin/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/firstaid_oxy
	name = "急救包 (缺氧)"
	path = /obj/item/storage/firstaid/o2/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/firstaid_adv
	name = "急救包 (高级)"
	path = /obj/item/storage/firstaid/adv/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/firstaid_rad
	name = "急救包 (辐射)"
	path = /obj/item/storage/firstaid/rad/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/syringe_case
	name = "注射器盒"
	path = /obj/item/storage/syringe_case
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/surgical_case
	name = "手术箱"
	path = /obj/item/storage/surgical_case
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/vial_box
	name = "药瓶盒"
	path = /obj/item/storage/fancy/vials/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/surgical_tray
	name = "手术托盘"
	path = /obj/item/storage/surgical_tray/empty
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/pressurized_reagent_container
	name = "加压试剂罐包"
	path = /obj/item/storage/pouch/pressurized_reagent_canister
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/pressurized_canister
	name = "加压罐"
	path = /obj/item/reagent_container/glass/pressurized_canister
	category = AUTOLATHE_CATEGORY_MEDICAL_CONTAINERS

/datum/autolathe/recipe/medilathe/research_glasses
	name = "试剂扫描HUD护目镜"
	path = /obj/item/clothing/glasses/science
