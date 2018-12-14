note
	description: "Summary description for {SIF_IE_CONTROL_WEB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIF_IE_CONTROL_WEB

inherit
	SIF_IE_CONTROL

feature -- Creation

	make(a_commmunication_layer_sif: LAYER_APPLICATION_SIF)
		do
			layer_application_sif := a_commmunication_layer_sif
			create events.make(0)

			reset_events
		end

feature -- Interaction for the web

	do_put_interaction_element( an_interaction_element: detachable SIF_INTERACTION_ELEMENT)
			-- put an interaction element to be used for interaction
		do
			reset_events
			if attached an_interaction_element as l_interaction_element then
				interaction_element := l_interaction_element
				if an_interaction_element.is_granted then
					l_interaction_element.event_disable.subscribe(agent handle_event_disabled)
					l_interaction_element.event_enable.subscribe(agent handle_event_enabled)
					l_interaction_element.event_unvisible.subscribe(agent handle_event_unvisible)
					l_interaction_element.event_visible.subscribe(agent handle_event_visible)

					do_put_interaction_element_web
				else
					handle_event_unvisible
				end
			end
		end

	do_put_interaction_element_web
			-- put an interaction element to be used for interaction with the web user agent
		deferred
		end

    handle_interaction(a_ie_control_expanded: SIF_IE_CONTROL_EXPANDED)
    		-- Execute the published events in the given expanded argument
    	do
			do_handle_interaction(a_ie_control_expanded)
    	end


feature -- Status

	expanded_type_serializer: JSON_SERIALIZER
			-- Result contains the json serializer for the web control
		deferred
		end

	type_expanded: TYPE [detachable ANY]
			-- Result contains the type to be used for the json conversion of the web control
		deferred
		end

	has_current_interacting_view: BOOLEAN
			-- True when current interacting view is attached
		do
			Result := attached current_interacting_view
		end

	has_interaction_element: BOOLEAN
			-- True when interaction element is attached
		do
			Result := attached interaction_element
		end

feature -- Identification

	view_identifier: like current_interacting_view.identifier
			-- The indentifier of the current interacting view
		require
			has_current_interacting_view: has_current_interacting_view
		do
			if attached current_interacting_view as l_current_interacting_view then
				Result := l_current_interacting_view.identifier
			end
		end


	identifier: like interaction_element.identifier
			-- The interaction element identifier
		require
			has_interaction_element: has_interaction_element
		do
			if attached interaction_element as l_interaction_element then
				Result := l_interaction_element.identifier
			end
		end

	type_interaction_element: STRING
			-- The generating type of the interaction element
		require
			has_interaction_element: has_interaction_element
		do
			create Result.make_empty
			if attached interaction_element as l_interaction_element then
				Result := l_interaction_element.generator
			end
		end


feature -- JSON conversion

	json_expanded: SIF_IE_CONTROL_EXPANDED
			-- Result is a IE_CONTROL_EXPANDED instance for JSON message creation.
			-- The result is to be used in the JSON serializers, which are specific to serialize each ie_web_control in JSON.
		deferred
		end

feature {NONE} -- Implementation

	events: HASH_TABLE[BOOLEAN, STRING]

	reset_events
			-- reset events
		do
			events.wipe_out
			events.force (false, "event_visible")
			events.force (false, "event_unvisible")
			events.force (false, "event_enable")
			events.force (false, "event_disable")
			do_reset_events
		end

	handle_event_disabled
		do
			events.replace (true, "event_disable")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	handle_event_enabled
		do
			events.replace (true, "event_enable")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	handle_event_unvisible
		do
			events.replace (true, "event_unvisible")
			layer_application_sif.web_interact (Current)
			reset_events
		end

	handle_event_visible
		do
			events.replace (true, "event_visible")
			layer_application_sif.web_interact (Current)
			reset_events
		end


	do_reset_events
			-- reset events
		deferred
		end

    do_handle_interaction(a_ie_control_expanded: SIF_IE_CONTROL_EXPANDED)
    		-- Execute the published events in the given expanded argument
    	deferred
    	end


	layer_application_sif: LAYER_APPLICATION_SIF

end
