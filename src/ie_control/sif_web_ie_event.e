note
	description: "Summary description for {SIF_WEB_IE_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_WEB_IE_EVENT

inherit
	SIF_IE_CONTROL_WEB

create
	make

feature -- Interaction for the web

	do_put_interaction_element_web
			-- <Precursor>
		do
			if attached {SIF_IE_EVENT} interaction_element as l_interaction_element then
				l_interaction_element.event_label.subscribe (agent handle_event_label_changed)
				l_interaction_element.event_output_select.subscribe (agent handle_event_output_select)
				l_interaction_element.event_output_deselect.subscribe (agent handle_event_output_deselect)
			end
		end

feature -- Status

	expanded_type_serializer: JSON_SERIALIZER
			-- Result contains the json serializer for the web control
		do
			create {SIF_JSON_SERIALIZER_IE_CONTROL_WEB_EVENT}Result
		end

	type_expanded: TYPE [detachable ANY]
			-- Result contains the type to be used for the json conversion of the web control
		do
			Result := {SIF_IE_CONTROL_EVENT_EXPANDED}
		end

feature -- JSON conversion

	json_expanded: SIF_IE_CONTROL_EXPANDED
			-- Result is a SIF_IE_CONTROL_EXPANDED instance for JSON message creation.
			-- The result is to be used in the JSON serializers, which are specific to serialize each ie_web_control in JSON.
		local
			l_result: SIF_IE_CONTROL_EVENT_EXPANDED
		do
			create l_result.make (type_interaction_element, events)
			l_result.put_label (label_text)
			Result := l_result
		end

feature -- Label text

	label_text: detachable STRING
			-- The text of the label

feature {NONE} -- Implementation

	do_reset_events
			-- reset events
		do
			events.force (false, "event")
			events.force (false, "event_output_select")
			events.force (false, "event_output_deselect")
			events.force (false, "event_label")
			label_text := void
		end

	publish_event
		do
			if attached {SIF_IE_EVENT}interaction_element as l_ie_event_publish then
				l_ie_event_publish.event.publish ([])
			end
		end

	handle_event_label_changed(a_label: STRING)
		do
			events.replace (true, "event_label")
			create label_text.make_from_string (a_label)
			layer_application_sif.web_interact (Current)
			reset_events
		end

	handle_event_output_select
		do
			events.replace (true, "event_output_select")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	handle_event_output_deselect
		do
			events.replace (true, "event_output_deselect")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	-- For incoming message
    do_handle_interaction(a_ie_control_expanded: SIF_IE_CONTROL_EXPANDED)
    		-- <Precursor>
    	do
    		if attached {SIF_IE_EVENT} interaction_element as l_interaction_element then
	    		if attached {SIF_IE_CONTROL_EVENT_EXPANDED}a_ie_control_expanded as l_ie_control_event_expanded then
					if attached l_ie_control_event_expanded.events.item ("event")  as l_event and then
					   l_event.item then
						l_interaction_element.event.publish([])
					end
	    		end
	    	end
    	end

end

