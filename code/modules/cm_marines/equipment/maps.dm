/obj/item/map
	name = "map"
	icon = 'icons/obj/items/marine-items.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_righthand.dmi'
	)
	icon_state = "map"
	item_state = "map"
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_TINY
	// color = ... (Colors can be names - "red, green, grey, cyan" or a HEX color code "#FF0000")
	var/dat // Page content
	var/html_link = ""

/obj/item/map/attack_self(mob/user) //Open the map
	..()
	user.visible_message(SPAN_NOTICE("[user]打开了[src.name]。"))
	initialize_map()

/obj/item/map/attack()
	return

/obj/item/map/proc/initialize_map()
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl)
		dat = {"
				<!DOCTYPE html>
				<html>
				<head>
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta charset="utf-8">
					<style>
						img {
							display: none;
							position: absolute;
							top: 30;
							left: 0;
							max-width: 100%;
							height: auto;
							overflow: hidden;
							border: 0;
						}
					</style>
				</head>
				<body>
				<script type="text/javascript">
					function pageloaded(obj) {
						document.getElementById("loading").style.display = "none";
						obj.style.display = "inline";
					}
				</script>
				<p id='loading'>You start unfolding the map...</p>
					<img onload="pageloaded(this)" src="[wikiurl]/[html_link]?printable=yes&remove_links=1" id="main_frame" alt=""></img>
				</body>

				</html>
			"}
	show_browser(usr, dat, name, "papermap", width = 1280, height = 720)

/obj/item/map/lazarus_landing_map
	name = "\improper Lazarus Landing Map"
	desc = "LV-624上拉撒路着陆殖民地的卫星打印图。"
	html_link = "images/6/6f/LV624.png"

/obj/item/map/ice_colony_map
	name = "\improper Ice Colony map"
	desc = "冰雪殖民地的卫星打印图。"
	html_link = "images/1/18/Map_icecolony.png"
	color = "cyan"

/obj/item/map/ice_colony_map_v3
	name = "\improper Shivas Snowball map"
	desc = "UA殖民地湿婆雪球的前部扫描标注打印图。"
	html_link = "images/1/18/Map_icecolony.png"
	color = "cyan"

/obj/item/map/whiskey_outpost_map
	name = "\improper Whiskey Outpost map"
	desc = "威士忌前哨防御阵地和位置的战术打印图。"
	html_link = "images/7/78/Whiskey_outpost.png"
	color = "grey"

/obj/item/map/big_red_map
	name = "\improper Solaris Ridge Map"
	desc = "索拉里斯山脊设施的审查版蓝图。"
	html_link = "images/9/9e/Solaris_Ridge.png"
	color = "#e88a10"

/obj/item/map/FOP_map
	name = "\improper Fiorina Orbital Penitentiary Map"
	desc = "菲奥里纳轨道监狱的内部扫描标注图。"
	html_link = "images/4/4c/Map_Prison.png"
	color = "#e88a10"

/obj/item/map/FOP_map_v3
	name = "\improper Fiorina Orbital Civilian Annex Map"
	desc = "阿尔迈耶号传感器阵列对菲奥里纳轨道监狱民用附属设施的扫描图。它似乎已与空间站主体分离，目前正围绕行星进行自由地球同步轨道运行。"
	html_link = "images/e/e0/Prison_Station_Science_Annex.png"
	color = "#e88a10"

/obj/item/map/desert_dam
	name = "\improper Trijent Dam map"
	desc = "特里金特大坝殖民地的轨道扫描打印图。"
	html_link = "images/9/92/Trijent_Dam.png"
	color = "#ad8d0e"

/obj/item/map/sorokyne_map
	name = "\improper Sorokyne Strata map"
	desc = "维兰德-汤谷殖民地索罗金前哨的地图，通常称为索罗金地层。"
	html_link = "images/2/21/Sorokyne_Wiki_Map.jpg" //The fact that this is just a wiki-link makes me sad and amused.
	color = "cyan"

/obj/item/map/corsat
	name = "\improper CORSAT map"
	desc = "CORSAT空间站的蓝图。"
	html_link = "images/8/8e/CORSAT_Satellite.png"
	color = "red"

/obj/item/map/kutjevo_map
	name = "\improper Kutjevo Refinery map"
	desc = "库特耶沃精炼厂的轨道扫描图。"
	html_link = "images/0/0d/Kutjevo_a1.jpg"
	color = "red"

/obj/item/map/lv522_map
	name = "\improper LV-522 Map"
	desc = "LV-522的示意图总览。"
	html_link = "images/b/bb/C_claim.png"
	color = "cyan"

/obj/item/map/lv759_map
	name = "\improper LV-759 Map"
	desc = "LV-759的示意图总览。"
	html_link = "images/6/60/LV759_Hybrisa_Prospera.png" //needs proper image still.
	color = "#005eab"

/obj/item/map/new_varadero
	name = "\improper New Varadero map"
	desc = "标注有UA前哨新瓦拉德罗的蓝图。"
	html_link = "images/9/94/New_Varadero.png"
	color = "red"

GLOBAL_LIST_INIT_TYPED(map_type_list, /obj/item/map, setup_all_maps())

/proc/setup_all_maps()
	return list(
		MAP_LV_624 = new /obj/item/map/lazarus_landing_map(),
		MAP_ICE_COLONY = new /obj/item/map/ice_colony_map(),
		MAP_ICE_COLONY_V3 = new /obj/item/map/ice_colony_map_v3(),
		MAP_WHISKEY_OUTPOST = new /obj/item/map/whiskey_outpost_map(),
		MAP_BIG_RED = new /obj/item/map/big_red_map(),
		MAP_PRISON_STATION = new /obj/item/map/FOP_map(),
		MAP_PRISON_STATION_V3 = new /obj/item/map/FOP_map_v3(),
		MAP_DESERT_DAM = new /obj/item/map/desert_dam(),
		MAP_SOROKYNE_STRATA = new /obj/item/map/sorokyne_map(),
		MAP_CORSAT = new /obj/item/map/corsat(),
		MAP_KUTJEVO = new /obj/item/map/kutjevo_map(),
		MAP_LV522_CHANCES_CLAIM = new /obj/item/map/lv522_map(),
		MAP_LV759_HYBRISA_PROSPERA = new /obj/item/map/lv759_map(),
		MAP_NEW_VARADERO = new /obj/item/map/new_varadero()
	)

//used by marine equipment machines to spawn the correct map.
/obj/item/map/current_map

/obj/item/map/current_map/Initialize(mapload, ...)
	. = ..()

	var/map_name = SSmapping.configs[GROUND_MAP].map_name
	var/obj/item/map/map = GLOB.map_type_list[map_name]
	if (!map && (map_name == MAP_RUNTIME || map_name == MAP_CHINOOK || map_name == MAIN_SHIP_DEFAULT_NAME || map_name == MAP_ROSTOCK))
		return // "Maps" we don't have maps for so we don't need to throw a runtime for (namely in unit_testing)
	name = map.name
	desc = map.desc
	html_link = map.html_link
	color = map.color

// Landmark - Used for mapping. Will spawn the appropriate map for each gamemode (LV map items will spawn when LV is the gamemode, etc)
/obj/effect/landmark/map_item
	name = "地图物品"
	icon_state = "ipool"

/obj/effect/landmark/map_item/Initialize(mapload, ...)
	. = ..()
	GLOB.map_items += src

/obj/effect/landmark/map_item/Destroy()
	GLOB.map_items -= src
	return ..()
