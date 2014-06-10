bytecode generators
genPushLiteralConstantBytecode
	^self genPushLiteralIndex: (byte0 bitAnd: 31)