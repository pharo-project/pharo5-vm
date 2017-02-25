bytecode generators
genStoreAndPopReceiverVariableBytecode
	^self genStorePop: true ReceiverVariable: (byte0 bitAnd: 7)