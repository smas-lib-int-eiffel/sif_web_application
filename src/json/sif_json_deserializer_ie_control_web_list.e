note
	description: "Summary description for {SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_LIST}."
	author: "Crystal Huang"
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_LIST

inherit
	SIF_JSON_DESERIALIZER_IE_CONTROL_WEB

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable SIF_IE_CONTROL_LIST_EXPANDED
		local
			l_events: like {SIF_IE_CONTROL_LIST_EXPANDED}.events
--			l_selection_array: like {SIF_IE_CONTROL_LIST_EXPANDED}.selections
			l_selection_array: ARRAY[INTEGER]
			i, l_item: INTEGER

--			l_converter: JSON_TO_EIFFEL_CONVERTER
		do
			if attached {JSON_OBJECT} a_json as j_sif_ie_control_event_expanded then
				create l_events.make (0)
				create Result.make ("sif_ie_list", l_events)

				base_from_json (j_sif_ie_control_event_expanded, ctx, Result)

				if attached {JSON_OBJECT} j_sif_ie_control_event_expanded.item ("event_input_selection") as j_event_input_selection and then
				   attached {JSON_BOOLEAN} j_event_input_selection.item ("published") as j_published and then
				   j_published.item and then
				   attached {JSON_ARRAY} j_event_input_selection.item ("selections") as j_list then

				   	create l_selection_array.make_empty
--				   	from
--				   		i:= 0
--				   	until
--				   		i <= j_list.count
--				   	loop
--						if attached {JSON_NUMBER} j_list[i] as la_number then
--							if la_number.is_integer then
--								l_selection_array.force (la_number.item.to_integer, i)
--							end
--						end

--				   		i:= i + 1
--				   	end

					across j_list as la_list
					loop
						if attached {JSON_NUMBER} la_list.item as la_number then
							l_selection_array.force (la_number.item.to_integer, i)
						end
					end

					Result.set_published (true)
				   	Result.set_selections(l_selection_array)
				   	l_events.force (true, "event_input_selection")
				end

--				create l_converter.do_convert(a_json)
--			
--				if attached {SIF_IE_CONTROL_LIST_EXPANDED} l_converter.converted_object then
--					Result := l_converter.converted_object
--				end

			end

		end

end
