bytecode generators
genPushLitVarDirSupBytecode
	^self genPushLiteralVariableGivenDirectedSuper: (byte0 bitAnd: 31)