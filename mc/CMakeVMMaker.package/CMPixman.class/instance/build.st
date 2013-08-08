generating actions
build

	gen 
		puts:
'
add_custom_command(OUTPUT "${libpixmanInstalled}"
	COMMAND ./configure --prefix=''${installPrefix}'' PKG_CONFIG="${pkgconfigPath}"
		PKG_CONFIG_PATH="${installPrefix}/lib/pkgconfig" CFLAGS=''-arch i386'' LDFLAGS=''-arch i386''
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}" pkg-config
	COMMENT "Building ${libName}"
)
'
