GLOBAL_REFERENCE_LIST_INDEXED(adminreplies, /datum/autoreply/admin, title)
GLOBAL_REFERENCE_LIST_INDEXED(mentorreplies, /datum/autoreply/mentor, title)

/datum/autoreply
	/// What shows up in the list of replies, and the big red header on the reply itself.
	var/title = "空白"
	/// The detailed message in the auto reply.
	var/message = "Lorem ipsum dolor sit amit."
	/// If the autoreply will automatically close the ahelp or not.
	var/closer = TRUE

/// Admin Replies
/datum/autoreply/admin/handled
	title = "处理中"
	message = "管理员已获悉此问题，正在处理中"
	closer = FALSE

/datum/autoreply/admin/icissue
	title = "角色内问题"
	message = "管理员已判定你的问题属于角色内问题，目前<strong>不</strong>需要管理员介入。请通过角色内途径寻求进一步解决方案。"

/datum/autoreply/admin/bug
	title = "漏洞报告"

ON_CONFIG_LOAD(/datum/autoreply/admin/bug)
	message = "请在我们的<a href='[CONFIG_GET(string/githuburl)]'>Github</a>上报告所有漏洞。管理员通常无法在单局游戏内修复大多数漏洞，只有对当前回合至关重要的漏洞或利用行为才应通过管理员求助报告。"

/datum/autoreply/admin/marine
	title = "陆战队员指南"

ON_CONFIG_LOAD(/datum/autoreply/admin/marine)
	message = "你的问题可通过<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_MARINE_QUICKSTART]'>陆战队员快速入门指南</a>解答。如有任何不清楚之处或其他问题，请重新发起导师求助或管理员求助。"

/datum/autoreply/admin/xeno
	title = "异形指南"

ON_CONFIG_LOAD(/datum/autoreply/admin/xeno)
	message = "你的问题可通过<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_XENO_QUICKSTART]'>异形快速入门指南</a>解答。如有任何不清楚之处或其他问题，请重新发起导师求助或管理员求助。"

/datum/autoreply/admin/changelog
	title = "更新日志"
	message = "你的问题答案可在更新日志中找到。点击屏幕右上角的更新日志按钮在游戏中查看，或前往CM-SS13 Discord服务器，在cm-changelog频道查找所有已合并服务器更新的链接。"

/datum/autoreply/admin/intended
	title = "预期功能"
	message = "此为预期功能，因此无需管理员介入。"

/datum/autoreply/admin/event
	title = "事件"
	message = "当前正在进行特殊事件，许多内容可能已更改或有所不同，但除非管理员特别指示，否则常规规则依然适用。"

/datum/autoreply/admin/whitelist
	title = "白名单问题"

ON_CONFIG_LOAD(/datum/autoreply/admin/whitelist)
	message = "管理员无法在游戏中处理大多数白名单违规行为，请在论坛上提交玩家报告，<a href='[CONFIG_GET(string/playerreport)]'>点击此处</a>。"

/datum/autoreply/admin/clear_cache
	title = "清除缓存"
	message = "要清除缓存，你需要点击BYOND客户端右上角的齿轮图标并选择偏好设置。切换到游戏选项卡，点击清除缓存按钮。某些情况下需要手动删除缓存。为此，选择高级选项卡，点击打开用户目录并删除\"cache\" folder there."
	closer = FALSE

/datum/autoreply/admin/lobby
	title = "冷冻与返回大厅"
	message = "管理员已批准你返回大厅的请求。为此，你必须进入冷冻舱并进入观察者模式。随后管理员会手动将你送回大厅。"
	closer = FALSE
////////////////////////////
/////   MENTOR HELPS   /////
////////////////////////////

/datum/autoreply/mentor/staff_issue
	title = "A：管理员问题"
	message = "这不是导师能处理的问题，请通过管理员求助联系管理员团队。"

/datum/autoreply/mentor/whitelist
	title = "L：白名单问题"

ON_CONFIG_LOAD(/datum/autoreply/mentor/whitelist)
	message = "这不是导师能处理的问题，请通过管理员求助联系管理员团队。管理员无法在游戏中处理大多数白名单违规行为，你很可能会被要求在论坛上提交玩家报告，<a href='[CONFIG_GET(string/playerreport)]'>点击此处</a>。"

/datum/autoreply/mentor/event
	title = "A：事件进行中"
	message = "当前正在进行特殊事件，许多内容可能已更改或有所不同，但除非管理员特别指示，否则常规规则依然适用。"

/datum/autoreply/mentor/changelog
	title = "C：更新日志"
	message = "你的问题答案可在更新日志中找到。点击屏幕右上角的更新日志按钮在游戏中查看，或前往CM-SS13 Discord服务器，在cm-changelog频道查找所有已合并服务器更新的链接。"

/datum/autoreply/mentor/join_server
	title = "C：加入服务器"
	message = "由于管理员操作或回合结束时的自动设置，当前回合已禁止新玩家加入。你可以在回合结束时进行观察，并等待新回合开始。"

/datum/autoreply/mentor/leave_server
	title = "C：离开服务器"
	message = "如果你需要以陆战队员身份离开服务器，请在离开前进入冷冻舱或让他人将你冷冻。如果你是异形，请在离开前找到安全地点休息并进入观察者模式，这将立即解锁你的异形供观察者加入。"

/datum/autoreply/mentor/clear_cache
	title = "C：清除缓存"
	message = "要清除缓存，你需要点击BYOND客户端右上角的齿轮图标并选择偏好设置。切换到游戏选项卡，点击清除缓存按钮。某些情况下需要手动删除缓存。为此，选择高级选项卡，点击打开用户目录并删除\"cache\" folder there."

/datum/autoreply/mentor/click_drag
	title = "C：战斗点击拖动覆盖"
	message = "When clicking while moving the mouse, Byond sometimes detects it as a click-and-drag attempt and prevents the click from taking effect, even if the button was only held down for an instant.\
This toggle means that when you're on disarm or harm intent, depressing the mouse triggers a click immediately even if you hold it down - unless you're trying to click-drag yourself, an ally, or something in your own inventory."

/datum/autoreply/mentor/discord
	title = "L：Discord"

ON_CONFIG_LOAD(/datum/autoreply/mentor/discord)
	message = "你可以使用<a href='[CONFIG_GET(string/discordurl)]'>此链接</a>加入我们的Discord服务器！"

/datum/autoreply/mentor/bug
	title = "L：错误报告"

ON_CONFIG_LOAD(/datum/autoreply/mentor/bug)
	message = "请在我们的<a href='[CONFIG_GET(string/githuburl)]'>Github</a>上报告所有漏洞。管理员通常无法在单局游戏内修复大多数漏洞，只有对当前回合至关重要的漏洞或利用行为才应通过管理员求助报告。"

/datum/autoreply/mentor/currentmap
	title = "L：当前地图"

ON_CONFIG_LOAD(/datum/autoreply/mentor/currentmap)
	message = "如果你需要当前回合的地图概览，请使用OOC选项卡中的“当前地图”动词来查看地图名称。然后打开我们的<a href='[CONFIG_GET(string/wikiurl)]'>维基首页</a>，在“地图”部分查找地图概览。如果地图未列出，说明它是新地图或稀有地图，概览尚未完成。"

/datum/autoreply/mentor/marine
	title = "L：陆战队员指南"

ON_CONFIG_LOAD(/datum/autoreply/mentor/marine)
	message = "你的问题可通过<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_MARINE_QUICKSTART]'>陆战队员快速入门指南</a>解答。如有任何不清楚之处或其他问题，请重新发起导师求助或管理员求助。"

/datum/autoreply/mentor/xeno
	title = "L：异形指南"

ON_CONFIG_LOAD(/datum/autoreply/mentor/xeno)
	message = "你的问题可通过<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_XENO_QUICKSTART]'>异形快速入门指南</a>解答。如有任何不清楚之处或其他问题，请重新发起导师求助或管理员求助。"

/datum/autoreply/mentor/macros
	title = "L：宏指令"

ON_CONFIG_LOAD(/datum/autoreply/mentor/macros)
	message = "这份<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_MACROS]'>指南</a>解释了如何设置宏指令，并包含了最常见和最有用的示例。"

/datum/autoreply/mentor/synthkey
	title = "H：合成人重置密钥"
	message = "合成人无法用普通除颤器重启，而是需要一种名为合成人重置密钥的特殊物品。它的功能与除颤器相同，但仅适用于合成人。任何受过工程训练的人员均可使用，并可从各班组角色供应商处获取。大多数合成人会随身携带一个。"

/datum/autoreply/mentor/radio
	title = "H: Radio"
	message = "Take your headset in hand and activate it by clicking it or pressing \"Page Down\" or \"Z\" (in Hotkey Mode). This will open window with all available channels, which also contains channel keys. Marine headsets have their respective squad channels available on \";\" key. Ship crew headsets have access to the Almayer public comms on \";\" and their respective department channel on \":h\"."

/datum/autoreply/mentor/binos
	title = "H: Binoculars"
	message = "Binoculars allow you to increase distance of your view in direction you are looking. To zoom in, take them into your hand and activate them by pressing \"Page Down\" or \"Z\" (in Hotkey Mode) or clicking them while they are in your hand.\
Rangefinders allow you to get tile coordinates (longitude and latitude) by lasing it while zoomed in (produces a GREEN laser). Ctrl + Click on any open tile to start lasing. Ctrl + Click on your rangefinders to stop lasing without zooming out. Coordinates can be used by Staff Officers to send supply drops or to perform Orbital Bombardment. You also can use them to call mortar fire if there are engineers with a mortar. \
Laser Designators have a second mode (produces a RED laser) that allows highlighting targets for Close Air Support performed by dropship pilots. They also have a fixed ID number that is shown on the pilot's weaponry console. Examine the laser designator to check its ID. Red laser must be maintained as long as needed in order for the dropship pilot to bomb the designated area. To switch between lasing modes, Alt + Click the laser designator. Alternatively, Right + Click it in hand and click \"Toggle Mode\"."

/datum/autoreply/mentor/haul
	title = "X：作为异形拖拽"
	message = "拖拽对于快速将失去行动能力的宿主从一个地方运送到另一个地方非常有用。要作为异形拖拽宿主，抓住目标（CTRL+点击），然后点击自己开始拖拽。宿主可能会挣脱你的抓握，这会导致你死亡，因此请确保你的目标已失去行动能力。大约1分钟后，宿主会自动被释放。要主动释放目标，点击HUD上的‘释放’将其抛出。"

/datum/autoreply/mentor/plasma
	title = "X：无等离子体恢复"
	message = "如果你的等离子体恢复速度很低或没有恢复，很可能是因为你离开了菌毯，或者正在使用被动能力，例如奔跑者的‘隐藏’或正在释放信息素。"

/datum/autoreply/mentor/tunnel
	title = "X：地道"
	message = "点击地道进入。在地道内时，Alt + 点击地道出口，Ctrl + 点击选择目的地。"
