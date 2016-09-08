frame access
isLiveContext: oop
	"Answer if the argument, which can be any object, is a live context."
	self deny: (objectMemory isOopForwarded: oop).
	(objectMemory isContext: oop) ifFalse:
		[^false].
	(self isSingleContext: oop) ifTrue:
		[^objectMemory isIntegerObject: (objectMemory fetchPointer: InstructionPointerIndex ofObject: oop)].
	^(self isWidowedContext: oop) not