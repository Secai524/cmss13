/datum/element/corp_label
	var/manufacturer
	var/full_name

/datum/element/corp_label/wy
	manufacturer = "weyland_yutani"
	full_name = "<span class='corp_label_gold'>维兰德-汤谷公司</span>"

/datum/element/corp_label/armat
	manufacturer = "armat"
	full_name = "<span class='corp_label_green'>阿玛特战场系统公司</span>"

/datum/element/corp_label/seegson
	manufacturer = "seegson"
	full_name = "<span class='corp_label_green'>希格森公司</span>"

/datum/element/corp_label/hyperdyne
	manufacturer = "hyperdyne"
	full_name = "<span class='corp_label_red'>海珀戴恩系统公司</span>"

/datum/element/corp_label/gemba
	manufacturer = "gemba_systec"
	full_name = "<span class='corp_label_blue'>金巴系统科技公司</span>"

/datum/element/corp_label/koorlander
	manufacturer = "koorlander"
	full_name = "<span class='corp_label_bluegreen'>库兰德公司</span>"

/datum/element/corp_label/chigusa
	manufacturer = "chigusa"
	full_name = "<span class='corp_label_gold'>千草公司</span>"

/datum/element/corp_label/alphatech
	manufacturer = "alphatech"
	full_name = "<span class='corp_label_yellow'>阿尔法科技硬件公司</span>"

/datum/element/corp_label/henjin_garcia
	manufacturer = "henjin_garcia"
	full_name = "<span class='corp_label_white'>亨金-加西亚军械公司</span>"

/datum/element/corp_label/bionational
	manufacturer = "lasalle_bionational"
	full_name = "<span class='corp_label_blue'>拉萨尔生物国家公司</span>"

/datum/element/corp_label/kelland
	manufacturer = "kelland"
	full_name = "<span class='corp_label_gold'>凯兰矿业公司</span>"

/datum/element/corp_label/lockmart
	manufacturer = "lock_mart"
	full_name = "<span class='corp_label_white'>洛克希德·马丁公司</span>"

/datum/element/corp_label/spearhead
	manufacturer = "spearhead"
	full_name = "<span class='corp_label_white'>Spearhead Armory</span>"

/datum/element/corp_label/norcomm
	manufacturer = "norcomm"
	full_name = "<span class='corp_label_red'>Norcomm</span>"

/datum/element/corp_label/souta
	manufacturer = "souta"
	full_name = "<span class='corp_label_red'>Souta Corporation</span>"

/datum/element/corp_label/karnak
	manufacturer = "karnak"
	full_name = "<span class='corp_label_white'>Karnak Electronics</span>"

/datum/element/corp_label/grant
	manufacturer = "karnak"
	full_name = "<span class='corp_label_red'>Grant Corporation</span>"

/datum/element/corp_label/synsound
	manufacturer = "synsound"
	full_name = "<span class='corp_label_red'>Synsound Corporation</span>"

/datum/element/corp_label/Attach(datum/target)
	. = ..()
	if(!length(manufacturer))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

/datum/element/corp_label/Detach(datum/target)
	UnregisterSignal(target, list(COMSIG_PARENT_EXAMINE))
	return ..()

/datum/element/corp_label/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/logo = "[icon2html('icons/ui_icons/logos.dmi', user, manufacturer, extra_classes = "corplogo", non_standard_size = TRUE)]"
	examine_list += SPAN_INFO("On [source] you can see [full_name] logo, it reads: [logo]")
