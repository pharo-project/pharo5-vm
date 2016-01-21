object access primitives
primitiveObjectAtPut
	"Store a literal into a CompiledMethod at the given index. Defined for CompiledMethods only."
	| thisReceiver index newValue |
	newValue := self stackValue: 0.
	index := self stackValue: 1.
	((objectMemory isNonIntegerObject: index)
	 or: [index = ConstOne and: [(objectMemory isNonIntegerObject: newValue)]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.
	thisReceiver := self stackValue: 2.
	(objectMemory isObjImmutable: thisReceiver) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	(index > 0 and: [index <= ((objectMemory literalCountOf: thisReceiver) + LiteralStart)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	objectMemory storePointer: index - 1 ofObject: thisReceiver withValue: newValue.
	self pop: 3 thenPush: newValue