/// Subsystem for controlling anything related to the escape menu
PROCESSING_SUBSYSTEM_DEF(escape_menu)
	name = "退出菜单"
	flags = SS_NO_INIT
	runlevels = ALL
	wait = 2 SECONDS
