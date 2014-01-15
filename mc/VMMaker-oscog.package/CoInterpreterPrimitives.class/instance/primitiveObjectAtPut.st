object access primitives
primitiveObjectAtPut
	"Store a literal into a CompiledMethod at the given index. Defined for CompiledMethods only."
	| thisReceiver rawHeader realHeader index newValue |
	newValue := self stackValue: 0.
	index := self stackValue: 1.
	((objectMemory isNonIntegerObject: index)
	 or: [index = ConstOne and: [(objectMemory isNonIntegerObject: newValue)]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.
	thisReceiver := self stackValue: 2.
	rawHeader := self rawHeaderOf: thisReceiver.
	realHeader := (self isCogMethodReference: rawHeader)
					ifTrue: [(self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader]
					ifFalse: [rawHeader].
	(index > 0
	 and: [index <= ((self literalCountOfHeader: realHeader) + LiteralStart)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	(index = 1
	 and: [self isCogMethodReference: rawHeader])
		ifTrue: [(self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader: newValue]
		ifFalse: [objectMemory storePointer: index - 1 ofObject: thisReceiver withValue: newValue].
	self pop: 3 thenPush: newValue