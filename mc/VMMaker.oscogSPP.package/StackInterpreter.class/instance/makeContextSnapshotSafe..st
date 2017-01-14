frame access
makeContextSnapshotSafe: ctxt
	"Convert married contexts to widowed contexts, and in the CoInterpreter,
	 map any machine code pcs to bytecode pcs, and then nil all slots beyond
	 top of stack, so that the context can be resumed on any VM."
	<inline: false>
	self assert: (objectMemory isContext: ctxt).
	"The stack pages have already been discarded.  Any remaining married contexts are actually widows."
	(self isMarriedOrWidowedContext: ctxt)
		ifTrue: [self markContextAsDead: ctxt]
		ifFalse: [self ensureContextHasBytecodePC: ctxt].
	 "Fill slots beyond top of stack with nil"
	 (self fetchStackPointerOf: ctxt) + CtxtTempFrameStart
		to: (objectMemory numSlotsOf: ctxt) - 1
		do: [:i |
			 objectMemory
				storePointerUnchecked: i
				ofObject: ctxt
				withValue: objectMemory nilObject]