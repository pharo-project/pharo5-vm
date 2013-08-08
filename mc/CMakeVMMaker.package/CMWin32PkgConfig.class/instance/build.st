as yet unclassified
build
	gen 
		puts: '
add_custom_command(OUTPUT "${pkgConfigBinary}"
	COMMAND ./configure --prefix="${installPrefix}" --with-internal-glib CFLAGS="-m32 -march=pentium4" LDFLAGS="-m32 -march=pentium4"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
	COMMENT "Building ${libName}"
)
'
