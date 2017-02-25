process primitive support
threadSwitchIfNecessary: newProc from: sourceCode
	"Invoked from transferTo:from: to switch threads if the new process is bound or affined to some other thread."
	| newProcThreadId vmThread activeContext tlti vmo |
	<var: #vmThread type: #'CogVMThread *'>
	self cCode: []
		inSmalltalk:
			[vmo := cogThreadManager getVMOwner.
			 tlti := cogThreadManager ioGetThreadLocalThreadIndex.
			 self assert: vmo = tlti].
	deferThreadSwitch ifTrue: [^self].
	newProcThreadId := self ownerIndexOfProcess: newProc.
	((activeProcessAffined := newProcThreadId ~= 0)
	 and: [newProcThreadId ~= cogThreadManager getVMOwner]) ifTrue:
		[self cCode: ''
			inSmalltalk:
				[self transcript ensureCr; nextPutAll: #threadSwitchIfNecessary:from:; space; print: newProc;
								space; print: vmo; nextPutAll: '->'; print: newProcThreadId; cr; flush].
		 "If primitiveProcessBindToThreadId has bound a process and indicated a thread
		  switch is necessary we'll come in here but the activeProcess won't have a
		  context yet, and it needs one from which the new thread can resume execution."
		 (objectMemory fetchPointer: SuspendedContextIndex ofObject: newProc) = objectMemory nilObject ifTrue:
			[self assert: newProc = self activeProcess.
			 self push: instructionPointer.
			 self externalWriteBackHeadFramePointers.
			 activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
			 objectMemory storePointer: SuspendedContextIndex ofObject: newProc withValue: activeContext].
		 vmThread := cogThreadManager vmThreadAt: newProcThreadId.
		 vmThread priority: (self quickFetchInteger: PriorityIndex ofObject: newProc).
		 vmThread state = CTMUnavailable ifTrue:
				[vmThread state: CTMWantingOwnership].
		 self returnToSchedulingLoopAndReleaseVMOrWakeThread: vmThread source: CSSwitchIfNeccessary].
	(self quickFetchInteger: PriorityIndex ofObject: newProc) < maxWaitingPriority ifTrue:
		[checkThreadActivation := true.
		 self forceInterruptCheck]