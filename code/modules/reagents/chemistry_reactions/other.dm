/datum/chemical_reaction/explosive
	name = "氢氧化钾"
	id = "potassium_hydroxide"
	result = "potassium_hydroxide"
	required_reagents = list("water" = 1, "potassium" = 1)
	result_amount = 1
	var/sensitivity_threshold = 0

/datum/chemical_reaction/explosive/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	if(created_volume > sensitivity_threshold)
		holder.trigger_volatiles = TRUE
	return

/datum/chemical_reaction/explosive/anfo
	name = "anfo"
	id = "anfo"
	result = "anfo"
	required_reagents = list("ammonium_nitrate" = 2, "fuel" = 1)
	result_amount = 2
	sensitivity_threshold = 60.001

/datum/chemical_reaction/explosive/nitroglycerin
	name = "nitroglycerin"
	id = "nitroglycerin"
	result = "nitroglycerin"
	required_reagents = list("glycerol" = 1, "pacid" = 1, "sulphuric acid" = 1)
	result_amount = 2
	sensitivity_threshold = 5.001

/datum/chemical_reaction/emp_pulse
	name = "EMP脉冲"
	id = "emp_pulse"
	result = null
	required_reagents = list("uranium" = 1, "iron" = 1) // Yes, laugh, it's the best recipe I could think of that makes a little bit of sense
	result_amount = 2
	mob_react = FALSE

/datum/chemical_reaction/emp_pulse/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/turf/location = get_turf(holder.my_atom)
	// 100 created volume = 4 heavy range & 7 light range. A few tiles smaller than traitor EMP grandes.
	// 200 created volume = 8 heavy range & 14 light range. 4 tiles larger than traitor EMP grenades.
	var/mob/causer = GLOB.ckey_to_occupied_mob[ckey(holder.my_atom.fingerprintslast)]
	empulse(location, floor(created_volume / 24), floor(created_volume / 14), causer)
	holder.clear_reagents()


/datum/chemical_reaction/pttoxin
	name = "毒素"
	id = "pttoxin"
	result = "pttoxin"
	required_reagents = list("paracetamol" = 1, "tramadol" = 1)
	result_amount = 2

/datum/chemical_reaction/mutagen
	name = "不稳定诱变剂"
	id = "mutagen"
	result = "mutagen"
	required_reagents = list("radium" = 1, "phosphorus" = 1, "chlorine" = 1)
	result_amount = 3

/datum/chemical_reaction/stoxin
	name = "催眠剂"
	id = "stoxin"
	result = "stoxin"
	required_reagents = list("sugar" = 4, "chloralhydrate" = 1)
	result_amount = 5

/datum/chemical_reaction/chloralhydrate
	name = "水合氯醛"
	id = "chloralhydrate"
	result = "chloralhydrate"
	required_reagents = list("chlorine" = 3, "ethanol" = 1, "water" = 1)
	result_amount = 1

/datum/chemical_reaction/iron_sulfate
	name = "硫酸亚铁"
	id = "iron_sulfate"
	result = "iron_sulfate"
	required_reagents = list("iron" = 1, "sulphuric acid" = 5)
	result_amount = 1

/datum/chemical_reaction/iron_phoride_sulfate
	name = "硫酸铁"
	id = "iron_phoride_sulfate"
	result = "iron_phoride_sulfate"
	required_reagents = list("iron_sulfate" = 3, "phoron" = 1)
	reaction_type = parent_type::reaction_type | CHEM_REACTION_FIRE
	result_amount = 1

/datum/chemical_reaction/sacid
	name = "硫酸"
	id = "sulphuric acid"
	result = "sulphuric acid"
	required_reagents = list("hydrogen" = 2, "sulfur" = 1, "oxygen" = 4)
	result_amount = 1

/datum/chemical_reaction/copper_sulfate
	name = "硫酸铜"
	id = "copper_sulfate"
	result = "copper_sulfate"
	required_reagents = list("copper" = 2, "sulphuric acid" = 5)
	reaction_type = parent_type::reaction_type | CHEM_REACTION_SMOKING
	result_amount = 1

/datum/chemical_reaction/ethanol
	name = "乙醇"
	id = "ethanol"
	result = "ethanol"
	required_reagents = list("hydrogen" = 6, "carbon" = 2, "oxygen" = 1)
	result_amount = 1

/datum/chemical_reaction/water //I can't believe we never had this.
	name = "水"
	id = "water"
	result = "water"
	required_reagents = list("hydrogen" = 2, "oxygen" = 1)
	result_amount = 1


/datum/chemical_reaction/thermite
	name = "铝热剂"
	id = "thermite"
	result = "thermite"
	required_reagents = list("aluminum" = 1, "iron" = 1, "oxygen" = 1)
	result_amount = 3


/datum/chemical_reaction/lexorin
	name = "莱克索林"
	id = "lexorin"
	result = "lexorin"
	required_reagents = list("phoron" = 1, "hydrogen" = 1, "nitrogen" = 1)
	result_amount = 3

/datum/chemical_reaction/space_drugs
	name = "太空药物"
	id = "space_drugs"
	result = "space_drugs"
	required_reagents = list("mercury" = 1, "sugar" = 1, "lithium" = 1)
	result_amount = 3

/datum/chemical_reaction/sleen
	name = "斯林"
	id = "sleen"
	result = "sleen"
	required_reagents = list("oxycodone" = 1, "souto_lime" = 1)
	result_amount = 2

/datum/chemical_reaction/pacid
	name = "聚三硝基酸"
	id = "pacid"
	result = "pacid"
	required_reagents = list("sulphuric acid" = 1, "chlorine" = 1, "potassium" = 1)
	result_amount = 3

/datum/chemical_reaction/impedrezene
	name = "阻抗嗪"
	id = "impedrezene"
	result = "impedrezene"
	required_reagents = list("mercury" = 1, "oxygen" = 1, "sugar" = 1)
	result_amount = 2

/datum/chemical_reaction/cryptobiolin
	name = "隐生菌素"
	id = "cryptobiolin"
	result = "cryptobiolin"
	required_reagents = list("potassium" = 1, "oxygen" = 1, "sugar" = 1)
	result_amount = 3

/datum/chemical_reaction/glycerol
	name = "甘油"
	id = "glycerol"
	result = "glycerol"
	required_reagents = list("cornoil" = 3, "sulphuric acid" = 1)
	result_amount = 1

/datum/chemical_reaction/flash_powder
	name = "闪光粉"
	id = "flash_powder"
	result = null
	required_reagents = list("aluminum" = 1, "potassium" = 1, "sulfur" = 1 )
	result_amount = 3
	reaction_type =  parent_type::reaction_type | CHEM_REACTION_FIRE
	mob_react = FALSE

/datum/chemical_reaction/flash_powder/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/turf/location = get_turf(holder.my_atom)
	var/datum/effect_system/spark_spread/sparker = new
	sparker.set_up(2, 1, location)
	sparker.start()
	var/obj/item/device/flashlight/flare/on/illumination/chemical/light = new(holder.my_atom, created_volume)

	//Admin messaging
	var/area/area = get_area(location)
	var/where = "[area.name]|[location.x], [location.y]"
	var/whereLink = "<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];adminplayerobservecoodjump=1;X=[location.x];Y=[location.y];Z=[location.z]'>[where]</a>"
	var/data = " [created_volume] volume -> fuel: [light.fuel] range: [light.light_range] power: [light.light_power]"

	if(holder.my_atom.fingerprintslast)
		msg_admin_niche("[src] reaction has taken place in ([whereLink])[data]. Last associated key is [holder.my_atom.fingerprintslast].")
		log_game("[src] reaction has taken place in ([where])[data]. Last associated key is [holder.my_atom.fingerprintslast].")
	else
		msg_admin_niche("[src] reaction has taken place in ([whereLink])[data]. No associated key.")
		log_game("[src] reaction has taken place in ([where])[data]. No associated key.")

/datum/chemical_reaction/chemfire
	name = "凝固汽油"
	id = "napalm"
	result = "napalm"
	required_reagents = list("aluminum" = 1, "phoron" = 1, "sulphuric acid" = 1 )
	result_amount = 1

/datum/chemical_reaction/chemfire/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	holder.trigger_volatiles = TRUE
	return

/datum/chemical_reaction/custom/sticky
	name = "粘性凝固汽油"
	id = "stickynapalm"
	result = "stickynapalm"
	required_reagents = list("napalm" = 1, "fuel" = 1)
	result_amount = 2

/datum/chemical_reaction/custom/high_damage
	name = "高燃凝固汽油燃料"
	id = "highdamagenapalm"
	result = "highdamagenapalm"
	required_reagents = list("napalm" = 1, "chlorine trifluoride" = 1)
	result_amount = 2

// Chemfire supplement chemicals.
/datum/chemical_reaction/chlorinetrifluoride
	name = "三氟化氯"
	id = "chlorine trifluoride"
	result = "chlorine trifluoride"
	required_reagents = list("fluorine" = 3, "chlorine" = 1)
	result_amount = 3

/datum/chemical_reaction/chlorinetrifluoride/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	holder.trigger_volatiles = TRUE
	return

/datum/chemical_reaction/methane
	name = "甲烷"
	id = "methane"
	result = "methane"
	required_reagents = list("hydrogen" = 4,"carbon" = 1)
	result_amount = 1

//Explosive components
/datum/chemical_reaction/formaldehyde
	name = "甲醛"
	id = "formaldehyde"
	result = "formaldehyde"
	reaction_type =  parent_type::reaction_type | CHEM_REACTION_SMOKING
	required_reagents = list("methane" = 1, "oxygen" = 1, "phoron" = 1)
	required_catalysts = list("silver" = 5)
	result_amount = 3

/datum/chemical_reaction/phenolformaldehyde_resin
	name = "酚醛树脂"
	id = "phenol_formaldehyde"
	result = "phenol_formaldehyde"
	required_reagents = list("formaldehyde" = 2, "phenol" = 1)
	required_catalysts = list("methane" = 5)
	reaction_type = CHEM_REACTION_ENDOTHERMIC
	result_amount = 3

/datum/chemical_reaction/paraformaldehyde
	name = "多聚甲醛"
	id = "paraformaldehyde"
	result = "paraformaldehyde"
	required_reagents = list("formaldehyde" = 1, "frostoil" = 1)
	result_amount = 1

/datum/chemical_reaction/hexamine
	name = "六胺"
	id = "hexamine"
	result = "hexamine"
	required_reagents = list("ammonia" = 2, "formaldehyde" = 3)
	reaction_type =  parent_type::reaction_type | CHEM_REACTION_BUBBLING
	result_amount = 3

/datum/chemical_reaction/ammoniumnitrate
	name = "硝酸铵"
	id = "ammonium_nitrate"
	result = "ammonium_nitrate"
	required_reagents = list("ammonia" = 1, "pacid" = 1)
	result_amount = 2

/datum/chemical_reaction/octogen
	name = "奥克托今"
	id = "octogen"
	result = "octogen"
	required_reagents = list("hexamine" = 1, "pacid" = 1, "paraformaldehyde" = 1, "ammonium_nitrate" = 1,)
	result_amount = 2

/datum/chemical_reaction/cyclonite
	name = "旋风炸药"
	id = "cyclonite"
	result = "cyclonite"
	required_reagents = list("hexamine" = 1, "pacid" = 1)
	result_amount = 1

/datum/chemical_reaction/ammoniumnitrate
	name = "硝酸铵"
	id = "ammonium_nitrate"
	result = "ammonium_nitrate"
	required_reagents = list("ammonia" = 1, "pacid" = 1)
	result_amount = 2

/datum/chemical_reaction/chemsmoke
	name = "化学烟雾"
	id = "chemsmoke"
	result = null
	required_reagents = list("potassium" = 1, "sugar" = 1, "phosphorus" = 1)
	result_amount = 0.4
	secondary = 1
	mob_react = FALSE

/datum/chemical_reaction/chemsmoke/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/smoke_spread/chem/S = new /datum/effect_system/smoke_spread/chem
	S.attach(location)
	S.set_up(holder, created_volume, 0, location)
	playsound(location, 'sound/effects/smoke.ogg', 25, 1)
	INVOKE_ASYNC(S, TYPE_PROC_REF(/datum/effect_system/smoke_spread/chem, start))
	holder.clear_reagents()

/datum/chemical_reaction/potassium_chloride
	name = "氯化钾"
	id = "potassium_chloride"
	result = "potassium_chloride"
	required_reagents = list("sodiumchloride" = 1, "potassium" = 1)
	reaction_type = parent_type::reaction_type | CHEM_REACTION_SMOKING
	result_amount = 2

/datum/chemical_reaction/potassium_chlorophoride
	name = "氯氟化钾"
	id = "potassium_chlorophoride"
	result = "potassium_chlorophoride"
	required_reagents = list("potassium_chloride" = 1, "phoron" = 1, "chloralhydrate" = 1)
	reaction_type = parent_type::reaction_type | CHEM_REACTION_BUBBLING
	result_amount = 4

/datum/chemical_reaction/potassium_phorosulfate
	name = "磷硫钾"
	id = "potassium_phorosulfate"
	result = "potassium_phorosulfate"
	required_reagents = list("potassium_chlorophoride" = 1, "sulphuric acid" = 4)
	reaction_type = CHEM_REACTION_ENDOTHERMIC
	result_amount = 1

/datum/chemical_reaction/zombiepowder
	name = "僵尸粉"
	id = "zombiepowder"
	result = "zombiepowder"
	required_reagents = list("carpotoxin" = 5, "stoxin" = 5, "copper" = 5)
	result_amount = 2

/datum/chemical_reaction/rezadone
	name = "雷扎酮"
	id = "rezadone"
	result = "rezadone"
	required_reagents = list("carpotoxin" = 1, "cryptobiolin" = 1, "copper" = 1)
	result_amount = 3

/datum/chemical_reaction/mindbreaker
	name = "心智崩坏毒素"
	id = "mindbreaker"
	result = "mindbreaker"
	required_reagents = list("silicon" = 1, "hydrogen" = 1, "anti_toxin" = 1)
	result_amount = 3

/datum/chemical_reaction/lipozine
	name = "脂解素"
	id = "lipozine"
	result = "lipozine"
	required_reagents = list("sodiumchloride" = 1, "ethanol" = 1, "radium" = 1)
	result_amount = 3

/datum/chemical_reaction/phoronsolidification
	name = "固态福隆"
	id = "solidphoron"
	result = null
	required_reagents = list("iron" = 5, "frostoil" = 5, "phoron" = 20)

	result_amount = 1

/datum/chemical_reaction/phoronsolidification/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /obj/item/stack/sheet/mineral/phoron(location)
	return

/datum/chemical_reaction/plastication
	name = "塑料"
	id = "solidplastic"
	result = null
	required_reagents = list("pacid" = 10, "plasticide" = 20)
	result_amount = 1

/datum/chemical_reaction/plastication/on_reaction(datum/reagents/holder)
	. = ..()
	new /obj/item/stack/sheet/mineral/plastic(get_turf(holder.my_atom),10)
	return

/datum/chemical_reaction/virus_food
	name = "病毒培养基"
	id = "virusfood"
	result = "virusfood"
	required_reagents = list("water" = 1, "milk" = 1, "oxygen" = 1)
	result_amount = 3


//*****************************************************************************************************/
//*********************************Foam and Foam Precursor*********************************************/
//*****************************************************************************************************/

/datum/chemical_reaction/surfactant
	name = "泡沫表面活性剂"
	id = "foam surfactant"
	result = "fluorosurfactant"
	required_reagents = list("fluorine" = 2, "carbon" = 2, "sulphuric acid" = 1)
	result_amount = 5

/datum/chemical_reaction/stablefoam
	name = "稳定金属泡沫"
	id = "stablefoam"
	result = "stablefoam"
	required_reagents = list("fluorosurfactant" = 1, "iron" = 1, "sulphuric acid" = 1)
	result_amount = 1

/datum/chemical_reaction/foam
	name = "泡沫"
	id = "foam"
	result = null
	required_reagents = list("fluorosurfactant" = 1, "water" = 1)
	result_amount = 2
	mob_react = FALSE

/datum/chemical_reaction/foam/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	location = get_turf(holder.my_atom)

	for(var/mob/M as anything in viewers(5, location))
		to_chat(M, SPAN_WARNING("溶液喷出泡沫！"))
	//for(var/datum/reagent/R in holder.reagent_list)

	var/datum/effect_system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 0)
	s.start()
	holder.clear_reagents()


/datum/chemical_reaction/metal_foam
	name = "金属泡沫"
	id = "metal_foam"
	result = null
	required_reagents = list("aluminum" = 3, "foaming_agent" = 1, "pacid" = 1)
	result_amount = 5

/datum/chemical_reaction/metal_foam/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)

	for(var/mob/M as anything in viewers(5, location))
		to_chat(M, SPAN_WARNING("溶液喷出闪亮的金属泡沫！"))

	var/datum/effect_system/foam_spread/s = new()
	if (created_volume > 300)
		created_volume = 300
	s.set_up(created_volume, location, holder, 1)
	s.start()

/datum/chemical_reaction/foaming_agent
	name = "发泡剂"
	id = "foaming_agent"
	result = "foaming_agent"
	required_reagents = list("lithium" = 1, "hydrogen" = 1)
	result_amount = 1

/datum/chemical_reaction/ammonia
	name = "氨水"
	id = "ammonia"
	result = "ammonia"
	required_reagents = list("hydrogen" = 3, "nitrogen" = 1)
	result_amount = 3

/datum/chemical_reaction/diethylamine
	name = "二乙胺"
	id = "diethylamine"
	result = "diethylamine"
	required_reagents = list ("ammonia" = 1, "ethanol" = 1)
	result_amount = 2

/datum/chemical_reaction/space_cleaner
	name = "太空清洁剂"
	id = "cleaner"
	result = "cleaner"
	required_reagents = list("ammonia" = 1, "water" = 1, "sodiumchloride" = 1)
	result_amount = 2

/datum/chemical_reaction/dinitroaniline
	name = "二硝基苯胺"
	id = "dinitroaniline"
	result = "dinitroaniline"
	required_reagents = list("ammonia" = 1, "sulphuric acid" = 1, "nitrogen" = 1)
	result_amount = 3

/datum/chemical_reaction/plantbgone
	name = "植物杀手"
	id = "plantbgone"
	result = "plantbgone"
	required_reagents = list("water" = 4, "toxin" = 1)
	result_amount = 5

/datum/chemical_reaction/royalplasma
	name = "皇家血浆"
	id = "royalplasma"
	result = "royalplasma"
	required_reagents = list("eggplasma" = 1, "xenobloodroyal" = 1)
	result_amount = 2

/datum/chemical_reaction/antineurotoxin
	name = "抗神经毒素"
	id = "antineurotoxin"
	result = "antineurotoxin"
	required_reagents = list("neurotoxinplasma" = 1, "anti_toxin" = 1)
	result_amount = 1

/datum/chemical_reaction/eggplasma
	name = "虫卵血浆"
	id = "eggplasma"
	result = "eggplasma"
	required_reagents = list("blood" = 10, "eggplasma" = 1)
	result_amount = 2
