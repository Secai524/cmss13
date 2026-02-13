/obj/effect/landmark/objective_landmark
	name = "目标地标"
	icon_state = "intel"
	var/document_holder_present = FALSE

/obj/effect/landmark/objective_landmark/Initialize(mapload, ...)
	. = ..()
	if(!mapload)
		return INITIALIZE_HINT_QDEL
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/objective_landmark/LateInitialize()
	for(var/obj/structure/filingcabinet/fc in loc)
		document_holder_present = TRUE
		break

/obj/effect/landmark/objective_landmark/close
	name = "目标地标 - 近"
	icon_state = "intel_close"
/obj/effect/landmark/objective_landmark/close/Initialize(mapload, ...)
	. = ..()
	GLOB.objective_landmarks_close[src] = document_holder_present
/obj/effect/landmark/objective_landmark/close/Destroy(force = FALSE)
	GLOB.objective_landmarks_close.Remove(src)
	return ..()

/obj/effect/landmark/objective_landmark/medium
	name = "目标地标 - 中"
	icon_state = "intel_medium"
/obj/effect/landmark/objective_landmark/medium/Initialize(mapload, ...)
	. = ..()
	GLOB.objective_landmarks_medium[src] = document_holder_present
/obj/effect/landmark/objective_landmark/medium/Destroy(force = FALSE)
	GLOB.objective_landmarks_medium.Remove(src)
	return ..()

/obj/effect/landmark/objective_landmark/far
	name = "目标地标 - 远"
	icon_state = "intel_far"
/obj/effect/landmark/objective_landmark/far/Initialize(mapload, ...)
	. = ..()
	GLOB.objective_landmarks_far[src] = document_holder_present
/obj/effect/landmark/objective_landmark/far/Destroy(force = FALSE)
	GLOB.objective_landmarks_far.Remove(src)
	return ..()

/obj/effect/landmark/objective_landmark/science
	name = "目标地标 - 科研"
	icon_state = "intel_sci"
/obj/effect/landmark/objective_landmark/science/Initialize(mapload, ...)
	. = ..()
	GLOB.objective_landmarks_science[src] = document_holder_present
/obj/effect/landmark/objective_landmark/science/Destroy(force = FALSE)
	GLOB.objective_landmarks_science.Remove(src)
	return ..()
