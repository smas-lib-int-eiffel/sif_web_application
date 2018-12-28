note
	description: "Summary description for {SIF_JSON_SERIALIZER_IE_CONTROL_WEB_LIST_SINGLE_SELECT}."
	author: "Crystl Haung"
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_JSON_SERIALIZER_IE_CONTROL_WEB_LIST_SELECT

inherit
	SHARED_HTML_ENCODER
		undefine
			default_create
		end

	SIF_JSON_SERIALIZER_IE_CONTROL_WEB

feature {NONE} -- Conversion

	to_json_extended (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT)
		local
			l_json_object: detachable JSON_OBJECT
		do
			if attached {SIF_IE_CONTROL_LIST_EXPANDED} obj as ie_control_expended_list and then
			   attached ie_control_expended_list.events.item ("event_list") as l_event_list and then
			   attached ie_control_expended_list.list as l_list then
				if l_event_list.item then
					ie_control_expended_list.set_published (true)
					l_json_object := (create {SIF_JSON_FROM_EIFFEL_CONVERTER}).eiffel_to_json (obj)

					j_object.put (l_json_object, "event_list")
				end
			end

			if attached {SIF_IE_CONTROL_LIST_EXPANDED} obj as ie_control_expended_list and then
			   attached ie_control_expended_list.events.item ("event_get_selection") as l_event_get_selection then
				if l_event_get_selection then
					ie_control_expended_list.set_published (true)
					ie_control_expended_list.set_list(void)
					l_json_object := (create {SIF_JSON_FROM_EIFFEL_CONVERTER}).eiffel_to_json (obj)

					j_object.put (l_json_object, "event_get_selection")
				end
			end
		end
end
