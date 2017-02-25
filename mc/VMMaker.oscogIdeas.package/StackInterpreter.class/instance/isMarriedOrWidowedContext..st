frame access
isMarriedOrWidowedContext: aContext
	^objectMemory isIntegerObject: (objectMemory fetchPointer: SenderIndex ofObject: aContext)