arithmetic integer primitives
primitiveHashMultiply
	"Implement 28-bit hashMultiply for SmallInteger and LargePositiveInteger receivers."
	| receiver low result |
	receiver := self stackTop.
	(objectMemory isIntegerObject: receiver)
		ifTrue: [receiver := objectMemory integerValueOf: receiver]
		ifFalse:
			[| ok |
			 ok := objectMemory is: receiver instanceOf: (objectMemory splObj: ClassLargePositiveInteger) compactClassIndex: ClassLargePositiveIntegerCompactIndex.
			 ok ifFalse:
				[^self primitiveFailFor: PrimErrBadReceiver].
			 receiver := objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: receiver)].
	low := receiver bitAnd: 16383.
	"N.B. We use undefined behaviour assuming the compiler will still generate a multiply, rather than simply crap out, so as to save the unnecessary bitAnd: 16383."
	result := (16r260D * low + ((16r260D * (receiver bitShift: -14) + (16r0065 * low) "bitAnd: 16383") * 16384)) bitAnd: 16r0FFFFFFF.
	self pop: 1 thenPush: (objectMemory integerObjectOf: result)