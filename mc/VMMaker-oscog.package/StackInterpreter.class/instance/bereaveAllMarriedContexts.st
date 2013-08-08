frame access
bereaveAllMarriedContexts
	"Enumerate all contexts and convert married contexts to widowed contexts so
	 that the snapshot contains only single contexts.  This allows the test for being
	 married to avoid checking for a context's frame pointer being in bounds.
	 Thanks to Greg Nuyens for this idea."
	| oop |
	<asmLabel: false>
	oop := objectMemory firstObject.
	[oop < objectMemory freeStart] whileTrue:
		[((objectMemory isFreeObject: oop) not
		   and: [(objectMemory isContextNonInt: oop)
		   and: [self isMarriedOrWidowedContext: oop]]) ifTrue:
			[self markContextAsDead: oop].
		 oop := objectMemory objectAfter: oop]