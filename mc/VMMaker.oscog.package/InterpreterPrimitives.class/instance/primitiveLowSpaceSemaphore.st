memory space primitives
primitiveLowSpaceSemaphore
	"Register the low-space semaphore. If the argument is not a 
	 Semaphore, unregister the current low-space Semaphore."
	| arg |
	arg := self stackTop.
	(arg = objectMemory nilObject
	 or: [objectMemory isSemaphoreOop: arg])
		ifTrue:
			[objectMemory splObj: TheLowSpaceSemaphore put: arg.
			 self pop: 1]
		ifFalse:
			[self primitiveFailFor: PrimErrBadArgument]