processor api
convertIntegerToInternal: anInteger
	"Default conversion for 32-bit processors.  64-bit processors override."
	^anInteger signedIntToLong