/proc/spawn_reagent(target, volume)
	message_admins("[usr] spawned in a container of [target] with a volume of [volume]u")

	if(volume > 300)
		var/obj/structure/reagent_dispensers/tank/fuel/custom/C = new(usr.loc, volume, target)
		C.reagents.add_reagent(target, volume)

		if(alert(usr, "是否要设置燃料箱的爆炸功能？（这将禁止向箱内转移或从箱内转移燃料）", "", "Yes", "No") == "Yes")
			var/explosive_power = tgui_input_number(usr,"功率")
			var/falloff = tgui_input_number(usr, "基础衰减")

			if(explosive_power && falloff)

				C.reagents.max_ex_power = explosive_power
				C.reagents.base_ex_falloff = max(1, falloff)

				C.reagents.locked = TRUE

				message_admins("[usr] modified [C] ([target]) to have [C.reagents.max_ex_power] explosive power and [C.reagents.base_ex_falloff] falloff")

	else if(volume > 120)
		var/obj/item/reagent_container/glass/beaker/bluespace/C = new /obj/item/reagent_container/glass/beaker/bluespace(usr.loc)
		C.reagents.add_reagent(target,volume)
	else if (volume > 60)
		var/obj/item/reagent_container/glass/beaker/large/C = new /obj/item/reagent_container/glass/beaker/large(usr.loc)
		C.reagents.add_reagent(target,volume)
	else if (volume > 30)
		var/obj/item/reagent_container/glass/beaker/C = new /obj/item/reagent_container/glass/beaker(usr.loc)
		C.reagents.add_reagent(target,volume)
	else
		var/obj/item/reagent_container/glass/beaker/vial/C = new /obj/item/reagent_container/glass/beaker/vial(usr.loc)
		C.reagents.add_reagent(target,volume)
	return


/datum/admins/proc/topic_chems(href)
	switch(href)
		if("view_reagent")
			var/response = alert(usr,"输入ID还是从列表中选择ID？",null, "Enter ID","Select from list")
			var/target
			if(response == "Select from list")
				var/list/pool = GLOB.chemical_reagents_list
				pool = sortAssoc(pool)
				target = tgui_input_list(usr,"选择你想查看的化学试剂ID：", "View reagent", pool)
			else if(response == "Enter ID")
				target = input(usr,"输入你想查看的化学试剂ID：")
			if(!target)
				return
			var/datum/reagent/R = GLOB.chemical_reagents_list[target]
			if(R)
				usr.client.debug_variables(R)
			else
				to_chat(usr,SPAN_WARNING("未找到具有此ID的试剂。"))
			return
		if("view_reaction")
			var/target = input(usr,"输入你想查看的化学反应ID：")
			if(!target)
				return
			var/datum/chemical_reaction/R = GLOB.chemical_reactions_list[target]
			if(R)
				usr.client.debug_variables(R)
				log_admin("[key_name(usr)] is viewing the chemical reaction for [R].")
			else
				to_chat(usr,SPAN_WARNING("未找到具有此ID的反应。"))
			return
		if("sync_filter")
			var/target = input(usr,"输入你想同步的化学反应ID。这仅在你通过调试器（VV）编辑了反应时才需要。")
			if(!target)
				return
			var/datum/chemical_reaction/R = GLOB.chemical_reactions_list[target]
			if(R)
				R.add_to_filtered_list(TRUE)
				log_debug("[key_name(usr)] resyncronized [R.id]")
				to_chat(usr,SPAN_WARNING("已重新同步[R.id]。"))
			else
				to_chat(usr,SPAN_WARNING("未找到具有此ID的反应。"))
			return
		if("spawn_reagent")
			var/target = input(usr,"输入你想制造的化学试剂ID：")
			if(!GLOB.chemical_reagents_list[target])
				to_chat(usr,SPAN_WARNING("未找到具有此ID的试剂。"))
				return
			var/volume = tgui_input_number(usr,"制造多少？将选择一个合适的容器。")
			if(volume <= 0)
				return

			spawn_reagent(target, volume)
			return
		if("make_report")
			var/target = input(usr, "输入你想为其生成报告的化学试剂ID：")
			if(!GLOB.chemical_reagents_list[target])
				to_chat(usr, SPAN_WARNING("未找到具有此ID的试剂。"))
				return

			var/datum/reagent/R = GLOB.chemical_reagents_list[target]
			R.print_report(loc = usr.loc, admin_spawned = TRUE)
		//For quickly generating a new chemical
		if("create_random_reagent")
			var/target = input(usr,"输入你想制造的化学试剂ID：")
			if(!target)
				return
			if(GLOB.chemical_reagents_list[target])
				to_chat(usr,SPAN_WARNING("此ID已被占用。"))
				return
			var/tier = tgui_input_number(usr,"输入你期望的生成等级。这将影响属性数量（等级+1）、组件稀有度和获得良好属性的潜力。应为1-4，最大10。", "Generation tier", 1, 10)
			if(tier <= 0)
				return
			if(tier > 10)
				tier = 10
			var/datum/reagent/generated/R = new /datum/reagent/generated
			R.id = target
			R.gen_tier = tier
			R.chemclass = CHEM_CLASS_ULTRA
			R.save_chemclass()
			R.properties = list()
			R.generate_name()
			R.generate_stats()
			//Save our reagent
			GLOB.chemical_reagents_list[target] = R
			message_admins("[key_name_admin(usr)] has generated the reagent: [target].")
			var/response = alert(usr,"你还需要做其他事吗？",null,"Generate associated reaction","View my reagent","Finish")
			while(response != "Finish")
				switch(response)
					if("Generate associated reaction")
						if(GLOB.chemical_reactions_list[target])
							to_chat(usr,SPAN_WARNING("此ID已被占用。"))
							return
						R.generate_assoc_recipe()
						if(!GLOB.chemical_reactions_list[target])
							to_chat(usr,SPAN_WARNING("保存反应时出错。相关试剂已被删除。"))
							GLOB.chemical_reagents_list[target] -= R
							return
						response = alert(usr,"你还需要做其他事吗？",null,"View my reaction","View my reagent","Finish")
					if("View my reagent")
						if(GLOB.chemical_reagents_list[target])
							R = GLOB.chemical_reagents_list[target]
							usr.client.debug_variables(R)
							log_admin("[key_name(usr)] is viewing the chemical reaction for [R].")
						else
							to_chat(usr,SPAN_WARNING("未找到具有此ID的试剂。等等，什么？但我刚刚……联系调试员。"))
							GLOB.chemical_reagents_list.Remove(target)
							GLOB.chemical_reactions_list.Remove("[target]")
							GLOB.chemical_reactions_filtered_list.Remove("[target]")
						return
					if("View my reaction")
						if(GLOB.chemical_reactions_list[target])
							var/datum/chemical_reaction/generated/G = GLOB.chemical_reactions_list[target]
							usr.client.debug_variables(G)
						else
							to_chat(usr,SPAN_WARNING("未找到具有此ID的反应。等等，什么？但我刚刚……联系调试员。"))
							GLOB.chemical_reagents_list.Remove(target)
							GLOB.chemical_reactions_list.Remove("[target]")
							GLOB.chemical_reactions_filtered_list.Remove("[target]")
						return
					else
						break
			//See what we want to do last
			if(alert(usr,"是否生成带有试剂的容器？","Custom reagent [target]","Yes","No") != "Yes")
				return
			var/volume = tgui_input_number(usr,"制造多少？将选择一个合适的容器。")
			if(volume <= 0)
				return
		//For creating a custom reagent
		if("create_custom_reagent")
			var/target = input(usr,"输入你想制造的化学试剂ID：")
			if(!target)
				return
			if(GLOB.chemical_reagents_list[target])
				to_chat(usr,SPAN_WARNING("此ID已被占用。"))
				return
			var/datum/reagent/generated/R = new /datum/reagent/generated
			R.id = target
			R.chemclass = CHEM_CLASS_NONE //So we don't count it towards defcon
			R.properties = list()
			R.overdose = 15
			R.overdose_critical = 30
			var/response = alert(usr,"使用大写ID作为名称？","Custom reagent [target]","[capitalize(target)]","Random name")
			if(!response)
				return
			if(response == "Random name")
				R.generate_name()
			else
				R.name = capitalize(response)
			response = alert(usr,"你想定制什么？","Custom reagent [target]","Add property","Randomize non property vars","Finish")
			while(response != "Finish")
				switch(response)
					if("Add property")
						response = alert(usr,"特定属性还是特定数量的随机属性？","Custom reagent [target]","Specific property","Specific number","No more properties")
					if("Specific property")
						response = alert(usr,"选择输入类型","Custom reagent [target]","Manual Input","Select","No more properties")
					if("Manual Input")
						var/input = input(usr,"输入你想要添加的化学属性名称：")
						var/datum/chem_property/P = GLOB.chemical_properties_list[input]
						if(!P)
							to_chat(usr,SPAN_WARNING("未找到属性，你拼写正确吗？"))
							response = "Specific property"
						else
							var/level = tgui_input_number(usr,"选择等级（这是一个强度修正器，应在1-8之间）", "strengthmod", 1)
							R.insert_property(P.name,level)
							response = alert(usr,"完成。添加更多？","Custom reagent [target]","Specific property","Specific number","No more properties")
					if("Select")
						var/list/pool = GLOB.chemical_properties_list
						pool = sortAssoc(pool)
						var/P = tgui_input_list(usr,"你想要哪个属性？", "Property selection", pool)
						var/level = tgui_input_number(usr,"选择等级（这是一个强度修正器，应在1-8之间）", "strengthmod", 1)
						R.insert_property(P,level)
						response = alert(usr,"完成。添加更多？","Custom reagent [target]","Specific property","Specific number","No more properties")
					if("Specific number")
						var/number = tgui_input_number(usr,"需要多少属性？")
						R.gen_tier = tgui_input_number(usr,"输入生成层级。这将影响属性的强度。必须在1-5之间。", "generation tier", 1, 5, 1)
						if(number > 10)
							number = 10
						for(var/i=1,i<=number,i++)
							R.add_property()
						response = alert(usr,"完成。接下来你想定制什么？","Custom reagent [target]","Add property","Randomize non property vars","Finish")
					if("No more properties")
						response = alert(usr,"你想定制什么？","Custom reagent [target]","Add property","Randomize non property vars","Finish")
					if("Randomize non property vars")
						R.generate_stats(1)
						response = alert(usr,"完成。接下来你想定制什么？","Custom reagent [target]","Add property","Randomize non property vars","Finish")
					else
						break
			R.generate_description()
			//Save our reagent
			GLOB.chemical_reagents_list[target] = R
			message_admins("[key_name_admin(usr)] has created a custom reagent: [target].")
			//See what we want to do last
			response = alert(usr,"是否生成带有试剂的容器？","Custom reagent [target]","Yes","No, show me the reagent","No, I'm all done")
			switch(response)
				if("Yes")
					var/volume = tgui_input_number(usr,"制造多少？将选择一个合适的容器。")
					if(volume <= 0)
						return

					spawn_reagent(target, volume)
				if("No, show me the reagent")
					usr.client.debug_variables(GLOB.chemical_reagents_list[target])
			return
		//For creating a custom reaction
		if("create_custom_reaction")
			var/target = input(usr,"输入你想要创建的化学反应ID：")
			if(!target)
				return
			if(GLOB.chemical_reactions_list[target])
				to_chat(usr,SPAN_WARNING("此ID已被占用。"))
				return
			var/datum/chemical_reaction/generated/R = new /datum/chemical_reaction/generated
			R.id = target
			R.result = input(usr,"输入反应应产生的试剂ID：")
			R.name = capitalize(target)
			var/modifier = 1
			var/component = "water"
			var/catalyst = FALSE
			var/response = alert(usr,"你想定制什么？","Custom reaction [target]","Add component","Add catalyst","Finish")
			while(response != "Finish")
				switch(response)
					if("Add component")
						catalyst = FALSE
						response = "Select type"
					if("Add catalyst")
						catalyst = TRUE
						response = "Select type"
					if("Select type")
						response = alert(usr,"手动输入ID还是从列表中选择？","Custom reaction [target]","Select from list","Manual input","Back")
					if("Select from list")
						var/list/pool = GLOB.chemical_reagents_list
						pool = sortAssoc(pool)
						component = tgui_input_list(usr,"选择：", "Create custom reaction", pool)
						if(!component)
							response = "Select type"
							continue
						response = "Add"
					if("Manual input")
						component = input(usr,"输入试剂ID：")
						if(!component)
							response = "Select type"
							continue
						if(!GLOB.chemical_reagents_list[component])
							to_chat(usr,SPAN_WARNING("未找到ID。请重试。"))
							continue
						response = "Add"
					if("Add")
						modifier = tgui_input_number(usr, "每次反应需要多少？")
						R.add_component(component,modifier,catalyst)
						response = "Back"
					if("Back")
						response = alert(usr,"你想定制什么？","Custom reaction [target]","Add component","Add catalyst","Finish")
					else
						return
			if(length(R.required_reagents) < 3)
				to_chat(usr,SPAN_WARNING("你需要添加至少3个催化剂以外的成分。反应尚未保存。"))
				return
			//Save our reaction
			GLOB.chemical_reactions_list[target] = R
			R.add_to_filtered_list()
			if(!GLOB.chemical_reactions_list[target])
				to_chat(usr,SPAN_WARNING("保存反应时出错。"))
				return
			usr.client.debug_variables(GLOB.chemical_reactions_list[target])
			message_admins("[key_name_admin(usr)] has created a custom chemical reaction: [target].")
			return
