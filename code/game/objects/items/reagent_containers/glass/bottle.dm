//Not to be confused with /obj/item/reagent_container/food/drinks/bottle

/obj/item/reagent_container/glass/bottle
	name = "bottle"
	desc = "一个小瓶子。"
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "bottle-1"
	item_state = "bottle-1"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,40,50,60)
	flags_atom = FPRINT|OPENCONTAINER
	volume = 60
	attack_speed = 4
	var/randomize = TRUE

/obj/item/reagent_container/glass/bottle/on_reagent_change()
	update_icon()

/obj/item/reagent_container/glass/bottle/pickup(mob/user)
	. = ..()
	update_icon()

/obj/item/reagent_container/glass/bottle/dropped(mob/user)
	..()
	update_icon()

/obj/item/reagent_container/glass/bottle/attack_hand()
	..()
	update_icon()

/obj/item/reagent_container/glass/bottle/Initialize()
	. = ..()
	if(randomize)
		icon_state = "bottle-[rand(1,4)]"

/obj/item/reagent_container/glass/bottle/update_icon()
	overlays.Cut()

	if(reagents.total_volume)
		var/image/filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]10")

		var/percent = floor((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0)
				filling.icon_state = null
			if(1 to 20)
				filling.icon_state = "[icon_state]-20"
			if(21 to 40)
				filling.icon_state = "[icon_state]-40"
			if(41 to 60)
				filling.icon_state = "[icon_state]-60"
			if(61 to 80)
				filling.icon_state = "[icon_state]-80"
			if(81 to INFINITY)
				filling.icon_state = "[icon_state]-100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling

	if(!is_open_container())
		var/image/lid = image(icon, src, "lid_[icon_state]")
		overlays += lid


/obj/item/reagent_container/glass/bottle/inaprovaline
	name = "\improper Inaprovaline bottle"
	desc = "一个小瓶子。内含伊纳普罗瓦林——用于稳定病人状况。"
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/inaprovaline/Initialize()
	. = ..()
	reagents.add_reagent("inaprovaline", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/kelotane
	name = "\improper Kelotane bottle"
	desc = "一个小瓶子。内含凯洛坦——用于治疗烧伤区域。"
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/kelotane/Initialize()
	. = ..()
	reagents.add_reagent("kelotane", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/dexalin
	name = "\improper Dexalin bottle"
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/dexalin/Initialize()
	. = ..()
	reagents.add_reagent("dexalin", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/spaceacillin
	name = "\improper Spaceacillin bottle"
	desc = "一个小瓶子。内含太空青霉素——用于治疗感染伤口。"
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/spaceacillin/Initialize()
	. = ..()
	reagents.add_reagent("spaceacillin", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/toxin
	name = "毒素瓶"
	desc = "一小瓶毒素。请勿饮用，有毒。"
/obj/item/reagent_container/glass/bottle/toxin/Initialize()
	. = ..()
	reagents.add_reagent("toxin", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/cyanide
	name = "氰化物瓶"
	desc = "一小瓶氰化物。苦杏仁味？"

/obj/item/reagent_container/glass/bottle/cyanide/Initialize()
	. = ..()
	reagents.add_reagent("cyanide", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/stoxin
	name = "安眠药瓶"
	desc = "一小瓶安眠药。光是气味就让人昏昏欲睡。"
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/stoxin/Initialize()
	. = ..()
	reagents.add_reagent("stoxin", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/chloralhydrate
	name = "水合氯醛瓶"
	desc = "一小瓶水合氯醛。米奇的最爱！"

/obj/item/reagent_container/glass/bottle/chloralhydrate/Initialize()
	. = ..()
	reagents.add_reagent("chloralhydrate", 30) //Intentionally low since it is so strong. Still enough to knock someone out.
	update_icon()

/obj/item/reagent_container/glass/bottle/antitoxin
	name = "\improper Dylovene bottle"
	desc = "一小瓶迪洛文。可解毒并修复毒素损伤。一种特效药。"
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/antitoxin/Initialize()
	. = ..()
	reagents.add_reagent("anti_toxin", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/mutagen
	name = "不稳定诱变剂瓶"
	desc = "一小瓶不稳定诱变剂。会随机改变接触者的DNA结构。"

/obj/item/reagent_container/glass/bottle/mutagen/Initialize()
	. = ..()
	reagents.add_reagent("mutagen", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/ammonia
	name = "氨水瓶"
	desc = "一个小瓶子。"

/obj/item/reagent_container/glass/bottle/ammonia/Initialize()
	. = ..()
	reagents.add_reagent("ammonia", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/diethylamine
	name = "二乙胺瓶"
	desc = "一个小瓶子。内含强力肥料。"

/obj/item/reagent_container/glass/bottle/diethylamine/Initialize()
	. = ..()
	reagents.add_reagent("diethylamine", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/flu_virion
	name = "流感病毒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液介质中的H13N1流感病毒。"

/obj/item/reagent_container/glass/bottle/flu_virion/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/advance/flu(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/epiglottis_virion
	name = "会厌炎病毒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液介质中的会厌炎病毒。"

/obj/item/reagent_container/glass/bottle/epiglottis_virion/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/advance/voice_change(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/liver_enhance_virion
	name = "肝脏增强病毒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液介质中的肝脏增强病毒。"

/obj/item/reagent_container/glass/bottle/liver_enhance_virion/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/advance/heal(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/hullucigen_virion
	name = "致幻病毒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液介质中的致幻病毒。"

/obj/item/reagent_container/glass/bottle/hullucigen_virion/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/advance/hullucigen(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/pierrot_throat
	name = "\improper Pierrot's Throat culture bottle"
	desc = "一个小瓶子。内含培养于合成血液介质中的H0NI<42病毒。"

/obj/item/reagent_container/glass/bottle/pierrot_throat/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/pierrot_throat(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/cold
	name = "鼻病毒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液介质中的XY-鼻病毒。"

/obj/item/reagent_container/glass/bottle/cold/Initialize()
	. = ..()
	var/datum/disease/advance/F = new /datum/disease/advance/cold(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/random
	name = "随机培养瓶"
	desc = "一个小瓶子。内含随机疾病。"

/obj/item/reagent_container/glass/bottle/random/Initialize()
	. = ..()
	var/datum/disease/advance/F = new(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/gbs
	name = "\improper GBS culture bottle"
	desc = "一个小瓶子。内含培养于合成血液介质中的重力动力学双势SADS+病毒。"//Or simply - General BullShit
	amount_per_transfer_from_this = 5

/obj/item/reagent_container/glass/bottle/gbs/Initialize()
	. = ..()
	create_reagents(20)
	var/datum/disease/F = new /datum/disease/gbs
	var/list/data = list("virus"= F)
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/fake_gbs
	name = "\improper GBS culture bottle"
	desc = "一个小瓶子。内含合成血培养基中的重力动力学双势SADS培养物。"//Or simply - General BullShit

/obj/item/reagent_container/glass/bottle/fake_gbs/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/fake_gbs(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/*
/obj/item/reagent_container/glass/bottle/rhumba_beat
	name = "伦巴节拍培养瓶"
	desc = "一个小瓶子。内含合成血培养基中的伦巴节拍培养物。"//Or simply - General BullShit
	amount_per_transfer_from_this = 5

	New()
		var/datum/reagents/R = new/datum/reagents(20)
		reagents = R
		R.my_atom = src
		var/datum/disease/F = new /datum/disease/rhumba_beat
		var/list/data = list("virus"= F)
		R.add_reagent("blood", 20, data)
		update_icon()

*/

/obj/item/reagent_container/glass/bottle/brainrot
	name = "\improper Brainrot culture bottle"
	desc = "一个小瓶子。内含合成血培养基中的隐球菌宇宙病培养物。"

/obj/item/reagent_container/glass/bottle/brainrot/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/brainrot(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/magnitis
	name = "\improper Magnitis culture bottle"
	desc = "一个小瓶子。内含一小剂量的福科斯奇迹剂。"

/obj/item/reagent_container/glass/bottle/magnitis/Initialize()
	. = ..()
	var/datum/disease/F = new /datum/disease/magnitis(0)
	var/list/data = list("viruses"= list(F))
	reagents.add_reagent("blood", 20, data)
	update_icon()

/obj/item/reagent_container/glass/bottle/pacid
	name = "聚三硝酸瓶"
	desc = "一个小瓶子。内含少量聚三硝酸，一种极其强效且危险的酸。"

/obj/item/reagent_container/glass/bottle/pacid/Initialize()
	. = ..()
	reagents.add_reagent("pacid", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/adminordrazine
	name = "\improper Adminordrazine bottle"
	desc = "一个小瓶子。内含众神的液体精华。"

/obj/item/reagent_container/glass/bottle/adminordrazine/Initialize()
	. = ..()
	reagents.add_reagent("adminordrazine", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/capsaicin
	name = "\improper Capsaicin bottle"
	desc = "一个小瓶子。内含辣酱。"

/obj/item/reagent_container/glass/bottle/capsaicin/Initialize()
	. = ..()
	reagents.add_reagent("capsaicin", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/frostoil
	name = "\improper Frost Oil bottle"
	desc = "一个小瓶子。内含冷酱。"

/obj/item/reagent_container/glass/bottle/frostoil/Initialize()
	. = ..()
	reagents.add_reagent("frostoil", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/bicaridine
	name = "\improper Bicaridine bottle"
	desc = "一个小瓶子。内含碧卡利定——用于治疗钝器伤。"
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/bicaridine/Initialize()
	. = ..()
	reagents.add_reagent("bicaridine", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/peridaxon
	name = "\improper Peridaxon bottle"
	desc = "一个小瓶子。内含培利达松——被懒惰的医生用来暂时阻止内脏损伤的影响。"
	volume = 60
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/peridaxon/Initialize()
	. = ..()
	reagents.add_reagent("peridaxon", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/tramadol
	name = "\improper Tramadol bottle"
	desc = "一个小瓶子。内含曲马多——用作基础止痛药。"
	volume = 60
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/tramadol/Initialize()
	. = ..()
	reagents.add_reagent("tramadol", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/oxycodone
	name = "\improper Oxycodone bottle"
	desc = "一个小瓶子。内含羟考酮——用作强效止痛药。禁止分发。"
	volume = 60
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/glass/bottle/oxycodone/Initialize()
	. = ..()
	reagents.add_reagent("oxycodone", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/tricordrazine
	name = "\improper Tricordrazine bottle"
	desc = "一个小瓶子。内含三合剂——一种效果较弱但能治疗各种损伤的万能药。"
	volume = 60

/obj/item/reagent_container/glass/bottle/tricordrazine/Initialize()
	. = ..()
	reagents.add_reagent("tricordrazine", 60)
	update_icon()

/obj/item/reagent_container/glass/bottle/epinephrine
	name = "\improper Epinephrine bottle"
	desc = "一个小瓶子。内含肾上腺素——用于提高患者的动脉血压等，以协助心肺复苏。" //"I can't lie to you about your odds of a successful resuscitation, but you have my sympathies."
	volume = 60

/obj/item/reagent_container/glass/bottle/epinephrine/Initialize()
	. = ..()
	reagents.add_reagent("adrenaline", 60)
	update_icon()
