bytecode generators
genLongStoreTemporaryVariableBytecode
	"234		11101010	i i i i i i i i	Store Temporary Variable #iiiiiiii"
	^self genStorePop: false TemporaryVariable: byte1