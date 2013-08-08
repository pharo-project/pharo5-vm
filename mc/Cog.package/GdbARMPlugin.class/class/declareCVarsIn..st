translation
declareCVarsIn: aCCodeGenerator
	"prevInterruptCheckChain lives in sqGdbARMPlugin.c"
	super declareCVarsIn: aCCodeGenerator.
	aCCodeGenerator removeVariable: 'prevInterruptCheckChain'