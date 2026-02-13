//prop items
/obj/item/oldresearch
	name = "异形器官"
	desc = "看着它让你想吐。"
	icon = 'icons/obj/items/Marine_Research.dmi'
	icon_state = "biomass"
	black_market_value = 50
	//For all of them for now, until we have specific organs/more techs

/obj/item/oldresearch/Resin
	name = "异形树脂"
	desc = "一块异形树脂。"
	icon_state = "biomass"


/obj/item/oldresearch/Chitin
	name = "几丁质块"
	desc = "一块异形几丁质。"
	icon_state = "chitin-chunk"


/obj/item/oldresearch/Blood
	name = "血液样本瓶"
	desc = "一份异形血液样本。"
	icon_state = "blood-vial"

//prop items end

//previously file holding left over stuff that never got finished from 8 years ago, it was boring though, so we change that.
/obj/item/research_upgrades
	name = "研究升级"
	desc = "不知何故你得到了这个，你本不该能拿到，就当自己很特别吧。"
	icon = 'icons/obj/items/disk.dmi'
	w_class = SIZE_TINY
	icon_state = "datadisk1" // doesnt HAVE to be a disk!
	ground_offset_x = 8
	ground_offset_y = 8
	///technology stored on this disk, goes through one to whatever levels of upgrades there are.
	var/value

// Upgrade for autodoc T1: Internal bleeding
/obj/item/research_upgrades/autodoc
	name = "研究升级（自动医疗机）"
	desc = "用于自动医疗机的研究升级。这张磁盘上的技术用于缝合内出血。将其插入自动医疗机以使用。"
	value = RESEARCH_UPGRADE_TIER_1

// Upgrade for autodoc T2: Broken bones
/obj/item/research_upgrades/autodoc/tier2
	desc = "自动医疗机的研发升级盘。此磁盘中的技术用于修复骨折。将其插入自动医疗机以使用。"
	value = RESEARCH_UPGRADE_TIER_2

// Upgrade for autodoc T3: Internal organ damage
/obj/item/research_upgrades/autodoc/tier3
	desc = "自动医疗机的研发升级盘。此磁盘中的技术用于治疗内脏损伤。将其插入自动医疗机以使用。"
	value = RESEARCH_UPGRADE_TIER_3

// Upgrade for autodoc T4: Larva removal
/obj/item/research_upgrades/autodoc/tier4
	desc = "自动医疗机的研发升级盘。此磁盘中的技术用于提取未知寄生虫。将其插入自动医疗机以使用。"
	value = RESEARCH_UPGRADE_TIER_4

/obj/item/research_upgrades/sleeper
	name = "研发升级盘（休眠舱）"
	desc = "休眠舱系统的研发升级盘。此磁盘中的技术用于休眠舱，以允许施用更广谱的化学药剂。"

/obj/item/research_upgrades/grinderspeed
	name = "研发升级盘（研磨机）"
	desc = "试剂研磨机的研究升级，此磁盘上的技术使存储和研磨过程更加高效，提高了研磨机的速度和产品容量。"

/obj/item/research_upgrades/autoharvest
	name = "研发升级盘（植物学）"
	desc = "水培系统的研发升级盘。此磁盘中的技术用于水培托盘，可在作物成熟待收获时自动摇晃植株。"

/obj/item/research_upgrades/reroll
	name = "研发市场数据盘（重抽）"
	desc = "包含分析仪所能抢救的所有数据碎片的研发磁盘，将其插入研究计算机以出售数据并立即重抽合同。"
