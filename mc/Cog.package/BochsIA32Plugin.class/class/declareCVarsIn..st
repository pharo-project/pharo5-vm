translation
declareCVarsIn: aCCodeGenerator
	"prevInterruptCheckChain lives in sqBochsIA32Plugin.c"
	super declareCVarsIn: aCCodeGenerator.
	aCCodeGenerator removeVariable: 'prevInterruptCheckChain'