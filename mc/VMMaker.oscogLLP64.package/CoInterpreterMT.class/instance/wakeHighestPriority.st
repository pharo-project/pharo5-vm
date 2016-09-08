process primitive support
wakeHighestPriority
	"Return the highest priority process that is ready to run.
	 To save time looking at many empty lists before finding a
	 runnable process the VM maintains a variable holding the
	 highest priority runnable process.  If this variable is 0 then the
	 VM does not know the highest priority and must search all lists.

	 Override to answer nil when there is no runnable process instead of
	 aborting.  In the threaded VM the abort test is done in transferTo:from:
	 becaue there may be some thread waiting to own the VM.  The transfer
	 to the thread shouldn't be done here because not all clients call this in
	 the right context (allowing a longjmp back to the threadSchedulingLoop)."
	| schedLists p processList proc ctxt |
	schedLists := objectMemory fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	p := highestRunnableProcessPriority = 0
			ifTrue: [objectMemory numSlotsOf: schedLists]
			ifFalse: [highestRunnableProcessPriority].
	[(p := p - 1) >= 0] whileTrue:
		[processList := objectMemory fetchPointer: p ofObject: schedLists.
	 	 [self isEmptyList: processList] whileFalse:
			["Only answer processes with a runnable suspendedContext.
			  Discard those that aren't; the VM would crash otherwise."
			 proc := self removeFirstLinkOfList: processList.
			 ctxt := objectMemory fetchPointer: SuspendedContextIndex ofObject: proc.
			 (self isLiveContext: ctxt) ifTrue:
				[highestRunnableProcessPriority := p + 1.
				^proc].
			 self warning: 'evicted zombie process from run queue']].
	^nil