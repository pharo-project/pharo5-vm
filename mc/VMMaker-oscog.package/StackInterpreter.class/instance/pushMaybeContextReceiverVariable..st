stack bytecodes
pushMaybeContextReceiverVariable: fieldIndex
	"Must trap accesses to married and widowed contexts.
	 But don't want to check on all inst var accesses.  This
	 method is only used by the long-form bytecodes, evading
	 the cost. Note that the method, closure and receiver fields
	 of married contexts are correctly initialized so they don't
	 need special treatment on read.  Only sender, instruction
	 pointer and stack pointer need to be intercepted on reads."
	| rcvr |
	<inline: true>
	rcvr := self receiver.
	((self isReadMediatedContextInstVarIndex: fieldIndex)
	and: [objectMemory isContextNonImm: rcvr])
		ifTrue:
			[self internalPush: (self instVar: fieldIndex ofContext: rcvr)]
		ifFalse:
			[self internalPush: (objectMemory fetchPointer: fieldIndex ofObject: rcvr)]