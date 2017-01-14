I/O primitives support
ioUTCStartMicroseconds
	"Answer the value of the microsecond clock at startup."

	^startMicroseconds ifNil:
		[self class initializationOptions
			at: #startMicroseconds
			ifAbsent: [[Time utcMicrosecondClock] on: Error do: [Time totalSeconds * 1000000]]]