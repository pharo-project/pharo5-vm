debug support
debugStackPointersFor: aMethod
	^CArrayAccessor on:
		(StackDepthFinder on: (VMCompiledMethodProxy new
									for: aMethod
									coInterpreter: self
									objectMemory: objectMemory))
			stackPointers