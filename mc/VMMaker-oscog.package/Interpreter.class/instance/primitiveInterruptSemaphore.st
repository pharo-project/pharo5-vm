I/O primitives
primitiveInterruptSemaphore
	"Register the user interrupt semaphore. If the argument is 
	not a Semaphore, unregister the current interrupt 
	semaphore. "
	| arg |
	arg := self popStack.
	(self fetchClassOf: arg) = (self splObj: ClassSemaphore)
		ifTrue: [self storePointer: TheInterruptSemaphore ofObject: specialObjectsOop withValue: arg]
		ifFalse: [self storePointer: TheInterruptSemaphore ofObject: specialObjectsOop withValue: nilObj]