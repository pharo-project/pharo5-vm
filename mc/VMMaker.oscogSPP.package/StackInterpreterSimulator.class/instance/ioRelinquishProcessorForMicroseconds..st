I/O primitives support
ioRelinquishProcessorForMicroseconds: microseconds
	"In the simulator give an indication that we're idling and check for input."
	Display reverse: ((displayView
						ifNil: [0@0]
						ifNotNil: [displayView bounds origin]) extent: 16@16).
	Sensor peekEvent ifNotNil:
		[self forceInterruptCheck].
	Processor activeProcess == Project uiProcess ifTrue:
		[World doOneCycle].
	microseconds >= 1000
		ifTrue: [(Delay forMilliseconds: microseconds + 999 // 1000) wait]
		ifFalse: [Processor yield].
	"And increase the byteCount form which the microsecond clock is derived..."
	byteCount := byteCount + microseconds - 1.
	self incrementByteCount