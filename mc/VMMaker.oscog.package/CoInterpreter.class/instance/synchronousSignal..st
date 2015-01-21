process primitive support
synchronousSignal: aSemaphore 
	"Signal the given semaphore from within the interpreter.
	 Answer if the current process was preempted.
	 Override to add tracing info."
	| excessSignals |
	<inline: false>
	(self isEmptyList: aSemaphore) ifTrue:
		["no process is waiting on this semaphore"
		 excessSignals := self fetchInteger: ExcessSignalsIndex ofObject: aSemaphore.
		 self storeInteger: ExcessSignalsIndex
			ofObject: aSemaphore
			withValue: excessSignals + 1.
		 ^false].

	objectMemory ensureSemaphoreUnforwardedThroughContext: aSemaphore.

	^self resume: (self removeFirstLinkOfList: aSemaphore)
		preemptedYieldingIf: preemptionYields
		from: CSSignal