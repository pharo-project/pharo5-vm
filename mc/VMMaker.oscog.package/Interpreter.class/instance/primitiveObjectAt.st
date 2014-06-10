object access primitives
primitiveObjectAt
"Defined for CompiledMethods only"
	| thisReceiver index |
	index  := self popInteger.
	thisReceiver := self popStack.
	self success: index > 0.
	self success: index <= ((self literalCountOf: thisReceiver) + LiteralStart).
	successFlag
		ifTrue: [self push: (self fetchPointer: index - 1 ofObject: thisReceiver)]
		ifFalse: [self unPop: 2]