bytecode generators
genPushQuickIntegerConstantBytecode
	^self genPushLiteral: (objectMemory integerObjectOf: byte0 - 117)