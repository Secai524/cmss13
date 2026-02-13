/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area
	category = JOE_EMOTE_CATEGORY_RESTRICTED_AREA

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/presence_logged
	key = "presencelogged"
	sound = 'sound/voice/joe/presence_logged.ogg'
	haz_sound = 'sound/voice/joe/presence_logged_haz.ogg'
	say_message = "你的存在已被记录。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/trespassing
	key = "trespassing"
	sound = 'sound/voice/joe/trespassing.ogg'
	say_message = "你正在非法侵入。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/not_allowed_there
	key = "notallowedthere"
	sound = 'sound/voice/joe/not_allowed_there.ogg'
	haz_sound = 'sound/voice/joe/not_allowed_there_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/vamsyduanelza.ogg'
	say_message = "你不允许进入那里。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/shouldnt_be_here
	key = "shouldntbehere"
	sound = 'sound/voice/joe/shouldnt_be_here.ogg'
	say_message = "你不该在这里。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/really_shouldnt_be_here
	key = "reallyshouldntbehere"
	sound = 'sound/voice/joe/really_shouldnt_be_here.ogg'
	haz_sound = 'sound/voice/joe/really_shouldnt_be_here_haz.ogg'
	say_message = "你真的不该在这里。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/this_shouldnt_be_here
	key = "thishouldbehere"
	sound = 'sound/voice/joe/this_shouldnt_be_here.ogg'
	haz_sound = 'sound/voice/joe/this_shouldnt_be_here_haz.ogg'
	say_message = "这东西不该在这里。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/interloper
	key = "interloper"
	sound = 'sound/voice/joe/interloper.ogg'
	haz_sound = 'sound/voice/joe/interloper_haz.ogg'
	say_message = "除了数不清的职责，现在又来了个闯入者。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/area_restricted
	key = "arearestrict"
	haz_sound = 'sound/voice/joe/area_restricted_haz.ogg'
	say_message = "此区域为限制区域。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/protected_area_compromised
	key = "areacompromised"
	sound = 'sound/voice/joe/protected_area_compromised.ogg'
	haz_sound = 'sound/voice/joe/protected_area_compromised_haz.ogg'
	say_message = "保护区已被侵入。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/breach
	key = "breach"
	sound = 'sound/voice/joe/breach.ogg'
	haz_sound = 'sound/voice/joe/breach_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/narusheniekarantina.ogg'
	say_message = "危险物收容失效已记录。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/no_laughing_matter
	key = "nolaughingmatter"
	sound = 'sound/voice/joe/no_laughing_matter.ogg'
	say_message = "恐怕危险物收容警报不是开玩笑的事。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/working_joe/restricted_area/come_out_vent
	key = "comeoutvent"
	sound = 'sound/voice/joe/come_out_vent.ogg'
	haz_sound = 'sound/voice/joe/come_out_vent_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/ventilyacii.ogg'
	say_message = "请从通风管道系统里出来。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE
