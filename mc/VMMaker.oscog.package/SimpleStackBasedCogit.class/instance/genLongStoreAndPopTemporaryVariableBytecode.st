bytecode generators
genLongStoreAndPopTemporaryVariableBytecode
	"237		11101101	i i i i i i i i	Pop and Store Temporary Variable #iiiiiiii"
	^self genStorePop: true TemporaryVariable: byte1