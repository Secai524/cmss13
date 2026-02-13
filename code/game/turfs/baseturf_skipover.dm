// This is a typepath to just sit in baseturfs and act as a marker for other things.
/turf/baseturf_skipover
	name = "基础地形跳过占位符"
	desc = "这不应该存在。"

/turf/baseturf_skipover/Initialize()
	. = ..()
	stack_trace("[src]([type]) was instanced which should never happen. Changing into the next baseturf down...")
	ScrapeAway()

/turf/baseturf_skipover/shuttle
	name = "穿梭机基础地形跳过"
	desc = "作为穿梭机的底部，如果这里没有，穿梭机地板就会被击穿。"

/turf/baseturf_bottom
	name = "Z层级基础地形占位符"
	desc = "Z层级基础地形的标记，通常解析为太空。"
	baseturfs = /turf/baseturf_bottom
