note
	description: "Summary description for {SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_EVENT

inherit
	SIF_JSON_DESERIALIZER_IE_CONTROL_WEB

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable SIF_IE_CONTROL_EVENT_EXPANDED
		local
			l_events: like {SIF_IE_CONTROL_EVENT_EXPANDED}.events
			l_string_table: STRING_TABLE[STRING]
			l_key: STRING
			i: INTEGER
		do
			if attached {JSON_OBJECT} a_json as j_sif_ie_control_event_expanded then
				create l_events.make (0)
				create Result.make ("sif_ie_event", l_events)
				base_from_json (j_sif_ie_control_event_expanded, ctx, Result)

				if attached {JSON_OBJECT} j_sif_ie_control_event_expanded.item ("event") as j_event and then
				   attached {JSON_BOOLEAN} j_event.item ("published") as j_published and then
				   j_published.item then
				   	l_events.force (true, "event")
				end
				if attached {JSON_OBJECT} j_sif_ie_control_event_expanded.item ("event_submit") as j_event_submit and then
				   attached {JSON_OBJECT} j_event_submit.item ("submit_list") as j_submit_list and then
				   not j_submit_list.is_empty and then
				   attached {JSON_BOOLEAN} j_event_submit.item ("published") as j_published and then
				   j_published.item then
				   	create l_string_table.make(j_submit_list.count)
				   	l_events.force (true, "event_submit")

				   	--Convet JSON to STRING_TABLE--------------
				   	from
				   		i := 1
				   	until
				   		i > j_submit_list.count
				   	loop
				   		l_key := j_submit_list.current_keys[i].item
				   		if attached {JSON_STRING} j_submit_list.item (l_key) as la_value then
				   			l_string_table.put (la_value.item, l_key)
				   		end
				   		i := i + 1
				   	end
					-------------------------------------------
				   	Result.put_submit_list(l_string_table)
				end
			end
		end

end
