/datum/emote/living/carbon/human
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	keybind_category = CATEGORY_HUMAN_EMOTE

	/// Species that can use this emote.
	var/list/species_type_allowed_typecache = list(/datum/species/human, /datum/species/synthetic, /datum/species/yautja)
	/// Species that can't use this emote.
	var/list/species_type_blacklist_typecache = list(/datum/species/monkey, /datum/species/synthetic/synth_k9)

/datum/emote/living/carbon/human/New()
	. = ..()

	species_type_allowed_typecache = typecacheof(species_type_allowed_typecache)
	species_type_blacklist_typecache = typecacheof(species_type_blacklist_typecache)

/datum/emote/living/carbon/human/can_run_emote(mob/living/carbon/human/user, status_check, intentional)
	. = ..()
	if(!.)
		return

	if(!is_type_in_typecache(user.species, species_type_allowed_typecache))
		. = FALSE
	if(is_type_in_typecache(user.species, species_type_blacklist_typecache) && !is_type_in_typecache(user.species, species_type_allowed_typecache))
		. = FALSE

/datum/emote/living/carbon/human/blink
	key = "blink"
	key_third_person = "blinks"
	message = "闪烁。"

/datum/emote/living/carbon/human/blink_rapid
	key = "rapidblink"
	message = "快速眨眼。"

/datum/emote/living/carbon/human/bow
	key = "bow"
	key_third_person = "bows"
	message = "鞠躬。"
	message_param = "向%t鞠躬。"

/datum/emote/living/carbon/human/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "轻笑。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/clap
	key = "clap"
	key_third_person = "claps"
	message = "鼓掌。"
	hands_use_check = TRUE
	audio_cooldown = 5 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'sound/misc/clap.ogg'

/datum/emote/living/carbon/human/collapse
	key = "collapse"
	key_third_person = "collapses"
	message = "瘫倒了！"

/datum/emote/living/carbon/human/collapse/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	user.apply_effect(2, PARALYZE)

/datum/emote/living/carbon/human/cough
	key = "cough"
	key_third_person = "coughs"
	message = "咳嗽！"

/datum/emote/living/carbon/human/cry
	key = "cry"
	key_third_person = "cries"
	message = "哭泣。"

/datum/emote/living/carbon/human/eyebrow
	key = "eyebrow"
	message = "挑起眉毛。"

/datum/emote/living/carbon/human/facepalm
	key = "facepalm"
	key_third_person = "facepalms"
	message = "捂脸。"

/datum/emote/living/carbon/human/faint
	key = "faint"
	key_third_person = "faints"
	message = "昏倒了！"

/datum/emote/living/carbon/human/faint/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	user.sleeping += 10

/datum/emote/living/carbon/human/frown
	key = "frown"
	key_third_person = "frowns"
	message = "皱眉。"

/datum/emote/living/carbon/human/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "倒吸一口气！"

/datum/emote/living/carbon/human/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "咯咯笑。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/glare
	key = "glare"
	key_third_person = "glares"
	message = "怒视。"
	message_param = "怒视着%t。"

/datum/emote/living/carbon/human/golfclap
	key = "golfclap"
	key_third_person = "golfclaps"
	message = "鼓掌，显然不为所动。"
	alt_message = "claps"
	sound = 'sound/misc/golfclap.ogg'
	cooldown = 5 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/grin
	key = "grin"
	key_third_person = "grins"
	message = "咧嘴笑。"

/datum/emote/living/carbon/human/grumble
	key = "grumble"
	key_third_person = "grumbles"
	message = "嘟囔。"

/datum/emote/living/carbon/human/handshake
	key = "handshake"
	message_param = "与%t握手。"

/datum/emote/living/carbon/human/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "大笑！"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/laugh/get_sound(mob/living/user)
	if(isyautja(user))
		return pick('sound/voice/pred_laugh1.ogg', 'sound/voice/pred_laugh2.ogg', 'sound/voice/pred_laugh3.ogg', 'sound/voice/pred_laugh4.ogg', 'sound/voice/pred_laugh5.ogg', 'sound/voice/pred_laugh6.ogg')

/datum/emote/living/carbon/human/look
	key = "look"
	key_third_person = "looks"
	message = "张望。"
	message_param = "看向%t。"

/datum/emote/living/carbon/human/medic
	key = "medic"
	message = "呼叫医疗兵！"
	alt_message = "喊叫着什么"
	cooldown = 10 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/medic/get_sound(mob/living/user)
	if(user.gender == MALE)
		return pick('sound/voice/corpsman.ogg', 'sound/voice/corpsman_up.ogg', 'sound/voice/corpsman_over_here.ogg', 'sound/voice/i_need_a_corpsman_1.ogg', 'sound/voice/i_need_a_corpsman_2.ogg', 'sound/voice/im_hit_get_doc_up_here.ogg', 'sound/voice/get_doc_up_here_im_hit.ogg', 20;'sound/voice/i_cant_feel_my_legs_corpsman.ogg', 0.5;'sound/voice/human_male_medic_rare_1.ogg', 0.5;'sound/voice/human_male_medic.ogg', 1;'sound/voice/human_male_medic_rare_2.ogg')
	else
		return 'sound/voice/human_female_medic.ogg'

/datum/emote/living/carbon/human/medic/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

/datum/emote/living/carbon/human/medic/run_langchat(mob/living/user, group)
	if(!ishuman_strict(user))
		return

	var/medic_message = pick("Corpsman!", "Doc!", "Help!")
	user.langchat_speech(medic_message, group, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_bolded"))
	user.show_speech_bubble(group, "medic")

/datum/emote/living/carbon/human/moan
	key = "moan"
	key_third_person = "moans"
	message = "呻吟。"

/datum/emote/living/carbon/human/mumble
	key = "mumble"
	key_third_person = "mumbles"
	message = "咕哝着。"

/datum/emote/living/carbon/human/nod
	key = "nod"
	key_third_person = "nods"
	message = "点头。"

/datum/emote/living/carbon/human/pain
	key = "pain"
	message = "痛苦地喊叫！"
	alt_message = "喊叫"
	species_type_allowed_typecache = list(/datum/species/human, /datum/species/synthetic, /datum/species/yautja, /datum/species/synthetic/colonial/wy_droid)
	species_type_blacklist_typecache = list(/datum/species/synthetic)
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/pain/get_sound(mob/living/user)
	if(ishuman_strict(user))
		if(user.gender == MALE)
			return get_sfx("male_pain")
		else
			return get_sfx("female_pain")

	if(isyautja(user))
		return get_sfx("pred_pain")

	if(iswydroid(user))
		return get_sfx("wy_droid_pain")

/datum/emote/living/carbon/human/pain/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

/datum/emote/living/carbon/human/pain/run_langchat(mob/living/user, group)
	if(!ishuman_strict(user))
		return

	var/pain_message = pick("OW!!", "AGH!!", "ARGH!!", "OUCH!!", "ACK!!", "OUF!")
	user.langchat_speech(pain_message, group, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_yell"))
	user.show_speech_bubble(group, "pain")

/datum/emote/living/carbon/human/salute
	key = "salute"
	key_third_person = "salutes"
	message = "敬礼。"
	message_param = "向%t敬礼。"
	sound = 'sound/misc/salute.ogg'
	audio_cooldown = 10 SECONDS
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/scream
	key = "scream"
	key_third_person = "screams"
	message = "尖叫！"
	audio_cooldown = 10 SECONDS
	species_type_blacklist_typecache = list(/datum/species/synthetic)
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/scream/get_sound(mob/living/user)
	if(ishuman_strict(user))
		if(user.gender == MALE)
			return get_sfx("male_scream")
		else
			return get_sfx("female_scream")
	if(isyautja(user))
		return get_sfx("pred_pain")

/datum/emote/living/carbon/human/scream/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

/datum/emote/living/carbon/human/scream/run_langchat(mob/living/user, group)
	if(!ishuman_strict(user))
		return

	var/scream_message = pick("FUCK!!!", "AGH!!!", "ARGH!!!", "AAAA!!!", "HGH!!!", "NGHHH!!!", "NNHH!!!", "SHIT!!!")
	user.langchat_speech(scream_message, group, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_PANIC_POP, additional_styles = list("langchat_yell"))
	user.show_speech_bubble(group, "scream")

/datum/emote/living/carbon/human/shakehead
	key = "shakehead"
	message = "摇了摇头。"

/datum/emote/living/carbon/human/shiver
	key = "shiver"
	key_third_person = "shivers"
	message = "打了个寒颤。"

/datum/emote/living/carbon/human/shrug
	key = "shrug"
	key_third_person = "shrugs"
	message = "耸肩。"

/datum/emote/living/carbon/human/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "叹气。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/smile
	key = "smile"
	key_third_person = "smiles"
	message = "微笑。"

/datum/emote/living/carbon/human/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "打喷嚏！"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/snore
	key = "snore"
	key_third_person = "snores"
	message = "打鼾。"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/stare
	key = "stare"
	key_third_person = "stares"
	message = "凝视。"
	message_param = "凝视着%t。"

/datum/emote/living/carbon/human/signal
	key = "signal"
	key_third_person = "signals"
	message_param = "竖起%t根手指。"
	hands_use_check = TRUE

/datum/emote/living/carbon/human/signal/run_emote(mob/user, params, type_override, intentional)
	params = text2num(params)
	if(params == 1 || !isnum(params))
		return "raises one finger."
	params = num2text(clamp(params, 2, 10))
	return ..()

/datum/emote/living/carbon/human/stop
	key = "stop"
	message = "伸出手掌，示意停止。"
	hands_use_check = TRUE

/datum/emote/living/carbon/human/thumbsup
	key = "thumbsup"
	message = "竖起大拇指。"
	hands_use_check = TRUE

/datum/emote/living/carbon/human/thumbsdown
	key = "thumbsdown"
	message = "拇指向下。"
	hands_use_check = TRUE

/datum/emote/living/carbon/human/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "抽搐。"

/datum/emote/living/carbon/human/wave
	key = "wave"
	key_third_person = "waves"
	message = "挥手。"

/datum/emote/living/carbon/human/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "打了个哈欠。"

/datum/emote/living/carbon/human/warcry
	key = "warcry"
	message = "发出鼓舞人心的呐喊！"
	alt_message = "喊叫着什么"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/warcry/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

/datum/emote/living/carbon/human/warcry/run_langchat(mob/living/user, list/group)
	. = ..()
	user.show_speech_bubble(group, "warcry")

/datum/emote/living/carbon/human/warcry/get_sound(mob/living/user)
	if(ishumansynth_strict(user))
		switch(user.faction)
			if(FACTION_UPP, FACTION_HUNTED_UPP)
				return get_sfx("[user.gender]_upp_warcry")
			else
				return get_sfx("[user.gender]_warcry")

/datum/emote/living/carbon/human/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "呜咽。"

/datum/emote/living/carbon/human/whimper/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return

/datum/emote/living/carbon/human/whimper/run_langchat(mob/living/user, list/group)
	. = ..()
	user.show_speech_bubble(group, "scream")

/datum/emote/living/carbon/human/burstscream
	key = "burstscream"
	message = "痛苦地尖叫！"
	emote_type = EMOTE_FORCED_AUDIO|EMOTE_AUDIBLE|EMOTE_VISIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/carbon/human/burstscream/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.burstscreams[user.gender])
		return user.species.burstscreams[user.gender]
	if(user.species.burstscreams[NEUTER])
		return user.species.burstscreams[NEUTER]

/datum/emote/living/carbon/human/burstscream/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return FALSE

/datum/emote/living/carbon/human/burstscream/run_langchat(mob/living/user, list/group)
	. = ..()
	user.show_speech_bubble(group, "pain")
