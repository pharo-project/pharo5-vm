I/O primitives
primitiveRelinquishProcessor
	"Relinquish the processor for up to the given number of microseconds. The exact behavior of this primitive is platform dependent."

	| microSecs |
	microSecs := self stackIntegerValue: 0.
	self successful ifTrue: [
		self ioRelinquishProcessorForMicroseconds: microSecs.
		self pop: 1]  "microSecs; leave rcvr on stack"
