plugin extra rules
extraPluginSettings: maker	
	maker set: 'CMAKE_OSX_ARCHITECTURES' to: 'i386'.
	
	maker 
		setTargetProperty: 'COMPILE_FLAGS' 
		to: '"-include \"', (self buildDir / self prefixHeaderFileName) fullName, '\""'.  

	maker isExternal ifTrue: [
		"copy result to results dir "
		
		maker set: 'LIBRARY_OUTPUT_PATH' toString: self outputDir fullName.
		maker set: 'EXECUTABLE_OUTPUT_PATH' toString: self outputDir fullName.
		maker puts: 'list(APPEND linkFlags "-undefined dynamic_lookup")' ].
	
	"maker addXCodeProperty: 'GCC_VERSION' value: '4.3'."
	maker addXCodeProperty: 'GCC_PREFIX_HEADER' value: '${buildDir}/' , self executableName , '_Prefix.pch'.
	
