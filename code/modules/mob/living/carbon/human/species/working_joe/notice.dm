/datum/emote/living/carbon/human/synthetic/working_joe/notice
	category = JOE_EMOTE_CATEGORY_NOTICE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/report
	key = "report"
	sound = 'sound/voice/joe/report.ogg'
	haz_sound = 'sound/voice/joe/report_haz.ogg'
	say_message = "正在向APOLLO记录报告。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/detailed_report
	key = "detailedreport"
	sound = 'sound/voice/joe/detailed_report.ogg'
	haz_sound = 'sound/voice/joe/detailed_report_haz.ogg'
	say_message = "APOLLO将需要一份详细报告。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/be_careful
	key = "careful"
	sound = 'sound/voice/joe/be_careful_with_that.ogg'
	haz_sound = 'sound/voice/joe/be_careful_with_that_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/ostorozhnee.ogg'
	say_message = "小心那东西。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/firearm
	key = "firearm"
	sound = 'sound/voice/joe/firearm.ogg'
	haz_sound = 'sound/voice/joe/firearm_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/ognestrelnoeoruzie.ogg'
	say_message = "枪械可能造成严重伤害。让我来协助你。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/investigate_weapon
	key = "weapon"
	sound = 'sound/voice/joe/investigate_weapon.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/nado_viesnit.ogg'
	say_message = "武器。我最好调查一下。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/firearm_concerning
	key = "firearmconcerning"
	sound = 'sound/voice/joe/most_concerning.ogg'
	say_message = "一把枪。非常令人担忧。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/permit_for_that
	key = "permitforthat"
	sound = 'sound/voice/joe/permit_for_that.ogg'
	haz_sound = 'sound/voice/joe/permit_for_that_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/nadeusuvasestrazre.ogg'
	say_message = "我猜你有那件武器的许可证。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/invest_disturbance
	key = "investigatedisturbance"
	haz_sound = 'sound/voice/joe/investigating_disturbance_haz.ogg'
	say_message = "正在调查骚乱。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/unexplained_disturbance
	key = "disturbance"
	haz_sound = 'sound/voice/joe/disturbance_haz.ogg'
	say_message = "不明骚乱最令人不安。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/unexplained_disturbance_upp
	key = "disturbanceupp"
	upp_joe_sound = 'sound/voice/joe/upp_joe/prichina.ogg'
	say_message = "最令人不安的，是不知道原因是什么。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/species
	key = "species"
	sound = 'sound/voice/joe/species.ogg'
	haz_sound = 'sound/voice/joe/species_haz.ogg'
	say_message = "未识别物种。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/species_upp
	key = "speciesupp"
	upp_joe_sound = 'sound/voice/joe/upp_joe/neizvestnoesuchestvo.ogg'
	say_message = "未知生物。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/beyond_repair
	key = "beyondrepair"
	sound = 'sound/voice/joe/beyond_repair.ogg'
	haz_sound = 'sound/voice/joe/beyond_repair_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/remontu.ogg'
	say_message = "嗯，损坏严重，无法修复。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/apollo_behalf
	key = "apollobehalf"
	sound = 'sound/voice/joe/apollo_behalf.ogg'
	haz_sound = 'sound/voice/joe/apollo_behalf_haz.ogg'
	say_message = "我将代表你通知APOLLO。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/have_to_check
	key = "havetocheck"
	upp_joe_sound = 'sound/voice/joe/upp_joe/nado-posmotret.ogg'
	say_message = "我必须检查一下。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/combust_on_its_own
	key = "combustonitsown"
	sound = 'sound/voice/joe/combust.ogg'
	haz_sound = 'sound/voice/joe/combust_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/zagorelos.ogg'
	say_message = "我推测这不是自燃的。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/safety_log
	key = "safetylog"
	sound = 'sound/voice/joe/safety_log.ogg'
	haz_sound = 'sound/voice/joe/safety_log_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/zurnal.ogg'
	say_message = "安全日志已更新。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/strange
	key = "strange"
	sound = 'sound/voice/joe/strange.ogg'
	haz_sound = 'sound/voice/joe/strange_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/stranno.ogg'
	say_message = "奇怪。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/report_this
	key = "reportthis"
	sound = 'sound/voice/joe/report_this.ogg'
	haz_sound = 'sound/voice/joe/report_this_haz.ogg'
	say_message = "我必须上报此事。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/failed_support
	key = "failedsupport"
	sound = 'sound/voice/joe/failed_support_request.ogg'
	say_message = "你失败的支持请求已记录在APOLLO中。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/alarm_activated
	key = "alarmactivated"
	sound = 'sound/voice/joe/alarm_activated.ogg'
	haz_sound = 'sound/voice/joe/alarm_activated_haz.ogg'
	say_message = "警报已激活，开始调查。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/potential_hazard
	key = "potentialhazard"
	sound = 'sound/voice/joe/potential_hazard.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/ugroza.ogg'
	say_message = "潜在威胁。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/saw_that
	key = "sawthat"
	sound = 'sound/voice/joe/saw_that.ogg'
	say_message = "我看到了。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/clean_up
	key = "cleanup"
	sound = 'sound/voice/joe/clean_up.ogg'
	haz_sound = 'sound/voice/joe/clean_up_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/uborka.ogg'
	say_message = "需要清理。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/curious
	key = "curious"
	sound = 'sound/voice/joe/curious.ogg'
	haz_sound = 'sound/voice/joe/curious_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/lybopitno.ogg'
	say_message = "有意思。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/thats_odd
	key = "thatsodd"
	sound = 'sound/voice/joe/odd.ogg'
	haz_sound = 'sound/voice/joe/odd_haz.ogg'
	say_message = "这不对劲。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/usually_happen
	key = "usuallyhappen"
	sound = 'sound/voice/joe/usually_happen.ogg'
	haz_sound = 'sound/voice/joe/usually_happen_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/ne_bivaet.ogg'
	say_message = "这通常不会发生。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/not_a_toy
	key = "notatoy"
	sound = 'sound/voice/joe/not_a_toy.ogg'
	haz_sound = 'sound/voice/joe/not_a_toy_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/ne_igrushka.ogg'
	say_message = "那不是玩具。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/made_a_mess
	key = "madeamess"
	sound = 'sound/voice/joe/made_a_mess.ogg'
	haz_sound = 'sound/voice/joe/made_a_mess_haz.ogg'
	say_message = "有人搞得一团糟。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/been_here
	key = "sbeenhere"
	sound = 'sound/voice/joe/been_here.ogg'
	haz_sound = 'sound/voice/joe/been_here_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/kto_to_byl.ogg'
	say_message = "有人来过这里。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/as_i_thought
	key = "asithought"
	sound = 'sound/voice/joe/as_i_thought.ogg'
	haz_sound = 'sound/voice/joe/as_i_thought_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/dosadno.ogg'
	say_message = "不出所料。真不幸。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE

/datum/emote/living/carbon/human/synthetic/working_joe/notice/energy_surge
	key = "energysurge"
	sound = 'sound/voice/joe/energy_surge.ogg'
	haz_sound = 'sound/voice/joe/energy_surge_haz.ogg'
	upp_joe_sound = 'sound/voice/joe/upp_joe/skachok.ogg'
	say_message = "检测到能量激增。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	joe_flag = WORKING_JOE_EMOTE|HAZARD_JOE_EMOTE|UPP_JOE_EMOTE
