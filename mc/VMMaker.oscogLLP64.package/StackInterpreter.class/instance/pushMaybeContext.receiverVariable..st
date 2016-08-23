stack bytecodes
pushMaybeContext: obj receiverVariable: fieldIndex
	"Must trap accesses to married and widowed contexts.
	 But don't want to check on all inst var accesses.  This
	 method is only used by the long-form bytecodes, evading
	 the cost. Note that the method, closure and receiver fields
	 of married contexts are correctly initialized so they don't
	 need special treatment on read.  Only sender, instruction
	 pointer and stack pointer need to be intercepted on reads."
	<inline: true>
	((self isReadMediatedContextInstVarIndex: fieldIndex)
	and: [objectMemory isContextNonImm: obj])
		ifTrue:
			[self internalPush: (self instVar: fieldIndex ofContext: obj)]
		ifFalse:
			[self internalPush: (objectMemory fetchPointer: fieldIndex ofObject: obj)]