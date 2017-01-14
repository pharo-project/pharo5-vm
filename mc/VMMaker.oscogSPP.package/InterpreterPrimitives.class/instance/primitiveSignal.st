process primitives
primitiveSignal
	"Synchronously signal the semaphore.
	 This may change the active process as a result."
	self synchronousSignal: self stackTop