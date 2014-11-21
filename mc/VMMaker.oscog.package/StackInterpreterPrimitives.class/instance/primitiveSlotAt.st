object access primitives
primitiveSlotAt
	| index rcvr numSlots value |
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
			[(objectMemory isContextNonImm: rcvr)
							ifTrue: [value := self externalInstVar: index ofContext: rcvr]
							ifFalse: [value := objectMemory fetchPointer: index ofObject: rcvr].
			 self pop: argumentCount + 1 thenPush: value.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].
	"for now just fail for non-pointer objects; the issue here is should
	 strings answer characters and if so how do we efficiently identify strings?"
	^self primitiveFailFor: PrimErrBadReceiver