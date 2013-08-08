utils
setExtraTargetProperties: maker

	maker addExternalLibraries: self externalLibraries.
	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: '${outputDir}'.

"	maker puts: 'set_source_files_properties(${srcVMDir}/cogit.c PROPERTIES COMPILE_FLAGS -O1)'."
	maker puts: 'set_source_files_properties(${srcVMDir}/gcc3x-cointerp.c PROPERTIES COMPILE_FLAGS -O1)'
