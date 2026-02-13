
//This proc is the most basic of the procs. All it does is make a new mob on the same tile and transfer over a few variables.
//Returns the new mob
//Note that this proc does NOT do MMI related stuff!
/mob/proc/change_mob_type(new_type = null, turf/location = null, new_name = null as text, delete_old_mob = FALSE, subspecies, datacore_check = FALSE)
	if(istype(src,/mob/new_player))
		to_chat(usr, SPAN_DANGER("无法转换尚未进入游戏的玩家。"))
		return

	if(!new_type)
		new_type = input("Mob type path:", "生物类型") as text|null

	if(istext(new_type))
		new_type = text2path(new_type)

	if( !ispath(new_type) )
		to_chat(usr, "change_mob_type()中存在无效类型路径（new_type = [new_type]）。请联系程序员。")
		return

	if( new_type == /mob/new_player )
		to_chat(usr, SPAN_DANGER("无法转换为新玩家生物类型。"))
		return

	var/mob/M
	if(isturf(location))
		M = new new_type( location )
	else
		M = new new_type( src.loc )

	if(!M || !ismob(M))
		to_chat(usr, "change_mob_type()中的类型路径不是生物（new_type = [new_type]）。请联系程序员。")
		qdel(M)
		return

	if(mind)
		mind.transfer_to(M, TRUE)

	if(subspecies && istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		H.set_species(subspecies)

	if(M.client && M.client.prefs)
		M.client.prefs.copy_all_to(M, check_datacore = datacore_check)

	if(istext(new_name))
		M.change_real_name(M, new_name)
	else
		if(!isxeno(M)) //Xenos have their own naming convention, leave them alone!
			M.change_real_name(M, name)

	if(delete_old_mob)
		QDEL_IN(src, 1)
	return M
