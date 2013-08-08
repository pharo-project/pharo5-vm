generate sources
interpreterHeaderPath
	"Answer the fully-qualified path for the generated interpreter header file."

	^(self coreVMDirectory / self interpreterHeaderName) fullPath