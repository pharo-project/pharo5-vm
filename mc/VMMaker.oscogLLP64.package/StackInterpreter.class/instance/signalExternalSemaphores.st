process primitive support
signalExternalSemaphores
	"Signal all requested semaphores.  Answer if a context switch has occurred."
	| xArray |
	xArray := objectMemory splObj: ExternalObjectsArray.
	^self doSignalExternalSemaphores: (objectMemory numSlotsOf: xArray)