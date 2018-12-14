note
	description: "Summary description for {SIF_JSON_SERIALIZER_IE_CONTROL_WEB_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_JSON_SERIALIZER_IE_CONTROL_WEB_EVENT

inherit
	SIF_JSON_SERIALIZER_IE_CONTROL_WEB

feature {NONE} -- Conversion

	to_json_extended (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT)
		local
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
			l_json_object: detachable JSON_OBJECT
			i: INTEGER
		do
			if attached {SIF_IE_CONTROL_EVENT_EXPANDED} obj as ie_control_simple_event and then
			   attached ie_control_simple_event.events.item ("event") as l_event and then
			   attached ie_control_simple_event.events.item ("event_add_submit") as l_event_add_submit and then
			   attached ie_control_simple_event.events.item ("event_output_select") as l_event_output_select and then
			   attached ie_control_simple_event.events.item ("event_output_deselect") as l_event_output_deselect and then
			   attached ie_control_simple_event.events.item ("event_label") as l_event_label then

					-- "event"
				if l_event.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event.item, "published")
					j_object.put(l_json_object,"event")
				end
					-- "event_add_submit"
				if l_event_add_submit.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event_add_submit.item, "published")
					j_object.put(l_json_object,"event_add_submit")
				end
					-- "event output select"
				if l_event_output_select.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event_output_select.item, "published")
					j_object.put (l_json_object, "event_output_select")
				end
					-- "event output deselect"
				if l_event_output_deselect then
					create l_json_object.make
					l_json_object.put_boolean (l_event_output_deselect.item, "published")
					j_object.put (l_json_object, "event_output_deselect")
				end
					-- "event label"
				if l_event_label and then
				  attached ie_control_simple_event.label as l_label then
					create l_json_object.make
					l_json_object.put_boolean (l_event_label.item, "published")
					l_json_object.put_string(l_label, "text")
					j_object.put (l_json_object, "event_label")
				end

			end
		end

end
