frame access
isLiveContext: oop
	"Answer if the argument, which can be any object, is a live context."
	(objectMemory isContext: oop) ifFalse:
		[^false].
	(self isSingleContext: oop) ifTrue:
		[^objectMemory isIntegerObject: (objectMemory fetchPointer: InstructionPointerIndex ofObject: oop)].
	^(self isWidowedContext: oop) not