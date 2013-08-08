bytecode generators
genPushReceiverVariableBytecode
	^self genPushReceiverVariable: (byte0 bitAnd: 15)