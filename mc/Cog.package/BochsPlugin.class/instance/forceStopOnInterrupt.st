interruption
forceStopOnInterrupt
	<returnTypeC: #void>
	interpreterProxy getInterruptPending ifTrue:
		[self forceStopRunning]