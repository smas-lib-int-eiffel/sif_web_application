note
	description: "Summary description for {SIF_IE_CONTROL_EVENT_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_IE_CONTROL_EVENT_EXPANDED

inherit
	SIF_IE_CONTROL_EXPANDED

create
	make

feature -- Element Change

	put_label(a_label: like label)
		do
			label := a_label
		end

	put_submit_list(a_list: like submit_list)
		do
			submit_list := a_list
		end

feature -- Additional event information

	label: detachable STRING

	submit_list: detachable STRING_TABLE[STRING]

end
