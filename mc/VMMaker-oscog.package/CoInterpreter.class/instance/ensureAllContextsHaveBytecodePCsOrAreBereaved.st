frame access
ensureAllContextsHaveBytecodePCsOrAreBereaved
	"Enumerate all contexts preparing them for a snapshot.  Map all native pcs to bytecoded pcs.
	 Convert widowed contexts to single contexts so that the snapshot contains only single contexts.
	 This allows the being married test to avoid checking for a context's frame pointer being in bounds
	 since all frame pointers must have been created in the current system and so be in bounds.
	 Thanks to Greg Nuyens for this idea."
	| oop decodedIP |
	oop := objectMemory firstObject.
	[oop < objectMemory freeStart] whileTrue:
		[((objectMemory isFreeObject: oop) not
		   and: [objectMemory isContextNonInt: oop]) ifTrue:
			[(self isMarriedOrWidowedContext: oop)
				ifTrue: "The stack pages have already been discarded.  Any remaining married contexts are actually widows."
					[self markContextAsDead: oop]
				ifFalse:
					[decodedIP := objectMemory fetchPointer: InstructionPointerIndex ofObject: oop.
					((objectMemory isIntegerObject: decodedIP)
					 and: [decodedIP signedIntFromLong < 0]) ifTrue:
						[decodedIP := self mustMapMachineCodePC: (objectMemory integerValueOf: decodedIP)
											context: oop.
						 objectMemory storePointerUnchecked: InstructionPointerIndex ofObject: oop withValue: decodedIP]]].
		 oop := objectMemory objectAfter: oop]