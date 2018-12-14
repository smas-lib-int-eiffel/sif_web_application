note
	description: "Summary description for {SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_TEXT

inherit
	SIF_JSON_DESERIALIZER_IE_CONTROL_WEB

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable SIF_IE_CONTROL_TEXT_EXPANDED
		local
			l_events: like {SIF_IE_CONTROL_TEXT_EXPANDED}.events
--			l_text: like {SIF_IE_CONTROL_TEXT_EXPANDED}.text
		do
			if attached {JSON_OBJECT} a_json as j_sif_ie_control_event_expanded then
				create l_events.make (0)
				create Result.make ("sif_ie_text", l_events)
				base_from_json (j_sif_ie_control_event_expanded, ctx, Result)
				if attached {JSON_OBJECT} j_sif_ie_control_event_expanded.item ("event_input") as j_event_input and then
				   attached {JSON_BOOLEAN} j_event_input.item ("published") as j_published and then
				   j_published.item and then
				   attached {JSON_STRING} j_event_input.item ("text") as j_text then
--					l_text := j_text.item
				   	Result.put_text(j_text.item)
				   	l_events.force (true, "event_input")
				end
			end
		end

end
