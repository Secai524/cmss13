/datum/weather_event/light_rain
	name = "小雨"
	display_name = "小雨"
	length = 8 MINUTES
	fullscreen_type = /atom/movable/screen/fullscreen/weather/low

	turf_overlay_icon_state = "strata_storm"
	turf_overlay_alpha = 50

	effect_message = null
	damage_per_tick = 0

	ambience = 'sound/ambience/rainforest.ogg'

	fire_smothering_strength = 1

/datum/weather_event/heavy_rain
	name = "大雨"
	display_name = "大雨"
	length = 12 MINUTES
	fullscreen_type = /atom/movable/screen/fullscreen/weather/medium

	turf_overlay_icon_state = "strata_storm"
	turf_overlay_alpha = 125

	effect_message = null
	damage_per_tick = 0

	ambience = 'sound/ambience/rainforest.ogg'

	has_process = TRUE
	lightning_chance = 2

	fire_smothering_strength = 4
