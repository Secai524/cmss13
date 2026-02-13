//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/datum/song
	var/name = "Untitled"
	var/list/lines = new()
	var/tempo = 5

/obj/structure/device/broken_piano
	name = "损坏的老式钢琴"
	icon = 'icons/obj/structures/props/furniture/musician.dmi'
	desc = "真可惜。这架钢琴看起来再也无法演奏了。永远不能。甚至别问。"
	icon_state = "pianobroken"
	anchored = TRUE
	density = TRUE

/obj/structure/device/broken_moog
	name = "损坏的老式合成器"
	icon = 'icons/obj/structures/props/furniture/musician.dmi'
	desc = "这台太空穆格合成器是老型号，但被砸坏了。看来有人不喜欢它那火辣的新曲调。"
	icon_state = "minimoogbroken"
	anchored = TRUE
	density = TRUE
