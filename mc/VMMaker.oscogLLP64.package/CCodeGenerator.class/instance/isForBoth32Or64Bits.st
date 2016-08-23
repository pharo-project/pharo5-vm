testing
isForBoth32Or64Bits
	"Answer true if the code is generated for both 32 and 64 bits.
	Answer false otherwise.
	Currently, VM source is generated for specific WordSize.
	But plugins source are generated in common directory for both."
	
	^self isGeneratingPluginCode