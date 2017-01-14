vm scheduling
threadSchedulingLoop: vmThread
	"Enter a loop attempting to run the VM with the highest priority process and
	 blocking on the thread's OS semaphore when unable to run that process.
	 We will return to this via threadSwitchIfNecessary:from: which is called in the
	 middle of transferTo:from: once the active process has been stored in the scheduler."
	<var: #vmThread type: #'CogVMThread *'>
	| attemptToRun |
	<inline: false>
	[self assert: vmThread state = CTMAssignableOrInVM.
	 attemptToRun := false.
	 (cogThreadManager getVMOwner = vmThread index)
		ifTrue: [attemptToRun := true]
		ifFalse:
			[(cogThreadManager tryLockVMToIndex: vmThread index) ifTrue:
				["If relinquishing is true, then primitiveRelinquishProcessor has disowned the
				  VM and only a returning call or callback should take ownership in that case."
				 relinquishing
					ifTrue: [cogThreadManager releaseVM]
					ifFalse: [attemptToRun := true]]].
	 attemptToRun ifTrue:
		[self tryToExecuteSmalltalk: vmThread].
	 (cogThreadManager testVMOwnerIs: vmThread index) ifFalse:
		[cogThreadManager waitForWork: vmThread].
	 true] whileTrue