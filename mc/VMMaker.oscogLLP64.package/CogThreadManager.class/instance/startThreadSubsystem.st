public api
startThreadSubsystem
	"Initialize the threading subsystem, aborting if there is an error."
	| vmThread |
	<var: #vmThread type: #'CogVMThread *'>
	<inline: false>
	self assert: threads = nil.
	vmOSThread := self ioCurrentOSThread.
	numThreadsIncrement := (self ioNumProcessors max: 2) min: 16.
	(self growThreadInfosToAtLeast: numThreadsIncrement * 2) ifFalse:
		[self error: 'no memory to start thread system'].
	vmThread := threads at: 1.
	vmThread state: CTMInitializing.
	self registerVMThread: vmThread.
	vmThread state: CTMAssignableOrInVM.
	self setVMOwner: 1