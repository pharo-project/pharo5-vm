generate sources
interpreterExportsFilePath
	"Return the full path for the interpreter exports file.  Since we're leaving it up to
	 platform makefiles to specify the actual named prims, just produce an example file."
	^self coreVMDirectory fullNameFor: 'exampleSqNamedPrims.h'