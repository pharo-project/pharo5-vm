debugging traps
createActualMessageTo: class

	class = objectMemory nilObject ifTrue: [self halt].

	^super createActualMessageTo: class