frame access
ensureContextHasBytecodePC: aContext
	"Make sure the context has a byetcode pc.  Can only be used on single contexts."
	| pc |
	self assert: (self isMarriedOrWidowedContext: aContext) not.
	pc := objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext.
	((objectMemory isIntegerObject: pc)
	 and: [(pc := objectMemory integerValueOf: pc) < 0]) ifTrue:
		[pc := self mustMapMachineCodePC: pc context: aContext.
		 objectMemory storePointerUnchecked: InstructionPointerIndex ofObject: aContext withValue: pc]