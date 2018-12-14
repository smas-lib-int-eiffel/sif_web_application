note
	description: "Summary description for {SIF_IE_CONTROL_LIST_SINGLE_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	discription: "This class is to reflect interection element SIF_IE_LIST_SINGLE_SELECT, to be able to serialize to JSON"

class
	SIF_IE_CONTROL_LIST_SINGLE_EXPANDED

inherit
	SIF_IE_CONTROL_EXPANDED

create
	make


feature -- Element Change

	set_list(a_list: like list)
		do
			list := a_list
		end

	clean_list()
		do
			list := void
		end

--	update_source_list_item (a_list_item: ARRAY[STRING], a_index_number: INTEGER_32)
--		do
--			if attached source_list as l_source_list  then
--				source_list.force (a_list_item, a_index_number)
--			end
--		end

feature -- Additional event information

	list: detachable ARRAY[ARRAY[STRING]]

end
