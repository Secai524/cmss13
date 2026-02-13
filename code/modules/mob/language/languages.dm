/datum/language/common
	name = LANGUAGE_ENGLISH
	desc = "通用地球英语。美利坚合众国的标准语言。"
	speech_verb = "says"
	ask_verb = "asks"
	exclaim_verb = list("exclaims","shouts","yells")
	key = "1"
	flags = RESTRICTED

	syllables = list("al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it", "le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to", "ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin", "his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi", "tio", "uld", "ver", "was", "wit", "you")

/datum/language/generated //parent type for languages with custom sound generation methods like chinese and japanese
	space_chance = 100 //uses a unique system

// Galactic common languages (systemwide accepted standards).
/datum/language/scandinavian
	name = LANGUAGE_SCANDINAVIAN
	desc = "虽然严格来说并非单一语言，但斯堪的纳维亚诸语言已变得极为相似，除非真正通晓这些语言，否则几乎无法区分。"
	speech_verb = "utters"
	ask_verb = "queries"
	exclaim_verb = "yelps"
	color = "scandinavian"
	key = "0"

	syllables = list("de", "vin", "meg", "og", "vi", "en", "nei", "ing", "gen", "et", "pur", "ke", "er", "nei", "hjort", "tysk", "de", "kjae", "en", "stein", "ja", "ull", "sil", "pa", "hun", "kjo", "erg", "ba", "re", "ol", "kyll", "menn", "esk", "gul", "gronn", "natt", "makt", "to", "fi", "re", "dag", "god", "jul", "ild", "fem", "jeg", "deg", "bjor", "en", "russ", "land", "sve", "rig", "nor", "ge", "dan", "is")

/datum/language/generated/japanese
	name = LANGUAGE_JAPANESE
	desc = "一种以复杂著称的语言，拥有庞大的语法体系、三种书写系统以及少量英语外来词。由于在3WE地区的高频文化交流而流行，并因移民传播至外部世界。"
	speech_verb = "vocalizes"
	color = "japanese"
	key = "2"

/datum/language/russian
	name = LANGUAGE_RUSSIAN
	desc = "一种源自地球的东斯拉夫语。是UPP的主导语言，也常被联合美洲的斯拉夫少数民族使用。"
	speech_verb = "enunciates"
	color = "soghun"
	key = "3"

	syllables = list("al", "an", "bi", "vye", "vo", "go", "dye", "yel", "en", "yer", "yet", "ka", "ko", "la", "ly", "lo", "l", "na", "nye", "ny", "no", "ov", "ol", "on", "or", "slog", "ot", "po", "pr", "ra", "rye", "ro", "st", "ta", "tye", "to", "t", "at", "bil", "vyer", "yego", "yeny", "yenn", "yest", "kak", "ln", "ova", "ogo", "oro", "ost", "oto", "pry", "pro", "sta", "stv", "tor", "chto", "eto", "rus", "nar", "arya", "mol")

/datum/language/german
	name = LANGUAGE_GERMAN
	desc = "标准高地德语，主要在中欧地区使用，也由德国移民传播至其他地方。"
	speech_verb = "proclaims"
	ask_verb = "inquires"
	exclaim_verb = "bellows"
	color = "german"
	key = "4"

	syllables = list("die", "das", "wein", "mir", "und", "wir", "ein", "nein", "gen", "en", "sauen", "bin", "nein", "rhein", "deut", "der", "lieb", "en", "stein", "nein", "ja", "wolle", "sil", "bei", "der", "sie", "sch", "kein", "nur", "ach", "kann", "volk", "vau", "gelb", "grun", "macht", "zwei", "vier", "nacht", "tag")

/datum/language/spanish
	name = LANGUAGE_SPANISH
	desc = "联合美洲第二常用的语言，由来自拉丁美洲领土和前美国南部的陆战队员带来。"
	speech_verb = "states"
	ask_verb = "quizes"
	exclaim_verb = "yells"
	color = "spanish"
	key = "5"

	syllables = list("ha", "pana", "ja", "blo", "que", "spa", "di", "ga", "na", "ces", "si", "mo", "so", "de", "el", "to", "ro", "mi", "ca", "la", "di", "ah", "mio", "tar", "ion", "gran", "van", "jo", "cie", "qie", "las", "locho", "mas", "no", "gui", "es", "mal")

/datum/language/event_hivemind
	name = LANGUAGE_TELEPATH
	desc = "一种仅在特定事件中出现的语言，为其使用者提供蜂巢思维连接。"
	speech_verb = "resonates"
	ask_verb = "resonates"
	exclaim_verb = "resonates"
	color = "tajaran"
	key = "7"
	flags = RESTRICTED|HIVEMIND

/datum/language/generated/chinese
	name = LANGUAGE_CHINESE
	desc = "UPP的次要语言，在亚洲广泛使用，并在世界其他地区有显著的移民人口。是已勘测太空中最常用的语言。"
	speech_verb = "voices"
	ask_verb = "questions"
	exclaim_verb = "shouts"
	color = "chinese"
	key = "8"

/datum/language/french
	name = LANGUAGE_FRENCH
	desc = "标准法语，由法兰西共和国使用，这是地球上仅存的少数独立国家之一。"
	speech_verb = "declares"
	ask_verb = "inquires"
	exclaim_verb = "exclaims"
	color = "french"
	key = "9"

	syllables = list("le", "en", "es", "de", "re", "ai", "an", "ar", "au", "ou", "nt", "on", "er", "ur", "an", "it", "te", "me", "la", "is", "ou", "nt", "on", "er", "ur", "an", "it", "te", "et", "me", "is", "qu", "se", "il", "ent", "que", "ait", "les", "lle", "our", "men", "ais", "est", "tre", "mai", "ous", "par", "ant", "ion", "eme", "tai", "ans", "pas", "ell", "vou", "tou", "pou", "eur", "ont", "res", "dan", "une", "ien", "sur", "son", "mme", "tio", "des")

/datum/language/forgotten
	name = LANGUAGE_FORGOTTEN
	desc = "一种被时间遗忘的古老人类语言。除非有人被低温冷冻，否则你不太可能找到会说这种语言的人。"
	speech_verb = "utters"
	ask_verb = "questions"
	exclaim_verb = "shouts"
	color = "tajaran_signlang"
	key = "f"

	syllables = list("le", "en", "es", "de", "re", "ai", "an", "ar", "au", "di", "ga", "na", "ces", "si", "mo", "so", "de", "el", "to", "ro", "mi", "he", "hi", "in", "is", "it", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to", "ve", "pas", "ell", "vou", "tou", "pou", "eur", "ont", "res", "dan", "une", "ien", "sur", "son", "mme", "tio", "des")

/datum/language/hellhound
	name = LANGUAGE_HELLHOUND
	desc = "一种低吼、喉音式的交流方式，似乎只有地狱犬能发出这种声音。"
	speech_verb = "growls"
	ask_verb = "grumbles"
	exclaim_verb = "snarls"
	color = "monkey"
	key = "h"

/datum/language/hellhound/scramble(input)
	return pick("Grrr...", "Grah!", "Gurrr...")

/datum/language/commando
	name = LANGUAGE_TSL
	desc = "战术手语是一种现代技术，结合了改良的美式手语、战术手势以及只有精英突击队才知道的无线电隐秘代号。"
	speech_verb = "discreetly communicates"
	ask_verb = "interrogates"
	exclaim_verb = "orders"
	color = "commando"
	key = "l"

	syllables = list("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "!", "?", "@", "#" ,"*")
	sentence_chance = 50
	space_chance = 50

/datum/language/sainja //Yautja tongue
	name = LANGUAGE_YAUTJA
	desc = "铁血战士那深沉、隆隆作响的喉音。对于没有面部颌骨的人来说很难模仿。"
	speech_verb = "rumbles"
	ask_verb = "rumbles"
	exclaim_verb = "roars"
	color = "tajaran"
	key = "s"
	flags = WHITELISTED

	syllables = list("!", "?", ".", "@", "$", "%", "^", "&", "*", "-", "=", "+", "e", "b", "y", "p", "|", "z", "~", ">")
	space_chance = 20

/datum/language/xenomorph
	name = LANGUAGE_XENOMORPH
	color = "xenotalk"
	desc = "异形的通用语。"
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "hisses"
	key = "x"
	syllables = list("sss", "sSs", "SSS")
	flags = RESTRICTED

/datum/language/xenos
	name = LANGUAGE_HIVEMIND
	desc = "异形拥有通过心灵蜂巢思维进行交流的奇特能力。"
	speech_verb = "hiveminds"
	ask_verb = "hiveminds"
	exclaim_verb = "hiveminds"
	color = "xeno"
	key = "q"
	flags = RESTRICTED|HIVEMIND

//Make queens BOLD text
/datum/language/xenos/broadcast(mob/living/speaker, message, speaker_mask)
	if(iscarbon(speaker))
		var/mob/living/carbon/C = speaker

		if(!(C.hivenumber in GLOB.hive_datum))
			return

		C.hivemind_broadcast(message, GLOB.hive_datum[C.hivenumber])

/datum/language/apollo
	name = LANGUAGE_APOLLO
	desc = "APOLLO链接是SEEGSON设计的人工智能子处理器，用于协调维护无人机和工作乔。维兰德否认该处理器被ARES窃取的指控。"
	color = "skrell"
	speech_verb = "states"
	ask_verb = "queries"
	exclaim_verb = "declares"
	key = "6"
	flags = RESTRICTED|HIVEMIND

/datum/language/apollo/broadcast(mob/living/speaker, message, speaker_mask)
	if(!speaker.hear_apollo())
		return

	if (!message)
		return

	///Font size
	var/scale = "message"
	if(isARES(speaker))
		scale = "large"

	var/message_start = "<i><span class='game say'>[name], <span class='name'>[speaker.name]</span>"
	var/message_body = "<span class='message'>broadcasts, \"[message]\"</span></span></i>"
	var/full_message = "<span class='[scale]'><span class='[color]'>[message_start] [message_body]</span></span>"


	GLOB.STUI.game.Add("\[[time_stamp()]]<font color='#FFFF00'>APOLLO: [key_name(speaker)] : [message]</font><br>")
	GLOB.STUI.processing |= STUI_LOG_GAME_CHAT
	log_say("[speaker.name != "未知" ? speaker.name : "([speaker.real_name])"] \[APOLLO\]: [message] (CKEY: [speaker.key]) (JOB: [speaker.job]) (AREA: [get_area_name(speaker)])")
	log_ares_apollo(speaker.real_name, message)
	for (var/mob/dead in GLOB.dead_mob_list)
		if(!istype(dead,/mob/new_player) && !istype(dead,/mob/living/brain)) //No meta-evesdropping
			var/dead_message = "<span class='[scale]'><span class='[color]'>[message_start](<a href='byond://?src=\ref[dead];track=\ref[speaker]'>F</a>) [message_body]</span></span>"
			dead.show_message(dead_message, SHOW_MESSAGE_VISIBLE)

	for (var/mob/living/listener in GLOB.alive_mob_list)

		if (!listener.hear_apollo())
			continue

		listener.show_message(full_message, SHOW_MESSAGE_VISIBLE)

	var/list/listening = hearers(1, src)
	listening -= src

	for (var/mob/living/M in listening)
		if(isSilicon(M) || M.hear_apollo())
			continue
		M.show_message("<i><span class='game say'><span class='name'>合成语音</span> <span class='message'>发出哔哔声，\"beep beep beep\"</span></span></i>",2)

/datum/language/primitive
	name = LANGUAGE_MONKEY
	desc = "呜克呜克呜克。"
	speech_verb = "chimpers"
	ask_verb = "chimpers"
	exclaim_verb = "screeches"
	color = "monkey"
	key = "_"
