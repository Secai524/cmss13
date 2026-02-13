//Link to thrall bracer, enabling most of it's abilities
/obj/item/clothing/gloves/yautja/hunter/verb/link_bracer()
	set name = "Link Thrall Bracer"
	set desc = "Link your bracer to that of your thrall."
	set category = "Yautja.Thrall"
	set src in usr

	var/mob/living/carbon/human/user = usr
	if(!istype(user))
		return
	if(!user.hunter_data)
		to_chat(user, SPAN_WARNING("错误：未检测到猎人数据。"))
		return

	if(linked_bracer)
		to_chat(user, SPAN_YAUTJABOLD("[icon2html(src)] \The <b>[src]</b>发出哔哔声：链接已建立！"))
		return

	if(user.gloves != src)
		to_chat(user, SPAN_WARNING("你没有佩戴护腕！"))
		return
	else if(!owner || user != owner)
		to_chat(user, SPAN_YAUTJABOLD("[icon2html(src)] \The <b>[src]</b>发出哔哔声：检测到错误用户！"))
		return

	var/mob/living/carbon/human/thrall = user.hunter_data.thrall
	if(!thrall)
		to_chat(user, SPAN_WARNING("你没有可供链接的仆从！"))
		return
	else if(!istype(thrall.gloves, /obj/item/clothing/gloves/yautja/thrall))
		to_chat(user, SPAN_YAUTJABOLD("[icon2html(src)] \The <b>[src]</b>发出哔哔声：你的仆从没有佩戴护腕！"))
		return
	else
		var/obj/item/clothing/gloves/yautja/thrall/thrall_gloves = thrall.gloves

		linked_bracer = thrall_gloves
		thrall_gloves.linked_bracer = src
		thrall_gloves.owner = thrall
		thrall.client?.init_verbs()
		thrall.set_species("奴仆")
		thrall.allow_gun_usage = FALSE
		to_chat(user, SPAN_YAUTJABOLD("[icon2html(src)] \The <b>[src]</b>发出哔哔声：你的护腕现已链接到你的仆从。"))
		if(notification_sound)
			playsound(loc, 'sound/items/pred_bracer.ogg', 75, 1)

		to_chat(thrall, SPAN_WARNING("\The [thrall_gloves] locks around your wrist with a sharp click."))
		to_chat(thrall, SPAN_YAUTJABOLD("[icon2html(thrall_gloves)] \The <b>[thrall_gloves]</b>发出哔哔声：你的主人已将其护腕与你的护腕链接。"))
		if(thrall_gloves.notification_sound)
			playsound(thrall_gloves.loc, 'sound/items/pred_bracer.ogg', 75, 1)

// Message thrall or master
/obj/item/clothing/gloves/yautja/verb/bracer_message()
	set name = "Transmit Message"
	set desc = "For direct communication between thrall and master."
	set src in usr

	var/mob/living/carbon/human/messenger = usr
	if(!istype(messenger))
		return

	var/mob/living/carbon/human/receiver
	var/messenger_title = "thrall"
	var/receiver_title = "master"
	if(messenger.hunter_data.thralled)
		receiver = messenger.hunter_data.thralled_set
	else
		receiver = messenger.hunter_data.thrall
		messenger_title = "master"
		receiver_title = "thrall"

	if(!istype(receiver))
		to_chat(messenger, SPAN_WARNING("你没有可发送消息的对象！"))
		return
	if(!istype(receiver.gloves, /obj/item/clothing/gloves/yautja))
		to_chat(messenger, SPAN_WARNING("你的[receiver_title]没戴臂铠！"))
		return

	var/message = sanitize(input(messenger, "输入你要发送的信息：", "Send Message") as null|text)
	if(!message)
		return

	if(!istype(receiver))
		to_chat(messenger, SPAN_WARNING("你没有可发送消息的对象！"))
		return
	var/obj/item/clothing/gloves/yautja/receiver_gloves = receiver.gloves
	if(!istype(receiver_gloves))
		to_chat(messenger, SPAN_WARNING("你的[receiver_title]没戴臂铠！"))
		return

	to_chat(receiver, SPAN_YAUTJABOLD("\The <b>[receiver_gloves]</b> beeps with a message from your [messenger_title]: [message]"))
	to_chat(messenger, SPAN_YAUTJABOLD("\The <b>[src]</b> beeps: You have sent '[message]' to your [receiver_title]."))

	if(notification_sound)
		playsound(loc, 'sound/items/pred_bracer.ogg', 75, 1)
	if(receiver_gloves.notification_sound)
		playsound(receiver_gloves.loc, 'sound/items/pred_bracer.ogg', 75, 1)

	log_game("HUNTER: [key_name(messenger)] has sent [key_name(receiver)] the message '[message]' via bracer")

/obj/item/clothing/gloves/yautja/hunter/bracer_message()
	set category = "Yautja.Thrall"
	. = ..()

/obj/item/clothing/gloves/yautja/thrall/bracer_message()
	set category = "奴仆"
	. = ..()

/obj/item/clothing/gloves/yautja/hunter/verb/stun_thrall()
	set name = "Stun Thrall"
	set desc = "Stun your thrall when it misbehaves."
	set category = "Yautja.Thrall"
	set src in usr

	var/mob/living/carbon/human/master = usr
	var/mob/living/carbon/human/thrall = master.hunter_data.thrall
	if(!thrall)
		to_chat(master, SPAN_WARNING("你没有仆从可供惩罚！"))
		return
	if(thrall.IsStun())
		to_chat(master, SPAN_WARNING("你的仆从已经眩晕了！"))
		return

	thrall.apply_effect(10, WEAKEN)
	to_chat(master, SPAN_WARNING("你的臂铠哔哔作响，你的仆从受到了惩罚。"))
	to_chat(thrall, SPAN_WARNING("你感到一阵灼热的电击撕裂你的身体！你痛苦地倒在地上！"))

/obj/item/clothing/gloves/yautja/hunter/verb/self_destruct_thrall()
	set name = "Self Destruct Thrall (!)"
	set desc = "Stun and trigger the self destruct device inside of your thrall's bracers. They have failed you. Show no mercy."
	set category = "Yautja.Thrall"
	set src in usr

	var/mob/living/carbon/human/master = usr
	var/mob/living/carbon/human/thrall = master.hunter_data.thrall
	var/area/grounds = get_area(thrall)



	if(master.stat == DEAD)
		to_chat(master, SPAN_WARNING("现在做这个已经太迟了！"))
		return
	if(master.health < master.health_threshold_crit)
		to_chat(master, SPAN_WARNING("当你陷入昏迷时，你在倒下前未能启动自毁装置。"))
		return
	if(master.stat)
		to_chat(master, SPAN_WARNING("在你昏迷时不行..."))
		return
	if(grounds?.flags_area & AREA_YAUTJA_HUNTING_GROUNDS)
		to_chat(master, SPAN_WARNING("你的臂铠不允许你启动自毁程序，以保护狩猎场。"))
		return
	if(!thrall)
		to_chat(master, SPAN_WARNING("你没有仆从可供摧毁！"))

	if(exploding)
		return

	if(tgui_alert(thrall, "你确定要引爆这个[thrall.species]的臂铠吗？此过程无法停止","Self Destruct Thrall", list("Yes", "No")) == "No")
		return

	var/area/area = get_area(thrall)
	var/turf/turf = get_turf(thrall)
	message_admins(FONT_SIZE_HUGE("ALERT: [master] ([master.key]) triggered their thrall's self-destruct sequence [area ? "in [area.name]":""] [ADMIN_JMP(turf)]"))
	log_attack("[key_name(master)] triggered their thrall's self-destruct sequence in [area ? "in [area.name]":""]")
	message_all_yautja("[master.real_name] has triggered their thrall's self-destruction sequence.")
	to_chat(master, SPAN_DANGER("你设定了计时器。他们让你失望了。"))
	explode(thrall)
	exploding = FALSE
	do_after(thrall, (80), INTERRUPT_NONE, BUSY_ICON_HOSTILE)

	if(thrall)
		var/datum/cause_data/cause_data = create_cause_data("thrall remote self-destruct", master)
		cell_explosion(thrall, 800, 550, EXPLOSION_FALLOFF_SHAPE_LINEAR, explosion_cause_data=cause_data)
		thrall.gib() // kills the thrall
		qdel(thrall)

	if(thrall.stat == DEAD)
		return
	thrall.apply_effect(10, WEAKEN)
	to_chat(thrall, SPAN_WARNING("你感到一阵灼热的电击撕裂你的身体！你痛苦地倒在地上！"))
