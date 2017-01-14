I/O primitives
primitiveInterruptSemaphore
	"Register the user interrupt semaphore. If the argument is 
	not a Semaphore, unregister the current interrupt 
	semaphore. "
	| arg |
	arg := self stackTop.
	(arg = objectMemory nilObject
	 or: [objectMemory isSemaphoreOop: arg])
		ifTrue:
			[objectMemory splObj: TheInterruptSemaphore put: arg.
			 self pop: 1]
		ifFalse:
			[self primitiveFailFor: PrimErrBadArgument]