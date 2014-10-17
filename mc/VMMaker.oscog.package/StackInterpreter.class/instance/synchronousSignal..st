process primitive support
synchronousSignal: aSemaphore 
	"Signal the given semaphore from within the interpreter.
	 Answer if the current process was preempted."
	| excessSignals |
	<inline: false>
	(self isEmptyList: aSemaphore) ifTrue:
		["no process is waiting on this semaphore"
		 excessSignals := self fetchInteger: ExcessSignalsIndex ofObject: aSemaphore.
		 self storeInteger: ExcessSignalsIndex
			ofObject: aSemaphore
			withValue: excessSignals + 1.
		 ^false].

	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[| firstLink |
		 firstLink := objectMemory fetchPointer: FirstLinkIndex ofObject: aSemaphore.
		 (objectMemory isForwarded: firstLink) ifTrue:
			["0 = aSemaphore, 1 = aProcess. Hence reference to suspendedContext will /not/ be forwarded."
			 objectMemory followForwardedObjectFields: aSemaphore toDepth: 1].
		 self assert: (objectMemory isForwarded: (objectMemory fetchPointer: SuspendedContextIndex ofObject: firstLink)) not].

	^self resume: (self removeFirstLinkOfList: aSemaphore)
		preemptedYieldingIf: preemptionYields