public api
acquireVMFor: threadIndex
	"Attempt to acquire the VM, eventually blocking until it becomes available.
	 Spin until the maxWaitingPriority has been updated if it is lower than this thread's priority."
	<returnTypeC: #'CogVMThread *'>
	| vmThread |
	<var: #vmThread type: #'CogVMThread *'>
	self assert: threadIndex = self ioGetThreadLocalThreadIndex.
	vmThread := self vmThreadAt: threadIndex.
	self assert: (vmThread state = CTMUnavailable
				or: [vmThread state = CTMWantingOwnership]).
	(self tryLockVMToIndex: threadIndex) ifFalse:
		[vmThread state: CTMWantingOwnership.
		 [self tryLockVMToIndex: threadIndex] whileFalse:
			[[coInterpreter getMaxWaitingPriority < vmThread priority] whileTrue:
				[cogit tryLockVMOwner ifTrue:
					[coInterpreter waitingPriorityIsAtLeast: vmThread priority.
					 cogit unlockVMOwner]].
			vmOwner ~= threadIndex ifTrue:
				[self ioWaitOnOSSemaphore: (self addressOf: vmThread osSemaphore)]]].
	vmOSThread := vmThread osThread.
	vmThread state: CTMAssignableOrInVM.
	^vmThread