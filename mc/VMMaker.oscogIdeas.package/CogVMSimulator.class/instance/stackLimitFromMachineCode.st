I/O primitives support
stackLimitFromMachineCode
	"Intercept accesses to the stackLimit from machine code to increment byteCount so that
	 ioMSecs/ioMicroseconds does something reasonable when we're purely in machine code.
	 Force an interrupt check every 2 ms in simulated time (2ms = the default heartbeat), or if
	 the profile tick has expired.."

	(byteCount := byteCount + 1) - lastPollCount >= (2000 * ByteCountsPerMicrosecond) ifTrue:
		[lastPollCount := byteCount].
	(lastPollCount = byteCount
	 or: [nextProfileTick > 0 and: [nextProfileTick <= self ioUTCMicroseconds]]) ifTrue:
		[suppressHeartbeatFlag "gets set by selector breakpoints"
			ifTrue: [self forceInterruptCheck]
			ifFalse: [self forceInterruptCheckFromHeartbeat]].
	^stackLimit