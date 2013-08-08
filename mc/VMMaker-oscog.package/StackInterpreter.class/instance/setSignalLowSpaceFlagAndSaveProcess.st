process primitive support
setSignalLowSpaceFlagAndSaveProcess
	"The low space semaphore is about to be signaled. Set the signalLowSpace flag,
	 and force an interrupt check.  Save the currently active process in the special
	 objects array so that the low space handler will be able to determine the process
	 that first triggered a low space condition. The image's low space handler is expected
	 to nil out the special objects array slot when it handles the low space condition."

	| lastSavedProcess activeProc |
	<inline: false>
	DumpStackOnLowSpace ~= 0 ifTrue:
		[self printCallStack.
		 self printAllStacks].
	objectMemory signalLowSpace: true.
	objectMemory lowSpaceThreshold: 0. "disable additional interrupts until lowSpaceThreshold is reset by image"
	lastSavedProcess := objectMemory splObj: ProcessSignalingLowSpace.
	lastSavedProcess = objectMemory nilObject ifTrue:
		[activeProc := self activeProcess.
		objectMemory splObj: ProcessSignalingLowSpace put: activeProc].
	self forceInterruptCheck