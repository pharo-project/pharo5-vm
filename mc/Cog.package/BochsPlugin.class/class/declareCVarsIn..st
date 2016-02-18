translation
declareCVarsIn: aCCodeGenerator
	"prevInterruptCheckChain lives in sqBochsIA32|X64Plugin.c"
	self ~~ BochsPlugin ifTrue:
		[super declareCVarsIn: aCCodeGenerator.
		 aCCodeGenerator removeVariable: 'prevInterruptCheckChain']