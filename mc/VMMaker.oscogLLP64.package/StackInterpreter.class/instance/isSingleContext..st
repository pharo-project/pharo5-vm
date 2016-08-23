frame access
isSingleContext: aContext
	^objectMemory isNonImmediate: (objectMemory fetchPointer: SenderIndex ofObject: aContext)