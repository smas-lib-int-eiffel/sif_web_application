note
	description: "Summary description for {SIF_IE_CONTROL_TEXT_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIF_IE_CONTROL_TEXT_EXPANDED

inherit
	SIF_IE_CONTROL_EXPANDED

create
	make

feature -- Element Change

	put_text(a_text: like text)
		do
			text := a_text
		end

feature -- Additional event information

	text: detachable STRING

end
