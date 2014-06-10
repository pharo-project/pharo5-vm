bytecode generators
genPushConstantZeroBytecode
	"78			01001110		Push 0"
	^self genPushLiteral: (objectMemory integerObjectOf: 0)