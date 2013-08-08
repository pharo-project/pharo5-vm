debug support
debugStackPointersFor: aMethod
	^CArrayAccessor on:
		(((NewspeakVM
			ifTrue: [NewspeakStackDepthFinder]
			ifFalse: [StackDepthFinder]) on: (VMCompiledMethodProxy new
									for: aMethod
									coInterpreter: self
									objectMemory: objectMemory))
			stackPointers)