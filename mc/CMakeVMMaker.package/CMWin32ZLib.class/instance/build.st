generating actions
build

'	COMMAND ./configure --prefix="${installPrefix}" --archs="-arch i386" '.
	
	gen 
		puts: '
add_custom_command(OUTPUT "${libzInstalled}"
	COMMAND make -fwin32/Makefile.gcc 
	COMMAND make install -fwin32/Makefile.gcc prefix="${installPrefix}" INCLUDE_PATH="${installPrefix}/include" LIBRARY_PATH="${installPrefix}/lib" BINARY_PATH="${installPrefix}/bin" SHARED_MODE=1
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
	COMMENT "Building ${libName}"
)
'
