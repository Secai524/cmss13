/obj/structure/machinery/cm_vending/clothing/k9_synth
	name = "\improper 维兰德-汤谷合成K9装备申请"
	desc = "合成犬K9的自动化装备供应商。"
	show_points = FALSE
	req_access = list(ACCESS_MARINE_SYNTH)
	vendor_role = list(JOB_SYNTH_K9)

/obj/structure/machinery/cm_vending/clothing/k9_synth/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_k9_synth

//------------GEAR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_k9_synth, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("耳机", 0, /obj/item/device/radio/headset/almayer/mcom/synth, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
		list("K9系列识别标签", 0, /obj/item/clothing/under/rank/synthetic/synth_k9, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("名称修改器", 0, /obj/item/k9_name_changer/, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_MANDATORY),

		list("处理工具包（选择1）", 0, null, null, null),
		list("小队医护兵 -> 警犬训导员", 0, /obj/item/storage/box/kit/k9_handler/corpsman, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),
		list("军事警察 -> 警犬训导员", 0, /obj/item/storage/box/kit/k9_handler/mp, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),

		list("携带背包（选择1个）", 0, null, null, null),
		list("医疗携行背带", 0, /obj/item/storage/backpack/marine/k9_synth/medicalpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("货物携带背带", 0, /obj/item/storage/backpack/marine/k9_synth/cargopack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("MP 携行背带", 0, /obj/item/storage/backpack/marine/k9_synth/mppack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

	))
