process primitive support
cedeToHigherPriorityThreads
	"Invoked from checkForEventsMayContextSwitch: to switch threads if a thread
	 wanting to acquire the VM has higher priority than the active process."
	| activeProc ownerIndex activeContext activePriority activeThread vmThread |
	<var: #activeThread type: #'CogVMThread *'>
	<var: #vmThread type: #'CogVMThread *'>
	<inline: false>
	activeProc := self activeProcess.
	activePriority := self quickFetchInteger: PriorityIndex ofObject: activeProc.
	ownerIndex := self ownerIndexOfProcess: activeProc.
	ownerIndex = 0
		ifTrue: [activeThread := cogThreadManager currentVMThread]
		ifFalse: [activeThread := cogThreadManager vmThreadAt: ownerIndex].
	activeThread priority: activePriority.
	vmThread := cogThreadManager
					highestPriorityThreadIfHigherThan: activePriority
					expectedMax: maxWaitingPriority.
	(vmThread isNil					"no waiting thread of sufficiently high priority.  Do not switch."
	or: [vmThread = activeThread]) "The activeProcess needs to run on a different thread.  Leave this to
									  threadSwitchIfNecessary:from: in checkForEventsMayContextSwitch:"
		ifTrue:
			[maxWaitingPriority > activePriority ifTrue:
				[maxWaitingPriority := activePriority].
			 ^self].

	self assert: vmThread priority > activePriority.
	self assert: vmThread ~= cogThreadManager currentVMThread.
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer.

	maxWaitingPriority > vmThread priority ifTrue:
		[maxWaitingPriority := vmThread priority].
	statProcessSwitch := statProcessSwitch + 1.
	activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
	objectMemory storePointer: SuspendedContextIndex ofObject: activeProc withValue: activeContext.
	self ensurePushedInstructionPointer.
	self externalWriteBackHeadFramePointers.
	self putToSleep: activeProc yieldingIf: preemptionYields.
	"Transcript cr; print: #cedeToHighestPriorityThreadIfHigherThan:; cr.
	  self printExternalHeadFrame.
	  self print: 'ip: '; printHex: self instructionPointer. Transcript cr; flush."
	self returnToSchedulingLoopAndReleaseVMOrWakeThread: vmThread source: CSCheckEvents