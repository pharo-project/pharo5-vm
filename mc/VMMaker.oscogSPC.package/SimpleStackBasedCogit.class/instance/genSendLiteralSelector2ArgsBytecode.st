bytecode generators
genSendLiteralSelector2ArgsBytecode
	^self genSend: (byte0 bitAnd: 15) numArgs: 2