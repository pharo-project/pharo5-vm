bytecode generators
genStoreAndPopTemporaryVariableBytecode
	^self genStorePop: true TemporaryVariable: (byte0 bitAnd: 7)