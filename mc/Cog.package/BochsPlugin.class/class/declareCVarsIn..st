translation
declareCVarsIn: aCCodeGenerator
	"prevInterruptCheckChain lives in sqBochsIA32|X64Plugin.c"
	super declareCVarsIn: aCCodeGenerator.
	aCCodeGenerator removeVariable: 'prevInterruptCheckChain'