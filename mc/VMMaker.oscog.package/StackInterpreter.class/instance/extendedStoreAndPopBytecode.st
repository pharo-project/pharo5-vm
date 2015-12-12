stack bytecodes
extendedStoreAndPopBytecode

	self extendedStoreBytecode.
	self internalPop: 1.
