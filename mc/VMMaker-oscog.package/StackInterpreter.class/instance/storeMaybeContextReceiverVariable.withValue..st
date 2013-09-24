stack bytecodes
storeMaybeContextReceiverVariable: fieldIndex withValue: anObject
	"Must trap accesses to married and widowed contexts.
	 But don't want to check on all inst var accesses.  This
	 method is only used by the long-form bytecodes, evading the cost."
	| rcvr |
	rcvr := self receiver.
	((self isWriteMediatedContextInstVarIndex: fieldIndex)
	and: [(objectMemory isContextNonImm: rcvr)
	and: [self isMarriedOrWidowedContext: rcvr]])
		ifTrue:
			[self instVar: fieldIndex ofContext: rcvr put: anObject]
		ifFalse:
			[objectMemory storePointer: fieldIndex ofObject: rcvr withValue: anObject]
