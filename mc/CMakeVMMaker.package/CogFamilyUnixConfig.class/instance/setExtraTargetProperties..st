utils
setExtraTargetProperties: maker


	maker addExternalLibraries: 
		#(
			'm'  "math lib"
			'dl'  "dynamic loader"
			'pthread' "posix threads" 
		).
		
	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: '${outputDir}'.
	self addVMDrivers: maker.