process primitive support
doSignalSemaphoreWithIndex: index
	"Signal the external semaphore with the given index.  Answer if a context switch
	 occurs as a result.  Do not bounds check.  This has been done in the caller."
	<api>
	| xArray semaphoreClass sema |
	xArray := objectMemory splObj: ExternalObjectsArray.
	semaphoreClass := objectMemory splObj: ClassSemaphore.
	sema := objectMemory fetchPointer: index - 1 ofObject: xArray. "Note: semaphore indices are 1-based"
	^(objectMemory isNonIntegerObject: sema)
	   and: [(objectMemory fetchClassOfNonImm: sema) = semaphoreClass
	   and: [self synchronousSignal: sema]]