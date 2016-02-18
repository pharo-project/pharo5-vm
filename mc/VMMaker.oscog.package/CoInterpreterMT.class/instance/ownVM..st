vm scheduling
ownVM: threadIndexAndFlags
	<api>
	<inline: false>
	"This is the entry-point for plugins and primitives that wish to reacquire the VM after having
	 released it via disownVM or callbacks that want to acquire it without knowing their ownership
	 status.  This call will block until the VM is owned by the current thread or an error occurs.
	 The argument should be the value answered by disownVM, or 0 for callbacks that don't know
	 if they have disowned or not.  This is both an optimization to avoid having to query thread-
	 local storage for the current thread's index (since it can easily keep it in some local variable),
	 and a record of when an unbound process becomes affined to a thread for the dynamic
	 extent of some operation.

	 Answer 0 if the current thread is known to the VM.
	 Answer 1 if the current thread is unknown to the VM and takes ownership.
	 Answer -1 if the current thread is unknown to the VM and fails to take ownership."
	| threadIndex flags vmThread myProc activeProc sched |
	<var: #vmThread type: #'CogVMThread *'>
	threadIndexAndFlags = 0 ifTrue:
		[^self ownVMFromUnidentifiedThread].
	threadIndex := threadIndexAndFlags bitAnd: ThreadIdMask.
	flags := threadIndexAndFlags >> DisownFlagsShift.
	(flags anyMask: DisownVMForProcessorRelinquish) ifTrue:
		[relinquishing := false.
		 self sqLowLevelMFence].
	(threadIndexAndFlags anyMask: LockGUIThreadFlag) ifTrue:
		[self assert: (noThreadingOfGUIThread and: [self inGUIThread]).
		 self assert: disowningVMThread = nil.
		 (flags anyMask: DisownVMLockOutFullGC) ifTrue:
			[objectMemory decrementFullGCLock].
		 cogit recordEventTrace ifTrue:
			[self recordTrace: TraceOwnVM thing: ConstZero source: 0].
		 ^0].

	vmThread := cogThreadManager acquireVMFor: threadIndex.
	disownCount := disownCount - 1.

	(flags anyMask: DisownVMLockOutFullGC) ifTrue:
		[objectMemory decrementFullGCLock].
	disowningVMThread notNil ifTrue:
		[vmThread = disowningVMThread ifTrue:
			[self cCode: ''
				inSmalltalk:
					[| range |
					 range := self cStackRangeForThreadIndex: threadIndex.
					 self assert: (range includes: cogit getCStackPointer).
					 self assert: (range includes: cogit getCFramePointer)].
			 self assert: self successful.
			 self assert: (objectMemory fetchPointer: MyListIndex ofObject: self activeProcess) = objectMemory nilObject.
			 disowningVMThread := nil.
			 cogit recordEventTrace ifTrue:
				[self recordTrace: TraceOwnVM thing: ConstOne source: 0].
			 ^0].  "if not preempted we're done."
		self preemptDisowningThread].
	"We've been preempted; we must restore state and update the threadId
	 in our process, and may have to put the active process to sleep."
	sched := self schedulerPointer.
	activeProc := objectMemory fetchPointer: ActiveProcessIndex ofObject: sched.
	(threadIndexAndFlags anyMask: OwnVMForeignThreadFlag)
		ifTrue:
			[self assert: foreignCallbackProcessSlot == ForeignCallbackProcess.
			 myProc := objectMemory splObj: foreignCallbackProcessSlot.
			self assert: myProc ~= objectMemory nilObject.
			objectMemory splObj: foreignCallbackProcessSlot put: objectMemory nilObject]
		ifFalse: [myProc := cogThreadManager popAWOLProcess: vmThread].
	self assert: activeProc ~= myProc.
	(activeProc ~= objectMemory nilObject
	 and: [(objectMemory fetchPointer: MyListIndex ofObject: activeProc) = objectMemory nilObject]) ifTrue:
		[self putToSleep: activeProc yieldingIf: preemptionYields].
	self assert: (objectMemory fetchPointer: MyListIndex ofObject: myProc) = (objectMemory splObj: ProcessInExternalCodeTag).
	objectMemory
		storePointer: ActiveProcessIndex ofObject: sched withValue: myProc;
		storePointerUnchecked: MyListIndex ofObject: myProc withValue: objectMemory nilObject.
	"Only unaffine if the process was affined at this level and did not become bound in the interim."
	((threadIndexAndFlags anyMask: ProcessUnaffinedOnDisown)
	 and: [(self isBoundProcess: myProc) not]) ifTrue:
		[self setOwnerIndexOfProcess: myProc to: 0 bind: false].
	self initPrimCall.
	self externalSetStackPageAndPointersForSuspendedContextOfProcess: myProc.
	"If this primitive is called from machine code maintain the invariant that the return pc
	 of an interpreter callee calling a machine code caller is ceReturnToInterpreterPC."
	(vmThread inMachineCode
	 and: [instructionPointer >= objectMemory startOfMemory]) ifTrue:
		[self iframeSavedIP: framePointer put: instructionPointer.
		 instructionPointer := cogit ceReturnToInterpreterPC].
	newMethod := vmThread newMethodOrNull.
	argumentCount := vmThread argumentCount.
	self cCode:
			[self mem: reenterInterpreter
				cp: vmThread reenterInterpreter
				y: (self sizeof: #'jmp_buf')]
		inSmalltalk:
			[reenterInterpreter := vmThread reenterInterpreter].
	vmThread newMethodOrNull: nil.
	self cCode: ''
		inSmalltalk:
			[| range |
			 range := self cStackRangeForThreadIndex: threadIndex.
			 self assert: (range includes: vmThread cStackPointer).
			 self assert: (range includes: vmThread cFramePointer)].
	cogit setCStackPointer: vmThread cStackPointer.
	cogit setCFramePointer: vmThread cFramePointer.
	self assert: newMethod ~~ nil.
	cogit recordEventTrace ifTrue:
		[self recordTrace: TraceOwnVM thing: ConstTwo source: 0].
	^threadIndexAndFlags bitAnd: OwnVMForeignThreadFlag