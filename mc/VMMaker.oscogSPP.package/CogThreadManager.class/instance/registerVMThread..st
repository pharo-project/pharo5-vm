scheduling
registerVMThread: vmThread
	"Register the current thread in the set of threads, initializing the supplied
	 vmThread and setting the thread's thread block index there-to."
	<var: #vmThread type: #'CogVMThread *'>
	<returnTypeC: #'CogVMThread *'>
	self assert: (vmThread state = CTMInitializing
				or: [vmThread state = CTMWantingOwnership]).
	vmThread osThread: self ioCurrentOSThread.
	self ioSetThreadLocalThreadIndex: vmThread index.
	self assert: self ioGetThreadLocalThreadIndex = vmThread index.
	^vmThread