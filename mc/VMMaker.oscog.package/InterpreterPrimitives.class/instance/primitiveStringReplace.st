indexing primitives
primitiveStringReplace
	"<array> primReplaceFrom: start to: stop with: replacement startingAt: repStart  
		<primitive: 105>"
	objectMemory hasSpurMemoryManagerAPI
		ifTrue: [self primitiveSpurStringReplace]
		ifFalse: [self primitiveV3StringReplace]