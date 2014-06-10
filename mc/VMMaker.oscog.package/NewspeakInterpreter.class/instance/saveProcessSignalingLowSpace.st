processes
saveProcessSignalingLowSpace
	"The low space semaphore is about to be signaled. Save the currently active
	process in the special objects array so that the low space handler will be able
	to determine the process that first triggered a low space condition. The low
	space handler (in the image) is expected to nil out the special objects array
	slot when it handles the low space condition."

	| lastSavedProcess currentProc |
	lastSavedProcess := self splObj: ProcessSignalingLowSpace.
	(lastSavedProcess == self nilObject) ifTrue:
		[currentProc := self activeProcess.
		self storePointer: ProcessSignalingLowSpace ofObject: specialObjectsOop withValue: currentProc]