object access primitives
primitiveObjectAtPut
	"Store a literal into a CompiledMethod at the given index. Defined for CompiledMethods only."
	| thisReceiver rawHeader realHeader index newValue |
	newValue := self stackValue: 0.
	index := self stackValue: 1.
	(objectMemory isNonIntegerObject: index) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.
	thisReceiver := self stackValue: 2.
	(objectMemory isObjImmutable: thisReceiver) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	rawHeader := self rawHeaderOf: thisReceiver.
	realHeader := (self isCogMethodReference: rawHeader)
					ifTrue: [(self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader]
					ifFalse: [rawHeader].
	(index > 0
	 and: [index <= ((objectMemory literalCountOfMethodHeader: realHeader) + LiteralStart)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	index = 1
		ifTrue:
			[((objectMemory isNonIntegerObject: newValue)
			 or: [(objectMemory literalCountOfMethodHeader: newValue) ~= (objectMemory literalCountOfMethodHeader: realHeader)]) ifTrue:
				[^self primitiveFailFor: PrimErrBadArgument].
			 (self isCogMethodReference: rawHeader)
				ifTrue: [(self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader: newValue]
				ifFalse: [objectMemory storePointerUnchecked: 0 ofObject: thisReceiver withValue: newValue]]
		ifFalse:
			[objectMemory storePointer: index - 1 ofObject: thisReceiver withValue: newValue].
	self pop: 3 thenPush: newValue