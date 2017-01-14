initialization
initializeContextIndices
	super initializeContextIndices.

	HasBeenReturnedFromMCPC := -1.
	HasBeenReturnedFromMCPCOop := self objectMemoryClass basicNew integerObjectOf: HasBeenReturnedFromMCPC