as yet unclassified
setExtraTargetProperties: maker

	maker setTargetProperties: 'LINK_FLAGS "-m32 -Wl,--export-dynamic"'.
		
	maker puts: 'set_source_files_properties( ${srcVMDir}/cogit.c PROPERTIES 
		COMPILE_FLAGS "-O1 -fno-omit-frame-pointer -momit-leaf-frame-pointer -mno-rtd -mno-accumulate-outgoing-args")'.
		
	
	maker 
		cmd: 'set_source_files_properties'
		params: ' ${targetPlatform}/vm/sqUnixITimerHeartbeat.c PROPERTIES 
		COMPILE_FLAGS "-O1 -fno-omit-frame-pointer -mno-rtd -mno-accumulate-outgoing-args"'.

	maker addExternalLibraries: 
		#(
			'm'  "math lib"
			'pthread' "posix threads" 
			'execinfo' "for backtrace"
		).
						
	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: '${outputDir}'.
	self addVMDrivers: maker.