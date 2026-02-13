/datum/emote/living/carbon/human/synthetic/working_joe/fire
	category = JOE_EMOTE_CATEGORY_FIRE

/datum/emote/living/carbon/human/synthetic/working_joe/fire/fire_drill
	key = "firedrill"
	sound = 'sound/voice/joe/fire_drill.ogg'
	say_message = "请前往最近的消防集合点集合。这不是演习；请勿惊慌。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/working_joe/fire/temperatures
	key = "temperatures"
	sound = 'sound/voice/joe/temperatures.ogg'
	haz_sound = 'sound/voice/joe/temperatures_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/temp.ogg'
	say_message = "我的构造可承受高达1210度的温度。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/fire/fire
	key = "fire"
	sound = 'sound/voice/joe/fire.ogg'
	haz_sound = 'sound/voice/joe/fire_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/tolko_zveri.ogg'
	say_message = "只有野兽才会惧怕火焰。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/fire/unprotected_flames
	key = "unprotectedflames"
	sound = 'sound/voice/joe/unprotected_flames.ogg'
	haz_sound = 'sound/voice/joe/unprotected_flames_haz.ogg'
	say_message = "无防护的火焰极其危险，完全不建议使用。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/fire/fire_on_station
	key = "unprotectedflamesupp"
	upp_joe_sound = 'sound/voice/joe/upp_joe/otkritogog.ogg'
	say_message = "空间站内禁止使用明火。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = UPP_JOE_EMOTE
