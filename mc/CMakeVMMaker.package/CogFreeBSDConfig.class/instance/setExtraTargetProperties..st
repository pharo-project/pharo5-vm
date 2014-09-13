as yet unclassified
setExtraTargetProperties: maker


	maker addExternalLibraries: 
		#(
			'm'  "math lib"
			'pthread' "posix threads" 
		).
		
	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: '${outputDir}'.
	self addVMDrivers: maker.