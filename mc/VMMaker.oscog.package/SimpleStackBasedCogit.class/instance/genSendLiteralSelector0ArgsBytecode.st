bytecode generators
genSendLiteralSelector0ArgsBytecode
	^self genSend: (self getLiteral: (byte0 bitAnd: 15)) numArgs: 0