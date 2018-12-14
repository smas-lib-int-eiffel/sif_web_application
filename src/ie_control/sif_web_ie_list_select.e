note
	description: "Summary description for {SIF_WEB_IE_LIST_SINGLE_SELECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_WEB_IE_LIST_SELECT

inherit
	SIF_IE_CONTROL_WEB

create
	make

feature -- Interaction for the web

	do_put_interaction_element_web
			-- <Precursor>
		do
			if attached {SIF_IE_LIST_SINGLE_SELECT} interaction_element as l_interaction_element then
				l_interaction_element.event_list.subscribe (agent handle_event_list_output)
				l_interaction_element.event_get_selection.subscribe (agent handle_event_get_selection)
--				l_interaction_element.event_label.subscribe (agent handle_event_output)
			end
		end

feature -- Status

	expanded_type_serializer: JSON_SERIALIZER
			-- Result contains the json serializer for the web control
		do
			create {SIF_JSON_SERIALIZER_IE_CONTROL_WEB_LIST_SELECT}Result
		end

	type_expanded: TYPE [detachable ANY]
			-- Result contains the type to be used for the json conversion of the web control
		do
			Result := {SIF_IE_CONTROL_LIST_EXPANDED}
		end

feature -- JSON conversion

	json_expanded: SIF_IE_CONTROL_EXPANDED
			-- Result is a SIF_IE_CONTROL_EXPANDED instance for JSON message creation.
			-- The result is to be used in the JSON serializers, which are specific to serialize each ie_web_control in JSON.
		local
			l_result: SIF_IE_CONTROL_LIST_EXPANDED
		do
			create l_result.make (type_interaction_element, events)
			if attached {SIF_IE_LIST_SINGLE_SELECT}interaction_element as l_ie_list then
				l_result.set_list (l_ie_list.list)
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	do_reset_events
			-- reset events
		do
			events.force (false, "event_list")
			events.force (false, "event_input_selection")
			events.force (false, "event_get_selection")
		end


	handle_event_output(a_text: STRING_32)
		do
			events.replace (true, "event_output")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	handle_event_list_output(a_source_list: ARRAY[ARRAY[STRING]])
		do
			events.replace (true, "event_list")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	handle_event_get_selection
		do
			events.replace (true, "event_get_selection")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	-- Handel incoming message	
    do_handle_interaction(a_ie_control_expanded: SIF_IE_CONTROL_EXPANDED)
    		-- <Precursor>
    	local
    		l_selection: INTEGER
    	do
    		if attached {SIF_IE_CONTROL_LIST_EXPANDED}a_ie_control_expanded as l_ie_control_list_expanded then
				if attached l_ie_control_list_expanded.events.item ("event_input_selection")  as l_event_input_list and then
				    l_event_input_list.item and then
				   attached l_ie_control_list_expanded.selections as l_selection_list then

					-- publish integer array's 1st item for single select
				   	if attached {SIF_IE_LIST_SINGLE_SELECT} interaction_element as l_interaction_element and then
					   l_selection_list.count = 1 then
						l_selection := l_selection_list.at (0)
						l_interaction_element.event_input_selection.publish (l_selection)

					end
				end
    		end

    	end

end
