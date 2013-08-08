generating actions
build

	gen 
		puts:
'
add_custom_command(OUTPUT "${ft2config}"
	COMMAND ./configure --prefix=''${installPrefix}'' ', self configurationFlags, '
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
)
add_custom_command(OUTPUT "${ft2libInstalled}"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${ft2config}"
	COMMENT "Building ${libName}"
)
'
