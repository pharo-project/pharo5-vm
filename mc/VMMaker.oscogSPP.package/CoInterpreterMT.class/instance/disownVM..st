vm scheduling
disownVM: flags
	"Release the VM to other threads and answer the current thread's index.
	 Currently valid flags:
		DisownVMLockOutFullGC	- prevent fullGCs while this thread disowns the VM.
		OwnVMForeignThreadFlag	- indicates lowest-level entry from a foreign thread
									- not to be used explicitly by clients
									- only set by ownVMFromUnidentifiedThread
		VMAlreadyOwnedHenceDoNotDisown
									- indicates an ownVM from a callback was made when
									  the vm was still owned.
									- not to be used explicitly by clients
									- only set by ownVMFromUnidentifiedThread

	 This is the entry-point for plugins and primitives that wish to release the VM while
	 performing some operation that may potentially block, and for callbacks returning
	 back to some blocking operation.  If this thread does not reclaim the VM before-
	 hand then when the next heartbeat occurs the thread manager will schedule a
	 thread to acquire the VM which may start running the VM in place of this thread.

	 N.B. Most of the state needed to resume after preemption is set in preemptDisowningThread."
	<api>
	<inline: false>
	| vmThread result |
	<var: #vmThread type: #'CogVMThread *'>
	self assert: self successful.
	cogit recordEventTrace ifTrue:
		[self recordTrace: TraceDisownVM thing: (objectMemory integerObjectOf: flags) source: 0].
	processHasThreadId ifFalse:
		[willNotThreadWarnCount < 10 ifTrue:
			[self print: 'warning: VM parameter 48 indicates Process doesn''t have threadId; VM will not thread'; cr.
			 willNotThreadWarnCount := willNotThreadWarnCount + 1]].
	vmThread := cogThreadManager currentVMThread.
	(flags anyMask: VMAlreadyOwnedHenceDoNotDisown) ifTrue:
		[disowningVMThread := vmThread.
		 vmThread state: CTMUnavailable.
		 ^0].
	self cCode: ''
		inSmalltalk:
			[| range |
			 range := self cStackRangeForThreadIndex: vmThread index.
			 self assert: (range includes: cogit getCStackPointer).
			 self assert: (range includes: cogit getCFramePointer)].
	(flags anyMask: DisownVMForProcessorRelinquish) ifTrue:
		[| proc |
		 (proc := objectMemory splObj: foreignCallbackProcessSlot) ~= objectMemory nilObject ifTrue:
			[foreignCallbackPriority := self quickFetchInteger: PriorityIndex ofObject: proc].
		 relinquishing := true.
		 self sqLowLevelMFence].
	(flags anyMask: DisownVMLockOutFullGC) ifTrue:
		[objectMemory incrementFullGCLock].
	(noThreadingOfGUIThread and: [self inGUIThread]) ifTrue:
		[^vmThread index
		 + LockGUIThreadFlag
		 + (activeProcessAffined ifTrue: [0] ifFalse: [ProcessUnaffinedOnDisown])
		 + (flags << DisownFlagsShift)].
	disownCount := disownCount + 1.
	disowningVMThread := vmThread.
	"self cr; cr; print: 'disownVM  Csp: '; printHex: vmThread cStackPointer; cr.
	(0 to: 16 by: 4) do:
		[:offset|
		self print: ' *(esp+'; printNum: offset; print: ': '; printHex: (stackPages longAt: cogit processor sp + offset); cr].
	cogit processor printIntegerRegistersOn: Transcript."

	"OwnVMForeignThreadFlag indicates lowest-level of entry by a foreign
	 thread. If that's where we are then release the vmThread.  Otherwise
	 indicate the vmThread is off doing something outside of the VM."
	(flags anyMask: OwnVMForeignThreadFlag)
		ifTrue:
			["I don't think this is quite right.  Josh's use case is creating some foreign thread and then registering
			 it with the VM. That's not the same as binding a process to a foreign thread given that the foreign
			 callback process is about to terminate anyway (it is returning from a callback here).  So do we need
			 an additional concept, that of a vmThread being either of the set known to the VM or floating?"
			self flag: 'issue with registering foreign threads with the VM'.
			(self isBoundProcess: self activeProcess) ifFalse:
				[cogThreadManager unregisterVMThread: vmThread]]
		ifFalse: [vmThread state: CTMUnavailable].
	result := vmThread index
				+ (activeProcessAffined ifTrue: [0] ifFalse: [ProcessUnaffinedOnDisown])
				+ (flags << DisownFlagsShift).
	cogThreadManager releaseVM.
	^result