generate sources
interpreterExportsFilePath
	"return the full path for the interpreter exports file"
	"RiscOS keeps the exports file in a 'h' subdirectory of coreVMDirectory"
	self coreVMDirectory assureExistenceOfPath: 'h'.
	^(self coreVMDirectory directoryNamed: 'h') fullNameFor: 'sqNamedPrims'