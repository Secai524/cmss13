// patient_exam defines
#define PATIENT_NOT_AWAKE 1
#define PATIENT_LOW_BLOOD 2
#define PATIENT_LOW_NUTRITION 4

/obj/structure/machinery/optable
	name = "手术台"
	desc = "用于高级医疗程序。"
	icon = 'icons/obj/structures/machinery/surgery.dmi'
	icon_state = "table2-idle"
	density = TRUE
	layer = TABLE_LAYER
	anchored = TRUE
	unslashable = TRUE
	unacidable = TRUE
	climbable = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 1
	active_power_usage = 5
	var/strapped = 0
	can_buckle = TRUE
	buckle_lying = 90
	var/buckling_y = -4
	surgery_duration_multiplier = SURGERY_SURFACE_MULT_IDEAL //Ideal surface for surgery.
	var/patient_exam = 0
	var/obj/item/tank/anesthetic/anes_tank

	var/obj/structure/machinery/computer/operating/computer = null

/obj/structure/machinery/optable/Initialize()
	. = ..()
	for(dir in list(NORTH,EAST,SOUTH,WEST))
		computer = locate(/obj/structure/machinery/computer/operating, get_step(src, dir))
		if (computer)
			computer.table = src
			break
	anes_tank = new(src)

/obj/structure/machinery/optable/Destroy()
	QDEL_NULL(anes_tank)
	QDEL_NULL(computer)
	. = ..()

/obj/structure/machinery/optable/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER|PASS_AROUND

/obj/structure/machinery/optable/ex_act(severity)

	switch(severity)
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if (prob(25))
				src.density = FALSE
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if (prob(50))
				deconstruct(FALSE)
				return
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)
			return

/obj/structure/machinery/optable/get_examine_text(mob/user)
	. = ..()
	if(get_dist(user, src) > 2 && !isobserver(user))
		return
	if(anes_tank)
		. += SPAN_INFO("It has an [anes_tank] connected with the gauge showing [round(anes_tank.pressure,0.1)] kPa.")

/obj/structure/machinery/optable/attack_hand(mob/living/user)
	if(buckled_mob)
		unbuckle(user)
		return
	if(anes_tank)
		user.put_in_active_hand(anes_tank)
		to_chat(user, SPAN_NOTICE("你将\the [anes_tank]从\the [src]上取下。"))
		anes_tank = null

// Removing marines connected to anesthetic
/obj/structure/machinery/optable/attack_alien(mob/living/carbon/xenomorph/alien, mob/living/user)
	if(buckled_mob)
		to_chat(alien, SPAN_XENONOTICE("你扯断宿主身上的管子，将其释放！"))
		playsound(alien, "alien_claw_flesh", 25, 1)
		unbuckle(user)
	else
		. = ..()

/obj/structure/machinery/optable/buckle_mob(mob/living/carbon/human/H, mob/living/user)
	if(!istype(H) || !ishuman(user) || H == user || H.buckled || user.action_busy || user.is_mob_incapacitated() || buckled_mob)
		return

	if(H.loc != loc)
		to_chat(user, SPAN_WARNING("病人需要先躺在手术台上。"))
		return

	if(!H.has_limb("head"))
		to_chat(user, SPAN_WARNING("病人没有头部。"))
		return

	if(!anes_tank)
		to_chat(user, SPAN_WARNING("手术台没有连接麻醉剂罐，请先装载一个。"))
		return
	H.visible_message(SPAN_NOTICE("[user]开始将[H]连接到麻醉系统。"))
	if(!do_after(user, 25, INTERRUPT_NO_NEEDHAND, BUSY_ICON_FRIENDLY))
		to_chat(user, SPAN_NOTICE("你停止将面罩戴在[H]脸上。"))
		return

	if(H.buckled || buckled_mob || H.loc != loc)
		return

	if(!anes_tank)
		to_chat(user, SPAN_WARNING("手术台没有连接麻醉剂罐，请先装载一个。"))
		return
	if(!H.has_limb("head"))
		to_chat(user, SPAN_WARNING("病人没有头部。"))
		return

	if(H.wear_mask)
		var/obj/item/mask = H.wear_mask
		if(mask.flags_inventory & CANTSTRIP)
			to_chat(user, SPAN_DANGER("你无法移除他们的面罩！"))
			return
		H.drop_inv_item_on_ground(mask)
	var/obj/item/clothing/mask/breath/medical/B = new()
	if(!H.equip_if_possible(B, WEAR_FACE, TRUE))
		to_chat(user, SPAN_DANGER("你无法将防毒面具戴在他们脸上！"))
		return
	H.update_inv_wear_mask()

	do_buckle(H, user)

/obj/structure/machinery/optable/do_buckle(mob/target, mob/user)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = target
	H.internal = anes_tank
	H.visible_message(SPAN_NOTICE("[user]将面罩戴在[H]脸上并打开了麻醉剂。"))
	to_chat(H, SPAN_INFO("你开始感到困倦。"))
	H.setDir(SOUTH)
	start_processing()
	update_icon()

/obj/structure/machinery/optable/unbuckle(mob/living/user)
	if(!buckled_mob)
		return
	if(ishuman(buckled_mob)) // sanity check
		var/mob/living/carbon/human/H = buckled_mob
		H.internal = null
		var/obj/item/M = H.wear_mask
		H.drop_inv_item_on_ground(M)
		qdel(M)
		if(ishuman(user)) //Checks for whether a xeno is unbuckling from the operating table
			H.visible_message(SPAN_NOTICE("[user]关闭麻醉剂并从[H]脸上取下面罩。"))
		else
			H.visible_message(SPAN_WARNING("麻醉面罩从[H]脸上被扯下！"))
		stop_processing()
		patient_exam = 0
		..()
		update_icon()

/obj/structure/machinery/optable/afterbuckle(mob/M)
	. = ..()
	if(. && buckled_mob == M)
		M.old_y = M.pixel_y
		M.pixel_y = buckling_y
	else
		M.pixel_y = M.old_y

/obj/structure/machinery/optable/MouseDrop_T(atom/A, mob/user)

	if(istype(A, /obj/item))
		var/obj/item/I = A
		if (!istype(I) || user.get_active_hand() != I)
			return
		if(user.drop_held_item())
			if (I.loc != loc)
				step(I, get_dir(I, src))
	else if(ismob(A))
		..()

/obj/structure/machinery/optable/update_icon()
	if(inoperable())
		icon_state = "table2-idle"
	else if(!ishuman(buckled_mob))
		icon_state = "table2-idle"
	else
		var/mob/living/carbon/human/H = buckled_mob
		icon_state = H.pulse ? "table2-active" : "table2-idle"

/obj/structure/machinery/optable/process()
	update_icon()

	if(!ishuman(buckled_mob))
		stop_processing()

	var/mob/living/carbon/human/H = buckled_mob

	// Check for problems
	// Check for blood
	if(H.blood_volume < BLOOD_VOLUME_SAFE)
		if(!(patient_exam & PATIENT_LOW_BLOOD))
			visible_message("[icon2html(src, viewers(src))] <b>[src]发出哔哔声，</b>警告：病人血液水平危险偏低：[floor(H.blood_volume / BLOOD_VOLUME_NORMAL * 100)]%。血型：[H.blood_type]。")
			patient_exam |= PATIENT_LOW_BLOOD
	else
		patient_exam &= ~PATIENT_LOW_BLOOD

	// Check for nutrition
	if(H.nutrition < NUTRITION_LOW)
		if(!(patient_exam & PATIENT_LOW_NUTRITION))
			visible_message("[icon2html(src, viewers(src))] <b>[src]发出哔哔声，</b>警告：患者营养水平极低：[floor(H.nutrition / NUTRITION_MAX * 100)]%。")
			patient_exam |= PATIENT_LOW_NUTRITION
	else
		patient_exam &= ~PATIENT_LOW_NUTRITION

	// Check if they awake
	switch(H.stat)
		if(0)
			patient_exam &= ~PATIENT_NOT_AWAKE
		if(1)
			if(!(patient_exam & PATIENT_NOT_AWAKE))
				visible_message("[icon2html(src, viewers(src))] <b>[src]发出哔哔声，</b>警告：患者已昏迷。")
				patient_exam |= PATIENT_NOT_AWAKE
		if(2)
			if(!(patient_exam & PATIENT_NOT_AWAKE))
				visible_message("[icon2html(src, viewers(src))] <b>[src]发出哔哔声，</b>警告：患者已死亡。")
				patient_exam |= PATIENT_NOT_AWAKE

/obj/structure/machinery/optable/proc/take_victim(mob/living/carbon/C, mob/living/carbon/user)
	if (C == user)
		user.visible_message(SPAN_NOTICE("[user]爬上了手术台。"),
			SPAN_NOTICE("You climb on the operating table."), null, null, 4)
	else
		visible_message(SPAN_NOTICE("[user]已将[C]平放在手术台上。"), null, 4)
	C.resting = 1
	C.forceMove(loc)

	add_fingerprint(user)

/obj/structure/machinery/optable/verb/mount_table()
	set name = "Mount Operating Table"
	set category = "Object"
	set src in oview(1)

	var/mob/living/carbon/human/H = usr
	if(!istype(H) || H.stat || H.is_mob_restrained() || !check_table(H))
		return

	take_victim(H, H)

/obj/structure/machinery/optable/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/tank/anesthetic))
		if(!anes_tank)
			user.drop_inv_item_to_loc(W, src)
			anes_tank = W
			to_chat(user, SPAN_NOTICE("你将\the [anes_tank]连接到\the [src]。"))
			return
	if (istype(W, /obj/item/grab) && ishuman(user))
		var/obj/item/grab/G = W
		if(buckled_mob)
			to_chat(user, SPAN_WARNING("手术台已被占用！"))
			return
		var/mob/living/carbon/human/M
		if(ishuman(G.grabbed_thing))
			M = G.grabbed_thing
			if(M.buckled)
				to_chat(user, SPAN_WARNING("先解开安全带！"))
				return
		else if(istype(G.grabbed_thing,/obj/structure/closet/bodybag/cryobag))
			var/obj/structure/closet/bodybag/cryobag/C = G.grabbed_thing
			if(!C.stasis_mob)
				return
			M = C.stasis_mob
			C.open(user)
			user.stop_pulling()
			user.start_pulling(M)
		else
			return

		take_victim(M,user)

/obj/structure/machinery/optable/proc/check_table(mob/living/carbon/patient)
	if(buckled_mob)
		to_chat(patient, SPAN_NOTICE("<B>手术台已被占用！</B>"))
		return FALSE

	if(patient.buckled)
		to_chat(patient, SPAN_NOTICE("<B>先解开固定带！</B>"))
		return FALSE

	return TRUE

/obj/structure/machinery/optable/yautja
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'
