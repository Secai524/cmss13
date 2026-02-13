//------------ENGINEERING VENDORS---------------

/obj/structure/machinery/cm_vending/sorted/tech
	name = "\improper 工程供应商"
	desc = "你不应该生成这个。"
	icon_state = "tool"
	unacidable = FALSE
	unslashable = FALSE
	wrenchable = TRUE
	hackable = TRUE
	req_one_access = list(ACCESS_MARINE_ENGINEERING, ACCESS_CIVILIAN_ENGINEERING)
	vendor_theme = VENDOR_THEME_COMPANY

/obj/structure/machinery/cm_vending/sorted/tech/tool_storage
	name = "\improper 工具 存储 机器"
	desc = "一台大型存储机，内含各种用于常规维修的工具和设备。"
	icon_state = "tool"

/obj/structure/machinery/cm_vending/sorted/tech/tool_storage/populate_product_list(scale)
	listed_products = list(
		list("装备", -1, null, null),
		list("战斗 手电筒", floor(scale * 2), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("安全帽", floor(scale * 2), /obj/item/clothing/head/hardhat, VENDOR_ITEM_REGULAR),
		list("绝缘手套", floor(scale * 2), /obj/item/clothing/gloves/yellow, VENDOR_ITEM_REGULAR),
		list("实用工具带", floor(scale * 2), /obj/item/storage/belt/utility, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", floor(scale * 2), /obj/item/clothing/glasses/welding, VENDOR_ITEM_REGULAR),
		list("焊接头盔", floor(scale * 2), /obj/item/clothing/head/welding, VENDOR_ITEM_REGULAR),
		list("工程师套件", floor(scale * 2), /obj/item/storage/toolkit/empty, VENDOR_ITEM_REGULAR),

		list("扫描仪", -1, null, null),
		list("大气 扫描仪", floor(scale * 2), /obj/item/device/analyzer, VENDOR_ITEM_REGULAR),
		list("爆破 扫描仪", floor(scale * 1), /obj/item/device/demo_scanner, VENDOR_ITEM_REGULAR),
		list("介子 扫描仪", floor(scale * 2), /obj/item/clothing/glasses/meson, VENDOR_ITEM_REGULAR),
		list("试剂 扫描仪", floor(scale * 2), /obj/item/device/reagent_scanner, VENDOR_ITEM_REGULAR),
		list("T射线扫描仪", floor(scale * 2), /obj/item/device/t_scanner, VENDOR_ITEM_REGULAR),

		list("工具", -1, null, null),
		list("喷灯", floor(scale * 4), /obj/item/tool/weldingtool, VENDOR_ITEM_REGULAR),
		list("撬棍", floor(scale * 4), /obj/item/tool/crowbar, VENDOR_ITEM_REGULAR),
		list("西格森 MCT", floor(scale * 2), /obj/item/tool/weldingtool/simple, VENDOR_ITEM_REGULAR),
		list("螺丝起子", floor(scale * 4), /obj/item/tool/screwdriver, VENDOR_ITEM_REGULAR),
		list("剪线钳", floor(scale * 4), /obj/item/tool/wirecutters, VENDOR_ITEM_REGULAR),
		list("扳手", floor(scale * 4), /obj/item/tool/wrench, VENDOR_ITEM_REGULAR),
		list("灯泡更换器", floor(scale * 4), /obj/item/device/lightreplacer, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/tech/comtech_tools
	name = "\improper 殖民地海军陆战队科技（ColMarTech） 小队通讯技术工具供应商"
	desc = "一台储存各种在战场上很有用的额外工具的贩卖机。"
	icon_state = "tool"
	req_access = list(ACCESS_MARINE_ENGPREP)

/obj/structure/machinery/cm_vending/sorted/tech/comtech_tools/populate_product_list(scale)
	listed_products = list(
		list("装备", -1, null, null),
		list("实用工具带", floor(scale * 4), /obj/item/storage/belt/utility, VENDOR_ITEM_REGULAR),
		list("电缆卷", floor(scale * 4), /obj/item/stack/cable_coil/random, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", floor(scale * 2), /obj/item/clothing/glasses/welding, VENDOR_ITEM_REGULAR),
		list("工程师套件", floor(scale * 2), /obj/item/storage/toolkit/empty, VENDOR_ITEM_REGULAR),

		list("工具", -1, null, null),
		list("喷灯", floor(scale * 4), /obj/item/tool/weldingtool, VENDOR_ITEM_REGULAR),
		list("撬棍", floor(scale * 4), /obj/item/tool/crowbar, VENDOR_ITEM_REGULAR),
		list("螺丝起子", floor(scale * 4), /obj/item/tool/screwdriver, VENDOR_ITEM_REGULAR),
		list("剪线钳", floor(scale * 4), /obj/item/tool/wirecutters, VENDOR_ITEM_REGULAR),
		list("扳手", floor(scale * 4), /obj/item/tool/wrench, VENDOR_ITEM_REGULAR),
		list("多功能工具", floor(scale * 4), /obj/item/device/multitool, VENDOR_ITEM_REGULAR),
		list("西格森 MCT", floor(scale * 2), /obj/item/tool/weldingtool/simple, VENDOR_ITEM_REGULAR),
		list("灯泡更换器", floor(scale * 4), /obj/item/device/lightreplacer, VENDOR_ITEM_REGULAR),

		list("实用工具", -1, null, null),
		list("哨戒炮网络笔记本电脑", 4, /obj/item/device/sentry_computer, VENDOR_ITEM_REGULAR),
		list("哨戒炮网络加密密钥", 4, /obj/item/device/encryptionkey/sentry_laptop, VENDOR_ITEM_REGULAR),
	)

/obj/structure/machinery/cm_vending/sorted/tech/circuits
	name = "电路板贩卖机"
	desc = "一个用于安全存储预编程电路板的装置，它内置陀螺仪以防止任何外力移动电路板，拥有厚实的绝缘层和一个定制的2.1毫米UPS端口，用于为各种维兰德-汤谷独家设备充电（需单独购买）。"
	icon_state = "robotics"

/obj/structure/machinery/cm_vending/sorted/tech/circuits/populate_product_list(scale)
	listed_products = list(
		list("电路板", -1, null, null),
		list("火警警报", 5, /obj/item/circuitboard/firealarm, VENDOR_ITEM_REGULAR),
		list("装甲运兵车", 6, /obj/item/circuitboard/apc, VENDOR_ITEM_REGULAR),
		list("自动车床", 2, /obj/item/circuitboard/machine/autolathe, VENDOR_ITEM_REGULAR),
		list("TC-4T 电信系统", 1, /obj/item/circuitboard/machine/telecomms/relay/tower, VENDOR_ITEM_REGULAR),
		list("乘员监控计算机", 2, /obj/item/circuitboard/computer/crew, VENDOR_ITEM_REGULAR),
		list("ID计算机", 2, /obj/item/circuitboard/computer/card, VENDOR_ITEM_REGULAR),
		list("安全记录", 2, /obj/item/circuitboard/computer/secure_data, VENDOR_ITEM_REGULAR),
		list("物资订购控制台", 2, /obj/item/circuitboard/computer/ordercomp, VENDOR_ITEM_REGULAR),
		list("研究数据终端", 2, /obj/item/circuitboard/computer/research_terminal, VENDOR_ITEM_REGULAR),
		list("P.A.C.M.A.N. 生成器", 1, /obj/item/circuitboard/machine/pacman, VENDOR_ITEM_REGULAR),
		list("辅助动力存储单元", 2, /obj/item/circuitboard/machine/ghettosmes, VENDOR_ITEM_REGULAR),
		list("空气警报 电子", 2, /obj/item/circuitboard/airalarm, VENDOR_ITEM_REGULAR),
		list("安全摄像头监视器", 2, /obj/item/circuitboard/computer/cameras, VENDOR_ITEM_REGULAR),
		list("电视机", 4, /obj/item/circuitboard/computer/cameras/tv, VENDOR_ITEM_REGULAR),
		list("站点警报", 2, /obj/item/circuitboard/computer/stationalert, VENDOR_ITEM_REGULAR),
		list("街机", 2, /obj/item/circuitboard/computer/arcade, VENDOR_ITEM_REGULAR),
		list("大气监测器", 2, /obj/item/circuitboard/computer/air_management, VENDOR_ITEM_REGULAR),
	)

/obj/structure/machinery/cm_vending/sorted/tech/tool_storage/antag
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null

/obj/structure/machinery/cm_vending/sorted/tech/electronics_storage
	name = "\improper 电子供应商"
	desc = "备用工具贩卖机。怎么？你还指望有什么俏皮的描述吗？"
	icon_state = "engivend"

/obj/structure/machinery/cm_vending/sorted/tech/electronics_storage/populate_product_list(scale)
	listed_products = list(
		list("工具", -1, null, null),
		list("电缆卷", floor(scale * 3), /obj/item/stack/cable_coil/random, VENDOR_ITEM_REGULAR),
		list("多功能工具", floor(scale * 2), /obj/item/device/multitool, VENDOR_ITEM_REGULAR),

		list("电路板", -1, null, null),
		list("气闸电路板", floor(scale * 4), /obj/item/circuitboard/airlock, VENDOR_ITEM_REGULAR),
		list("APC电路板", floor(scale * 4), /obj/item/circuitboard/apc, VENDOR_ITEM_REGULAR),

		list("电池", -1, null, null),
		list("高容量动力电池", floor(scale * 3), /obj/item/cell/high, VENDOR_ITEM_REGULAR),
		list("低容量能量电池", floor(scale * 7), /obj/item/cell, VENDOR_ITEM_REGULAR),
	)

/obj/structure/machinery/cm_vending/sorted/tech/electronics_storage/antag
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null

/obj/structure/machinery/cm_vending/sorted/tech/comp_storage
	name = "\improper 组件 存储 Machine"
	desc = "一台大型存储机，内含各种组件。"
	icon_state = "engi"

/obj/structure/machinery/cm_vending/sorted/tech/comp_storage/populate_product_list(scale)
	listed_products = list(
		list("装配组件", -1, null, null),
		list("引燃者", floor(scale * 8), /obj/item/device/assembly/igniter, VENDOR_ITEM_REGULAR),
		list("计时器", floor(scale * 4), /obj/item/device/assembly/timer, VENDOR_ITEM_REGULAR),
		list("接近传感器", floor(scale * 4), /obj/item/device/assembly/prox_sensor, VENDOR_ITEM_REGULAR),
		list("信号员", floor(scale * 4), /obj/item/device/assembly/signaller, VENDOR_ITEM_REGULAR),

		list("容器", -1, null, null),
		list("水桶", floor(scale * 6), /obj/item/reagent_container/glass/bucket, VENDOR_ITEM_REGULAR),
		list("拖把桶", floor(scale * 2), /obj/item/reagent_container/glass/bucket/mopbucket, VENDOR_ITEM_REGULAR),

		list("库存零件", -1, null, null),
		list("控制台屏幕", floor(scale * 4), /obj/item/stock_parts/console_screen, VENDOR_ITEM_REGULAR),
		list("物质箱", floor(scale * 4), /obj/item/stock_parts/matter_bin, VENDOR_ITEM_REGULAR),
		list("微型激光", floor(scale * 4), /obj/item/stock_parts/micro_laser , VENDOR_ITEM_REGULAR),
		list("微操器", floor(scale * 4), /obj/item/stock_parts/manipulator, VENDOR_ITEM_REGULAR),
		list("扫描模块", floor(scale * 4), /obj/item/stock_parts/scanning_module, VENDOR_ITEM_REGULAR),
		list("电容器", floor(scale * 3), /obj/item/stock_parts/capacitor, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/tech/comp_storage/antag
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null

//------COLONY-SPECIFIC VENDORS-------

/obj/structure/machinery/cm_vending/sorted/tech/science
	name = "\improper 维兰德科技供应商"
	desc = "贩卖机，内含你实验所需的基本设备。"
	icon_state = "robotics"
	req_access = list(ACCESS_MARINE_RESEARCH)

/obj/structure/machinery/cm_vending/sorted/tech/science/populate_product_list(scale)
	listed_products = list(
		list("装备", -1, null, null),
		list("生化头罩", 2, /obj/item/clothing/head/bio_hood, VENDOR_ITEM_REGULAR),
		list("生物防护服", 2, /obj/item/clothing/suit/bio_suit, VENDOR_ITEM_REGULAR),
		list("科学家's Jumpsuit", 2, /obj/item/clothing/under/rank/scientist, VENDOR_ITEM_REGULAR),

		list("装配组件", -1, null, null),
		list("点火器", floor(scale * 8), /obj/item/device/assembly/igniter, VENDOR_ITEM_REGULAR),
		list("接近传感器", floor(scale * 4), /obj/item/device/assembly/prox_sensor, VENDOR_ITEM_REGULAR),
		list("信号员", floor(scale * 4), /obj/item/device/assembly/signaller, VENDOR_ITEM_REGULAR),
		list("坦克传输阀", floor(scale * 4), /obj/item/device/transfer_valve, VENDOR_ITEM_REGULAR),
		list("计时器", floor(scale * 4), /obj/item/device/assembly/timer, VENDOR_ITEM_REGULAR),
	)

/obj/structure/machinery/cm_vending/sorted/tech/robotics
	name = "\improper 太空堡垒豪华版"
	desc = "创建你自己的机器人大军所需的所有工具。"
	icon_state = "robotics"
	req_access = list(ACCESS_MARINE_RESEARCH)

/obj/structure/machinery/cm_vending/sorted/tech/robotics/populate_product_list(scale)
	listed_products = list(
		list("装备", -1, null, null),
		list("实验服", 2, /obj/item/clothing/suit/storage/labcoat, VENDOR_ITEM_REGULAR),
		list("医用口罩", 2, /obj/item/clothing/mask/breath/medical, VENDOR_ITEM_REGULAR),
		list("机器人专家的连体服", 2, /obj/item/clothing/under/rank/roboticist, VENDOR_ITEM_REGULAR),

		list("工具", -1, null, null),
		list("电缆卷", 4, /obj/item/stack/cable_coil/random, VENDOR_ITEM_REGULAR),
		list("圆锯", 2, /obj/item/tool/surgery/circular_saw, VENDOR_ITEM_REGULAR),
		list("撬棍", 2, /obj/item/tool/crowbar, VENDOR_ITEM_REGULAR),
		list("手术刀", 2, /obj/item/tool/surgery/scalpel, VENDOR_ITEM_REGULAR),
		list("螺丝起子", 2, /obj/item/tool/screwdriver, VENDOR_ITEM_REGULAR),

		list("装配组件", -1, null, null),
		list("闪现", 4, /obj/item/device/flash, VENDOR_ITEM_REGULAR),
		list("高容量动力电池", 4, /obj/item/cell/high, VENDOR_ITEM_REGULAR),
		list("接近传感器", 4, /obj/item/device/assembly/prox_sensor, VENDOR_ITEM_REGULAR),
		list("信号员", 4, /obj/item/device/assembly/signaller, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("麻醉剂储罐", 2, /obj/item/tank/anesthetic, VENDOR_ITEM_REGULAR),
		list("健康分析仪", 2, /obj/item/device/healthanalyzer, VENDOR_ITEM_REGULAR)
	)

