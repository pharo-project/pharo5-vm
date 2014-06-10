bytecode generators
genPushLiteralVariableBytecode
	^self genPushLiteralVariable: (byte0 bitAnd: 31)