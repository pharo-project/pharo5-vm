process primitive support
doSignalSemaphoreWithIndex: index
	"Signal the external semaphore with the given index.  Answer if a context switch
	 occurs as a result.  Do not bounds check.  This has been done in the caller."
	<api>
	| xArray sema |
	xArray := objectMemory splObj: ExternalObjectsArray.
	self assert: (objectMemory isArray: xArray).
	sema := objectMemory fetchPointer: index - 1 ofObject: xArray. "Note: semaphore indices are 1-based"
	self assert: (objectMemory isOopForwarded: sema) not.
	^(objectMemory isSemaphoreOop: sema)
	  and: [self synchronousSignal: sema]