as yet unclassified
build

	gen 
		puts:
'
add_custom_command(OUTPUT "${libSourcesDir}/Makefile"
	COMMAND ./config shared --prefix=''${installPrefix}'' 
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
)

add_custom_command(OUTPUT "${installPrefix}/bin/libeay32.dll" "${installPrefix}/bin/ssleay32.dll"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${libSourcesDir}/Makefile"
	COMMENT "Building ${libName}"
)
'
