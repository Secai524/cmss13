/obj/item/explosive/grenade/empgrenade
	name = "经典电磁脉冲手榴弹"
	desc = "广域电磁脉冲手榴弹。"
	icon_state = "emp"
	item_state = "emp"


/obj/item/explosive/grenade/empgrenade/prime()
	..()
	if(empulse(src, 4, 10, cause_data?.resolve_mob()))
		qdel(src)
	return

/obj/item/explosive/grenade/empgrenade/dutch
	name = "达奇的混合物"
	desc = "广域电磁脉冲手榴弹。标签上写着：'潜行者毁灭者 - 威力极强'。"
	icon_state = "emp"
	item_state = "emp"

/obj/item/explosive/grenade/empgrenade/dutch/prime()
	..()
	if(empulse(src, 15, 20, cause_data?.resolve_mob()))
		qdel(src)
	return
