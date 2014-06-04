accessing
debugStackPointersFor: anOop
	^CArrayAccessor on:
		(StackDepthFinder on: (objectMap keyAtValue: anOop))
			stackPointers