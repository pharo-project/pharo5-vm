bytecode generators
genExtendedSuperBytecode
	^self genSendSuper: (byte1 bitAnd: 16r1F) numArgs: byte1 >> 5