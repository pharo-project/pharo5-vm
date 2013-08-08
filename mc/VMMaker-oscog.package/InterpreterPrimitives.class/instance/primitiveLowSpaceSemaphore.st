memory space primitives
primitiveLowSpaceSemaphore
	"Register the low-space semaphore. If the argument is not a 
	Semaphore, unregister the current low-space Semaphore."
	| arg |
	arg := self popStack.
	(objectMemory fetchClassOf: arg) = (objectMemory splObj: ClassSemaphore)
		ifTrue: [objectMemory splObj: TheLowSpaceSemaphore put: arg]
		ifFalse: [objectMemory splObj: TheLowSpaceSemaphore put: objectMemory nilObject]