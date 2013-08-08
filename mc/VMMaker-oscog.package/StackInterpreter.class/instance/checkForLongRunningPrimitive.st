primitive support
checkForLongRunningPrimitive
	"Called from forceInterruptCheckFromHeartbeat.  If the system has been running
	 the same primitive on two successive heartbeats then signal profileMethod."
	<inline: true>
	longRunningPrimitiveCheckSemaphore isNil ifTrue:
		[^nil].
	(longRunningPrimitiveStartUsecs > 0
	 and: [longRunningPrimitiveCheckMethod = newMethod
	 and: [longRunningPrimitiveCheckSequenceNumber = statCheckForEvents]]) ifTrue:
		[longRunningPrimitiveStopUsecs := self ioUTCMicroseconds.
		self assert: longRunningPrimitiveStopUsecs > longRunningPrimitiveStartUsecs.
		^nil].
	"See traceProfileState & mapProfileState."
	longRunningPrimitiveStopUsecs = 0 ifTrue:
		[longRunningPrimitiveCheckSequenceNumber := statCheckForEvents.
		 longRunningPrimitiveCheckMethod := newMethod.
		 longRunningPrimitiveStartUsecs := self ioUTCMicroseconds.
		 self sqLowLevelMFence]