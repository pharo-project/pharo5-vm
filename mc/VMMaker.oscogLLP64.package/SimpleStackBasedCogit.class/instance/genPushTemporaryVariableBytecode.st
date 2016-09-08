bytecode generators
genPushTemporaryVariableBytecode
	^self genPushTemporaryVariable: (byte0 bitAnd: 15)