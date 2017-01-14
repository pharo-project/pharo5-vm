I/O primitives support
ioRelinquishProcessorForMicroseconds: microseconds
	"In the simulator give an indication that we're idling and check for input.
	 If called from machine code then increment the byte count since the clock
	 is derived from it and the clock will not advance otherwise.
	 If we're simulating threading we're in difficulties.  We need a UI process
	 (to run activities such as fill-in-the-blanks) but we also need an independent
	 thread of control to run this VM thread.  So we need to fork a new UI process."
	Display reverse: ((displayView
						ifNil: [0@0]
						ifNotNil: [displayView bounds origin]) extent: 16@16).
	Sensor peekEvent ifNotNil:
		[self forceInterruptCheck].
	Processor activeProcess == Project uiProcess ifTrue:
		[World doOneCycle].
	microseconds >= 1000
		ifTrue: [self isThreadedVM ifTrue:
					[self forceInterruptCheckFromHeartbeat].
				(Delay forMilliseconds: microseconds + 999 // 1000) wait]
		ifFalse: [Processor yield].
	byteCount := byteCount + (microseconds * ByteCountsPerMicrosecond) - 1.
	self incrementByteCount