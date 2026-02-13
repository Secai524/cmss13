// Contain all the crate related to research.

//explosif related section

/datum/supply_packs/assembly
	name = "组装箱"
	contains = list(
		/obj/item/device/assembly/igniter,
		/obj/item/device/assembly/igniter,
		/obj/item/device/assembly/igniter,
		/obj/item/device/assembly/igniter,
		/obj/item/device/assembly/igniter,
		/obj/item/device/assembly/prox_sensor,
		/obj/item/device/assembly/prox_sensor,
		/obj/item/device/assembly/prox_sensor,
		/obj/item/device/assembly/prox_sensor,
		/obj/item/device/assembly/prox_sensor,
		/obj/item/device/assembly/timer,
		/obj/item/device/assembly/timer,
		/obj/item/device/assembly/timer,
		/obj/item/device/assembly/timer,
		/obj/item/device/assembly/timer,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "组装箱"
	access = ACCESS_MARINE_ENGINEERING
	group = "Research"

//Chemical section

/datum/supply_packs/pyrotec
	name = "烟火装置箱"
	contains = list(
		/obj/item/reagent_container/glass/beaker/sulphuric,
		/obj/item/reagent_container/glass/beaker/sulphuric,
		/obj/item/reagent_container/glass/beaker/sulphuric,
		/obj/item/reagent_container/glass/beaker/ethanol,
		/obj/item/reagent_container/glass/beaker/ethanol,
		/obj/item/reagent_container/glass/beaker/ethanol,
		/obj/item/reagent_container/glass/beaker/large/phosphorus,
		/obj/item/reagent_container/glass/beaker/large/phosphorus,
		/obj/item/reagent_container/glass/beaker/large/phosphorus,
		/obj/item/reagent_container/glass/beaker/large/lithium,
		/obj/item/reagent_container/glass/beaker/large/lithium,
		/obj/item/reagent_container/glass/beaker/large/sodiumchloride,
		/obj/item/reagent_container/glass/beaker/large/sodiumchloride,
		/obj/item/reagent_container/glass/beaker/large/potassiumchloride,
		/obj/item/reagent_container/glass/beaker/large/potassiumchloride,
	)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "烟火装置箱"
	access = ACCESS_MARINE_ENGINEERING
	group = "Research"

/datum/supply_packs/phoron
	name = "氪石货箱"
	contains = list(
		/obj/item/stack/sheet/mineral/phoron/medium_stack,
		/obj/item/stack/sheet/mineral/phoron/medium_stack,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "氪石货箱"
	access = ACCESS_MARINE_ENGINEERING
	group = "Research"

/datum/supply_packs/plastic
	name = "塑料箱"
	contains = list(
		/obj/item/stack/sheet/mineral/plastic/small_stack,
		/obj/item/stack/sheet/mineral/plastic/small_stack,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "塑料箱"
	access = ACCESS_MARINE_ENGINEERING
	group = "Research"

/datum/supply_packs/precious_metals
	name = "贵金属箱"
	contains = list(
		/obj/item/stack/sheet/mineral/gold/small_stack,
		/obj/item/stack/sheet/mineral/silver/small_stack,
		/obj/item/stack/sheet/mineral/uranium/small_stack,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "贵金属箱"
	access = ACCESS_MARINE_ENGINEERING
	group = "Research"

/datum/supply_packs/exp_production
	name = "爆炸物生产箱"
	contains = list(
		/obj/item/reagent_container/glass/canister,
		/obj/item/reagent_container/glass/canister,
		/obj/item/reagent_container/glass/canister/ammonia,
		/obj/item/reagent_container/glass/canister/ammonia,
		/obj/item/reagent_container/glass/canister/methane,
		/obj/item/reagent_container/glass/canister/methane,
		/obj/item/reagent_container/glass/canister/oxygen,
		/obj/item/reagent_container/glass/canister/oxygen,
		/obj/item/reagent_container/glass/canister/pacid,
		/obj/item/reagent_container/glass/canister/pacid,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "爆炸物生产箱"
	access = ACCESS_MARINE_ENGINEERING
	group = "Research"

//Xeno section

/datum/supply_packs/xeno_tags
	name = "异形敌我识别标签箱（x7标签）"
	contains = list(
		/obj/item/storage/xeno_tag_case/full,
	)
	cost = 60
	containertype = /obj/structure/closet/crate/secure/weyland
	containername = "IFF tag crate"
	group = "Research"
