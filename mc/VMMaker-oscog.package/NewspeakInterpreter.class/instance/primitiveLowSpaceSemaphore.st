memory space primitives
primitiveLowSpaceSemaphore
	"Register the low-space semaphore. If the argument is not a 
	Semaphore, unregister the current low-space Semaphore."
	| arg |
	arg := self popStack.
	(self fetchClassOf: arg) = (self splObj: ClassSemaphore)
		ifTrue: [self storePointer: TheLowSpaceSemaphore ofObject: specialObjectsOop withValue: arg]
		ifFalse: [self storePointer: TheLowSpaceSemaphore ofObject: specialObjectsOop withValue: nilObj]