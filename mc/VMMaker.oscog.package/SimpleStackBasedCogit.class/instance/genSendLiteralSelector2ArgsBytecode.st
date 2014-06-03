bytecode generators
genSendLiteralSelector2ArgsBytecode
	^self genSend: (self getLiteral: (byte0 bitAnd: 15)) numArgs: 2