note
	description: "Summary description for {SIF_JSON_SERIALIZER_IE_CONTROL_WEB_TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_JSON_SERIALIZER_IE_CONTROL_WEB_TEXT


inherit
	SHARED_HTML_ENCODER
		undefine
			default_create
		end

	SIF_JSON_SERIALIZER_IE_CONTROL_WEB


feature {NONE} -- Conversion

	to_json_extended (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT)
		local
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
			l_json_object: detachable JSON_OBJECT
			i: INTEGER
		do
			if attached {SIF_IE_CONTROL_TEXT_EXPANDED} obj as ie_control_expended_text and then
			   attached ie_control_expended_text.events.item ("event_output") as l_event_output and then
			   attached ie_control_expended_text.text as l_text then
					-- "event_output"
				if l_event_output.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event_output.item, "published")
					l_json_object.put_string(html_encoder.encoded_string (l_text), "text")
					j_object.put (l_json_object, "event_output")
				end
			end
		end

end
