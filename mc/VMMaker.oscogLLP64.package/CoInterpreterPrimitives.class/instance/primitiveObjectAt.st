object access primitives
primitiveObjectAt
"Defined for CompiledMethods only"
	| thisReceiver rawHeader realHeader index |
	index  := self stackIntegerValue: 0.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	thisReceiver := self stackValue: 1.
	rawHeader := self rawHeaderOf: thisReceiver.
	realHeader := (self isCogMethodReference: rawHeader)
					ifTrue: [(self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader]
					ifFalse: [rawHeader].
	(index > 0
	 and: [index <= ((objectMemory literalCountOfMethodHeader: realHeader) + LiteralStart)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	self pop: 2
		thenPush: (index = 1
					ifTrue: [realHeader]
					ifFalse: [objectMemory fetchPointer: index - 1 ofObject: thisReceiver])