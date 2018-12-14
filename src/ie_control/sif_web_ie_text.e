note
	description: "Summary description for {SIF_WEB_IE_TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_WEB_IE_TEXT

inherit
	SIF_IE_CONTROL_WEB

create
	make

feature -- Interaction for the web

	do_put_interaction_element_web
			-- <Precursor>
		do
			if attached {SIF_IE_TEXT} interaction_element as l_interaction_element then
				l_interaction_element.event_output.subscribe (agent handle_event_output)
			end
		end

feature -- Status

	expanded_type_serializer: JSON_SERIALIZER
			-- Result contains the json serializer for the web control
		do
			create {SIF_JSON_SERIALIZER_IE_CONTROL_WEB_TEXT}Result
		end

	type_expanded: TYPE [detachable ANY]
			-- Result contains the type to be used for the json conversion of the web control
		do
			Result := {SIF_IE_CONTROL_TEXT_EXPANDED}
		end

feature -- JSON conversion

	json_expanded: SIF_IE_CONTROL_EXPANDED
			-- Result is a SIF_IE_CONTROL_EXPANDED instance for JSON message creation.
			-- The result is to be used in the JSON serializers, which are specific to serialize each ie_web_control in JSON.
		local
			l_result: SIF_IE_CONTROL_TEXT_EXPANDED
		do
			create l_result.make (type_interaction_element, events)
			if attached {SIF_IE_TEXT}interaction_element as l_ie_text then
				l_result.put_text (l_ie_text.text)
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	do_reset_events
			-- reset events
		do
			events.force (false, "event_output")
		end


	handle_event_output(a_text: STRING_32)
		do
			events.replace (true, "event_output")
			layer_application_sif.web_interact (Current)
			reset_events
		end

    do_handle_interaction(a_ie_control_expanded: SIF_IE_CONTROL_EXPANDED)
    		-- <Precursor>
    	local
    		l_string: STRING_32
    	do
    		if attached {SIF_IE_TEXT} interaction_element as l_interaction_element then
	    		if attached {SIF_IE_CONTROL_TEXT_EXPANDED}a_ie_control_expanded as l_ie_control_text_expanded then
					if attached l_ie_control_text_expanded.events.item ("event_input")  as l_event_input and then
					   l_event_input.item and then
					   attached l_ie_control_text_expanded.text as l_text then
					   	l_string := l_text.as_string_32
						l_interaction_element.event_input.publish (l_string)
					end
	    		end
	    	end
    	end

end


