
/datum/entity/twitch_link
	var/ckey
	var/access_code
	var/twitch_id

/datum/entity_meta/twitch_link
	entity_type = /datum/entity/twitch_link
	table_name = "twitch_link"
	field_types = list(
		"ckey" = DB_FIELDTYPE_STRING_LARGE,
		"access_code" = DB_FIELDTYPE_STRING_MEDIUM,
		"twitch_id" = DB_FIELDTYPE_STRING_LARGE,
	)

/datum/view_record/twitch_link
	var/ckey
	var/access_code
	var/twitch_id
	var/id

/datum/entity_view_meta/twitch_link
	root_record_type = /datum/entity/twitch_link
	destination_entity = /datum/view_record/twitch_link

	fields = list(
		"ckey",
		"access_code",
		"twitch_id",
		"id",
	)

/datum/config_entry/string/twitch_link_url
	protection = CONFIG_ENTRY_LOCKED

CLIENT_VERB(link_twitch)
	set name = "Twitch Link"
	set category = "OOC"

	var/url = CONFIG_GET(string/twitch_link_url)
	if(!url)
		to_chat(src, SPAN_WARNING("此服务器未启用Twitch关联功能。"))
		return

	if(IsGuestKey(key, TRUE))
		to_chat(src, SPAN_WARNING("你必须以BYOND密钥连接才能关联Twitch。"))
		return

	if(length(DB_VIEW(/datum/view_record/twitch_link,
		DB_AND(
			DB_COMP("ckey", DB_EQUALS, ckey),
			DB_COMP("twitch_id", DB_IS)
		))
	))
		to_chat(src, SPAN_WARNING("你已将此CKEY关联至Twitch。请联系支持人员解除关联。"))
		return

	var/datum/view_record/twitch_link/existing_link = locate() in DB_VIEW(
		DB_COMP("ckey", DB_EQUALS, ckey)
	)

	if(existing_link)
		to_chat(src, SPAN_LARGE(SPAN_NOTICE("Please click <a href='[url]?code=[existing_link.access_code]'>here</a> to link your CKEY to Twitch.")))
		return

	var/datum/entity/twitch_link/new_link = DB_ENTITY(/datum/entity/twitch_link)
	new_link.access_code = generate_access_code()
	new_link.ckey = ckey

	new_link.save()
	new_link.detach()

	to_chat(src, SPAN_LARGE(SPAN_NOTICE("Please click <a href='[url]?code=[new_link.access_code]'>here</a> to link your CKEY to Twitch.")))
