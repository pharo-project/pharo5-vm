as yet unclassified
setExtraTargetProperties: maker

	"maker setTargetProperties: 'LINK_FLAGS ""'."
		
	maker puts: 'set_source_files_properties( ${srcVMDir}/cogit.c PROPERTIES 
		COMPILE_FLAGS "-O1 -fno-omit-frame-pointer -momit-leaf-frame-pointer")'.
		
	
	maker 
		cmd: 'set_source_files_properties'
		params: ' ${targetPlatform}/vm/sqUnixITimerHeartbeat.c PROPERTIES 
		COMPILE_FLAGS "-O1 -fno-omit-frame-pointer"'.
						
	
	maker addExternalLibraries: 
		#(
			'm'  "math lib"
			'dl'  "dynamic loader"
			'pthread' "posix threads" 
		).
		
	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: '${outputDir}'.
	self addVMDrivers: maker.