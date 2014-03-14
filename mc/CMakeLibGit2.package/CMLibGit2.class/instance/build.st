generating actions
build

	gen 
		puts:
'
add_custom_command(OUTPUT "${libGit2Installed}"
	COMMAND cmake -DCMAKE_INSTALL_PREFIX="${installPrefix}" -DCMAKE_OSX_ARCHITECTURES="i386" . 
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)
'
