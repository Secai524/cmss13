CLIENT_VERB(edit_characters)
	set category = "Preferences"
	set name = "Edit Characters"
	set desc = "Edit your characters in your preferences."

	to_chat(usr, SPAN_WARNING("请注意，更改可能需在重生后生效。"))
	prefs.ShowChoices(mob)
