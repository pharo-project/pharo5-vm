as yet unclassified
build

	gen 
		puts:
'
add_custom_command(OUTPUT "${libpixmanInstalled}"
	COMMAND ./configure --prefix=''${installPrefix}'' PKG_CONFIG="${pkgconfigPath}"
		PKG_CONFIG_PATH="${installPrefix}/lib/pkgconfig" CFLAGS="-m32 -march=pentium4 -I${installPrefix}/include" LDFLAGS="-m32 -march=pentium4" LIBS="-L${installPrefix}/lib"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}" pkg-config
	COMMENT "Building ${libName}"
)
'
