/obj/structure/closet/secure_closet/emergency
	name = "应急柜"
	desc = "这是一个固定的、由身份卡锁定的存储单元，使用劫持协议来确定其开启和解锁行为。"
	icon_state = "secure1"
	store_mobs = FALSE
	var/hijack = FALSE

/obj/structure/closet/secure_closet/emergency/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_HIJACK_INBOUND, PROC_REF(open_up))

/obj/structure/closet/secure_closet/emergency/togglelock(mob/living/user)
	if(hijack == FALSE)
		to_chat(user, SPAN_WARNING("在撤离程序期间，此储物柜将自动解锁并打开。"))
	else
		return ..()

/obj/structure/closet/secure_closet/emergency/attackby(obj/item/W, mob/living/user)
	if(hijack == FALSE)
		to_chat(user, SPAN_WARNING("在撤离程序期间，此储物柜将自动解锁并打开。"))
	else
		return ..()

/obj/structure/closet/secure_closet/emergency/attack_hand(mob/living/user)
	if(hijack == FALSE)
		to_chat(user, SPAN_WARNING("在撤离程序期间，此储物柜将自动解锁并打开。"))
	else
		return ..()

/obj/structure/closet/secure_closet/emergency/verb_toggleopen(mob/living/user)
	if(hijack == FALSE)
		to_chat(user, SPAN_WARNING("在撤离程序期间，此储物柜将自动解锁并打开。"))
	else
		return ..()

/obj/structure/closet/secure_closet/emergency/AIShiftClick()
	return

/obj/structure/closet/secure_closet/emergency/proc/open_up() //A DROPSHIP HAS BEEN HIJACKED! OPEN DIS BITCH UP!
	hijack = TRUE
	unlock()
	open()
