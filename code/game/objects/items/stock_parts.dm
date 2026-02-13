
///////////////////////////////////////Stock Parts /////////////////////////////////

//stock parts for constructable machines

/obj/item/stock_parts
	name = "枪托部件"
	desc = "什么？"
	gender = PLURAL
	icon = 'icons/obj/items/stock_parts.dmi'
	w_class = SIZE_SMALL
	var/rating = 1

/obj/item/stock_parts/Initialize()
	. = ..()
	src.pixel_x = rand(-5.0, 5)
	src.pixel_y = rand(-5.0, 5)

//Rank 1

/obj/item/stock_parts/console_screen
	name = "控制台屏幕"
	desc = "用于制造计算机和其他带有交互控制台的设备。"
	icon_state = "screen"

	matter = list("glass" = 200)

/obj/item/stock_parts/capacitor
	name = "capacitor"
	desc = "一种用于制造多种设备的基础电容器。"
	icon_state = "capacitor"

	matter = list("metal" = 50,"glass" = 50)

/obj/item/stock_parts/scanning_module
	name = "扫描模块"
	desc = "一种用于制造特定设备的紧凑型高分辨率扫描模块。"
	icon_state = "scan_module"

	matter = list("metal" = 50,"glass" = 20)

/obj/item/stock_parts/manipulator
	name = "微型机械臂"
	desc = "一种用于制造特定设备的微型机械臂。"
	icon_state = "micro_mani"

	matter = list("metal" = 30)

/obj/item/stock_parts/micro_laser
	name = "微型激光器"
	desc = "一种用于特定设备的微型激光器。"
	icon_state = "micro_laser"

	matter = list("metal" = 10,"glass" = 20)

/obj/item/stock_parts/matter_bin
	name = "物质箱"
	desc = "一个用于存放等待重构的压缩物质的容器。"
	icon_state = "matter_bin"

	matter = list("metal" = 80)

//Rank 2

/obj/item/stock_parts/capacitor/adv
	name = "高级电容器"
	desc = "一种用于构建多种设备的高级电容器。"

	rating = 2
	matter = list("metal" = 50,"glass" = 50)

/obj/item/stock_parts/scanning_module/adv
	name = "高级扫描模块"
	desc = "一种用于制造特定设备的紧凑型高分辨率扫描模块。"
	icon_state = "scan_module"

	rating = 2
	matter = list("metal" = 50,"glass" = 20)

/obj/item/stock_parts/manipulator/nano
	name = "纳米操纵器"
	desc = "一种用于制造特定设备的微型机械臂。"
	icon_state = "nano_mani"

	rating = 2
	matter = list("metal" = 30)

/obj/item/stock_parts/micro_laser/high
	name = "高功率微型激光器"
	desc = "一种用于特定设备的微型激光器。"
	icon_state = "high_micro_laser"

	rating = 2
	matter = list("metal" = 10,"glass" = 20)

/obj/item/stock_parts/matter_bin/adv
	name = "高级物质箱"
	desc = "一个用于存放等待重构的压缩物质的容器。"
	icon_state = "advanced_matter_bin"

	rating = 2
	matter = list("metal" = 80)

//Rating 3

/obj/item/stock_parts/capacitor/super
	name = "超级电容器"
	desc = "一种用于构建多种设备的超高容量电容器。"

	rating = 3
	matter = list("metal" = 50,"glass" = 50)

/obj/item/stock_parts/scanning_module/phasic
	name = "相控扫描模块"
	desc = "一种用于构建特定设备的紧凑型高分辨率相控扫描模块。"

	rating = 3
	matter = list("metal" = 50,"glass" = 20)

/obj/item/stock_parts/manipulator/pico
	name = "皮可操纵器"
	desc = "一种用于制造特定设备的微型机械臂。"
	icon_state = "pico_mani"

	rating = 3
	matter = list("metal" = 30)

/obj/item/stock_parts/micro_laser/ultra
	name = "超高功率微型激光器"
	icon_state = "ultra_high_micro_laser"
	desc = "一种用于特定设备的微型激光器。"

	rating = 3
	matter = list("metal" = 10,"glass" = 20)

/obj/item/stock_parts/matter_bin/super
	name = "超级物质箱"
	desc = "一个用于存放等待重构的压缩物质的容器。"
	icon_state = "super_matter_bin"

	rating = 3
	matter = list("metal" = 80)

// Subspace stock parts

/obj/item/stock_parts/subspace/ansible
	name = "子空间安塞波"
	icon_state = "subspace_ansible"
	desc = "一种能够感知维度外活动的紧凑模块。"

	matter = list("metal" = 30,"glass" = 10)

/obj/item/stock_parts/subspace/filter
	name = "超波滤波器"
	icon_state = "hyperwave_filter"
	desc = "一种能够过滤和转换超强无线电波的微型设备。"

	matter = list("metal" = 30,"glass" = 10)

/obj/item/stock_parts/subspace/amplifier
	name = "子空间放大器"
	icon_state = "subspace_amplifier"
	desc = "一种能够放大微弱子空间传输信号的紧凑型微型机器。"

	matter = list("metal" = 30,"glass" = 10)

/obj/item/stock_parts/subspace/treatment
	name = "子空间处理盘"
	icon_state = "treatment_disk"
	desc = "一种能够展开超压缩无线电波的紧凑型微型机器。"

	matter = list("metal" = 30,"glass" = 10)

/obj/item/stock_parts/subspace/analyzer
	name = "子空间波长分析仪"
	icon_state = "wavelength_analyzer"
	desc = "一种能够分析加密子空间波长的精密分析仪。"

	matter = list("metal" = 30,"glass" = 10)

/obj/item/stock_parts/subspace/crystal
	name = "安塞波晶体"
	icon_state = "ansible_crystal"
	desc = "一种由纯玻璃制成的晶体，用于向子空间传输激光数据脉冲。"

	matter = list("glass" = 50)

/obj/item/stock_parts/subspace/transmitter
	name = "子空间发射器"
	icon_state = "subspace_transmitter"
	desc = "一台用于打开通往子空间维度窗口的大型设备。"

	matter = list("metal" = 50)


//Construction Item for the SMES
/obj/item/stock_parts/smes_coil
	name = "超导磁线圈"
	desc = "重型超导磁线圈，主要用于建造SMES单元。"
	icon_state = "smes_coil"
	w_class = SIZE_LARGE
	var/ChargeCapacity = 5000000
	var/IOCapacity = 250000
