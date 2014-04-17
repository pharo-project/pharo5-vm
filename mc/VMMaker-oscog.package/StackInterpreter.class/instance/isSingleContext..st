frame access
isSingleContext: aContext
	^objectMemory isNonIntegerObject: (objectMemory fetchPointer: SenderIndex ofObject: aContext)