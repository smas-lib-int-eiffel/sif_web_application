note
	description: "Summary description for {SIF_SI_USER_VIEWABLE_WEB_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIF_SI_USER_VIEWABLE_WEB_APPLICATION

inherit
	SIF_SYSTEM_INTERFACE_USER_VIEWABLE
		redefine
			activate_view,
			reactivate_view,
			deactivate_view,
			present_view,
			hide_view
		end

feature -- Creation

	make_with_layer(a_communication_application_layer_sif: LAYER_APPLICATION_SIF)
			-- Make sure we are able to use a remote communication layer
		do
			sif_layer_application := a_communication_application_layer_sif
			make
		end

feature -- Command

	activate_view( a_view_identifier : INTEGER_64)
			-- Activate the view if present in the views register.
		do
			Precursor(a_view_identifier)
			if attached sif_layer_application as l_sif_application_layer and
			   attached {SIF_VIEW_WEB}view (a_view_identifier) as l_view_web then
				l_sif_application_layer.handle_view (l_view_web, {ENUMERATION_VIEW_ACTION}.activate)
			end
		end

	reactivate_view( a_view_identifier : INTEGER_64)
			-- Activate the view if present in the views register.
		do
			Precursor(a_view_identifier)
			if attached sif_layer_application as l_sif_application_layer and
			   attached {SIF_VIEW_WEB}view (a_view_identifier) as l_view_web then
				l_sif_application_layer.handle_view (l_view_web, {ENUMERATION_VIEW_ACTION}.reactivate)
			end
		end

	deactivate_view( a_view_identifier : INTEGER_64)
			-- Activate the view if present in the views register.
		do
			Precursor(a_view_identifier)
			if attached sif_layer_application as l_sif_application_layer and
			   attached {SIF_VIEW_WEB}view (a_view_identifier) as l_view_web then
				l_sif_application_layer.handle_view (l_view_web, {ENUMERATION_VIEW_ACTION}.deactivate)
			end
		end

	present_view( a_view_identifier : INTEGER_64)
			-- Present the view if present in the views register to the user.
		do
			Precursor(a_view_identifier)
			if attached sif_layer_application as l_sif_application_layer and
			   attached {SIF_VIEW_WEB}view (a_view_identifier) as l_view_web then
				l_sif_application_layer.handle_view (l_view_web, {ENUMERATION_VIEW_ACTION}.present)
			end
		end

	hide_view( a_view_identifier : INTEGER_64)
			-- Hide the view if present in the views register to the user.
		do
			Precursor(a_view_identifier)
			if attached sif_layer_application as l_sif_application_layer and
			   attached {SIF_VIEW_WEB}view (a_view_identifier) as l_view_web then
				l_sif_application_layer.handle_view (l_view_web, {ENUMERATION_VIEW_ACTION}.hide)
			end
		end


feature -- Remote communication

	put_layer_application(a_application_layer: LAYER_APPLICATION_SIF)
			-- The application communication layer able to communicate SIF views and interaction elements
		do
			sif_layer_application := a_application_layer
		end

	sif_layer_application: LAYER_APPLICATION_SIF

end
