note
	description: "Summary description for {SIF_JSON_SERIALIZER_IE_CONTROL_WEB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIF_JSON_SERIALIZER_IE_CONTROL_WEB

inherit
	JSON_SERIALIZER
		redefine
			default_create
		end

feature -- Creation

	default_create
		do
			create j_object.make_with_capacity (4)
			Precursor
		end

feature -- External object

	put_object(a_object: JSON_OBJECT)
			-- When called the serializer will work en the external object
		do
			j_object := a_object
		end

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			l_json_object: detachable JSON_OBJECT
		do
			if attached {SIF_IE_CONTROL_EXPANDED} obj as ie_control_simple and then
			   attached ie_control_simple.events.item ("event_visible") as l_event_visible and then
			   attached ie_control_simple.events.item ("event_unvisible") as l_event_unvisible and then
			   attached ie_control_simple.events.item ("event_enable") as l_event_enable and then
			   attached ie_control_simple.events.item ("event_disable") as l_event_disable then
					-- "event visible"
				if l_event_visible.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event_visible.item, "published")
					j_object.put(l_json_object,"event_visible")
				end
					-- "event unvisible"
				if l_event_unvisible.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event_unvisible.item, "published")
					j_object.put(l_json_object,"event_unvisible")
				end
					-- "event enable"
				if l_event_enable.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event_enable.item, "published")
					j_object.put(l_json_object,"event_enable")
				end
					-- "event disable"
				if l_event_disable.item then
					create l_json_object.make
					l_json_object.put_boolean (l_event_disable.item, "published")
					j_object.put(l_json_object,"event_disable")
				end
				-- After the basic events add the specific events if published
				to_json_extended(obj, ctx)

			end
			Result := j_object
		end


feature {NONE} -- Implementation

	to_json_extended (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT)
		deferred
		end

	j_object: JSON_OBJECT

end
