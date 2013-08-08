as yet unclassified
build
" Note: echo  #define _SSIZE_T_DEFINED 1 >> config.h
there just for a workaround of bug in cairo,
which fails the build it when building some unrelared utils. It does not affects library build, but i don't know how to tell it to not bother
building everything but just library
"


	gen 
		puts:
'
add_custom_command(OUTPUT "${libcairoInstalled}"
	COMMAND ./configure --prefix=''${installPrefix}'' PKG_CONFIG="${pkgconfigPath}"
		PKG_CONFIG_PATH="${installPrefix}/lib/pkgconfig" CFLAGS="-m32 -march=pentium4 -I${installPrefix}/include" LDFLAGS="-m32 -march=pentium4 -L${installPrefix}/lib"
		--disable-silent-rules --disable-xlib --disable-dependency-tracking

	COMMAND echo "#define _SSIZE_T_DEFINED 1" >> config.h
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}" pkg-config freetype2 libpng pixman
	COMMENT "Building ${libName}"
)
'
