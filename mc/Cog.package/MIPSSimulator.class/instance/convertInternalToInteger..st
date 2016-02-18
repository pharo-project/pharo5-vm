processor api
convertInternalToInteger: unsigned
	"Default conversion for 32-bit processors.  64-bit processors override."
	^unsigned signedIntFromLong