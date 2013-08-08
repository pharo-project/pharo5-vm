generate sources
interpreterExportsFilePath
	"return the full path for the interpreter exports file"
	^(self coreVMDirectory / 'sqNamedPrims.h') fullPath