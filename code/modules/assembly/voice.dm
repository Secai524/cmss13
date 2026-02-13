/obj/item/device/assembly/voice
	name = "语音分析器"
	desc = "一种小型电子设备，能够录制语音样本，并在该样本被重复时发送信号。"
	icon_state = "voice"
	matter = list("metal" = 500, "glass" = 50, "waste" = 10)

	var/listening = 0
	var/recorded //the activation message

/obj/item/device/assembly/voice/hear_talk(mob/living/M as mob, msg)
	if(listening)
		recorded = msg
		listening = 0
		var/turf/T = get_turf(src) //otherwise it won't work in hand
		T.visible_message("[icon2html(src, hearers(src))]发出哔哔声，\"Activation message is '[recorded]'.\"")
	else
		if(findtext(msg, recorded))
			pulse(0)

/obj/item/device/assembly/voice/activate()
	if(secured)
		if(!holder)
			listening = !listening
			var/turf/T = get_turf(src)
			T.visible_message("[icon2html(src, hearers(src))]发出哔哔声，\"[listening ? "Now" : "No longer"] recording input.\"")


/obj/item/device/assembly/voice/attack_self(mob/user)
	..()

	if(!user)
		return

	activate()


/obj/item/device/assembly/voice/toggle_secure()
	. = ..()
	listening = 0
