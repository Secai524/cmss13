/obj/structure/sign
	icon = 'icons/obj/structures/props/wall_decorations/decals.dmi'
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	layer = WALL_OBJ_LAYER
	var/deconstructable = TRUE

/obj/structure/sign/ex_act(severity)
	if(!explo_proof)
		deconstruct(FALSE)
	return

/obj/structure/sign/attackby(obj/item/tool as obj, mob/user as mob) //deconstruction
	if(deconstructable && HAS_TRAIT(tool, TRAIT_TOOL_SCREWDRIVER) && !istype(src, /obj/structure/sign/double) && !QDELETED(src))
		to_chat(user, "你用[tool]拆下了指示牌。")
		var/obj/item/sign/S = new(src.loc)
		S.name = name
		S.desc = desc
		S.icon_state = icon_state
		S.sign_state = icon_state
		S.icon = icon
		deconstruct(FALSE)
	else ..()

/obj/item/sign
	name = "sign"
	desc = ""
	icon = 'icons/obj/structures/props/wall_decorations/decals.dmi'
	w_class = SIZE_MEDIUM //big
	var/sign_state = ""

/obj/item/sign/attackby(obj/item/tool as obj, mob/user as mob) //construction
	if(HAS_TRAIT(tool, TRAIT_TOOL_SCREWDRIVER) && isturf(user.loc))
		var/direction = tgui_input_list(usr, "朝哪个方向？", "Select direction.", list("北", "东", "南", "西", "Cancel"))
		if(direction == "Cancel")
			return
		if(!Adjacent(user, src))
			return
		var/obj/structure/sign/S = new(user.loc)
		switch(direction)
			if("北")
				S.pixel_y = 32
			if("东")
				S.pixel_x = 32
			if("南")
				S.pixel_y = -32
			if("西")
				S.pixel_x = -32
			else
				return
		S.name = name
		S.desc = desc
		S.icon_state = sign_state
		S.icon = icon
		to_chat(user, "你用[tool]固定住了\the [S]。")
		qdel(src)
	else ..()

//=====================//
// Miscellaneous Signs //
//=====================//

/obj/structure/sign/nosmoking_1
	name = "\improper NO SMOKING"
	desc = "一块写着‘禁止吸烟’的警告牌。"
	icon_state = "nosmoking"
	deconstructable = FALSE

/obj/structure/sign/nosmoking_2
	name = "\improper NO SMOKING"
	desc = "一块写着‘禁止吸烟’的警告牌。"
	icon_state = "nosmoking2"
	deconstructable = FALSE

/obj/structure/sign/goldenplaque
	name = "最强悍者奖"
	desc = "强悍并非一种行为或生活方式，而是一种精神状态。唯有意志力足够强大，能在危机中果断行动，从敌人手中拯救战友的人，才是真正的强悍。保持强悍，我的朋友们。"
	icon_state = "goldenplaque"

/obj/structure/sign/kiddieplaque
	name = "AI开发者铭牌"
	desc = "在一长串名字和职位列表旁边，有一幅小孩子的涂鸦。图像下方，有人潦草地刻着字\"PACKETS\""
	icon_state = "kiddieplaque"

/obj/structure/sign/arcturianstopsign
	name = "\improper Arcturian stop sign"
	desc = "这是上次上岸休假时，第一排的一些布拉沃班陆战队员偷来的北极星停车标志。"
	icon_state = "arcturian_stop_sign"

/obj/structure/sign/double/maltesefalcon //The sign is 64x32, so it needs two tiles. ;3
	name = "马耳他之鹰"
	desc = "马耳他之鹰，太空酒吧与烧烤店。"

/obj/structure/sign/double/maltesefalcon/left
	icon_state = "maltesefalcon-left"

/obj/structure/sign/double/maltesefalcon/right
	icon_state = "maltesefalcon-right"

/obj/structure/sign/uacqs
	name = "\improper UACQS Plaque"
	desc = "一块UACQS标志牌。"
	icon_state = "roplaque"
	deconstructable = FALSE

/obj/structure/sign/uacqs/New(loc, ...)
	. = ..()
	desc = "1) 本场所由美洲合众国质量与标准委员会运营。<br>2) 进入本场所需经UACQS人员或该区域监管机构批准。<br>[SPAN_RED("3) In accordance with Civil Law, firearms are not permitted in these premises.")]"

//============//
//  Banners  //
//==========//

/obj/structure/sign/banners
	icon = 'icons/obj/structures/props/wall_decorations/banners.dmi'

/obj/structure/sign/banners/happybirthdaysteve
	name = "\improper Happy Birthday Steve banner"
	desc = "一条看起来令人沮丧的纸质横幅，祝一个名叫史蒂夫的人生日快乐。"
	icon_state = "birthdaysteve"

/obj/structure/sign/banners/maximumeffort
	name = "\improper Maximum Effort banner"
	desc = "这条横幅描绘了德尔塔班的座右铭。德尔塔班的陆战队员在不久前的一次电影之夜选了一部老式轰炸机电影后，便采纳了它。"
	icon_state = "maximumeffort"

/obj/structure/sign/banners/united_americas_flag
	name = "\improper United Americas flag"
	desc = "一面美洲合众国国旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "uaflag"
/obj/structure/sign/banners/united_americas_flag_worn
	name = "\improper Worn United Americas flag"
	desc = "一面非常破旧的美洲合众国国旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "uaflag_worn"
/obj/structure/sign/banners/colonial_marines_flag
	name = "\improper United States Colonial Marine Corps flag"
	desc = "一面美国殖民地海军陆战队军旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "cmflag"
/obj/structure/sign/banners/colonial_marines_flag_worn
	name = "\improper Worn United States Colonial Marine Corps flag"
	desc = "一面非常破旧的美国殖民地海军陆战队军旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "cmflag_worn"
/obj/structure/sign/banners/twe_flag
	name = "\improper Three World Empire flag"
	desc = "一面三世界帝国国旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "tweflag"
/obj/structure/sign/banners/twe_worn
	name = "\improper Worn Three World Empire flag"
	desc = "一面非常破旧的三世界帝国国旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "tweflag_worn"
/obj/structure/sign/banners/upp_flag
	name = "\improper Union of Progressive Peoples flag"
	desc = "一面进步人民联盟国旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "uppflag"
/obj/structure/sign/banners/upp_worn
	name = "\improper Worn Union of Progressive Peoples flag"
	desc = "一面非常破旧的进步人民联盟国旗。根据观看者的政治倾向，会激发爱国情怀、恐惧或厌恶。"
	icon_state = "uppflag_worn"
/obj/structure/sign/banners/clf_flag
	name = "\improper Colonial Liberation Front flag"
	desc = "一面殖民地解放阵线的旗帜。根据观看者的政治倾向，会激发爱国热情、恐惧或厌恶。"
	icon_state = "clfflag"
/obj/structure/sign/banners/clf_worn
	name = "\improper Worn Colonial Liberation Front flag"
	desc = "一面非常破旧的殖民地解放阵线旗帜。根据观看者的政治倾向，会激发爱国热情、恐惧或厌恶。"
	icon_state = "clfflag_worn"
//============//
//  Flags    //
//==========//

/obj/structure/sign/flag
	icon = 'icons/obj/structures/props/wall_decorations/flags.dmi'

/obj/structure/sign/flag/upp
	name = "\improper Union of Progressive Peoples Flag"
	desc = "团结铸就力量，自由源于团结。"
	icon_state = "upp_flag"

//=====================//
// SEMIOTIC STANDARD  //
//===================//

/obj/structure/sign/safety
	name = "sign"
	icon = 'icons/obj/structures/props/wall_decorations/semiotic_standard.dmi'
	desc = "一个表示符号学标准的标志。星际商业委员会要求为了您的安全，这些符号几乎应放置在所有地方。"
	anchored = TRUE
	opacity = FALSE
	density = FALSE

/obj/structure/sign/safety/airlock
	name = "气闸符号"
	desc = "表示附近存在气闸的符号学标准。"
	icon_state = "airlock"

/obj/structure/sign/safety/ammunition
	name = "弹药储存符号"
	desc = "表示附近存在弹药储存的符号学标准。"
	icon_state = "ammo"

/obj/structure/sign/safety/analysis_lab
	name = "分析实验室符号"
	desc = "表示附近存在分析实验室的符号学标准。"
	icon_state = "analysislab"

/obj/structure/sign/safety/autodoc
	name = "自动医疗机符号"
	desc = "表示附近存在自动医疗机的符号学标准。"
	icon_state = "autodoc"

/obj/structure/sign/safety/autoopenclose
	name = "自动开/关符号"
	desc = "表示附近存在自动关闭阀的符号学标准。"
	icon_state = "autoopenclose"

/obj/structure/sign/safety/bathmens
	name = "男卫生间符号"
	desc = "表示附近存在男卫生间的符号学标准。"
	icon_state = "bathmens"

/obj/structure/sign/safety/bathunisex
	name = "无性别卫生间符号"
	desc = "表示附近存在无性别卫生间的符号学标准。"
	icon_state = "bathunisex"

/obj/structure/sign/safety/bathwomens
	name = "女卫生间符号"
	desc = "表示附近存在女卫生间的符号学标准。"
	icon_state = "bathwomens"

/obj/structure/sign/safety/biohazard
	name = "生物危害符号"
	desc = "表示附近存在生物危害的符号学标准。"
	icon_state = "biohazard"

/obj/structure/sign/safety/biolab
	name = "生物实验室符号"
	desc = "表示附近存在生物实验室的符号学标准。"
	icon_state = "biolab"

/obj/structure/sign/safety/bridge
	name = "舰桥符号"
	desc = "表示附近有星舰舰桥的符号标准。"
	icon_state = "bridge"

/obj/structure/sign/safety/bulkhead_door
	name = "舱壁门符号"
	desc = "表示附近有舱壁门的符号标准。"
	icon_state = "bulkheaddoor"

/obj/structure/sign/safety/chem_lab
	name = "化学实验室符号"
	desc = "表示附近有化学实验室的符号标准。"
	icon_state = "chemlab"

/obj/structure/sign/safety/coffee
	name = "咖啡符号"
	desc = "表示附近有咖啡的符号标准：任何星舰船员的命脉。"
	icon_state = "coffee"

/obj/structure/sign/safety/commline_connection
	name = "通信线路连接点符号"
	desc = "表示附近有通信线路连接点的符号标准。"
	icon_state = "commlineconnection"

/obj/structure/sign/safety/conference_room
	name = "会议室符号"
	desc = "表示附近有会议室的符号标准。"
	icon_state = "confroom"

/obj/structure/sign/safety/cryo
	name = "低温储藏库符号"
	desc = "表示附近有低温储藏库的符号标准。"
	icon_state = "cryo"

/obj/structure/sign/safety/debark_lounge
	name = "离舰休息室符号"
	desc = "表示附近有离舰休息室的符号标准。"
	icon_state = "debarkationlounge"

/obj/structure/sign/safety/distribution_pipes
	name = "分配管道符号"
	desc = "表示附近有分配管道的符号标准。"
	icon_state = "distpipe"

/obj/structure/sign/safety/east
	name = "\improper East semiotic"
	desc = "表示东面附近有某物的符号标准。"
	icon_state = "east"

/obj/structure/sign/safety/electronics
	name = "电子系统符号"
	desc = "表示附近有电子系统的符号标准。这是电气系统的一种花哨说法。"
	icon_state = "astronics"

/obj/structure/sign/safety/elevator
	name = "电梯符号"
	desc = "表示附近有电梯的符号标准。"
	icon_state = "elevator"

/obj/structure/sign/safety/escapepod
	name = "逃生舱符号"
	desc = "表示逃生舱的符号标准。"
	icon_state = "escapepod"

/obj/structure/sign/safety/exhaust
	name = "排气口符号"
	desc = "符号标准，表示附近存在引擎或发电机排气口。"
	icon_state = "exhaust"

/obj/structure/sign/safety/fire_haz
	name = "火灾危险符号"
	desc = "符号标准，表示附近存在火灾危险。"
	icon_state = "firehaz"

/obj/structure/sign/safety/firingrange
	name = "射击场符号"
	desc = "符号标准，表示附近存在实弹射击场。"
	icon_state = "firingrange"

/obj/structure/sign/safety/food_storage
	name = "有机存储（食品）符号"
	desc = "符号标准，表示附近存在非冷藏食品存储区。"
	icon_state = "foodstorage"

/obj/structure/sign/safety/galley
	name = "厨房符号"
	desc = "符号标准，表示附近存在厨房。"
	icon_state = "galley"

/obj/structure/sign/safety/hazard
	name = "危险符号"
	desc = "符号标准，表示附近存在危险。小心！"
	icon_state = "hazard"

/obj/structure/sign/safety/high_rad
	name = "高放射性符号"
	desc = "符号标准，表示附近存在高放射性区域。"
	icon_state = "highrad"

/obj/structure/sign/safety/high_voltage
	name = "高压电符号"
	desc = "符号标准，表示附近存在高压电流。"
	icon_state = "highvoltage"

/obj/structure/sign/safety/hvac
	name = "\improper HVAC semiotic"
	desc = "符号标准，表示附近存在...一个暖通空调系统。此标志必定已更新至新标准。"
	icon_state = "hvac"

/obj/structure/sign/safety/hvac_old
	name = "\improper HVAC semiotic"
	desc = "符号标准，表示附近存在一个暖通空调系统。此标志仍在使用旧标准。"
	icon_state = "hvacold"

/obj/structure/sign/safety/intercom
	name = "内部通话系统符号"
	desc = "符号标准，表示附近存在内部通话系统。"
	icon_state = "comm"

/obj/structure/sign/safety/ladder
	name = "梯子符号"
	desc = "符号标准，表示附近存在梯子。"
	icon_state = "ladder"

/obj/structure/sign/safety/laser
	name = "激光符号"
	desc = "符号标准，表示附近存在激光。通常不像听起来那么酷。"
	icon_state = "laser"

/obj/structure/sign/safety/life_support
	name = "生命维持系统符号"
	desc = "符号标准，表示附近存在生命维持系统。"
	icon_state = "lifesupport"

/obj/structure/sign/safety/maint
	name = "维护标识"
	desc = "标识标准，表示附近存在维护权限通道。"
	icon_state = "maint"

/obj/structure/sign/safety/manualopenclose
	name = "手动开/关标识"
	desc = "标识标准，表示附近存在手动关闭阀。"
	icon_state = "manualopenclose"

/obj/structure/sign/safety/med_cryo
	name = "医疗冷冻舱标识"
	desc = "标识标准，表示附近存在医疗冷冻舱。"
	icon_state = "medcryo"

/obj/structure/sign/safety/med_life_support
	name = "医疗维生系统标识"
	desc = "标识标准，表示附近存在医疗舱的维生系统。"
	icon_state = "medlifesupport"

/obj/structure/sign/safety/medical
	name = "医疗标识"
	desc = "标识标准，表示附近存在医疗舱。"
	icon_state = "medical"

/obj/structure/sign/safety/nonpress
	name = "前方非加压区域标识"
	desc = "标识标准，表示前方区域未加压。"
	icon_state = "nonpressarea"

/obj/structure/sign/safety/nonpress_ag
	name = "人工重力区域，非加压，需穿太空服标识"
	desc = "标识标准，表示附近存在具有人工重力但缺乏加压的区域。"
	icon_state = "nonpressag"

/obj/structure/sign/safety/nonpress_0g
	name = "非加压区域，无重力，需穿太空服标识"
	desc = "标识标准，表示前方区域未加压且无人工重力。"
	icon_state = "nonpresszerog"

/obj/structure/sign/safety/north
	name = "\improper North semiotic"
	desc = "标识标准，表示附近存在位于北方的某物。"
	icon_state = "north"

/obj/structure/sign/safety/opens_up
	name = "向上开启标识"
	desc = "标识标准，表示附近的舱门向上开启。"
	icon_state = "opensup"

/obj/structure/sign/safety/outpatient
	name = "门诊诊所标识"
	desc = "标识标准，表示附近存在门诊诊所。"
	icon_state = "outpatient"

/obj/structure/sign/safety/fibre_optics
	name = "光子学系统（光纤）标识"
	desc = "标识标准，表示附近存在光纤线路。"
	icon_state = "fibreoptic"

/obj/structure/sign/safety/press_area_ag
	name = "加压且有人工重力标识"
	desc = "标识标准，表示附近存在加压但无人工重力的区域。"
	icon_state = "pressareaag"

/obj/structure/sign/safety/press_area
	name = "加压区域标志"
	desc = "表示附近存在加压区域的标志标准。"
	icon_state = "pressarea"

/obj/structure/sign/safety/rad_haz
	name = "辐射危害标志"
	desc = "表示附近存在辐射危害的标志标准。"
	icon_state = "radhaz"

/obj/structure/sign/safety/rad_shield
	name = "辐射屏蔽区域标志"
	desc = "表示附近存在辐射屏蔽区域的标志标准。"
	icon_state = "radshield"

/obj/structure/sign/safety/radio_rad
	name = "无线电波辐射标志"
	desc = "表示附近存在无线电塔辐射的标志标准。"
	icon_state = "radiorad"

/obj/structure/sign/safety/reception
	name = "接待处标志"
	desc = "表示附近存在接待区域的标志标准。"
	icon_state = "reception"

/obj/structure/sign/safety/reduction
	name = "区域收窄标志"
	desc = "表示前方区域变小的标志标准。"
	icon_state = "reduction"

/obj/structure/sign/safety/ref_bio_storage
	name = "冷藏生物储存标志"
	desc = "表示附近存在冷藏生物储存的标志标准。"
	icon_state = "refbiostorage"

/obj/structure/sign/safety/ref_chem_storage
	name = "冷藏化学品储存标志"
	desc = "表示附近存在冷藏化学品储存的标志标准。"
	icon_state = "refchemstorage"

/obj/structure/sign/safety/restrictedarea
	name = "限制区域标志"
	desc = "表示附近存在限制区域的标志标准。"
	icon_state = "restrictedarea"

/obj/structure/sign/safety/fridge
	name = "冷藏储存（有机食品）标志"
	desc = "表示附近存在冰箱的标志标准。"
	icon_state = "fridge"

/obj/structure/sign/safety/refridgeration
	name = "制冷标志"
	desc = "表示附近存在非食品制冷设备的标志标准。"
	icon_state = "refridgeration"

/obj/structure/sign/safety/rewire
	name = "线路重接系统标志"
	desc = "表示附近存在线路重接系统的标志标准。"
	icon_state = "rewire"

/obj/structure/sign/safety/security
	name = "安保标志"
	desc = "符号标准，表示附近有执法或安保力量。"
	icon_state = "security"

/obj/structure/sign/safety/south
	name = "\improper South semiotic"
	desc = "符号标准，表示南面附近有某物。"
	icon_state = "south"

/obj/structure/sign/safety/stairs
	name = "楼梯符号"
	desc = "符号标准，表示附近有楼梯。"
	icon_state = "stairs"

/obj/structure/sign/safety/storage
	name = "存储符号"
	desc = "符号标准，表示附近有通用干存储室。"
	icon_state = "storage"

/obj/structure/sign/safety/suit_storage
	name = "压力服储物柜符号"
	desc = "符号标准，表示附近有压力服储物柜。"
	icon_state = "suitstorage"

/obj/structure/sign/safety/synth_storage
	name = "合成人存储符号"
	desc = "符号标准，表示附近有合成人单元存储室。"
	icon_state = "synthstorage"

/obj/structure/sign/safety/terminal
	name = "计算机终端符号"
	desc = "符号标准，表示附近有计算机终端。"
	icon_state = "terminal"

/obj/structure/sign/safety/tram
	name = "轨道列车线路符号"
	desc = "符号标准，表示附近有轨道列车线路。"
	icon_state = "tramline"

/obj/structure/sign/safety/twilight_zone_terminator
	name = "暮光区终结者符号"
	desc = "符号标准，表示附近有暮光区终结者。听起来可比这酷多了。"
	icon_state = "twilightzoneterminator"

/obj/structure/sign/safety/water
	name = "水源符号"
	desc = "符号标准，表示附近有水源。"
	icon_state = "water"

/obj/structure/sign/safety/waterhazard
	name = "水域危险符号"
	desc = "符号标准，表示水域危险。请让电子设备远离。"
	icon_state = "waterhaz"

/obj/structure/sign/safety/west
	name = "\improper West semiotic"
	desc = "符号标准，表示西面附近有某物。"
	icon_state = "west"

/obj/structure/sign/safety/zero_g
	name = "人工重力缺失符号"
	desc = "符号标准，表示附近缺乏人工重力。"
	icon_state = "zerog"

/obj/structure/sign/safety/flightcontrol
	name = "\improper flight control semiotic"
	desc = "符号标准，表示飞行控制系统使用或所属区域。"
	icon_state = "flightcontrol"

/obj/structure/sign/safety/airtraffictower
	name = "\improper air traffic tower semiotic"
	desc = "符号标准，表示附近有空中交通管制塔。"
	icon_state = "airtraffictower"

/obj/structure/sign/safety/luggageclaim
	name = "\improper luggage claim semiotic"
	desc = "表示附近有行李提取区的符号标准。"
	icon_state = "luggageclaim"

/obj/structure/sign/safety/landingzone
	name = "\improper landing zone semiotic"
	desc = "表示附近有着陆区的符号标准。"
	icon_state = "landingzone"

/obj/structure/sign/safety/zero
	name = "零号符号"
	desc = "表示数字零的符号标准。"
	icon_state = "0"

/obj/structure/sign/safety/one
	name = "一号符号"
	desc = "表示数字一的符号标准。"
	icon_state = "1"

/obj/structure/sign/safety/two
	name = "二号符号"
	desc = "表示数字二的符号标准。"
	icon_state = "2"

/obj/structure/sign/safety/three
	name = "三号符号"
	desc = "表示数字三的符号标准。"
	icon_state = "3"

/obj/structure/sign/safety/four
	name = "四号符号"
	desc = "表示数字四的符号标准。"
	icon_state = "4"

/obj/structure/sign/safety/five
	name = "五号符号"
	desc = "表示数字五的符号标准。"
	icon_state = "5"

/obj/structure/sign/safety/six
	name = "六号符号"
	desc = "表示数字六的符号标准。"
	icon_state = "6"

/obj/structure/sign/safety/seven
	name = "七号符号"
	desc = "表示数字七的符号标准。"
	icon_state = "7"

/obj/structure/sign/safety/eight
	name = "八号符号"
	desc = "表示数字八的符号标准。"
	icon_state = "8"

/obj/structure/sign/safety/nine
	name = "九号符号"
	desc = "表示数字九的符号标准。"
	icon_state = "9"

//===================//
//   Marine signs   //
//=================//

/obj/structure/sign/ROsign
	name = "\improper USCM Requisitions Office Guidelines"
	desc = "1. 你无权要求服务或装备。附件是特权，而非权利。\n2. 你必须着装整齐才能获得服务。冷冻睡眠内衣不可接受。\n3. 军需长拥有最终决定权，并有权拒绝服务。只有代理指挥官可以推翻其决定。\n4. 请尊重你的补给处工作人员。他们工作很努力。"
	icon_state = "roplaque"
	deconstructable = FALSE

/obj/structure/sign/ROcreed
	name = "\improper QMC Creed Plaque"
	desc = "这是美国军需兵部队制定的《军需长信条》简版，此版本纯属装饰性和仪式性，内容更短，且未包含更现代的修订。"
	desc_lore = {"I am Quartermaster
		My story is enfolded in the history of this nation.
		Sustainer of Armies...

		My forges burned at Valley Forge.
		Down frozen, rutted roads my oxen hauled
		the meager foods a bankrupt Congress sent me...
		Scant rations for the cold and starving troops,
		Gunpowder, salt, and lead.

		In 1812 we sailed to war in ships my boatwrights built.
		I fought beside you in the deserts of our great Southwest.
		My pack mules perished seeking water holes,
		And I went on with camels.
		I gave flags to serve.
		The medals and crest you wear are my design.

		Since 1862, I have sought our fallen brothers
		from Private to President.
		In war or peace I bring them home
		And lay them gently down in fields of honor.

		Provisioner, transporter.
		In 1898 I took you to Havana Harbor and the Philippines.
		I brought you tents, your khaki cloth for uniforms.
		When yellow fever struck, I brought the mattresses you lay upon.

		In 1917, we crossed the ocean to fight in the trenches and fields of France,
		New weapons, training, technologies, and tactics for the Great War.
		But always the need for food, water, ammunition, and now fuel.

		We shed first blood together at Pearl Harbor and Corregidor.
		Then begin the long march to Victory - Guadalcanal and North Africa, Sicily and the Solomons.
		I was there with you at Omaha Beach on D-Day and even the night before from Glider and Parachute.
		Across Europe and the Pacific, I drove and dug and fought till the job was done.

		When war came to the Peninsula in 1950, it was my 'chutes that filled the grey Korean skies.
		From the perimeter at Pusan to the cold roads of the Chosin, I was there.
		In 1965, I established the fire bases and depots across South Vietnam,
		The Hueys and Chinooks carried my supplies forward.

		I AM QUARTERMASTER.
		I can shape the course of combat,
		Change the outcome of battle.
		Look to me: Sustainer of Armies...Since 1775.

		I AM QUARTERMASTER. I AM PROUD."}
	icon_state = "rocreed"

/obj/structure/sign/prop1
	name = "\improper USCM Poster"
	desc = "美国殖民地海军陆战队的徽章。"
	icon_state = "prop1"

/obj/structure/sign/prop2
	name = "\improper USCM Poster"
	desc = "一张严重褪色的海报，上面是一群身着制服、光彩照人的殖民地海军陆战队员。可能拍摄于阿尔法行动之前。"
	icon_state = "prop2"

/obj/structure/sign/prop3
	name = "\improper USCM Poster"
	desc = "一张USCM的旧征兵海报。看着它，一股混杂着自豪与真诚悔恨的情绪涌上心头。"
	icon_state = "prop3"


/obj/structure/sign/catclock
	name = "猫形钟"
	desc = "一个令人难以置信的诡异猫形钟，每一次滴答声都在审视着房间。"
	icon = 'icons/obj/structures/props/furniture/clock.dmi'
	icon_state = "cat_clock_motion"

//===================//
//      Calendar     //
//=================//

/obj/structure/sign/calendar
	name = "挂历"
	desc = "经典的办公室装饰，也是一个可以疯狂凝视的地方。"
	icon_state = "calendar_civ"
	var/calendar_faction

/obj/structure/sign/catclock/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("The [src] reads: [worldtime2text()]")

/obj/structure/sign/calendar/get_examine_text(mob/user)
	. = ..()
	. += SPAN_INFO("The current date is: [time2text(world.realtime, "DDD, MMM DD")], [GLOB.game_year].")
	if(length(GLOB.holidays))
		. += SPAN_INFO("Events:")
		for(var/holidayname in GLOB.holidays)
			var/datum/holiday/holiday = GLOB.holidays[holidayname]
			if(holiday.holiday_faction)
				if(holiday.holiday_faction != calendar_faction)
					continue
			. += SPAN_INFO("[holiday.name]")
			. += SPAN_BOLDNOTICE("[holiday.greet_text]")

/obj/structure/sign/calendar/upp
	icon_state = "calendar_upp"
	desc = "经典的办公室装饰，带有一个可以疯狂凝视的点。印有UPP标志，用俄语书写。"
	calendar_faction = FACTION_UPP

/obj/structure/sign/calendar/wy
	icon_state = "calendar_wy"
	desc = "经典的办公室装饰，也是一个可以疯狂凝视的地方，由维兰德-汤谷生产。"
	calendar_faction = FACTION_WY

/obj/structure/sign/calendar/wy/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/structure/sign/calendar/twe
	icon_state = "calendar_twe"
	desc = "经典的办公室装饰，也是一个可以疯狂凝视的地方，上面有类似英国国旗的图案。"
	calendar_faction = FACTION_TWE

/obj/structure/sign/calendar/ua
	icon_state = "calendar_ua"
	desc = "经典的办公室装饰，也是一个可以疯狂凝视的地方，上面有垂直放置的UA旗帜和一些军队象征图案。"
	calendar_faction = FACTION_MARINE
