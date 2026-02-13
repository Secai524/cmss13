//------------GEAR VENDOR---------------

GLOBAL_LIST_EMPTY(primary_specialists_picked)

GLOBAL_LIST_INIT(cm_vending_gear_spec, list(
		list("武器专家套装（任选其一）", 0, null, null, null),
		list("爆破手装备包", 0, /obj/item/storage/box/spec/demolitionist, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("重型掷弹兵装备包", 0, /obj/item/storage/box/spec/heavy_grenadier, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("SHARP特战队员装备包", 0, /obj/item/storage/box/spec/sharp_operator, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("喷火兵装备包", 0, /obj/item/storage/box/spec/pyro, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("侦察兵装备包", 0, /obj/item/storage/box/spec/scout, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("狙击手装备包", 0, /obj/item/storage/box/spec/sniper, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),
		list("反器材狙击手装备包", 0, /obj/item/storage/box/spec/sniper/anti_materiel, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),

		list("额外侦察兵弹药", 0, null, null, null),
		list("A19高速冲击弹匣（10x24毫米）", 40, /obj/item/ammo_magazine/rifle/m4ra/custom/impact, null, VENDOR_ITEM_REGULAR),
		list("A19高速燃烧弹匣（10x24毫米）", 40, /obj/item/ammo_magazine/rifle/m4ra/custom/incendiary, null, VENDOR_ITEM_REGULAR),
		list("A19高速弹匣（10x24毫米）", 40, /obj/item/ammo_magazine/rifle/m4ra/custom, null, VENDOR_ITEM_REGULAR),

		list("额外狙击弹药", 0, null, null, null),
		list("M42A 高射炮弹匣（10x28mm）", 40, /obj/item/ammo_magazine/sniper/flak, null, VENDOR_ITEM_REGULAR),
		list("M42A燃烧弹匣（10x28毫米）", 40, /obj/item/ammo_magazine/sniper/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M42A神射手弹匣（10x28mm无壳弹）", 40, /obj/item/ammo_magazine/sniper, null, VENDOR_ITEM_REGULAR),
		list("XM43E1 神射手弹匣（10x99毫米无壳弹）", 40, /obj/item/ammo_magazine/sniper/anti_materiel, null, VENDOR_ITEM_REGULAR),

		list("额外爆破手弹药", 0, null, null, null),
		list("84毫米反装甲火箭弹", 40, /obj/item/ammo_magazine/rocket/ap, null, VENDOR_ITEM_REGULAR),
		list("84毫米高爆火箭", 40, /obj/item/ammo_magazine/rocket, null, VENDOR_ITEM_REGULAR),
		list("84毫米白磷火箭弹", 40, /obj/item/ammo_magazine/rocket/wp, null, VENDOR_ITEM_REGULAR),

		list("超锐利弹药", 0, null, null, null),
		list("SHARP 9X-E 粘性爆炸飞镖弹匣（飞镖）", 40, /obj/item/ammo_magazine/rifle/sharp/explosive, null, VENDOR_ITEM_REGULAR),
		list("SHARP 9X-T 粘性燃烧飞镖弹匣（飞镖）", 40, /obj/item/ammo_magazine/rifle/sharp/incendiary, null, VENDOR_ITEM_REGULAR),
		list("SHARP 9X-F 飞镖弹匣（飞镖）", 40, /obj/item/ammo_magazine/rifle/sharp/flechette, null, VENDOR_ITEM_REGULAR),

		list("额外手榴弹", 0, null, null, null),
		list("M40 HEDP 榴弹 x6", 40, /obj/effect/essentials_set/hedp_6_pack, null, VENDOR_ITEM_REGULAR),
		list("M40 HIDP燃烧手榴弹 x6", 40, /obj/effect/essentials_set/hidp_6_pack, null, VENDOR_ITEM_REGULAR),
		list("M40 CCDP 化学复合手榴弹 x6", 40, /obj/effect/essentials_set/ccdp_6_pack, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-F 破片手榴弹 x6", 40, /obj/effect/essentials_set/agmf_6_pack, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-I 燃烧手榴弹 x6", 40, /obj/effect/essentials_set/agmi_6_pack, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S 烟雾弹 x6", 20, /obj/effect/essentials_set/agms_6_pack, null, VENDOR_ITEM_REGULAR),
		list("G2 电击手雷包 x6", 40, /obj/effect/essentials_set/sebb_6_pack, null, VENDOR_ITEM_REGULAR),

		list("额外火焰喷射器储罐", 0, null, null, null),
		list("大型焚化炉储罐", 40, /obj/item/ammo_magazine/flamer_tank/large, null, VENDOR_ITEM_REGULAR),
		list("大型焚化炉罐（B型）（绿色火焰）", 40, /obj/item/ammo_magazine/flamer_tank/large/B, null, VENDOR_ITEM_REGULAR),
		list("大型焚化炉罐（X）（蓝焰）", 40, /obj/item/ammo_magazine/flamer_tank/large/X, null, VENDOR_ITEM_REGULAR),

	))

GLOBAL_LIST_INIT(cm_vending_gear_spec_heavy, list(
	list("武器专家套装（任选其一）", 0, null, null, null),
	list("重型护甲装备包", 0, /obj/item/storage/box/spec/B18, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),
))



/obj/structure/machinery/cm_vending/gear/spec
	name = "\improper 殖民地海军陆战队科技（ColMarTech） 小队武器专家装备架"
	desc = "班组武器专家专用自动化装备架。"
	icon_state = "spec_gear"
	show_points = TRUE
	use_points = FALSE
	use_snowflake_points = TRUE
	vendor_role = list(JOB_SQUAD_SPECIALIST)
	req_access = list(ACCESS_MARINE_SPECPREP)

/obj/structure/machinery/cm_vending/gear/spec/get_listed_products(mob/user)
	if(SSticker.mode && MODE_HAS_MODIFIER(/datum/gamemode_modifier/heavy_specialists))
		return GLOB.cm_vending_gear_spec_heavy
	return GLOB.cm_vending_gear_spec

/obj/structure/machinery/cm_vending/gear/spec/vendor_successful_vend_one(prod_type, mob/living/carbon/human/user, turf/target_turf, insignas_override, stack_amount)
	. = ..()
	if(length(GLOB.primary_specialists_picked) >= /datum/job/marine/specialist::total_positions)
		return

	if(ispath(prod_type, /obj/item/storage/box/spec))
		var/obj/item/storage/box/spec/spec_kit = prod_type
		GLOB.primary_specialists_picked[spec_kit::kit_name] = TRUE

/obj/structure/machinery/cm_vending/gear/spec/automatic_vend(mob/user)
	// Try to automatically vend spec kit if it was already assigned automatically if needed
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user))
		return
	if(!HAS_TRAIT(user, TRAIT_SPEC_VENDOR))
		return
	if(!vendor_role.Find(JOB_SQUAD_SPECIALIST))
		return
	if(!user.skills.get_skill_level(SKILL_SPEC_WEAPONS) == SKILL_SPEC_TRAINED)
		return
	if((!human_user.assigned_squad && squad_tag) || (!human_user.assigned_squad?.omni_squad_vendor && (squad_tag && human_user.assigned_squad.name != squad_tag)))
		to_chat(user, SPAN_WARNING("这台机器不是给你所属班用的。"))
		return
	var/datum/specialist_set/chosen_set = get_specialist_set(user)
	if(!chosen_set)
		return
	var/kit_path = chosen_set::kit_typepath
	var/list/itemspec
	for(var/list/entry as anything in GLOB.cm_vending_gear_spec)
		if(entry[3] == kit_path)
			itemspec = entry
			break
	if(!itemspec)
		// Fallback
		human_user.put_in_any_hand_if_possible(new kit_path, FALSE)
		CRASH("Failed to locate [chosen_set::name] for [user] in GLOB.cm_vending_gear_spec!")
	if(!handle_vend(itemspec, human_user))
		return
	vendor_successful_vend(itemspec, user)
	var/obj/item/card/id/idcard = human_user.get_idcard()
	GLOB.data_core.manifest_modify(human_user.real_name, WEAKREF(human_user), idcard.assignment)

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_specialist, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("地图", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("背包（选择1件）", 0, null, null, null),
		list("背包", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("挎包", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用手枪携行装具", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 M39 枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M10 枪套装备", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2种）", 0, null, null, null),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（选择1件）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("限制性火器", 0, null, null, null),
		list("VP78 手枪", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("M10 HV 加长弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹匣", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("VP78 弹匣", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("服装物品", 0, null, null, null),
		list("砍刀刀鞘（完整）", 6, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）无线电通讯背包", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("燃料箱绑带袋", 5, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", 3, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 10, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),
		list("M276型 战斗 工具腰带 装备", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_REGULAR),
		list("自动注射器袋（满）", 15, /obj/item/storage/pouch/autoinjector/full, null, VENDOR_ITEM_REGULAR),

		list("公共事业", 0, null, null, null),
		list("滚筒床", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 10, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("数据探测器", 10, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),
		list("哨声", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("激光指示器", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("医疗头盔光学镜", 15, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("宣传册", 0, null, null, null),
		list("JTAC 手册", 15, /obj/item/pamphlet/skill/jtac, null, VENDOR_ITEM_REGULAR),
		list("工程手册", 15, /obj/item/pamphlet/skill/engineer, null, VENDOR_ITEM_REGULAR),

		list("无线电按键", 0, null, null, null),
		list("工程部无线电加密密钥", 5, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("英特尔无线电加密密钥", 5, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("JTAC无线电加密密钥", 5, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("补给无线电加密密钥", 5, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
		list("医疗无线电加密密钥", 5, /obj/item/device/encryptionkey/med, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/specialist
	name = "\improper 殖民地海军陆战队科技（ColMarTech） 小队武器专家装备架"
	desc = "连接至大型存储库的自动化装备架，存放班组武器专家标准配发装备。"
	show_points = TRUE
	req_access = list(ACCESS_MARINE_SPECPREP)
	vendor_role = list(JOB_SQUAD_SPECIALIST)

/obj/structure/machinery/cm_vending/clothing/specialist/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_specialist

/obj/structure/machinery/cm_vending/clothing/specialist/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha

/obj/structure/machinery/cm_vending/clothing/specialist/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo

/obj/structure/machinery/cm_vending/clothing/specialist/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie

/obj/structure/machinery/cm_vending/clothing/specialist/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/hedp_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
	)

/obj/effect/essentials_set/hefa_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
	)

/obj/effect/essentials_set/hidp_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
	)

/obj/effect/essentials_set/ccdp_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
	)

/obj/effect/essentials_set/agmf_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
	)

/obj/effect/essentials_set/agmi_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
	)

/obj/effect/essentials_set/agms_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
	)

/obj/effect/essentials_set/sebb_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
	)
