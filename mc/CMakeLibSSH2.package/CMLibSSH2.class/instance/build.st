generating actions
build

	gen 
		puts:
'
add_custom_command(OUTPUT "${libSSH2Installed}"
	COMMAND ./configure --prefix=''${installPrefix}'' ', self configurationFlags, '
	DEPENDS "${unpackTarget}"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)
'