note
	description: "Summary description for {SIF_IE_CONTROL_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIF_IE_CONTROL_EXPANDED

feature -- Creation

	make(a_type_name: like type_name_interaction_element; a_events: like events)
		do
			type_name_interaction_element := a_type_name
			events := a_events
		end

feature -- Access
	set_published(a_published: like published)
		do
			published := a_published
		end

feature -- Access
	published: detachable BOOLEAN

feature -- Implementation

	type_name_interaction_element: STRING

	events: HASH_TABLE[BOOLEAN, STRING]

end
