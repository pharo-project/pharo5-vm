stack bytecodes
longStoreTemporaryVariableBytecode
	"234		11101010	i i i i i i i i	Store Temporary Variable #iiiiiiii"
	| index |
	index := self fetchByte.
	self fetchNextBytecode.
	self temporary: index in: localFP put: self internalStackTop