///////////////////// LANDMARK CORPSE ///////


//These are meant for spawning on maps, namely Away Missions.

/obj/effect/landmark/corpsespawner
	name = "未知"
	icon_state = "corpse_spawner"
	var/equip_path = null

/obj/effect/landmark/corpsespawner/Initialize(mapload, ...)
	. = ..()
	GLOB.corpse_spawns += src

/obj/effect/landmark/corpsespawner/Destroy()
	GLOB.corpse_spawns -= src
	return ..()

///////////Civilians//////////////////////

/obj/effect/landmark/corpsespawner/prisoner
	name = "囚犯"
	equip_path = /datum/equipment_preset/corpse/prisoner

/obj/effect/landmark/corpsespawner/chef
	name = "厨师"
	equip_path = /datum/equipment_preset/corpse/chef

/obj/effect/landmark/corpsespawner/doctor
	name = "医生"
	equip_path = /datum/equipment_preset/corpse/doctor

/obj/effect/landmark/corpsespawner/engineer
	name = "工程师"
	equip_path = /datum/equipment_preset/corpse/engineer

/obj/effect/landmark/corpsespawner/scientist
	name = "科学家"
	equip_path = /datum/equipment_preset/corpse/scientist

/obj/effect/landmark/corpsespawner/miner
	name = "矿井矿工"
	equip_path = /datum/equipment_preset/corpse/miner

/obj/effect/landmark/corpsespawner/security
	name = "安保官"
	equip_path = /datum/equipment_preset/corpse/security

/obj/effect/landmark/corpsespawner/security/marshal
	name = "殖民地法警副官"
	equip_path = /datum/equipment_preset/corpse/security/cmb

/obj/effect/landmark/corpsespawner/security/marshal/riot
	name = "CMB防暴控制官"
	equip_path = /datum/equipment_preset/corpse/security/cmb/riot

/obj/effect/landmark/corpsespawner/security/liaison
	name = "公司联络官"
	equip_path = /datum/equipment_preset/corpse/liaison

/obj/effect/landmark/corpsespawner/prison_security
	name = "监狱守卫"
	equip_path = /datum/equipment_preset/corpse/prison_guard

/////////////////Officers//////////////////////

/obj/effect/landmark/corpsespawner/bridgeofficer
	name = "殖民地部门经理"
	equip_path = /datum/equipment_preset/corpse/manager

/obj/effect/landmark/corpsespawner/administrator
	name = "殖民地行政官"
	equip_path = /datum/equipment_preset/corpse/administrator

/obj/effect/landmark/corpsespawner/administrator/burst
	name = "爆裂殖民地行政官"
	equip_path = /datum/equipment_preset/corpse/administrator/burst

/obj/effect/landmark/corpsespawner/wysec
	name = "维兰德-汤谷公司安保警卫"
	equip_path = /datum/equipment_preset/corpse/wysec

/obj/effect/landmark/corpsespawner/wygoon
	name = "维兰德-汤谷公司安保官"
	equip_path = /datum/equipment_preset/corpse/pmc/goon

/obj/effect/landmark/corpsespawner/wygoon/lead
	name = "维兰德-汤谷企业安保领队"
	equip_path = /datum/equipment_preset/corpse/pmc/goon/lead

/obj/effect/landmark/corpsespawner/wygoon/lead/burst
	name = "爆裂维兰德-汤谷公司安保主管"
	equip_path = /datum/equipment_preset/corpse/pmc/goon/lead/burst

/obj/effect/landmark/corpsespawner/wygoon/kutjevo
	name = "维兰德-汤谷库特耶沃公司安保"
	equip_path = /datum/equipment_preset/corpse/pmc/goon/kutjevo

/obj/effect/landmark/corpsespawner/wygoon/trijent
	name = "维兰德-汤谷特里金特公司安保"
	equip_path = /datum/equipment_preset/corpse/pmc/goon/trijent

/obj/effect/landmark/corpsespawner/wygoon/lead/trijent
	name = "维兰德-汤谷特里金特公司安保主管"
	equip_path = /datum/equipment_preset/corpse/pmc/goon/lead/trijent


///CM specific jobs///

/obj/effect/landmark/corpsespawner/colonist //default is a colonist
	name = "殖民者"
	equip_path = /datum/equipment_preset/corpse/colonist

/obj/effect/landmark/corpsespawner/colonist/burst
	name = "连发殖民者"
	equip_path = /datum/equipment_preset/corpse/colonist/burst

/obj/effect/landmark/corpsespawner/colonist/kutjevo
	name = "库特耶沃殖民者"
	equip_path = /datum/equipment_preset/corpse/colonist/kutjevo

/obj/effect/landmark/corpsespawner/colonist/kutjevo/burst
	name = "连发库特耶沃殖民者"
	equip_path = /datum/equipment_preset/corpse/colonist/kutjevo/burst

/obj/effect/landmark/corpsespawner/colonist/random
	name = "随机殖民者"
	equip_path = /datum/equipment_preset/corpse/colonist/random

/obj/effect/landmark/corpsespawner/colonist/random/burst
	name = "连发随机殖民者"
	equip_path = /datum/equipment_preset/corpse/colonist/random/burst

/obj/effect/landmark/corpsespawner/ua_riot
	name = "UA军官"
	equip_path = /datum/equipment_preset/corpse/ua_riot

/obj/effect/landmark/corpsespawner/ua_riot/burst
	name = "连发UA军官"
	equip_path = /datum/equipment_preset/corpse/ua_riot/burst

/obj/effect/landmark/corpsespawner/wy/manager
	name = "公司主管"
	equip_path = /datum/equipment_preset/corpse/wy/manager

/obj/effect/landmark/corpsespawner/wy/manager/burst
	name = "连发公司主管"
	equip_path = /datum/equipment_preset/corpse/wy/manager/burst


///////////Faction Specific Corpses//////////////////////

/obj/effect/landmark/corpsespawner/clf
	name = "殖民地解放阵线士兵"
	equip_path = /datum/equipment_preset/corpse/clf

/obj/effect/landmark/corpsespawner/clf/burst
	name = "连发殖民地解放阵线士兵"
	equip_path = /datum/equipment_preset/corpse/clf/burst

/obj/effect/landmark/corpsespawner/upp
	name = "进步人民联盟士兵"
	equip_path = /datum/equipment_preset/corpse/upp

/obj/effect/landmark/corpsespawner/upp/burst
	name = "连发进步人民联盟士兵"
	equip_path = /datum/equipment_preset/corpse/upp/burst

/obj/effect/landmark/corpsespawner/pmc
	name = "维兰德-汤谷PMC（标准）"
	equip_path = /datum/equipment_preset/corpse/pmc

/obj/effect/landmark/corpsespawner/pmc/burst
	name = "连发维兰德-汤谷PMC（标准）"
	equip_path = /datum/equipment_preset/corpse/pmc/burst

/obj/effect/landmark/corpsespawner/freelancer
	name = "自由佣兵"
	equip_path = /datum/equipment_preset/corpse/freelancer

/obj/effect/landmark/corpsespawner/freelancer/burst
	name = "连发自由佣兵"
	equip_path = /datum/equipment_preset/corpse/freelancer/burst

// Fun Faction Corpse

/obj/effect/landmark/corpsespawner/realpirate
	name = "海盗"
	equip_path = /datum/equipment_preset/corpse/realpirate

/obj/effect/landmark/corpsespawner/realpirate/ranged
	name = "海盗枪手"
	equip_path = /datum/equipment_preset/corpse/realpirate/ranged

/obj/effect/landmark/corpsespawner/russian
	name = "俄罗斯人"
	equip_path = /datum/equipment_preset/corpse/russian

/obj/effect/landmark/corpsespawner/russian/ranged

/obj/effect/landmark/corpsespawner/dutchrifle
	name = "荷兰十二人步枪兵"
	equip_path = /datum/equipment_preset/corpse/dutchrifle

/obj/effect/landmark/corpsespawner/dutchrifle/burst
	name = "连发荷兰十二人步枪兵"
	equip_path = /datum/equipment_preset/corpse/dutchrifle/burst

/obj/effect/landmark/corpsespawner/pizza
	name = "披萨配送员"
	equip_path = /datum/equipment_preset/corpse/pizza

/obj/effect/landmark/corpsespawner/pizza/burst
	name = "连发披萨配送员"
	equip_path = /datum/equipment_preset/corpse/pizza/burst

/obj/effect/landmark/corpsespawner/gladiator
	name = "角斗士"
	equip_path = /datum/equipment_preset/corpse/gladiator

/obj/effect/landmark/corpsespawner/gladiator/burst
	name = "连发角斗士"
	equip_path = /datum/equipment_preset/corpse/gladiator/burst

//FORECON

/obj/effect/landmark/corpsespawner/forecon_spotter
	name = "USCM侦察观察员"
	equip_path = /datum/equipment_preset/corpse/forecon_spotter


///////////////////////
/////// HYBRISA ///////
///////////////////////

// Hybrisa - Goons

/obj/effect/landmark/corpsespawner/hybrisa_goon
	name = "维兰德-汤谷公司安保官"
	equip_path = /datum/equipment_preset/corpse/pmc/hybrisa_goon

/obj/effect/landmark/corpsespawner/hybrisa_goon/burst
	name = "爆裂的维兰德-汤谷公司安保官"
	equip_path = /datum/equipment_preset/corpse/pmc/hybrisa_goon/lead/burst

/obj/effect/landmark/corpsespawner/hybrisa_goon/lead
	name = "维兰德-汤谷企业安保领队"
	equip_path = /datum/equipment_preset/corpse/pmc/hybrisa_goon/lead

/obj/effect/landmark/corpsespawner/hybrisa_goon/lead/burst
	name = "爆裂维兰德-汤谷公司安保主管"
	equip_path = /datum/equipment_preset/corpse/pmc/hybrisa_goon/lead/burst

//*****************************************************************************************************/

// Civilian

/obj/effect/landmark/corpsespawner/hybrisa/civilian
	name = "尸体 - 平民"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian

/obj/effect/landmark/corpsespawner/hybrisa/civilian/burst
	name = "尸体 - 爆裂 - 平民"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian/burst

/obj/effect/landmark/corpsespawner/hybrisa/civilian_office
	name = "尸体 - 平民 - 办公室职员"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian_office

/obj/effect/landmark/corpsespawner/hybrisa/civilian_office/burst
	name = "尸体 - 爆裂 - 平民 - 办公室职员"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian_office/burst

// Weymart

/obj/effect/landmark/corpsespawner/hybrisa/weymart
	name = "尸体 - 平民 - 维玛特员工"
	equip_path = /datum/equipment_preset/corpse/hybrisa/weymart

/obj/effect/landmark/corpsespawner/hybrisa/weymart/burst
	name = "尸体 - 爆裂 - 平民 - 维玛特员工"
	equip_path = /datum/equipment_preset/corpse/hybrisa/weymart/burst

// Sanitation

/obj/effect/landmark/corpsespawner/hybrisa/sanitation
	name = "尸体 - 平民 - 材料回收技术员"
	equip_path = /datum/equipment_preset/corpse/hybrisa/sanitation

/obj/effect/landmark/corpsespawner/hybrisa/sanitation/burst
	name = "尸体 - 爆裂 - 平民 - 材料回收技术员"
	equip_path = /datum/equipment_preset/corpse/hybrisa/sanitation/burst

// Pizza Galaxy

/obj/effect/landmark/corpsespawner/hybrisa/pizza_galaxy
	name = "尸体 - 平民 - 银河披萨送货司机"
	equip_path = /datum/equipment_preset/corpse/hybrisa/pizza_galaxy

/obj/effect/landmark/corpsespawner/hybrisa/pizza_galaxy/burst
	name = "尸体 - 爆裂 - 平民 - 银河披萨送货司机"
	equip_path = /datum/equipment_preset/corpse/hybrisa/pizza_galaxy/burst

//*****************************************************************************************************/

// NSPA

/obj/effect/landmark/corpsespawner/hybrisa/nspa_constable
	name = "尸体 - NSPA警官"
	equip_path = /datum/equipment_preset/corpse/hybrisa/nspa_constable

/obj/effect/landmark/corpsespawner/hybrisa/nspa_constable/burst
	name = "尸体 - 爆裂 - NSPA警官"
	equip_path = /datum/equipment_preset/corpse/hybrisa/nspa_constable/burst

/obj/effect/landmark/corpsespawner/trijent/nspa_constable/
	name = "尸体 - 特里金特NSPA警官"
	equip_path = /datum/equipment_preset/corpse/hybrisa/nspa_constable/trijent

/obj/effect/landmark/corpsespawner/trijent/nspa_constable/burst
	name = "尸体 - 爆裂 - 特里金特NSPA警官"
	equip_path = /datum/equipment_preset/corpse/hybrisa/nspa_constable/trijent/burst

//*****************************************************************************************************/

// KMCC Mining

/obj/effect/landmark/corpsespawner/hybrisa/kelland_miner
	name = "尸体 - KMCC - 矿工"
	equip_path = /datum/equipment_preset/corpse/hybrisa/kelland_miner

/obj/effect/landmark/corpsespawner/hybrisa/kelland_miner/burst
	name = "尸体 - 爆裂 - KMCC - 矿工"
	equip_path = /datum/equipment_preset/corpse/hybrisa/kelland_miner/burst

//*****************************************************************************************************/

// Medical

/obj/effect/landmark/corpsespawner/hybrisa/medical_doctor_corpse

	name = "尸体 - 平民 - 医生"
	equip_path = /datum/equipment_preset/corpse/hybrisa/medical_doctor_corpse

/obj/effect/landmark/corpsespawner/hybrisa/medical_doctor_corpse/burst

	name = "尸体 - 爆裂 - 平民 - 医生"
	equip_path = /datum/equipment_preset/corpse/hybrisa/medical_doctor_corpse/burst

//*****************************************************************************************************/

// Science

// Xenobiologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenobiologist

	name = "尸体 - 平民 - 异形生物学家"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenobiologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenobiologist/burst

	name = "尸体 - 爆裂 - 平民 - 异形生物学家"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenobiologist/burst

// Xenoarchaeologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenoarchaeologist

	name = "尸体 - 平民 - 异形考古学家"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenoarchaeologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenoarchaeologist/burst

	name = "尸体 - 爆裂 - 平民 - 异形考古学家"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenoarchaeologist/burst

//*****************************************************************************************************/
