/client/var/inquisitive_ghost = 1
/mob/dead/observer/verb/toggle_inquisition() // warning: unexpected inquisition
	set name = "Toggle Inquisitiveness"
	set desc = "Sets whether your ghost examines everything on click by default."
	set category = "Ghost.Settings"
	if(!client)
		return
	client.inquisitive_ghost = !client.inquisitive_ghost
	if(client.inquisitive_ghost)
		to_chat(src, SPAN_NOTICE("你现在将检查所有点击的对象。"))
	else
		to_chat(src, SPAN_NOTICE("你将不再检查点击的对象。"))

/mob/dead/observer/do_click(atom/A, location, params)
	. = ..()
	if(check_click_intercept(params, A))
		return

	if(SEND_SIGNAL(src, COMSIG_OBSERVER_CLICKON, A, params) & COMSIG_MOB_CLICK_CANCELED)
		return

/mob/dead/observer/click(atom/target, list/mods)
	if(..())
		return TRUE

	if (mods[SHIFT_CLICK] && mods[MIDDLE_CLICK])
		point_to(target)
		return TRUE

	if(mods[CTRL_CLICK])
		if(target == src)
			if(!can_reenter_corpse || !mind || !mind.current)
				return FALSE
			if(tgui_alert(src, "你确定要重新进入你的尸体吗？", "确认", list("Yes", "No")) == "Yes")
				reenter_corpse()
			return TRUE

		if(isxeno(target))
			if(isfacehugger(target) || islesserdrone(target))
				do_observe(target) // Can't offer takeover for lessers or facehuggers
				return TRUE

			//if it's a xeno and all checks are alright, we are gonna try to take their body
			if(!SSticker.mode.check_xeno_late_join(src))
				do_observe(target)
				return TRUE

			var/mob/living/carbon/xenomorph/xeno = target
			var/dead_or_ignored = xeno.stat == DEAD || should_block_game_interaction(xeno)
			if(dead_or_ignored || xeno.aghosted)
				if(dead_or_ignored)
					to_chat(src, SPAN_WARNING("你不能以[xeno]身份加入。"))
				do_observe(xeno)
				return TRUE

			if(xeno.health <= 0)
				to_chat(src, SPAN_WARNING("如果异形处于危急状态或昏迷，则不能加入。"))
				do_observe(xeno)
				return TRUE

			var/required_leave_time = XENO_LEAVE_TIMER
			var/required_dead_time = XENO_JOIN_DEAD_TIME
			if(islarva(xeno))
				required_leave_time = XENO_LEAVE_TIMER_LARVA
				required_dead_time = XENO_JOIN_DEAD_LARVA_TIME

			if(xeno.away_timer < required_leave_time)
				var/to_wait = required_leave_time - xeno.away_timer
				if(to_wait < 30) // don't spam for clearly non-AFK xenos
					to_chat(src, SPAN_WARNING("该玩家离开的时间还不够长。请再等待[to_wait]秒。"))
				do_observe(target)
				return TRUE

			if(!SSticker.mode.xeno_bypass_timer)
				var/deathtime = world.time - timeofdeath
				if(deathtime < required_dead_time && !bypass_time_of_death_checks)
					to_chat(src, SPAN_WARNING("你已经死亡[DisplayTimeText(deathtime)]。"))
					to_chat(src, SPAN_WARNING("你必须至少等待[required_dead_time / 600]分钟才能重新加入游戏！"))
					do_observe(target)
					return TRUE

			if(xeno.hive)
				for(var/mob_name in xeno.hive.banished_ckeys)
					if(xeno.hive.banished_ckeys[mob_name] == ckey)
						to_chat(src, SPAN_WARNING("你已被[xeno.hive]驱逐，除非女王重新接纳你或死亡，否则不能重新加入。"))
						do_observe(target)
						return TRUE

			if(tgui_alert(src, "你确定要将自己转移到[xeno]中吗？", "Confirm Transfer", list("Yes", "No")) != "Yes")
				do_observe(target)
				return TRUE

			if(QDELETED(xeno) || xeno.away_timer < required_leave_time || xeno.stat == DEAD || !(xeno in GLOB.living_xeno_list)) // Do it again, just in case
				to_chat(src, SPAN_WARNING("该异形已无法控制。请尝试另一个。"))
				return TRUE

			SSticker.mode.transfer_xeno(src, xeno)
			return TRUE

		if(ismob(target) || isVehicle(target))
			do_observe(target)
			return TRUE

		if(!istype(target, /atom/movable/screen))
			following = null
			abstract_move(get_turf(target))
			return TRUE

	if(world.time <= next_move)
		return TRUE

	next_move = world.time + 8
	// You are responsible for checking config.ghost_interaction when you override this function
	// Not all of them require checking, see below
	if(!mods[SHIFT_CLICK])
		target.attack_ghost(src)
	return FALSE

// Oh by the way this didn't work with old click code which is why clicking shit didn't spam you
/atom/proc/attack_ghost(mob/dead/observer/user)
	if(user.client && user.client.inquisitive_ghost)
		examine(user)

// ---------------------------------------
// And here are some good things for free:
// Now you can click through portals, wormholes, gateways, and teleporters while observing. -Sayu

/obj/structure/machinery/teleport/hub/attack_ghost(mob/user as mob)
	var/atom/l = loc
	var/obj/structure/machinery/computer/teleporter/com = locate(/obj/structure/machinery/computer/teleporter, locate(l.x - 2, l.y, l.z))
	if(com && com.locked)
		user.forceMove(get_turf(com.locked))

/obj/effect/portal/attack_ghost(mob/user as mob)
	if(target)
		user.forceMove(get_turf(target))

/obj/structure/ladder/attack_ghost(mob/user as mob)
	var/obj/structure/ladder/ladder_dest
	if(up && down)
		ladder_dest = lowertext(show_radial_menu(user, src, direction_selection, require_near = FALSE))
		if(ladder_dest == "up")
			user.forceMove(get_turf(up))
		if(ladder_dest == "down")
			user.forceMove(get_turf(down))
	else if(up)
		user.forceMove(get_turf(up))
	else if(down)
		user.forceMove(get_turf(down))
	else
		return FALSE //just in case
// -------------------------------------------
// This was supposed to be used by adminghosts
// I think it is a *terrible* idea
// but I'm leaving it here anyway
// commented out, of course.
/*
/atom/proc/attack_admin(mob/user as mob)
	if(!user || !user.client || !user.client.admin_holder)
		return
	attack_hand(user)

*/

/* This allows Observers to click on disconnected Larva and become them, but not all Larva are clickable due to hiding
/mob/living/carbon/xenomorph/larva/attack_ghost(mob/user as mob)
	if(!istype(src, /mob/living/carbon/xenomorph/larva))
		return

	// if(src.key || src.mind || !src.client.is_afk())
	if(src.client)
		return

	if(!can_mind_transfer) //away_timer is not high enough. Number below should match number in mob.dm.
		to_chat(user, "该玩家离开的时间还不够长。请再等待[60 - away_timer]秒。")
		return

	if (alert(user, "你确定要将自己转移到这个异形幼虫中吗？", "确认", "Yes", "No") == "Yes")
		src.client = user.client
		return*/
