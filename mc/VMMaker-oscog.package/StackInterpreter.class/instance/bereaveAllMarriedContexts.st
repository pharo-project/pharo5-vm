frame access
bereaveAllMarriedContexts
	"Enumerate all contexts and convert married contexts to widowed contexts so
	 that the snapshot contains only single contexts.  This allows the test for being
	 married to avoid checking for a context's frame pointer being in bounds.
	 Thanks to Greg Nuyens for this idea."
	<asmLabel: false>
	objectMemory allObjectsDo:
		[:obj|
		((objectMemory isContextNonImm: obj)
		  and: [self isMarriedOrWidowedContext: obj]) ifTrue:
			[self markContextAsDead: obj]]