plugin extra rules
configurePlugin: aPlugin with: generator

	generator isExternal ifTrue: [
		" set output directory for dynamic library to Resources subdir in .app bundle location "
		generator 
			set: 'CMAKE_LIBRARY_OUTPUT_DIRECTORY' 
			toString: '${externalModulesDir}'
		].
	^ super configurePlugin: aPlugin with: generator
