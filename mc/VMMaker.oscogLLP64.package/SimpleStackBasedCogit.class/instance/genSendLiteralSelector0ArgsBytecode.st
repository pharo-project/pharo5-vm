bytecode generators
genSendLiteralSelector0ArgsBytecode
	^self genSend: (byte0 bitAnd: 15) numArgs: 0