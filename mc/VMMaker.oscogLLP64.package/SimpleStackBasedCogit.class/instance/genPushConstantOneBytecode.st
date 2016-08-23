bytecode generators
genPushConstantOneBytecode
	"79			01001111		Push 1"
	^self genPushLiteral: (objectMemory integerObjectOf: 1)