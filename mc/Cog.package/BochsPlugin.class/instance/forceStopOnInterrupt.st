interruption
forceStopOnInterrupt
	interpreterProxy getInterruptPending ifTrue:
		[self forceStopRunning]