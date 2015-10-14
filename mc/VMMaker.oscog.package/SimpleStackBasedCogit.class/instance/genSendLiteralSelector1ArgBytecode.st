bytecode generators
genSendLiteralSelector1ArgBytecode
	^self genSend: (byte0 bitAnd: 15) numArgs: 1