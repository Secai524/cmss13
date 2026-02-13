
//meson goggles

/obj/item/clothing/glasses/meson
	name = "光学介子扫描仪"
	desc = "用于保护使用者眼睛免受有害电磁辐射，也可用作通用安全护目镜。不足以作为焊接防护。"
	icon = 'icons/obj/items/clothing/glasses/huds.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/huds.dmi',
	)
	icon_state = "meson"
	item_state = "glasses"
	deactive_state = "degoggles"
	actions_types = list(/datum/action/item_action/toggle/hudgoggles)
	toggleable = TRUE
	fullscreen_vision = /atom/movable/screen/fullscreen/meson

/obj/item/clothing/glasses/meson/prescription
	name = "处方光学介子扫描仪"
	desc = "用于保护使用者眼睛免受有害电磁辐射，也可用作安全护目镜。包含处方镜片。"
	prescription = TRUE

/obj/item/clothing/glasses/meson/refurbished
	name = "翻新介子扫描仪"
	desc = "用于保护使用者眼睛免受有害电磁辐射，也可用作通用安全护目镜。这是光学系统升级的特殊版本。"
	icon_state = "refurb_meson"
	item_state = "glasses"
	darkness_view = 12
	lighting_alpha = LIGHTING_PLANE_ALPHA_SOMEWHAT_INVISIBLE
	vision_flags = SEE_TURFS
	flags_inventory = COVEREYES
	flags_item = MOB_LOCK_ON_EQUIP
	fullscreen_vision = /atom/movable/screen/fullscreen/meson/refurb
