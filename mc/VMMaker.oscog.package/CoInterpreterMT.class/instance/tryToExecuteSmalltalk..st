vm scheduling
tryToExecuteSmalltalk: vmThread
	"Attempt to run the current process, if it exists, on the given vmThread."
	<var: #vmThread type: #'CogVMThread *'>
	| dvmt activeProc ownerIndex |
	<var: #dvmt type: #'CogVMThread *'>
	self assert: cogThreadManager getVMOwner = vmThread index.
	self assert: cogThreadManager ioGetThreadLocalThreadIndex = vmThread index.
	dvmt := disowningVMThread.
	disowningVMThread
		ifNil: [activeProc := self activeProcess]
		ifNotNil:
			[self preemptDisowningThread.
			 activeProc := self wakeHighestPriority.
			 activeProc
				ifNil: [activeProc := objectMemory nilObject]
				ifNotNil: [objectMemory
							storePointerUnchecked: MyListIndex
							ofObject: activeProc
							withValue: objectMemory nilObject].
			 objectMemory
				storePointer: ActiveProcessIndex
				ofObject: self schedulerPointer
				withValue: activeProc].
	activeProc = objectMemory nilObject ifTrue:
		[cogThreadManager releaseVM.
		 ^nil].
	ownerIndex := self ownerIndexOfProcess: activeProc.
	(ownerIndex = 0
	 or: [ownerIndex ~= 0 and: [ownerIndex = cogThreadManager getVMOwner]])
		ifTrue:
			[self assert: (objectMemory fetchPointer: MyListIndex ofObject: self activeProcess) = objectMemory nilObject.
			 (objectMemory fetchPointer: SuspendedContextIndex ofObject: activeProc) ~= objectMemory nilObject ifTrue:
				[self externalSetStackPageAndPointersForSuspendedContextOfProcess: activeProc].
			 self enterSmalltalkExecutive.
			 "When we return here we should have already given up
			  the VM and so we cannot touch any interpreter state."]
		ifFalse:
			[cogThreadManager wakeVMThreadFor: ownerIndex]