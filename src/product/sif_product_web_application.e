note
	description: "Summary description for {SIF_PRODUCT_WEB_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIF_PRODUCT_WEB_APPLICATION

inherit
	SIF_PRODUCT_WEB
		rename
			manufacture as product_web_manufacture
		select
			product_web_manufacture
		end

	SIF_PRODUCT_USER_VIEWABLE
		rename
			manufacture as product_user_viewable_manufacture
		undefine
			use_logging,
			initialize
		end

feature -- System interface

	create_system_interface(a_layer_application_sif: LAYER_APPLICATION_SIF): SIF_SI_USER_VIEWABLE_WEB_APPLICATION
		-- Create an instance of a user viewable web application system interface
		deferred
		end

feature -- Query

	persistence_storage_name: STRING
		do
			create Result.make_empty
		end

feature {NONE} -- Manufacturing

	manufacture
			-- Manufacture the specific product
		do
			product_user_viewable_manufacture
			product_web_manufacture
		end

	manufacture_controllers
			-- Manufacture the controllers
		do
			-- Intended to be empty
			--
			-- Due to the concurrent nature of web applications, controllers need to have their own context.
			-- So when a session is started, the controllers of the software product need to be created for that particular session.
			-- None initial controllers can be executed when needed so there will be no waste of memory.
			--
		end

	is_authorisable: BOOLEAN
		do
			Result := true
		end

end
