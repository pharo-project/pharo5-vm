vm scheduling
ownVMFromUnidentifiedThread
	"Attempt to take ownership from a thread that as yet doesn't know its index.
	 This supports callbacks where the callback could originate from any thread.
	
	 Answer 0 if the owning thread is known to the VM.
	 Answer 1 if the owning thread is unknown to the VM and now owns the VM.
	 Answer -1 if the owning thread is unknown to the VM and fails to own the VM.
	 Answer -2 if the owning thread is unknown to the VM and there is no foreign callback process installed."
	| count threadIndex vmThread |
	<var: #vmThread type: #'CogVMThread *'>
	<inline: false>
	(threadIndex := cogThreadManager ioGetThreadLocalThreadIndex) ~= 0 ifTrue:
		[ "this is a callback from a known thread"
		 threadIndex = cogThreadManager getVMOwner ifTrue: "the VM has not been disowned"
			[self assert: (disowningVMThread isNil or: [disowningVMThread = self currentVMThread]).
			 disowningVMThread := nil.
			 self currentVMThread state: CTMAssignableOrInVM.
			 ^VMAlreadyOwnedHenceDoNotDisown].
		 ^self ownVM: threadIndex].
	foreignCallbackPriority = 0 ifTrue:
		[^-2].
	count := 0.
	"If the current thread doesn't have an index it's new to the vm
	 and we need to allocate a new threadInfo, failing if we can't.
	 We also need a process in the foreignCallbackProcessSlot upon
	 which to run the thread's eventual callback."
	[[cogThreadManager tryLockVMToIndex: -1] whileFalse:
		[self waitingPriorityIsAtLeast: foreignCallbackPriority. 
		cogThreadManager ioTransferTimeslice].
	 (objectMemory splObj: foreignCallbackProcessSlot) ~= objectMemory nilObject] whileFalse:
		[cogThreadManager releaseVM.
		 (count := count + 1) > 1000 ifTrue:
			[^-2].
		 cogThreadManager ioMilliSleep: 1].
	vmThread := cogThreadManager unusedThreadInfo.
	"N.B.  Keep the VM locked anonymously so that we reserve the non-nil ForeignCallbackProcess
	for this thread, avoiding the race between competing foreign callbacks.  The acquireVMFor: in
	ownVM: will set the vmOwner to the actual index.  So only unlock on failure."
	vmThread isNil ifTrue:
		[cogThreadManager releaseVM.
		^-1].
	vmThread
		state: CTMWantingOwnership;
		priority: foreignCallbackPriority.
	cogThreadManager registerVMThread: vmThread.
	^self ownVM: vmThread index + OwnVMForeignThreadFlag