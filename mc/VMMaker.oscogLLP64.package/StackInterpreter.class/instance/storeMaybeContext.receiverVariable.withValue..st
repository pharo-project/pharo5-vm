stack bytecodes
storeMaybeContext: obj receiverVariable: fieldIndex withValue: anObject
	"Must trap accesses to married and widowed contexts.
	 But don't want to check on all inst var accesses.  This
	 method is only used by the long-form bytecodes, evading the cost."
	<inline: true>
	((self isWriteMediatedContextInstVarIndex: fieldIndex)
	and: [(objectMemory isContextNonImm: obj)
	and: [self isMarriedOrWidowedContext: obj]])
		ifTrue:
			[self instVar: fieldIndex ofContext: obj put: anObject]
		ifFalse:
			[objectMemory storePointerImmutabilityCheck: fieldIndex ofObject: obj withValue: anObject]
