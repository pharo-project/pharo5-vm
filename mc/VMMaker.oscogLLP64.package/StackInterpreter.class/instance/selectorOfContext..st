debug printing
selectorOfContext: aContext
	(objectMemory isContext: aContext) ifFalse:
		[^nil].
	^self findSelectorOfMethod: (objectMemory fetchPointer: MethodIndex ofObject: aContext)