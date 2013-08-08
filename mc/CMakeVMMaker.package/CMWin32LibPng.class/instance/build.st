as yet unclassified
build

"LIBS=-L${installPrefix}/lib"
	gen 
		puts:
'
add_custom_command(OUTPUT "${libpngInstalled}"
	COMMAND ./configure --prefix=''${installPrefix}'' CFLAGS="-m32 -march=pentium4 -I${installPrefix}/include" CPPFLAGS="-m32 -I${installPrefix}/include" LDFLAGS="-m32 -march=pentium4 -L${installPrefix}/lib" 
	COMMAND make
	COMMAND make install
	COMMAND cp "${installPrefix}/lib/libpng.dll.a" "${installPrefix}/lib/libpng12.dll.a"
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}" pkg-config
	COMMENT "Building ${libName}"
)
'
