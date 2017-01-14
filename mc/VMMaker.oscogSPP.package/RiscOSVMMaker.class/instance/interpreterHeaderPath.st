generate sources
interpreterHeaderPath
	"return the full path for the interpreter header file"
	"RiscOS keeps the interp file in a 'h' subdirectory of coreVMDirectory"
	self coreVMDirectory assureExistenceOfPath: 'h'.
	^(self coreVMDirectory directoryNamed: 'h') fullNameFor: self interpreterFilename