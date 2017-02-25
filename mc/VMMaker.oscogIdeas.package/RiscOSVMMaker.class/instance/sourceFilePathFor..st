generate sources
sourceFilePathFor: sourceFileName
	"return the full path for the interpreter file"
	"RiscOS keeps the interp file in a 'c' subdirectory of coreVMDirectory"
	self coreVMDirectory assureExistenceOfPath: 'c'.
	^(self coreVMDirectory directoryNamed: 'c') fullNameFor: (sourceFileName allButLast: 2)