memory space primitives
primitiveGrowMemoryByAtLeast
	<option: #SpurObjectMemory>
	| ammount |
	ammount := self stackTop.
	(objectMemory isIntegerObject: ammount) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	(objectMemory growOldSpaceByAtLeast: (objectMemory integerValueOf: ammount))
		ifNil: [self primitiveFailFor: PrimErrNoMemory]
		ifNotNil: [:segSize| self pop: 2 thenPushInteger: segSize]