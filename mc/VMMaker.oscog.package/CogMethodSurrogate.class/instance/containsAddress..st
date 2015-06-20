testing
containsAddress: address
	"Simulation only; N.B. this will error if used on block method surrogates."
	^address <= address asUnsignedInteger
	  and: [address + self blockSize >= address asUnsignedInteger]