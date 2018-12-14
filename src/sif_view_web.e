note
	description: "Summary description for {SIF_VIEW_WEB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIF_VIEW_WEB

inherit
	SIF_INTERACTION_ELEMENT_IDENTIFIERS

	SIF_VIEW
		rename
			make as sif_view_make
		undefine
			default_create
		redefine
			sif_view_make,
			do_present,
			deactivate
		end

feature -- Creation

	sif_view_make(a_viewable_system_interface: SIF_SI_USER_VIEWABLE_WEB_APPLICATION; an_identifier: INTEGER_64)
		do
			create interaction_elements_set.make
			check attached a_viewable_system_interface.sif_layer_application end
			layer_application := a_viewable_system_interface.sif_layer_application
			Precursor(a_viewable_system_interface, an_identifier)
		end

feature -- HTML

	html: STRING
			-- Result is the html which will be put to the <div id= ....>, where .... is the view identifier.
		deferred
		end

feature -- Access

	do_present
		do
			-- Intended to be empty.
			-- This will be handled by the system interface by using remote communication
		end

feature -- Access

	do_interact (an_interaction_elements_set: SIF_INTERACTION_ELEMENT_SORTED_SET)
			-- Interact on the system interface through the set of interaction elements
		do
			check attached {SIF_SI_USER_VIEWABLE_WEB_APPLICATION} system_insterface_viewable_user end
			if attached {SIF_SI_USER_VIEWABLE_WEB_APPLICATION} system_insterface_viewable_user as l_si_web_application then
--				if attached {SIF_IE_EVENT} an_interaction_elements_set.interaction_element (Iei_redirect) as ie_redirect then
--					interaction_elements_set.extend (ie_redirect)
--					ie_redirect.event_label.subscribe(agent handle_redirect)
--				end

				do_interact_on_web_interface(an_interaction_elements_set, l_si_web_application)
			end
		end

	do_interact_on_web_interface(an_interaction_elements_set: SIF_INTERACTION_ELEMENT_SORTED_SET; a_si_web_application: SIF_SI_USER_VIEWABLE_WEB_APPLICATION)
			-- Interact on the system interface through the set of interaction elements on a system interface which is a web application in a browser
		deferred
		end

	deactivate
			-- Deactivate the view
			-- Deactivation of the view has to make sure the view is not presented anymore to the user.
		do
			Precursor
		end

	hide
		do
		end

	destroy
			-- Destroy the current view from the system so all resources are freed
		do
		end

feature -- Implementation

	interaction_elements_set: SIF_INTERACTION_ELEMENT_SORTED_SET

feature {NONE} -- Private implementation

	layer_application: LAYER_APPLICATION_SIF

	handle_redirect(a_uri: STRING)
		do
			layer_application.web_redirect (a_uri)
		end

end
