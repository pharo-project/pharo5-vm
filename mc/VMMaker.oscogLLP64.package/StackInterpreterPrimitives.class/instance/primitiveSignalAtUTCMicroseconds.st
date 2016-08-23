system control primitives
primitiveSignalAtUTCMicroseconds
	"Cause the time semaphore, if one has been registered, to be
	 signalled when the microsecond clock is greater than or equal to
	 the given tick value. A tick value of zero turns off timer interrupts."
	| usecsObj sema usecs |
	<var: #usecs type: #usqLong>
	usecsObj := self stackTop.
	sema := self stackValue: 1.
	usecs := self positive64BitValueOf: usecsObj.
	self successful ifTrue:
		[(objectMemory isSemaphoreOop: sema) ifTrue:
			[objectMemory splObj: TheTimerSemaphore put: sema.
			 nextWakeupUsecs := usecs.
			 ^self pop: 2].
		 sema = objectMemory nilObject ifTrue:
			[objectMemory
				storePointer: TheTimerSemaphore
				ofObject: objectMemory specialObjectsOop
				withValue: objectMemory nilObject.
			 nextWakeupUsecs := 0.
			 ^self pop: 2]].
	self primitiveFailFor: PrimErrBadArgument