// Weather events for Sorokyne

/datum/weather_event/soro/very_light_rain
	name = "索罗小雨"

	display_name = "小雨"

	length = 3 MINUTES

	lightning_chance = 4

	fire_smothering_strength = 1

	turf_overlay_icon_state = "strata_storm"
	turf_overlay_alpha = 25

	effect_message = null
	damage_per_tick = 0

	ambience = 'sound/ambience/rainandthunderlong.ogg'

/datum/weather_event/soro/light_rain
	name = "热带风暴"
	display_name = "热带风暴"
	length = 3 MINUTES
	fullscreen_type = /atom/movable/screen/fullscreen/weather/low

	turf_overlay_icon_state = "strata_storm"
	turf_overlay_alpha = 40

	effect_message = null
	damage_per_tick = 0

	has_process = TRUE
	lightning_chance = 1

	ambience = 'sound/ambience/rainforest.ogg'

	fire_smothering_strength = 1

/datum/weather_event/soro/monsoon
	name = "季风警报"
	display_name = "季风警报"

	should_sound_weather_alarm = TRUE

	length = 4 MINUTES
	fullscreen_type = /atom/movable/screen/fullscreen/weather/high

	turf_overlay_icon_state = "strata_storm"
	turf_overlay_alpha = 115

	effect_message = null
	damage_per_tick = 0

	ambience = 'sound/ambience/varadero_storm.ogg'

	has_process = TRUE
	lightning_chance = 6

	fire_smothering_strength = 4
