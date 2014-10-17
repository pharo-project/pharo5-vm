process primitive support
primitiveRelinquishProcessor
	"This is a special version of the primitive used in an event-driven VM. It does not call host's
	ioRelinquishProcessor at all; instead it long jumps to the interpreter's jump target and
	exits to the host program. The interpreter will be reentered on the next event either
	user-induced or by timer"

	| microSecs |
	microSecs := self stackIntegerValue: 0.
	"DO NOT allow relinquishing the processor while we are profiling since this
	may skew the time base for our measures (it may reduce processor speed etc).
	Instead we go full speed, therefore measuring the precise time we spend in the
	inner idle loop as a busy loop."
	
	self pop: 1.  
	nextProfileTick = 0 ifTrue:[
				self ioRelinquishProcessorForMicroseconds: microSecs].
			