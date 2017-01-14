object access primitives
primitiveObjectAt
"Defined for CompiledMethods only"
	| thisReceiver index |
	index  := self stackIntegerValue: 0.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	thisReceiver := self stackValue: 1.
	(index > 0 and: [index <= ((objectMemory literalCountOf: thisReceiver) + LiteralStart)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	self pop: 2 thenPush: (objectMemory fetchPointer: index - 1 ofObject: thisReceiver)