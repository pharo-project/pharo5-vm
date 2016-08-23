generate sources
interpreterExportsFilePath
	"return the full path for the interpreter exports file"
	^self coreVMDirectory fullNameFor: 'sqNamedPrims.h'