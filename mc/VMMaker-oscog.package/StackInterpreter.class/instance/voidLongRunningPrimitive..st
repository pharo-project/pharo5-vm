primitive support
voidLongRunningPrimitive: reason
	"Void the state associated with the long-running primitive check.
	 This is done when a new semaphore is installed or when it appears
	 that is longRunningPrimitiveCheckMethod is invalid, e.g. because it
	 has eben sampled in the middle of a GC."
	<var: #reason type: #'char *'>
	<inline: false>
	longRunningPrimitiveCheckMethod := nil.
	longRunningPrimitiveCheckSequenceNumber = 0. "not strictly necessary but prevents this being inlined into checkForLongRunningPrimitive"
	longRunningPrimitiveStartUsecs :=
	longRunningPrimitiveStopUsecs := 0.
	longRunningPrimitiveSignalUndelivered := true.
	self sqLowLevelMFence