I/O primitives
primitiveInterruptSemaphore
	"Register the user interrupt semaphore. If the argument is 
	not a Semaphore, unregister the current interrupt 
	semaphore. "
	| arg |
	arg := self popStack.
	(objectMemory fetchClassOf: arg) = (objectMemory splObj: ClassSemaphore)
		ifTrue: [objectMemory splObj: TheInterruptSemaphore put: arg]
		ifFalse: [objectMemory splObj: TheInterruptSemaphore put: objectMemory nilObject]