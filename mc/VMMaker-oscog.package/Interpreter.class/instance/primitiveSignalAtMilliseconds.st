system control primitives
primitiveSignalAtMilliseconds
	"Cause the time semaphore, if one has been registered, to
	be signalled when the millisecond clock is greater than or
	equal to the given tick value. A tick value of zero turns off
	timer interrupts."
	| tick sema |
	tick := self popInteger.
	sema := self popStack.
	successFlag
		ifTrue: [(self fetchClassOf: sema) = (self splObj: ClassSemaphore)
				ifTrue: [self
						storePointer: TheTimerSemaphore
						ofObject: specialObjectsOop
						withValue: sema.
					nextWakeupTick := tick]
				ifFalse: [self
						storePointer: TheTimerSemaphore
						ofObject: specialObjectsOop
						withValue: nilObj.
					nextWakeupTick := 0]]
		ifFalse: [self unPop: 2]