bytecode generators
genExtendedSuperBytecode
	^self genSendSuper: (self getLiteral: (byte1 bitAnd: 16r1F)) numArgs: byte1 >> 5