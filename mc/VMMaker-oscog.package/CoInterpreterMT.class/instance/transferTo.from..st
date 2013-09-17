process primitive support
transferTo: newProc from: sourceCode
	"Record a process to be awoken on the next interpreter cycle.  Override to
	 potentially switch threads either if the new process is bound to another thread,
	 or if there is no runnable process but there is a waiting thread. Note that the
	 abort on no runnable process has beeen moved here from wakeHighestPriority."
	| sched oldProc activeContext vmThread |
	<inline: false>
	<var: #vmThread type: #'CogVMThread *'>
	statProcessSwitch := statProcessSwitch + 1.
	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer.
	"ensureMethodIsCogged: in makeBaseFrameFor: in
	 externalSetStackPageAndPointersForSuspendedContextOfProcess:
	 below may do a code compaction. Nil instructionPointer to avoid it getting pushed twice."
	instructionPointer := 0.
	sched := self schedulerPointer.
	oldProc := objectMemory fetchPointer: ActiveProcessIndex ofObject: sched.
	self recordContextSwitchFrom: oldProc in: sourceCode.
	activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
	objectMemory storePointer: SuspendedContextIndex ofObject: oldProc withValue: activeContext.

	newProc isNil ifTrue:
		["Two possibilities.  One, there is at least one thread waiting to own the VM in which
		  case it should be activated.  Two, there are no processes to run and so abort."
		 vmThread := self willingVMThread.
		 (vmThread notNil and: [vmThread state = CTMWantingOwnership]) ifTrue:
			[self returnToSchedulingLoopAndReleaseVMOrWakeThread: vmThread source: sourceCode].
		self error: 'scheduler could not find a runnable process'].

	objectMemory storePointer: ActiveProcessIndex ofObject: sched withValue: newProc.
	objectMemory storePointerUnchecked: MyListIndex ofObject: newProc withValue: objectMemory nilObject.

	self threadSwitchIfNecessary: newProc from: sourceCode.

	self externalSetStackPageAndPointersForSuspendedContextOfProcess: newProc