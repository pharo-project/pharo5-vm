public api
wakeVMThreadFor: index
	"Transfer the VM to the thread with index.  Called from a thread that finds the
	 highest priority runnable process is bound to the thread with index index."
	<returnTypeC: #void>
	| vmThread |
	<var: #vmThread type: #'CogVMThread *'>
	self assert: (vmOwner > 0 and: [vmOwner ~= index]).
	self assert: index <= numThreads.
	self setVMOwner: index.
	vmThread := threads at: index.
	vmThread state = nil
		ifTrue: [self startThreadForThreadInfo: vmThread]
		ifFalse:
			[self assert: vmThread state = CTMWantingOwnership.
			 self ioSignalOSSemaphore: (self addressOf: vmThread osSemaphore)].
	self ioTransferTimeslice