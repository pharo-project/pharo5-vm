generating actions
build
	gen 
		puts: '
add_custom_command(OUTPUT "${pkgConfigBinary}"
	COMMAND ./configure --prefix=''${installPrefix}'' CFLAGS=''-std=gnu89 -arch i386'' LDFLAGS=''-arch i386''
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
	COMMENT "Building ${libName}"
)
'
