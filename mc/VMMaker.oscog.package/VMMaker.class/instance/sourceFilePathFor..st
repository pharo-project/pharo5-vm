generate sources
sourceFilePathFor: sourceFileName
	"Answer the fully-qualified path for the generated source file."
	^self coreVMDirectory fullNameFor: sourceFileName