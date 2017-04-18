arithmetic primitives
mcprimHashMultiply: receiverArg
	"Machine code primitive for hash multiply. c.f. primitiveHashMultiply.
	 mcprims consume receiver and arguments as parameters and answer the
	 result on success, or set the primitive error code and answer 0 on failure."
	"Implement 28-bit hashMultiply for SmallInteger and LargePositiveInteger receivers."
	<api>
	| receiver low |
	(objectMemory isIntegerObject: receiverArg)
		ifTrue: [receiver := objectMemory integerValueOf: receiverArg]
		ifFalse:
			[| ok |
			 ok := objectMemory is: receiverArg instanceOf: (objectMemory splObj: ClassLargePositiveInteger) compactClassIndex: ClassLargePositiveIntegerCompactIndex.
			 ok ifFalse:
				[self primitiveFailFor: PrimErrBadReceiver.
				 ^0].
			 receiver := objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: receiverArg)].
	low := receiver bitAnd: 16383.
	"N.B. We use undefined behaviour assuming the compiler will still generate a multiply, rather than simply crap out, so as to save the unnecessary bitAnd: 16383."
	^objectMemory integerObjectOf: ((16r260D * low + ((16r260D * (receiver bitShift: -14) + (16r0065 * low) "bitAnd: 16383") * 16384)) bitAnd: 16r0FFFFFFF)