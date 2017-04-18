arithmetic primitives
mcprimHashMultiply: receiverArg
	"Machine code primitive for hash multiply. c.f. primitiveHashMultiply.
	 mcprims consume receiver and arguments as parameters and answer the
	 result on success, or set the primitive error code and answer 0 on failure."
	"Implement 28-bit hashMultiply for SmallInteger and LargePositiveInteger receivers."
	<api>
	| value |
	(objectMemory isIntegerObject: receiverArg)
		ifTrue: [value := objectMemory integerValueOf: receiverArg]
		ifFalse:
			[| ok |
			 ok := objectMemory is: receiverArg instanceOf: (objectMemory splObj: ClassLargePositiveInteger) compactClassIndex: ClassLargePositiveIntegerCompactIndex.
			 ok ifFalse:
				[self primitiveFailFor: PrimErrBadReceiver.
				 ^0].
			 value := objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: receiverArg)].
	^objectMemory integerObjectOf: (value * HashMultiplyConstant bitAnd: 16rFFFFFFF)