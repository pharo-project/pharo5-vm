I/O primitives support
stackLimitFromMachineCode
	"Intercept accesses to the stackLimit from machine code to
	 increment byteCount so that ioMSecs/ioMicroseconds does
	 somethng reasonable when we're purely in machine code."
	(byteCount := byteCount + 1) - lastPollCount >= 100 ifTrue:
		[lastPollCount := byteCount.
		 (Sensor peekEvent notNil
		  or: [nextProfileTick > 0
			  and: [nextProfileTick <= self ioUTCMicroseconds]]) ifTrue:
			[suppressHeartbeatFlag "gets set by selector breakpoints"
				ifTrue: [self forceInterruptCheck]
				ifFalse: [self forceInterruptCheckFromHeartbeat]]].
	^stackLimit