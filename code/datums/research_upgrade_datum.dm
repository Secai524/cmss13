/datum/research_upgrades
	///unique to every upgrade. not the name of the item. name of the upgrade
	var/name = "Upgrade."
	///name of upgrades, not items. Items are at research_upgrades.dm somewhere in item folder.
	var/desc = "Something is broken. yippee!!"
	///which behavior should this type follow. Should this be completely excluded from the buy menu? should it be one of the dropdown options? or a normal item?
	var/behavior = RESEARCH_UPGRADE_EXCLUDE_BUY // should this be on the list?
	/// the price of the upgrade, refer to this: 500 is a runner, 8k is queen. T3 is usually 3k, woyer is 2k.
	var/value_upgrade = 1000
	///In which tab the upgrade should be.
	var/upgrade_type
	///Path to the item, upgrade, if any.
	var/item_reference
	///Clearance requirment to buy this upgrade. 5x is level 6. Why is it not that way? no one knows.
	var/clearance_req = 5
	///The change of price for item per purchase, recommended for mass producing stuff or limited upgrade.
	var/change_purchase = 0
	///the minimum price which we can't go any cheaper usually don't need to set this if change price is 0 or positive
	var/minimum_price = 0
	///the maximum price which we can't go any more expensive, usually don't need to set this if change price is 0 or negative
	var/maximum_price = INFINITY

///gets called once the product is purchased, override if you need to pass any special arguments or have special behavior on purchase.
/datum/research_upgrades/proc/on_purchase(turf/machine_loc)
	if(isnull(item_reference))
		return
	new item_reference(machine_loc)

/datum/research_upgrades/machinery
	name = "机械"
	behavior = RESEARCH_UPGRADE_CATEGORY // one on the dropdown choices you get

/datum/research_upgrades/machinery/autodoc
	name = "自动医疗机升级"
	behavior = RESEARCH_UPGRADE_EXCLUDE_BUY
	upgrade_type = ITEM_MACHINERY_UPGRADE

/datum/research_upgrades/machinery/autodoc/internal_bleed
	name = "自动医疗机内出血修复"
	desc = "一套用于自动医疗机的数据和指令集，使其能够近乎即时地修复内出血。"
	behavior = RESEARCH_UPGRADE_ITEM
	value_upgrade = 100
	clearance_req = 1

/datum/research_upgrades/machinery/autodoc/internal_bleed/on_purchase(turf/machine_loc)
	new /obj/item/research_upgrades/autodoc(machine_loc)

/datum/research_upgrades/machinery/autodoc/broken_bone
	name = "自动医疗机骨折修复"
	desc = "一套用于自动医疗机的数据和指令集，使其能够进行骨折复位并施用骨胶。"
	behavior = RESEARCH_UPGRADE_ITEM
	value_upgrade = 1500
	clearance_req = 3

/datum/research_upgrades/machinery/autodoc/broken_bone/on_purchase(turf/machine_loc)
	new /obj/item/research_upgrades/autodoc/tier2(machine_loc)

/datum/research_upgrades/machinery/autodoc/organ_damage
	name = "自动医疗机器官损伤修复"
	desc = "一套用于自动医疗机的数据和指令集，使其能够修复器官损伤。"
	behavior = RESEARCH_UPGRADE_ITEM
	value_upgrade = 1500
	clearance_req = 2

/datum/research_upgrades/machinery/autodoc/organ_damage/on_purchase(turf/machine_loc)
	new /obj/item/research_upgrades/autodoc/tier3(machine_loc)

/datum/research_upgrades/machinery/autodoc/larva_removal
	name = "自动医疗机胚胎移除"
	desc = "用于自动医疗机的数据和指令集，使其在移除未知生物体留下的寄生虫方面具备一定能力。"
	behavior = RESEARCH_UPGRADE_ITEM
	value_upgrade = 4000
	clearance_req = 6

/datum/research_upgrades/machinery/autodoc/larva_removal/on_purchase(turf/machine_loc)
	new /obj/item/research_upgrades/autodoc/tier4(machine_loc)

/datum/research_upgrades/machinery/grinderspeed
	name = "试剂研磨机升级"
	desc = "试剂研磨机的研究升级，此磁盘上的技术使存储和研磨过程更加高效，提高了研磨机的速度和产品容量。"
	behavior = RESEARCH_UPGRADE_ITEM
	value_upgrade = 500
	item_reference = /obj/item/research_upgrades/grinderspeed
	upgrade_type = ITEM_MACHINERY_UPGRADE
	clearance_req = 2


/datum/research_upgrades/machinery/sleeper
	name = "休眠舱升级"
	desc = "休眠舱系统的研究升级，此磁盘上的技术应用于休眠舱，允许施用更广谱的化学药物，并升级透析软件。"
	behavior = RESEARCH_UPGRADE_ITEM
	value_upgrade = 500
	item_reference = /obj/item/research_upgrades/sleeper
	upgrade_type = ITEM_MACHINERY_UPGRADE
	clearance_req = 1

/datum/research_upgrades/machinery/autoharvest
	name = "自动收获植物学升级"
	desc = "水培系统的研究升级，此磁盘上的技术可在植物成熟待收获时自动摇动植株。"
	behavior = RESEARCH_UPGRADE_ITEM
	value_upgrade = 250
	item_reference = /obj/item/research_upgrades/autoharvest
	upgrade_type = ITEM_MACHINERY_UPGRADE
	clearance_req = 2

/datum/research_upgrades/item
	name = "物品"
	behavior = RESEARCH_UPGRADE_CATEGORY

/datum/research_upgrades/item/research_credits
	name = "研究合同重抽"
	desc = "将获取的数据出售给最近的维兰德-汤谷科学部门团队，以申请新的合同化学品。"
	value_upgrade = 1000
	behavior = RESEARCH_UPGRADE_ITEM
	upgrade_type = ITEM_ACCESSORY_UPGRADE
	item_reference = /obj/item/research_upgrades/reroll
	change_purchase = 200
	maximum_price = 2000
	clearance_req = 4

/datum/research_upgrades/item/laser_scalpel
	name = "激光手术刀"
	desc = "一种先进、坚固的普通手术刀升级版，使其能够极其轻松地刺穿厚皮和甲壳。"
	value_upgrade = 3000
	behavior = RESEARCH_UPGRADE_ITEM
	upgrade_type = ITEM_ACCESSORY_UPGRADE
	item_reference = /obj/item/tool/surgery/scalpel/laser/advanced
	clearance_req = 3

/datum/research_upgrades/item/incision_management
	name = "切口管理系统"
	desc = "这是外科医生身体的真正延伸，这项奇迹能瞬间完全准备好切口，以便立即开始治疗步骤。"
	value_upgrade = 1500
	behavior = RESEARCH_UPGRADE_ITEM
	upgrade_type = ITEM_ACCESSORY_UPGRADE
	clearance_req = 3
	item_reference = /obj/item/tool/surgery/scalpel/manager


/datum/research_upgrades/item/nanosplints
	name = "强化纤维夹板"
	desc = "一套由耐用碳纤维板制成、并用柔性钛晶格强化的夹板，一叠五片。"
	value_upgrade = 800
	clearance_req = 3
	change_purchase = -100
	minimum_price = 100
	behavior = RESEARCH_UPGRADE_ITEM
	upgrade_type = ITEM_ACCESSORY_UPGRADE

/datum/research_upgrades/item/nanosplints/on_purchase(turf/machine_loc)
	new /obj/item/stack/medical/splint/nano/research(machine_loc, 5)//adjust this to change amount of nanosplints in a stack, can't be higher than five, go change max_amount in the nanosplint itself, then change it.

/datum/research_upgrades/item/flamer_tank
	name = "升级型焚烧器燃料罐"
	desc = "一个升级的焚烧器燃料罐，容量更大，并能处理更强的燃料。"
	value_upgrade = 300
	clearance_req = 1
	change_purchase = 100
	minimum_price = 100
	maximum_price = 1000
	behavior = RESEARCH_UPGRADE_ITEM
	upgrade_type = ITEM_ACCESSORY_UPGRADE
	item_reference = /obj/item/ammo_magazine/flamer_tank/custom/upgraded

/datum/research_upgrades/item/flamer_tank/smoke
	name = "升级型焚烧器烟雾罐"
	desc = "一个容量更大的升级型焚烧器烟雾罐。"
	value_upgrade = 100 //not useful enough to be expensive
	clearance_req = 1
	change_purchase = 50
	minimum_price = 100
	maximum_price = 500
	item_reference = /obj/item/ammo_magazine/flamer_tank/smoke/upgraded

/datum/research_upgrades/armor
	name = "护甲"
	behavior = RESEARCH_UPGRADE_CATEGORY

/datum/research_upgrades/armor/translator
	name = "通用翻译器板"
	desc = "一种可附着在制服上的板件，能够翻译穿戴者听到的任何未知语言。"
	value_upgrade = 2000
	behavior = RESEARCH_UPGRADE_ITEM
	clearance_req = 6
	upgrade_type = ITEM_ARMOR_UPGRADE
	item_reference = /obj/item/clothing/accessory/health/research_plate/translator

/datum/research_upgrades/armor/coagulator
	name = "主动凝血板"
	desc = "一种可附着在制服上的板件，能够凝固使用者身上的任何出血伤口。"
	value_upgrade = 1200
	behavior = RESEARCH_UPGRADE_ITEM
	clearance_req = 2
	change_purchase = -200
	minimum_price = 200
	upgrade_type = ITEM_ARMOR_UPGRADE
	item_reference = /obj/item/clothing/accessory/health/research_plate/coagulator


/datum/research_upgrades/armor/emergency_injector
	name = "医疗紧急注射器"
	desc = "一块带有侧面两个按钮和一个大型化学储罐的医疗板。附着在制服上，同时按下按钮时，它会注射一剂远超普通紧急自动注射器剂量的紧急医疗化学品。单次使用，可在生物质打印机中回收。具有防过量保护功能。"
	value_upgrade = 250
	clearance_req = 1
	behavior = RESEARCH_UPGRADE_ITEM
	change_purchase = -100
	minimum_price = 100
	upgrade_type = ITEM_ARMOR_UPGRADE
	item_reference = /obj/item/clothing/accessory/health/research_plate/emergency_injector

/datum/research_upgrades/armor/ceramic
	name = "陶瓷装甲板"
	desc = "一块坚固的创伤板，能够保护使用者免受大量子弹伤害。对尖锐物体完全无效。"
	value_upgrade = 500
	clearance_req = 2
	behavior = RESEARCH_UPGRADE_ITEM
	upgrade_type = ITEM_ARMOR_UPGRADE
	change_purchase = -100
	minimum_price = 200
	item_reference = /obj/item/clothing/accessory/health/ceramic_plate

/datum/research_upgrades/armor/preservation
	name = "死亡保存板"
	desc = "一种在用户死亡时激活的保存板，使用多种不同的物质和传感器来减缓腐败，并延长用户永久死亡前的时间。由于防腐剂储罐较小，每次死亡后都需要更换。将永久死亡前的时间延长约四分钟。"
	value_upgrade = 500
	clearance_req = 4
	behavior = RESEARCH_UPGRADE_ITEM
	upgrade_type = ITEM_ARMOR_UPGRADE
	change_purchase = -100
	minimum_price = 100
	item_reference = /obj/item/clothing/accessory/health/research_plate/anti_decay
