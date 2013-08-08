accessing
debugStackPointersFor: anOop
	^CArrayAccessor on:
		(((NewspeakVM
				ifTrue: [NewspeakStackDepthFinder]
				ifFalse: [StackDepthFinder]) on: (objectMap keyAtValue: anOop))
			stackPointers)