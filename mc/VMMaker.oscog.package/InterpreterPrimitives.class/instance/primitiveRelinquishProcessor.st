I/O primitives
primitiveRelinquishProcessor
	"Relinquish the processor for up to the given number of microseconds. The exact behavior of this primitive is platform dependent."

	| microSecs |
	microSecs := self stackIntegerValue: 0.
	self successful ifTrue: [
		"DO NOT allow relinquishing the processor while we are profiling since this
		may skew the time base for our measures (it may reduce processor speed etc).
		Instead we go full speed, therefore measuring the precise time we spend in the
		inner idle loop as a busy loop."
		nextProfileTick = 0 ifTrue:[self ioRelinquishProcessorForMicroseconds: microSecs].
		self pop: 1.  "microSecs; leave rcvr on stack"
	]