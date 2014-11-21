object access primitives
primitiveSlotAtPut
	| newValue index rcvr numSlots |
	newValue := self stackTop.
	index := self stackValue: 1.
	rcvr := self stackValue: 2.
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	index := objectMemory integerValueOf: index.
	(objectMemory isPointersNonImm: rcvr) ifTrue:
		[numSlots := objectMemory numSlotsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[objectMemory storePointer: index ofObject: rcvr withValue: newValue.
			 self pop: argumentCount + 1 thenPush: newValue.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].
	"for now just fail for non-pointer objects; the issue here is should
	 strings answer characters and if so how do we efficiently identify strings?"
	^self primitiveFailFor: PrimErrBadReceiver