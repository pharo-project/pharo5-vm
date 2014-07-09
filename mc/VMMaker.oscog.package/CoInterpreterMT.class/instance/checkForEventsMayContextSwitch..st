process primitive support
checkForEventsMayContextSwitch: mayContextSwitch
	"Check for possible interrupts and handle one if necessary.
	 Answer if a context switch has occurred."
	| switched sema now |
	<inline: false>
	<var: #now type: #usqLong>
	self assertSaneThreadAndProcess.
	cogit assertCStackWellAligned.
	statCheckForEvents := statCheckForEvents + 1.

	"restore the stackLimit if it has been smashed."
	self restoreStackLimit.
	self externalWriteBackHeadFramePointers.
	self assert: stackPage = stackPages mostRecentlyUsedPage.

	"Allow the platform to do anything it needs to do synchronously."
	self ioSynchronousCheckForEvents.

	self checkCogCompiledCodeCompactionCalledFor.

	objectMemory needGCFlag ifTrue:
		["sufficientSpaceAfterGC: runs the incremental GC and
		 then, if not enough space is available, the fullGC."
		 (objectMemory sufficientSpaceAfterGC: 0) ifFalse:
			[self setSignalLowSpaceFlagAndSaveProcess]].

	mayContextSwitch ifFalse: [^false].

	switched := false.
	self assert: deferThreadSwitch not.
	deferThreadSwitch := true.

	(profileProcess ~= objectMemory nilObject
	 or: [nextProfileTick > 0 and:[self ioHighResClock >= nextProfileTick]]) ifTrue:
		[nextProfileTick := 0.
		 "Take a sample (if not already done so) for the profiler if it is active.  This
		  must be done before any of the synchronousSignals below or else we will
		  attribute a pause in ioRelinquishProcessor to the newly activated process."
		 profileProcess = objectMemory nilObject ifTrue:
			[profileProcess := self activeProcess.
			 profileMethod := objectMemory nilObject].
		 "and signal the profiler semaphore if it is present"
		 (profileSemaphore ~= objectMemory nilObject
		  and: [self synchronousSignal: profileSemaphore]) ifTrue:
			[switched := true]].

	self checkDeliveryOfLongRunningPrimitiveSignal ifTrue:
		[switched := true].

	objectMemory signalLowSpace ifTrue:
		[objectMemory signalLowSpace: false. "reset flag"
		 sema := objectMemory splObj: TheLowSpaceSemaphore.
		 (sema ~= objectMemory nilObject
		  and: [self synchronousSignal: sema]) ifTrue:
			[switched := true]].

	"inIOProcessEvents prevents reentrancy into ioProcessEvents and allows disabling
	 ioProcessEvents e.g. for native GUIs.  We would like to manage that here but can't
	 since the platform code may choose to call ioProcessEvents itself in various places."
	false
		ifTrue:
			[((now := self ioUTCMicroseconds) >= nextPollUsecs
			 and: [inIOProcessEvents = 0]) ifTrue:
				[statIOProcessEvents := statIOProcessEvents + 1.
				 inIOProcessEvents := inIOProcessEvents + 1.
				 self ioProcessEvents. "sets interruptPending if interrupt key pressed; may callback"
				 inIOProcessEvents > 0 ifTrue:
					[inIOProcessEvents := inIOProcessEvents - 1].
				 nextPollUsecs := now + 20000
				 "msecs to wait before next call to ioProcessEvents.  Note that strictly
				  speaking we might need to update 'now' at this point since
				  ioProcessEvents could take a very long time on some platforms"]]
		ifFalse:
			[(now := self ioUTCMicroseconds) >= nextPollUsecs ifTrue:
				[statIOProcessEvents := statIOProcessEvents + 1.
				 self ioProcessEvents. "sets interruptPending if interrupt key pressed; may callback"
				 nextPollUsecs := now + 20000
				 "msecs to wait before next call to ioProcessEvents.  Note that strictly
				  speaking we might need to update 'now' at this point since
				  ioProcessEvents could take a very long time on some platforms"]].

	interruptPending ifTrue:
		[interruptPending := false.
		 "reset interrupt flag"
		 sema := objectMemory splObj: TheInterruptSemaphore.
		 (sema ~= objectMemory nilObject
		  and: [self synchronousSignal: sema]) ifTrue:
			[switched := true]].

	nextWakeupUsecs ~= 0 ifTrue:
		[now >= nextWakeupUsecs ifTrue:
			[nextWakeupUsecs := 0.
			 "set timer interrupt to 0 for 'no timer'"
			 sema := objectMemory splObj: TheTimerSemaphore.
			 (sema ~= objectMemory nilObject
			  and: [self synchronousSignal: sema]) ifTrue:
				[switched := true]]].

	"signal any pending finalizations"
	pendingFinalizationSignals > 0 ifTrue:
		[pendingFinalizationSignals := 0.
		 sema := objectMemory splObj: TheFinalizationSemaphore.
		 (sema ~= objectMemory nilObject
		  and: [self synchronousSignal: sema]) ifTrue:
			[switched := true]].

	"signal all semaphores in semaphoresToSignal"
	self signalExternalSemaphores ifTrue:
		[switched := true].

	deferThreadSwitch := false.
	checkThreadActivation ifTrue:
		[checkThreadActivation := false.
		 self cedeToHigherPriorityThreads]. "N.B.  This may not return if we do switch."

	self threadSwitchIfNecessary: self activeProcess from: CSCheckEvents.
	^switched