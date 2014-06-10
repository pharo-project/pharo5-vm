stack bytecodes
longStoreAndPopTemporaryVariableBytecode
	"237		11101101	i i i i i i i i	Pop and Store Temporary Variable #iiiiiiii"
	self longStoreTemporaryVariableBytecode.
	self internalPop: 1