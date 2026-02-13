
//=============================//WY PRIVATE SECURITY (GOONS)\\==================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate
	name = "\improper WY corporate security helmet"
	desc = "公司安保人员佩戴的基础骷髅头盔，评级可保护头部免受手持撬棍的失控科学家伤害。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/WY.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/WY.dmi'
	)
	icon_state = "sec_helmet"
	item_state = "sec_helmet"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/ppo
	icon_state = "ppo_helmet"
	item_state = "ppo_helmet"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/medic
	desc = "公司安保人员佩戴的基础骷髅头盔。此款没有面罩，让佩戴者能更好地观察任何潜在病人。"
	icon_state = "med_helmet"
	item_state = "med_helmet"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/engi
	name = "\improper WY corporate security technician helmet"
	desc = "公司安保人员佩戴的基础骷髅头盔。此款配备标准集成焊接面罩。长时间使用容易起雾。"
	icon_state = "eng_helmet"
	item_state = "eng_helmet"
	built_in_visors = list(new /obj/item/device/helmet_visor/welding_visor/goon)

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/lead
	desc = "公司安保人员佩戴的基础骷髅头盔。此款由脑容量太大塞不进旧头盔的低级守卫佩戴。至少他们是这么说的。"
	icon_state = "sec_lead_helmet"
	item_state = "sec_lead_helmet"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/kutjevo
	desc = "公司安保人员佩戴的基础骷髅头盔。此款带有更宽的帽檐，以保护使用者免受沙漠严酷气候的影响。"
	icon_state = "sec_helmet_kutjevo"
	item_state = "sec_helmet_kutjevo"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/kutjevo/medic
	desc = "公司安保人员佩戴的基础骷髅头盔。此款带有更宽的帽檐以保护使用者免受沙漠严酷气候的影响，并且正面有一个医疗十字标志。"
	icon_state = "sec_medic_helmet_kutjevo"
	item_state = "sec_medic_helmet_kutjevo"
