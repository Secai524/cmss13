GLOBAL_LIST_EMPTY(gear_datums_by_category)

GLOBAL_LIST_EMPTY_TYPED(gear_datums_by_name, /datum/gear)
GLOBAL_LIST_EMPTY_TYPED(gear_datums_by_type, /datum/gear)

GLOBAL_LIST_EMPTY(roles_with_gear)

/proc/populate_gear_list()
	var/datum/gear/G
	for(var/gear_type in subtypesof(/datum/gear))
		G = new gear_type()
		if(!G.path)
			continue //Skipping parent types that are not actual items.
		if(!G.display_name)
			G.display_name = capitalize(strip_improper(G.path::name))
		if(!G.category)
			log_debug("Improper gear datum: [gear_type].")
			continue
		LAZYADD(GLOB.gear_datums_by_category[G.category], G)
		GLOB.gear_datums_by_type[G.type] = G

		// it's okay if this gets clobbered by duplicate names, it's just used for a best guess to convert old names to types
		GLOB.gear_datums_by_name[G.display_name] = G

		if(G.allowed_roles)
			for(var/allowed_role in G.allowed_roles)
				GLOB.roles_with_gear |= allowed_role

/datum/gear

	/// Overrides the display name
	var/display_name

	/// Used for sorting in the loadout selection.
	var/category

	/// Path to item.
	var/obj/item/path

	/// Number of job specific loadout points used.
	var/loadout_cost = 0

	/// Number of fluff points used.
	var/fluff_cost = 2

	/// Slot to equip to, if any.
	var/slot

	/// Roles that can spawn with this item.
	var/list/allowed_roles

	/// Origins that can sapwn with this item.
	var/list/allowed_origins

/// Returns a list with the various variables used to display this gear in a UI
/datum/gear/proc/get_list_representation()
	return list(
		"name" = display_name,
		"type" = type,
		"fluff_cost" = fluff_cost,
		"loadout_cost" = loadout_cost,

		"icon" = path::icon,
		"icon_state" = path::icon_state
	)

/// Attempt to wear this equipment, in the given slot if possible. If not, any slot is used.
/datum/gear/proc/equip_to_user(mob/living/carbon/human/user, override_checks = FALSE, drop_instead_of_del = TRUE)
	if(!override_checks && allowed_roles && !(user.job in allowed_roles))
		to_chat(user, SPAN_WARNING("装备 [display_name] 无法装备：角色无效。"))
		return

	if(!override_checks && allowed_origins && !(user.origin in allowed_origins))
		to_chat(user, SPAN_WARNING("装备 [display_name] 无法装备：来源无效。"))
		return

	if(!(slot && user.equip_to_slot_or_del(new path, slot)))
		var/obj/equipping_gear = new path
		if(user.equip_to_appropriate_slot(equipping_gear))
			return

		if(user.equip_to_slot_if_possible(equipping_gear, WEAR_IN_BACK, disable_warning = TRUE))
			return

		if(drop_instead_of_del)
			equipping_gear.forceMove(get_turf(user))
			return

		qdel(equipping_gear)

/datum/gear/eyewear
	category = "Eyewear"
	slot = WEAR_EYES

/datum/gear/eyewear/goggles
	display_name = "防弹护目镜"
	path = /obj/item/clothing/glasses/mgoggles

/datum/gear/eyewear/prescription_goggles
	display_name = "处方防弹护目镜"
	path = /obj/item/clothing/glasses/mgoggles/prescription

/datum/gear/eyewear/goggles_black
	display_name = "防弹护目镜，黑色"
	path = /obj/item/clothing/glasses/mgoggles/black

/datum/gear/eyewear/goggles_orange
	display_name = "防弹护目镜，橙色"
	path = /obj/item/clothing/glasses/mgoggles/orange

/datum/gear/eyewear/goggles_red
	display_name = "防弹护目镜，红色"
	path = /obj/item/clothing/glasses/mgoggles/red

/datum/gear/eyewear/goggles_blue
	display_name = "防弹护目镜，蓝色"
	path = /obj/item/clothing/glasses/mgoggles/blue

/datum/gear/eyewear/goggles_purple
	display_name = "防弹护目镜，紫色"
	path = /obj/item/clothing/glasses/mgoggles/purple

/datum/gear/eyewear/goggles_yellow
	display_name = "防弹护目镜，黄色"
	path = /obj/item/clothing/glasses/mgoggles/yellow

/datum/gear/eyewear/goggles2
	display_name = "防弹护目镜，M1A1型"
	path = /obj/item/clothing/glasses/mgoggles/v2

/datum/gear/eyewear/goggles2/blue
	display_name = "防弹护目镜，M1A1型蓝色"
	path = /obj/item/clothing/glasses/mgoggles/v2/blue

/datum/gear/eyewear/goggles2/polarized_blue
	display_name = "偏光防弹护目镜，M1A1型蓝色"
	path = /obj/item/clothing/glasses/mgoggles/v2/polarized_blue

/datum/gear/eyewear/goggles2/polarized_orange
	display_name = "偏光防弹护目镜，M1A1型橙色"
	path = /obj/item/clothing/glasses/mgoggles/v2/polarized_orange

/datum/gear/eyewear/eyepatch
	display_name = "眼罩，黑色"
	path = /obj/item/clothing/glasses/eyepatch

/datum/gear/eyewear/eyepatch/white
	display_name = "眼罩，白色"
	path = /obj/item/clothing/glasses/eyepatch/white

/datum/gear/eyewear/eyepatch/green
	display_name = "眼罩，绿色"
	path = /obj/item/clothing/glasses/eyepatch/green

/datum/gear/eyewear/rpg_glasses
	display_name = "陆战队RPG眼镜"
	path = /obj/item/clothing/glasses/regular
	allowed_origins = USCM_ORIGINS

/datum/gear/eyewear/prescription_glasses
	display_name = "处方眼镜"
	path = /obj/item/clothing/glasses/regular/hipster

/datum/gear/eyewear/hippie_glasses
	display_name = "圆形处方眼镜"
	path = /obj/item/clothing/glasses/regular/hippie

/datum/gear/eyewear/aviators
	display_name = "飞行员墨镜，金色"
	path = /obj/item/clothing/glasses/sunglasses/aviator

/datum/gear/eyewear/aviators/silver
	display_name = "飞行员墨镜，银色"
	path = /obj/item/clothing/glasses/sunglasses/aviator/silver

/datum/gear/eyewear/new_bimex/black
	display_name = "BiMex战术墨镜，黑色"
	path = /obj/item/clothing/glasses/sunglasses/big/new_bimex/black
	fluff_cost = 4

/datum/gear/eyewear/new_bimex
	display_name = "BiMex偏光墨镜，黄色"
	path = /obj/item/clothing/glasses/sunglasses/big/new_bimex
	fluff_cost = 4

/datum/gear/eyewear/new_bimex/bronze
	display_name = "BiMex偏光墨镜，青铜色"
	path = /obj/item/clothing/glasses/sunglasses/big/new_bimex/bronze
	fluff_cost = 4

/datum/gear/eyewear/prescription_sunglasses
	display_name = "处方太阳镜"
	path = /obj/item/clothing/glasses/sunglasses/prescription

/datum/gear/eyewear/sunglasses
	display_name = "太阳镜"
	path = /obj/item/clothing/glasses/sunglasses

/datum/gear/mask
	category = "Masks and scarves"
	slot = WEAR_FACE

/datum/gear/mask/balaclava_black
	display_name = "巴拉克拉法帽，黑色"
	path = /obj/item/clothing/mask/balaclava

/datum/gear/mask/balaclava_green
	display_name = "巴拉克拉法帽，绿色"
	path = /obj/item/clothing/mask/balaclava/tactical

/datum/gear/mask/coif
	display_name = "头套"
	path = /obj/item/clothing/mask/rebreather/scarf

/datum/gear/mask/face_wrap_black
	display_name = "面罩，黑色"
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/black

/datum/gear/mask/face_wrap_green
	display_name = "面罩，绿色"
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/green

/datum/gear/mask/face_wrap_grey
	display_name = "面罩，灰色"
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask

/datum/gear/mask/face_wrap_red
	display_name = "面罩，红色"
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red

/datum/gear/mask/face_wrap_tan
	display_name = "面罩，棕褐色"
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/tan

/datum/gear/mask/face_wrap_squad
	display_name = "面罩，小队专用"
	path =/obj/item/clothing/mask/rebreather/scarf/tacticalmask/squad

/datum/gear/mask/gas
	display_name = "防毒面具"
	path = /obj/item/clothing/mask/gas

/datum/gear/mask/surgical
	display_name = "无菌口罩"
	path = /obj/item/clothing/mask/surgical

/datum/gear/mask/scarf_black
	display_name = "围巾，黑色"
	path = /obj/item/clothing/mask/tornscarf/black

/datum/gear/mask/scarf_desert
	display_name = "围巾，沙漠色"
	path = /obj/item/clothing/mask/tornscarf/desert

/datum/gear/mask/scarf_green
	display_name = "围巾，绿色"
	path = /obj/item/clothing/mask/tornscarf/green

/datum/gear/mask/scarf_grey
	display_name = "围巾，灰色"
	path = /obj/item/clothing/mask/tornscarf

/datum/gear/mask/scarf_urban
	display_name = "围巾，城市迷彩"
	path = /obj/item/clothing/mask/tornscarf/urban

/datum/gear/mask/scarf_white
	display_name = "围巾，白色"
	path = /obj/item/clothing/mask/tornscarf/snow

/datum/gear/mask/neckerchief
	display_name = "领巾，棕褐色"
	path = /obj/item/clothing/mask/neckerchief

/datum/gear/mask/neckerchief/gray
	display_name = "领巾，灰色"
	path = /obj/item/clothing/mask/neckerchief/gray

/datum/gear/mask/neckerchief/green
	display_name = "领巾，绿色"
	path = /obj/item/clothing/mask/neckerchief/green

/datum/gear/mask/neckerchief/black
	display_name = "领巾，黑色"
	path = /obj/item/clothing/mask/neckerchief/black

/datum/gear/mask/neckerchief/squad
	display_name = "领巾，小队专用"
	path = /obj/item/clothing/mask/neckerchief/squad

/datum/gear/mask/keffiyeh
	display_name = "阿拉伯头巾" // Traditional middle-eastern headdress, works like a balaclava/scarf.
	path = /obj/item/clothing/mask/rebreather/scarf/keffiyeh

/datum/gear/mask/keffiyeh_white
	display_name = "阿拉伯头巾，白色"
	path = /obj/item/clothing/mask/rebreather/scarf/keffiyeh/white

/datum/gear/mask/keffiyeh_red
	display_name = "阿拉伯头巾，红色"
	path = /obj/item/clothing/mask/rebreather/scarf/keffiyeh/red

/datum/gear/mask/keffiyeh_green
	display_name = "绿色头巾"
	path = /obj/item/clothing/mask/rebreather/scarf/keffiyeh/green

/datum/gear/mask/keffiyeh_black
	display_name = "黑色头巾"
	path = /obj/item/clothing/mask/rebreather/scarf/keffiyeh/black

/datum/gear/mask/keffiyeh_blue
	display_name = "蓝色头巾"
	path = /obj/item/clothing/mask/rebreather/scarf/keffiyeh/blue

/datum/gear/mask/uscm
	allowed_origins = USCM_ORIGINS

/datum/gear/mask/uscm/balaclava_green
	display_name = "USCM巴拉克拉瓦头套，绿色"
	path = /obj/item/clothing/mask/rebreather/scarf/green

/datum/gear/mask/uscm/balaclava_grey
	display_name = "USCM巴拉克拉瓦头套，灰色"
	path = /obj/item/clothing/mask/rebreather/scarf/gray

/datum/gear/mask/uscm/balaclava_tan
	display_name = "USCM巴拉克拉瓦头套，棕褐色"
	path = /obj/item/clothing/mask/rebreather/scarf/tan

/datum/gear/mask/uscm/skull_balaclava_blue
	display_name = "USCM巴拉克拉瓦头套，蓝色骷髅"
	path = /obj/item/clothing/mask/rebreather/skull
	fluff_cost = 4 //same as skull facepaint
	slot = WEAR_FACE

/datum/gear/mask/uscm/skull_balaclava_black
	display_name = "USCM巴拉克拉瓦头套，黑色骷髅"
	path = /obj/item/clothing/mask/rebreather/skull/black
	fluff_cost = 4
	slot = WEAR_FACE

/datum/gear/headwear
	category = "Headwear"
	fluff_cost = 2
	slot = WEAR_HEAD

/datum/gear/headwear/durag_black
	display_name = "杜拉格头巾，黑色"
	path = /obj/item/clothing/head/durag/black

/datum/gear/headwear/durag
	display_name = "杜拉格头巾，任务专用"
	path = /obj/item/clothing/head/durag

/datum/gear/headwear/uscm
	allowed_origins = USCM_ORIGINS

/datum/gear/headwear/uscm/bandana_green
	display_name = "USCM头巾，绿色"
	path = /obj/item/clothing/head/cmbandana

/datum/gear/headwear/uscm/bandana_tan
	display_name = "USCM头巾，棕褐色"
	path = /obj/item/clothing/head/cmbandana/tan

/datum/gear/headwear/uscm/beanie_grey
	display_name = "USCM针织帽，灰色"
	path = /obj/item/clothing/head/beanie/gray

/datum/gear/headwear/uscm/beanie_green
	display_name = "USCM针织帽，绿色"
	path = /obj/item/clothing/head/beanie/green

/datum/gear/headwear/uscm/beanie_tan
	display_name = "USCM针织帽，棕褐色"
	path = /obj/item/clothing/head/beanie/tan

/datum/gear/headwear/uscm/beret_squad
	display_name = "USCM贝雷帽，小队专用"
	path = /obj/item/clothing/head/beret/cm/squadberet

/datum/gear/headwear/uscm/beret_green
	display_name = "USCM贝雷帽，绿色"
	path = /obj/item/clothing/head/beret/cm/green

/datum/gear/headwear/uscm/beret_tan
	display_name = "USCM贝雷帽，棕褐色"
	path = /obj/item/clothing/head/beret/cm/tan

/datum/gear/headwear/uscm/beret_black
	display_name = "USCM贝雷帽，黑色"
	path = /obj/item/clothing/head/beret/cm/black

/datum/gear/headwear/uscm/beret_white
	display_name = "USCM贝雷帽，白色"
	path = /obj/item/clothing/head/beret/cm/white

/datum/gear/headwear/uscm/boonie_olive
	display_name = "USCM丛林帽，橄榄色"
	path = /obj/item/clothing/head/cmcap/boonie

/datum/gear/headwear/uscm/boonie_tan
	display_name = "USCM丛林帽，棕褐色"
	path = /obj/item/clothing/head/cmcap/boonie/tan

/datum/gear/headwear/uscm/cap
	display_name = "USCM军帽"
	path = /obj/item/clothing/head/cmcap

/datum/gear/headwear/uscm/headband_brown
	display_name = "USCM头带，棕色"
	path = /obj/item/clothing/head/headband/brown

/datum/gear/headwear/uscm/headband_green
	display_name = "USCM头带，绿色"
	path = /obj/item/clothing/head/headband

/datum/gear/headwear/uscm/headband_grey
	display_name = "USCM头带，灰色"
	path = /obj/item/clothing/head/headband/gray

/datum/gear/headwear/uscm/headband_red
	display_name = "USCM头带，红色"
	path = /obj/item/clothing/head/headband/red

/datum/gear/headwear/uscm/headband_tan
	display_name = "USCM头带，棕褐色"
	path = /obj/item/clothing/head/headband/tan

/datum/gear/headwear/uscm/headband_squad
	display_name = "USCM头带，小队专用"
	path = /obj/item/clothing/head/headband/squad

/datum/gear/headwear/uscm/headset
	display_name = "USCM耳机"
	path = /obj/item/clothing/head/headset

/datum/gear/helmet_garb
	category = "Helmet accessories"
	fluff_cost = 1

/datum/gear/helmet_garb/flair_initech
	display_name = "装饰徽章，Initech"
	path = /obj/item/prop/helmetgarb/flair_initech

/datum/gear/helmet_garb/flair_io
	display_name = "装饰徽章，Io"
	path = /obj/item/prop/helmetgarb/flair_io

/datum/gear/helmet_garb/flair_peace
	display_name = "装饰徽章，和平与爱"
	path = /obj/item/prop/helmetgarb/flair_peace

/datum/gear/helmet_garb/flair_uscm
	display_name = "装饰徽章，USCM"
	path = /obj/item/prop/helmetgarb/flair_uscm

/datum/gear/helmet_garb/helmet_gasmask
	display_name = "M5集成式防毒面具"
	path = /obj/item/prop/helmetgarb/helmet_gasmask

/datum/gear/helmet_garb/gunoil
	display_name = "枪油"
	path = /obj/item/prop/helmetgarb/gunoil

/datum/gear/helmet_garb/netting
	display_name = "头盔伪装网"
	path = /obj/item/clothing/accessory/helmet/cover/netting

/datum/gear/helmet_garb/netting/desert
	display_name = "沙漠头盔伪装网"
	path = /obj/item/clothing/accessory/helmet/cover/netting/desert

/datum/gear/helmet_garb/netting/jungle
	display_name = "丛林头盔伪装网"
	path = /obj/item/clothing/accessory/helmet/cover/netting/jungle

/datum/gear/helmet_garb/netting/urban
	display_name = "城市头盔伪装网"
	path = /obj/item/clothing/accessory/helmet/cover/netting/urban

/datum/gear/helmet_garb/lucky_feather
	display_name = "幸运羽毛，红色"
	path = /obj/item/prop/helmetgarb/lucky_feather

/datum/gear/helmet_garb/lucky_feather/yellow
	display_name = "幸运羽毛，黄色"
	path = /obj/item/prop/helmetgarb/lucky_feather/yellow

/datum/gear/helmet_garb/lucky_feather/purple
	display_name = "幸运羽毛，紫色"
	path = /obj/item/prop/helmetgarb/lucky_feather/purple

/datum/gear/helmet_garb/lucky_feather/blue
	display_name = "幸运羽毛，蓝色"
	path = /obj/item/prop/helmetgarb/lucky_feather/blue

/datum/gear/helmet_garb/broken_nvgs
	display_name = "夜视镜，已损坏"
	path = /obj/item/prop/helmetgarb/helmet_nvg/cosmetic

/datum/gear/helmet_garb/prescription_bottle
	display_name = "处方药瓶"
	path = /obj/item/prop/helmetgarb/prescription_bottle

/datum/gear/helmet_garb/raincover
	display_name = "雨罩"
	path = /obj/item/clothing/accessory/helmet/cover/raincover

/datum/gear/helmet_garb/raincover/jungle
	display_name = "丛林雨罩"
	path = /obj/item/clothing/accessory/helmet/cover/raincover/jungle

/datum/gear/helmet_garb/raincover/desert
	display_name = "沙漠雨罩"
	path = /obj/item/clothing/accessory/helmet/cover/raincover/desert

/datum/gear/helmet_garb/raincover/urban
	display_name = "城市雨罩"
	path = /obj/item/clothing/accessory/helmet/cover/raincover/urban

/datum/gear/helmet_garb/rabbits_foot
	display_name = "兔脚"
	path = /obj/item/prop/helmetgarb/rabbitsfoot

/datum/gear/helmet_garb/rosary
	display_name = "念珠"
	path = /obj/item/prop/helmetgarb/rosary

/datum/gear/helmet_garb/spent_buck
	display_name = "用过的霰弹"
	path = /obj/item/prop/helmetgarb/spent_buckshot

/datum/gear/helmet_garb/spent_flechette
	display_name = "用过的箭弹"
	path = /obj/item/prop/helmetgarb/spent_flech

/datum/gear/helmet_garb/spent_slugs
	display_name = "用过的独头弹"
	path = /obj/item/prop/helmetgarb/spent_slug

/datum/gear/helmet_garb/cartridge
	display_name = "弹壳"
	path = /obj/item/prop/helmetgarb/cartridge

/datum/gear/helmet_garb/spacejam_tickets
	display_name = "《太空大灌篮》门票"
	path = /obj/item/prop/helmetgarb/spacejam_tickets

/datum/gear/helmet_garb/trimmed_wire
	display_name = "修剪过的铁丝网"
	path = /obj/item/prop/helmetgarb/trimmed_wire

/datum/gear/helmet_garb/bullet_pipe
	display_name = "10x99mm XM43E1弹壳管"
	path = /obj/item/prop/helmetgarb/bullet_pipe
	allowed_origins = USCM_ORIGINS

/datum/gear/helmet_garb/chaplain_patch
	display_name = "USCM随军牧师头盔徽章"
	path = /obj/item/prop/helmetgarb/chaplain_patch
	allowed_origins = USCM_ORIGINS

/datum/gear/paperwork
	category = "Paperwork"
	fluff_cost = 1

/datum/gear/paperwork/pen
	display_name = "笔，黑色"
	path = /obj/item/tool/pen

/datum/gear/paperwork/pen_blue
	display_name = "笔，蓝色"
	path = /obj/item/tool/pen/blue

/datum/gear/paperwork/pen_green
	display_name = "笔，绿色"
	path = /obj/item/tool/pen/green

/datum/gear/paperwork/pen_red
	display_name = "笔，红色"
	path = /obj/item/tool/pen/red

/datum/gear/paperwork/pen_fountain
	display_name = "钢笔"
	path = /obj/item/tool/pen/multicolor/fountain
	fluff_cost = 2

/datum/gear/paperwork/paper
	display_name = "纸张"
	path = /obj/item/paper
	fluff_cost = 1

/datum/gear/paperwork/clipboard
	display_name = "写字板"
	path = /obj/item/clipboard

/datum/gear/paperwork/folder_black
	display_name = "文件夹，黑色"
	path = /obj/item/folder/black

/datum/gear/paperwork/folder_blue
	display_name = "文件夹，蓝色"
	path = /obj/item/folder/blue

/datum/gear/paperwork/folder_red
	display_name = "文件夹，红色"
	path = /obj/item/folder/red

/datum/gear/paperwork/folder_white
	display_name = "文件夹，白色"
	path = /obj/item/folder/white

/datum/gear/paperwork/folder_yellow
	display_name = "文件夹，黄色"
	path = /obj/item/folder/yellow

/datum/gear/paperwork/notepad_black
	display_name = "记事本，黑色"
	path = /obj/item/notepad/black

/datum/gear/paperwork/notepad_blue
	display_name = "记事本，蓝色"
	path = /obj/item/notepad/blue

/datum/gear/paperwork/notepad_green
	display_name = "记事本，绿色"
	path = /obj/item/notepad/green

/datum/gear/paperwork/notepad_red
	display_name = "红色记事本"
	path = /obj/item/notepad/red

/datum/gear/toy
	category = "Recreational"
	fluff_cost = 1

/datum/gear/toy/camera
	display_name = "相机"
	path = /obj/item/device/camera
	fluff_cost = 2

/datum/gear/toy/camera/disposable
	display_name = "旧一次性相机"
	path = /obj/item/device/camera/oldcamera
	fluff_cost = 3

/datum/gear/toy/mags
	fluff_cost = 1

/datum/gear/toy/mags/magazine_dirty
	display_name = "杂志"
	path = /obj/item/prop/magazine/dirty

/datum/gear/toy/mags/boots_magazine_one
	display_name = "制式靴子 第117号"
	path = /obj/item/prop/magazine/boots/n117

/datum/gear/toy/mags/boots_magazine_two
	display_name = "制式靴子 第150号"
	path = /obj/item/prop/magazine/boots/n150

/datum/gear/toy/mags/boot_magazine_three
	display_name = "制式靴子 第160号"
	path = /obj/item/prop/magazine/boots/n160

/datum/gear/toy/mags/boots_magazine_four
	display_name = "制式靴子 第54号"
	path = /obj/item/prop/magazine/boots/n054

/datum/gear/toy/mags/boots_magazine_five
	display_name = "制式靴子 第55号"
	path = /obj/item/prop/magazine/boots/n055

/datum/gear/toy/film
	display_name = "相机胶卷"
	path = /obj/item/device/camera_film
	fluff_cost = 1

/datum/gear/toy/card
	fluff_cost = 1

/datum/gear/toy/card/ace_of_spades
	display_name = "黑桃A纸牌"
	path = /obj/item/toy/handcard/aceofspades

/datum/gear/toy/card/uno_reverse_red
	display_name = "UNO反转牌 - 红色"
	path = /obj/item/toy/handcard/uno_reverse_red

/datum/gear/toy/card/uno_reverse_blue
	display_name = "UNO反转牌 - 蓝色"
	path = /obj/item/toy/handcard/uno_reverse_blue

/datum/gear/toy/card/uno_reverse_purple
	display_name = "UNO反转牌 - 紫色"
	path = /obj/item/toy/handcard/uno_reverse_purple

/datum/gear/toy/card/uno_reverse_yellow
	display_name = "UNO反转牌 - 黄色"
	path = /obj/item/toy/handcard/uno_reverse_yellow

/datum/gear/toy/card/trading_card
	display_name = "随机维兰德-汤谷交易卡"
	path = /obj/item/toy/trading_card

/datum/gear/toy/deck
	display_name = "标准扑克牌"
	path = /obj/item/toy/deck

/datum/gear/toy/deck/uno
	display_name = "UNO牌"
	path = /obj/item/toy/deck/uno

/datum/gear/toy/trading_card
	display_name = "交易卡包"
	path = /obj/item/storage/fancy/trading_card

/datum/gear/toy/d6
	display_name = "六面骰子"
	path = /obj/item/toy/dice

/datum/gear/toy/d20
	display_name = "二十面骰子"
	path = /obj/item/toy/dice/d20

/datum/gear/toy/walkman
	display_name = "随身听"
	path = /obj/item/device/walkman
	fluff_cost = 2

/datum/gear/toy/crayon
	display_name = "蜡笔"
	path = /obj/item/toy/crayon/rainbow

/datum/gear/toy/pride
	display_name = "骄傲蜡笔盒"
	path = /obj/item/storage/box/pride

/datum/gear/weapon
	category = "Weapons"
	fluff_cost = 4

/datum/gear/weapon/type_80_bayonet
	display_name = "80式刺刀"
	path = /obj/item/attachable/bayonet/upp_replica

/datum/gear/weapon/antique_Bayonet
	display_name = "古董刺刀" // ancient bayonet - family heirloom perhaps
	path = /obj/item/attachable/bayonet/antique

/datum/gear/weapon/L5_Bayonet
	display_name = "L5刺刀"
	path = /obj/item/attachable/bayonet/rmc_replica

/datum/gear/weapon/custom_Bayonet
	display_name = "M5'渡鸦之爪'战术刺刀" // custom style bayonet with variants, exclusive to loadout and unique. Name might need changing.
	path = /obj/item/attachable/bayonet/custom

/datum/gear/weapon/custom_Bayonet/red
	display_name = "M5'渡鸦之爪'战术刺刀，红色"
	path = /obj/item/attachable/bayonet/custom/red

/datum/gear/weapon/custom_Bayonet/blue
	display_name = "M5'渡鸦之爪'战术刺刀，蓝色"
	path = /obj/item/attachable/bayonet/custom/blue

/datum/gear/weapon/custom_Bayonet/black
	display_name = "M5'渡鸦之爪'战术刺刀，黑色"
	path = /obj/item/attachable/bayonet/custom/black

/datum/gear/weapon/tanto_Bayonet
	display_name = "T9战术刺刀" // TWE/CLF bayonet
	path = /obj/item/attachable/bayonet/tanto

/datum/gear/weapon/tanto_Bayonet/blue
	display_name = "T9战术刺刀，蓝色"
	path = /obj/item/attachable/bayonet/tanto/blue

/datum/gear/weapon/m8_cartridge_bayonet
	display_name = "M8弹匣刺刀"
	path = /obj/item/storage/box/co2_knife

/datum/gear/weapon/clfpistol
	display_name = "D18隐匿手枪"
	path = /obj/item/storage/box/clf

/datum/gear/weapon/upppistol //ww2 war trophy luger
	display_name = "73式手枪"
	path = /obj/item/storage/box/upp
	slot = WEAR_IN_BACK
	fluff_cost = 4

/datum/gear/weapon/l54_pistol
	display_name = "L54手枪" // TWE service pistol - same stats as the m4a3
	path = /obj/item/weapon/gun/pistol/l54
	allowed_origins = USCM_ORIGINS

/datum/gear/weapon/holdout
	display_name = "W62'低语者'" //22LR ratkiller and/or plinker
	path = /obj/item/storage/box/plinker

/datum/gear/weapon/action
	display_name = "AC71'行动者'" //380ACP holdout pistol
	path = /obj/item/storage/box/action

/datum/gear/weapon/m4a3_custom
	display_name = "M4A3定制手枪"
	path = /obj/item/weapon/gun/pistol/m4a3/custom
	allowed_origins = USCM_ORIGINS

/datum/gear/weapon/m4a4
	display_name = "M4A4制式手枪"
	path = /obj/item/weapon/gun/pistol/m4a3/m4a4
	allowed_origins = USCM_ORIGINS
	fluff_cost = 2

/datum/gear/weapon/m44_custom_revolver
	display_name = "M44定制左轮手枪"
	path = /obj/item/weapon/gun/revolver/m44/custom
	allowed_origins = USCM_ORIGINS

/datum/gear/drink
	category = "Canned drinks"
	fluff_cost = 1

/datum/gear/drink/water
	display_name = "瓶装水"
	path = /obj/item/reagent_container/food/drinks/cans/waterbottle
	fluff_cost = 1

/datum/gear/drink/grape_juice
	display_name = "葡萄汁"
	path = /obj/item/reagent_container/food/drinks/cans/grape_juice

/datum/gear/drink/lemon_lime
	display_name = "柠檬青柠"
	path = /obj/item/reagent_container/food/drinks/cans/lemon_lime

/datum/gear/drink/iced_tea
	display_name = "冰茶"
	path = /obj/item/reagent_container/food/drinks/cans/iced_tea

/datum/gear/drink/cola
	display_name = "经典可乐"
	path = /obj/item/reagent_container/food/drinks/cans/classcola

/datum/gear/drink/mountain_wind
	display_name = "山风"
	path = /obj/item/reagent_container/food/drinks/cans/space_mountain_wind

/datum/gear/drink/space_up
	display_name = "太空向上"
	path = /obj/item/reagent_container/food/drinks/cans/space_up

/datum/gear/drink/souto_classic
	display_name = "经典索托"
	path = /obj/item/reagent_container/food/drinks/cans/souto/classic

/datum/gear/drink/souto_diet
	display_name = "低糖索托"
	path = /obj/item/reagent_container/food/drinks/cans/souto/diet/classic

/datum/gear/drink/boda
	display_name = "博达苏打"
	path = /obj/item/reagent_container/food/drinks/cans/boda
	fluff_cost = 2 //Legally imported from UPP.

/datum/gear/drink/boda/plus
	display_name = "博达可乐"
	path = /obj/item/reagent_container/food/drinks/cans/bodaplus

/datum/gear/drink/alcohol
	fluff_cost = 2 //Illegal in military.

/datum/gear/drink/alcohol/ale
	display_name = "维兰德-汤谷IPA艾尔啤酒"
	path = /obj/item/reagent_container/food/drinks/cans/ale

/datum/gear/drink/alcohol/aspen
	display_name = "维兰德-汤谷阿斯彭啤酒"
	path = /obj/item/reagent_container/food/drinks/cans/aspen

/datum/gear/drink/alcohol/beer
	display_name = "维兰德-汤谷淡啤酒"
	path = /obj/item/reagent_container/food/drinks/cans/beer

/datum/gear/drink/alcohol/loko
	display_name = "十三乐可"
	path = /obj/item/reagent_container/food/drinks/cans/thirteenloko

/datum/gear/flask
	category = "Flasks"
	fluff_cost = 1

/datum/gear/flask/canteen
	display_name = "军用水壶"
	path = /obj/item/reagent_container/food/drinks/flask/canteen

/datum/gear/flask/leather
	display_name = "皮革酒壶"
	path = /obj/item/reagent_container/food/drinks/flask/detflask

/datum/gear/flask/leather_black
	display_name = "黑色皮革酒壶"
	path = /obj/item/reagent_container/food/drinks/flask/barflask

/datum/gear/flask/metal
	display_name = "金属酒壶"
	path = /obj/item/reagent_container/food/drinks/flask

/datum/gear/flask/uscm
	display_name = "USCM酒壶"
	path = /obj/item/reagent_container/food/drinks/flask/marine

/datum/gear/flask/vacuum
	display_name = "真空保温壶"
	path = /obj/item/reagent_container/food/drinks/flask/vacuumflask

/datum/gear/flask/wy
	display_name = "WY酒壶"
	path = /obj/item/reagent_container/food/drinks/flask/weylandyutani

/datum/gear/snack_sweet
	category = "Food (sweets)"
	fluff_cost = 1

/datum/gear/snack_sweet/candy
	display_name = "糖果棒"
	path = /obj/item/reagent_container/food/snacks/candy

/datum/gear/snack_sweet/chocolate
	display_name = "巧克力棒"
	path = /obj/item/reagent_container/food/snacks/chocolatebar

/datum/gear/snack_sweet/candy_apple
	display_name = "糖苹果"
	path = /obj/item/reagent_container/food/snacks/candiedapple

/datum/gear/snack_sweet/cookie
	display_name = "曲奇饼"
	path = /obj/item/reagent_container/food/snacks/cookie

/datum/gear/snack_sweet/fortune_cookie
	display_name = "幸运饼干"
	path = /obj/item/reagent_container/food/snacks/fortunecookie/prefilled

/datum/gear/snack_sweet/donut_normal
	display_name = "甜甜圈"
	path = /obj/item/reagent_container/food/snacks/donut/normal

/datum/gear/snack_sweet/donut_jelly
	display_name = "果冻甜甜圈"
	path = /obj/item/reagent_container/food/snacks/donut/jelly

/datum/gear/snack_sweet/donut_cherry
	display_name = "樱桃甜甜圈"
	path = /obj/item/reagent_container/food/snacks/donut/cherryjelly

/datum/gear/snack_packaged
	category = "Food (packaged)"
	fluff_cost = 1

/datum/gear/snack_packaged/beef_jerky
	display_name = "牛肉干"
	path = /obj/item/reagent_container/food/snacks/sosjerky

/datum/gear/snack_packaged/meat_bar
	display_name = "肉条"
	path = /obj/item/reagent_container/food/snacks/eat_bar

/datum/gear/snack_packaged/kepler_crisps
	display_name = "开普勒薯片"
	path = /obj/item/reagent_container/food/snacks/kepler_crisps

/datum/gear/snack_packaged/burrito
	display_name = "包装墨西哥卷饼"
	path = /obj/item/reagent_container/food/snacks/packaged_burrito

/datum/gear/snack_packaged/cheeseburger
	display_name = "包装芝士汉堡"
	path = /obj/item/reagent_container/food/snacks/packaged_burger

/datum/gear/snack_packaged/hotdog
	display_name = "包装热狗"
	path = /obj/item/reagent_container/food/snacks/packaged_hdogs

/datum/gear/snack_packaged/chips_pepper
	display_name = "维兰德胡椒薯片"
	path = /obj/item/reagent_container/food/snacks/wy_chips/pepper

/datum/gear/snack_grown
	category = "Food (healthy)"
	fluff_cost = 1

/datum/gear/snack_grown/apple
	display_name = "苹果"
	path = /obj/item/reagent_container/food/snacks/grown/apple

/datum/gear/snack_grown/carrot
	display_name = "胡萝卜"
	path = /obj/item/reagent_container/food/snacks/grown/carrot

/datum/gear/snack_grown/corn
	display_name = "玉米"
	path = /obj/item/reagent_container/food/snacks/grown/corn

/datum/gear/snack_grown/lemon
	display_name = "柠檬"
	path = /obj/item/reagent_container/food/snacks/grown/lemon

/datum/gear/snack_grown/lime
	display_name = "青柠"
	path = /obj/item/reagent_container/food/snacks/grown/lime

/datum/gear/snack_grown/orange
	display_name = "橙子"
	path = /obj/item/reagent_container/food/snacks/grown/orange

/datum/gear/snack_grown/potato
	display_name = "土豆"
	path = /obj/item/reagent_container/food/snacks/grown/potato

/datum/gear/snack_grown/cheese
	display_name = "奶酪"
	path = /obj/item/reagent_container/food/snacks/cheesewedge

/datum/gear/smoking
	category = "Smoking"
	fluff_cost = 1

/datum/gear/smoking/cigarette
	display_name = "香烟"
	path = /obj/item/clothing/mask/cigarette
	fluff_cost = 1
	slot = WEAR_FACE

/datum/gear/smoking/cigarette/cigar_classic
	display_name = "经典雪茄"
	path = /obj/item/clothing/mask/cigarette/cigar/classic
	fluff_cost = 3

/datum/gear/smoking/cigarette/cigar_premium
	display_name = "高级雪茄"
	path = /obj/item/clothing/mask/cigarette/cigar
	fluff_cost = 2

/datum/gear/smoking/cigarette/tarbacks
	display_name = "焦背牌烟盒"
	path = /obj/item/storage/fancy/cigar/tarbacks
	fluff_cost = 6

/datum/gear/smoking/cigarette/tarbacktube
	display_name = "焦背牌烟管"
	path = /obj/item/storage/fancy/cigar/tarbacktube
	fluff_cost = 2

/datum/gear/smoking/pack_emerald_green
	display_name = "翡翠绿牌香烟"
	path = /obj/item/storage/fancy/cigarettes/emeraldgreen

/datum/gear/smoking/pack_lucky_strikes
	display_name = "好运牌香烟"
	path = /obj/item/storage/fancy/cigarettes/lucky_strikes

/datum/gear/smoking/arcturian_ace
	display_name = "阿克图里安王牌香烟"
	path = /obj/item/storage/fancy/cigarettes/arcturian_ace

/datum/gear/smoking/lady_finger
	display_name = "淑女指牌香烟"
	path = /obj/item/storage/fancy/cigarettes/lady_finger

/datum/gear/smoking/lucky_strikes_4
	display_name = "迷你好运牌香烟"
	path = /obj/item/storage/fancy/cigarettes/lucky_strikes_4

/datum/gear/smoking/wypacket
	display_name = "维兰德-汤谷金牌香烟"
	path = /obj/item/storage/fancy/cigarettes/wypacket
	fluff_cost = 2

/datum/gear/smoking/spirit
	display_name = "绿松石美国精神牌香烟"
	path = /obj/item/storage/fancy/cigarettes/spirit

/datum/gear/smoking/yellow
	display_name = "黄色美国精神牌香烟"
	path = /obj/item/storage/fancy/cigarettes/spirit/yellow

/datum/gear/smoking/kpack
	display_name = "库兰德金装烟"
	path = /obj/item/storage/fancy/cigarettes/kpack
	fluff_cost = 2

/datum/gear/smoking/weed_joint
	display_name = "太空草烟卷"
	path = /obj/item/clothing/mask/cigarette/weed
	fluff_cost = 2

/datum/gear/smoking/lighter
	display_name = "廉价打火机"
	path = /obj/item/tool/lighter/random
	fluff_cost = 1

/datum/gear/smoking/zippo
	display_name = "芝宝打火机"
	path = /obj/item/tool/lighter/zippo

/datum/gear/smoking/zippo/black
	display_name = "黑色芝宝打火机"
	path = /obj/item/tool/lighter/zippo/black

/datum/gear/smoking/zippo/gold
	display_name = "金色芝宝打火机"
	path = /obj/item/tool/lighter/zippo/gold
	fluff_cost = 3

/datum/gear/smoking/zippo/executive
	display_name = "维兰德-汤谷高管芝宝打火机"
	path = /obj/item/tool/lighter/zippo/executive
	fluff_cost = 3

/datum/gear/smoking/zippo/blue
	display_name = "蓝色芝宝打火机"
	path = /obj/item/tool/lighter/zippo/blue

/datum/gear/smoking/electronic_cigarette
	display_name = "电子烟"
	path = /obj/item/clothing/mask/electronic_cigarette

/datum/gear/smoking/electronic_cigarette/cigar
	display_name = "电子雪茄"
	path = /obj/item/clothing/mask/electronic_cigarette/cigar

/datum/gear/misc
	category = "Miscellaneous"

/datum/gear/misc/facepaint_green
	display_name = "绿色油彩"
	path = /obj/item/facepaint/green

/datum/gear/misc/facepaint_brown
	display_name = "棕色油彩"
	path = /obj/item/facepaint/brown

/datum/gear/misc/facepaint_black
	display_name = "黑色油彩"
	path = /obj/item/facepaint/black

/datum/gear/misc/facepaint_skull
	display_name = "骷髅油彩"
	path = /obj/item/facepaint/skull
	fluff_cost = 3

/datum/gear/misc/facepaint_body
	display_name = "全身涂装"
	path = /obj/item/facepaint/sniper
	fluff_cost = 3

/datum/gear/misc/jungle_boots
	display_name = "丛林迷彩作战靴"
	path = /obj/item/clothing/shoes/marine/jungle
	fluff_cost = 2

/datum/gear/misc/brown_boots
	display_name = "棕色作战靴"
	path = /obj/item/clothing/shoes/marine/brown
	fluff_cost = 2

/datum/gear/misc/brown_gloves
	display_name = "棕色作战手套"
	path = /obj/item/clothing/gloves/marine/brown
	fluff_cost = 2

/datum/gear/misc/fingerless_gloves
	display_name = "露指作战手套"
	path = /obj/item/clothing/gloves/marine/fingerless
	fluff_cost = 2

/datum/gear/misc/grey_boots
	display_name = "灰色作战靴"
	path = /obj/item/clothing/shoes/marine/grey
	fluff_cost = 2

/datum/gear/misc/urban_boots
	display_name = "城市迷彩作战靴"
	path = /obj/item/clothing/shoes/marine/urban
	fluff_cost = 2

/datum/gear/misc/grey_gloves
	display_name = "灰色作战手套"
	path = /obj/item/clothing/gloves/marine/grey
	fluff_cost = 2

/datum/gear/misc/pdt_kit
	display_name = "PDT/L工具包"
	path = /obj/item/storage/box/pdt_kit
	fluff_cost = 3

/datum/gear/misc/sunscreen_stick
	display_name = "USCM制式防晒霜"
	path = /obj/item/facepaint/sunscreen_stick
	fluff_cost = 1 //The cadmium poisoning pays for the discounted cost longterm
	allowed_origins = USCM_ORIGINS

/datum/gear/misc/dogtags
	display_name = "可挂载身份牌"
	path = /obj/item/clothing/accessory/dogtags
	fluff_cost = 1
	slot = WEAR_IN_ACCESSORY
	allowed_origins = USCM_ORIGINS

/datum/gear/misc/patch_uscm
	display_name = "坠隼小队肩章"
	path = /obj/item/clothing/accessory/patch/falcon/squad_main
	fluff_cost = 1
	slot = WEAR_IN_ACCESSORY
	allowed_origins = USCM_ORIGINS

/datum/gear/misc/patch_uscm/medic_patch
	display_name = "战地医疗兵肩章"
	path = /obj/item/clothing/accessory/patch/medic_patch

/datum/gear/misc/armband
	display_name = "小队袖标"
	path = /obj/item/clothing/accessory/armband/squad
	fluff_cost = 1

/datum/gear/misc/family_photo
	display_name = "家庭照片"
	path = /obj/item/prop/helmetgarb/family_photo
	fluff_cost = 1

/datum/gear/misc/compass
	display_name = "指南针"
	path = /obj/item/prop/helmetgarb/compass
	fluff_cost = 1

/datum/gear/misc/bug_spray
	display_name = "杀虫喷雾"
	path = /obj/item/prop/helmetgarb/bug_spray
	fluff_cost = 1

/datum/gear/misc/straight_razor
	display_name = "直剃刀"
	path = /obj/item/weapon/straight_razor
	fluff_cost = 2

/datum/gear/misc/watch
	display_name = "廉价腕表"
	path = /obj/item/clothing/accessory/wrist/watch
	fluff_cost = 1 // Cheap and crappy

// Civilian only

/datum/gear/civilian
	category = "Civilian only (restricted)"
	allowed_origins = list(ORIGIN_CIVILIAN)

///Commented out until we have a factional system to restrict these properly
// /datum/gear/civilian/patch
// 	display_name = "Weyland-Yutani shoulder patch, black"
// 	path = /obj/item/clothing/accessory/patch/wy
// 	fluff_cost = 1
// 	slot = WEAR_IN_ACCESSORY

// /datum/gear/civilian/patch/wysquare
// 	display_name = "Weyland-Yutani shoulder patch"
// 	path = /obj/item/clothing/accessory/patch/wysquare

// /datum/gear/civilian/patch/wy_white
// 	display_name = "Weyland-Yutani shoulder patch, white"
// 	path = /obj/item/clothing/accessory/patch/wy_white

// /datum/gear/civilian/patch/wy_fury
// 	display_name = "维兰德-汤谷 狂怒 '161' 徽章"
// 	path = /obj/item/clothing/accessory/patch/wyfury

// /datum/gear/civilian/patch/twepatch
// 	display_name = "Three World Empire shoulder patch"
// 	path = /obj/item/clothing/accessory/patch/twe

// /datum/gear/civilian/patch/cec
// 	display_name = "Cosmos Exploration Corps shoulder patch"
// 	path = /obj/item/clothing/accessory/patch/cec_patch

// /datum/gear/civilian/patch/hyperdyne
// 	display_name = "Hyperdyne Corporation shoulder patch"
// 	path = /obj/item/clothing/accessory/patch/hyperdyne_patch

// Misc Headwear

/datum/gear/civilian/headwear
	fluff_cost = 2
	slot = WEAR_HEAD

/datum/gear/civilian/headwear/cowboy_hat
	display_name = "棕色牛仔帽"
	path = /obj/item/clothing/head/cowboy

/datum/gear/civilian/headwear/cowboy_hat/light
	display_name = "浅棕色牛仔帽"
	path = /obj/item/clothing/head/cowboy/light

// Cheap Civilian shades - colorful!

/datum/gear/civilian/eyewear/bimax_shades
	display_name = "BiMax个人墨镜"
	path = /obj/item/clothing/glasses/sunglasses/big/fake

/datum/gear/civilian/eyewear/bimax_shades/red
	display_name = "BiMax个人墨镜，红色"
	path = /obj/item/clothing/glasses/sunglasses/big/fake/red

/datum/gear/civilian/eyewear/bimax_shades/orange
	display_name = "BiMax个人墨镜，橙色"
	path = /obj/item/clothing/glasses/sunglasses/big/fake/orange

/datum/gear/civilian/eyewear/bimax_shades/yellow
	display_name = "BiMax个人墨镜，黄色"
	path = /obj/item/clothing/glasses/sunglasses/big/fake/yellow

/datum/gear/civilian/eyewear/bimax_shades/green
	display_name = "BiMax个人墨镜，绿色"
	path = /obj/item/clothing/glasses/sunglasses/big/fake/green

/datum/gear/civilian/eyewear/bimax_shades/blue
	display_name = "BiMax个人墨镜，蓝色"
	path = /obj/item/clothing/glasses/sunglasses/big/fake/blue

// Hippie Shades

/datum/gear/eyewear/sunglasses/hippie_shades/pink
	display_name = "Suntex-Sightware圆框墨镜，粉色"
	path = /obj/item/clothing/glasses/sunglasses/hippie

/datum/gear/eyewear/sunglasses/hippie_shades/green
	display_name = "Suntex-Sightware圆框墨镜，绿色"
	path = /obj/item/clothing/glasses/sunglasses/hippie/green

/datum/gear/eyewear/sunglasses/hippie_shades/sunrise
	display_name = "Suntex-Sightware圆框墨镜，日出色"
	path = /obj/item/clothing/glasses/sunglasses/hippie/sunrise

/datum/gear/eyewear/sunglasses/hippie_shades/sunset
	display_name = "Suntex-Sightware圆框墨镜，日落色"
	path = /obj/item/clothing/glasses/sunglasses/hippie/sunset

/datum/gear/eyewear/sunglasses/hippie_shades/nightblue
	display_name = "Suntex-Sightware圆框墨镜，夜蓝色"
	path = /obj/item/clothing/glasses/sunglasses/hippie/nightblue

/datum/gear/eyewear/sunglasses/hippie_shades/midnight
	display_name = "Suntex-Sightware圆框墨镜，午夜色"
	path = /obj/item/clothing/glasses/sunglasses/hippie/midnight

/datum/gear/eyewear/sunglasses/hippie_shades/bloodred
	display_name = "Suntex-Sightware圆框墨镜，血红色"
	path = /obj/item/clothing/glasses/sunglasses/hippie/bloodred

// Headband

/datum/gear/civilian/headwear/headband_rebel
	display_name = "CLF头带"
	path = /obj/item/clothing/head/headband/rebel
	fluff_cost = 2

// Civilian shoes

/datum/gear/civilian/shoes
	display_name = "黑色鞋子"
	path = /obj/item/clothing/shoes/black
	fluff_cost = 1

/datum/gear/civilian/shoes/brown
	display_name = "棕色鞋子"
	path = /obj/item/clothing/shoes/brown

/datum/gear/civilian/shoes/blue
	display_name = "蓝色鞋子"
	path = /obj/item/clothing/shoes/blue

/datum/gear/civilian/shoes/green
	display_name = "绿色鞋子"
	path = /obj/item/clothing/shoes/green

/datum/gear/civilian/shoes/yellow
	display_name = "黄色鞋子"
	path = /obj/item/clothing/shoes/yellow

/datum/gear/civilian/shoes/purple
	display_name = "紫色鞋子"
	path = /obj/item/clothing/shoes/purple

/datum/gear/civilian/shoes/red
	display_name = "红色鞋子"
	path = /obj/item/clothing/shoes/red

/datum/gear/civilian/shoes/rainbow
	display_name = "彩虹鞋子"
	path = /obj/item/clothing/shoes/rainbow

// Plushies - either civilian only or removed completely perhaps...

/datum/gear/civilian/plush/farwa
	display_name = "法瓦玩偶"
	path = /obj/item/toy/plush/farwa

/datum/gear/civilian/plush/barricade
	display_name = "路障玩偶"
	path = /obj/item/toy/plush/barricade

/datum/gear/civilian/plush/bee
	display_name = "蜜蜂玩偶"
	path = /obj/item/toy/plush/bee

/datum/gear/civilian/plush/shark
	display_name = "鲨鱼玩偶"
	path = /obj/item/toy/plush/shark

/datum/gear/civilian/plush/gnarp
	display_name = "格纳普玩偶"
	path = /obj/item/toy/plush/gnarp

/datum/gear/civilian/plush/gnarp/alt
	display_name = "格纳普玩偶（替代）"
	path = /obj/item/toy/plush/gnarp/alt

/datum/gear/civilian/plush/rock
	display_name = "岩石玩偶"
	path = /obj/item/toy/plush/rock

/datum/gear/civilian/plush/therapy
	display_name = "治疗玩偶"
	path = /obj/item/toy/plush/therapy

/datum/gear/civilian/plush/therapy/red
	display_name = "治疗玩偶（红色）"
	path = /obj/item/toy/plush/therapy/red

/datum/gear/civilian/plush/therapy/blue
	display_name = "治疗玩偶（蓝色）"
	path = /obj/item/toy/plush/therapy/blue

/datum/gear/civilian/plush/therapy/green
	display_name = "治疗玩偶（绿色）"
	path = /obj/item/toy/plush/therapy/green

/datum/gear/civilian/plush/therapy/orange
	display_name = "治疗玩偶（橙色）"
	path = /obj/item/toy/plush/therapy/orange

/datum/gear/civilian/plush/therapy/purple
	display_name = "治疗玩偶（紫色）"
	path = /obj/item/toy/plush/therapy/purple

/datum/gear/civilian/plush/therapy/yellow
	display_name = "治疗玩偶（黄色）"
	path = /obj/item/toy/plush/therapy/yellow
