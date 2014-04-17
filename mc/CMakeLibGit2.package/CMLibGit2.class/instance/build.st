generating actions
build

	gen 
		puts:
'
add_custom_command(OUTPUT "${libGit2Installed}"
	COMMAND cmake -DCMAKE_INSTALL_PREFIX="${installPrefix}" ', self configurationFlags, ' . 
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)
'
