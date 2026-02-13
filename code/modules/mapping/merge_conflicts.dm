// Used by mapmerge2 to denote the existence of a merge conflict (or when it has to complete a "best intent" merge where it dumps the movable contents of an old key and a new key on the same tile).
// We define it explicitly here to ensure that it shows up on the highest possible plane (while giving off a verbose icon) to aide mappers in resolving these conflicts.
// DO NOT USE THIS IN NORMAL MAPPING!!! Linters WILL fail.

/obj/merge_conflict_marker
	name = "合并冲突标记 - 请勿使用"
	icon = 'icons/landmarks.dmi'
	icon_state = "merge_conflict_marker"
	desc = "如果你在游戏中看到这个：有人真的、真的、真的搞砸了。他们居然在地图里放了一个该死的合并冲突标记。搞什么鬼。"

///We REALLY do not want un-addressed merge conflicts in maps for an inexhaustible list of reasons. This should help ensure that this will not be missed in case linters fail to catch it for any reason what-so-ever.
/obj/merge_conflict_marker/Initialize(mapload)
	. = ..()
	var/msg = "HEY, LISTEN!!! Merge Conflict Marker detected at [AREACOORD(src)]! Please manually address all potential merge conflicts!!!"
	to_chat(world, SPAN_BOLDANNOUNCE("[msg]"))
	CRASH(msg)
