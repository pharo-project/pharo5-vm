compile abstract instructions
compileEntireMethod
	"Compile the abstract instructions for the entire method, including blocks."
	regArgsHaveBeenPushed := false.
	^super compileEntireMethod