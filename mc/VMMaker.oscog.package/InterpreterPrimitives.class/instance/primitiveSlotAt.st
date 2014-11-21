object access primitives
primitiveSlotAt
	| index rcvr numSlots |
	index := self stackTop.
	rcvr := self stackValue: 1.
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	index := objectMemory integerValueOf: index.
	(objectMemory isPointersNonImm: rcvr) ifTrue:
		[numSlots := objectMemory numSlotsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[self pop: argumentCount + 1 thenPush: (objectMemory fetchPointer: index ofObject: rcvr).
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].
	"for now just fail for non-pointer objects; the issue here is should
	 strings answer characters and if so how do we efficiently identify strings?"
	^self primitiveFailFor: PrimErrBadReceiver