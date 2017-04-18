arithmetic integer primitives
primitiveHashMultiply
	"Implement 28-bit hashMultiply for SmallInteger and LargePositiveInteger receivers."
	| value |
	value := self stackTop.
	(objectMemory isIntegerObject: value)
		ifTrue: [value := objectMemory integerValueOf: value]
		ifFalse:
			[| ok |
			 ok := objectMemory is: value instanceOf: (objectMemory splObj: ClassLargePositiveInteger) compactClassIndex: ClassLargePositiveIntegerCompactIndex.
			 ok ifFalse:
				[^self primitiveFailFor: PrimErrBadReceiver].
			 value := objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: value)].
	self pop: 1
		thenPush: (objectMemory integerObjectOf: (value * HashMultiplyConstant bitAnd: 16rFFFFFFF))