process primitive support
signalFinalization: weakReferenceOop
	"Record the fact that there is at least one object to finalize
	 and cause the VM to check for interrupts at the earliest
	 opportunity. The finalization semaphore will actually be
	 signalled once in checkForEventsMayContextSwitch:"

	self forceInterruptCheck.
	pendingFinalizationSignals := pendingFinalizationSignals + 1