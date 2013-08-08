bytecode generators
genPushLiteral: literal
	^self ssPushConstant: literal