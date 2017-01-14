process primitive support
checkForInterrupts
	"Check for possible interrupts and handle one if necessary."
	| sema now |
	<inline: false>

	statCheckForEvents := statCheckForEvents + 1.

	(nextProfileTick > 0 and:[self ioHighResClock >= nextProfileTick]) ifTrue:[
		"Take a sample for the profiler if it is active. Note that this must
		be done before any of the synchronousSignals below or else we will
		attribute a pause in ioRelinquishProcessor to the newly activated process."
		profileProcess := self fetchPointer: ActiveProcessIndex 
									ofObject: self schedulerPointer.
		"and signal the profiler semaphore if it is present"
		profileSemaphore == nilObj 
			ifFalse:[self synchronousSignal: profileSemaphore].
		nextProfileTick := 0.
	] ifFalse:[
		"Reset process and method to avoid creating memory leaks"
		profileProcess := nilObj.
		profileMethod := nilObj.
	].

	"Mask so same wrapping as primitiveMillisecondClock"
	now := self ioMSecs bitAnd: MillisecondClockMask.

	self adjustInterruptCheckCounterFeedback ifTrue: [
		"don't play with the feedback if we forced a check. It only makes life difficult"
		now - lastTick < interruptChecksEveryNms
			ifTrue: ["wrapping is not a concern, it'll get caught quickly  
				enough. This clause is trying to keep a reasonable  
				guess of how many times per 	interruptChecksEveryNms we are calling  
				quickCheckForInterrupts. Not sure how effective it really is."
				interruptCheckCounterFeedBackReset := interruptCheckCounterFeedBackReset + 10]
			ifFalse: [interruptCheckCounterFeedBackReset <= 1000
					ifTrue: [interruptCheckCounterFeedBackReset := 1000]
					ifFalse: [interruptCheckCounterFeedBackReset := interruptCheckCounterFeedBackReset - 12]]].

	"reset the interrupt check counter"
	interruptCheckCounter := interruptCheckCounterFeedBackReset.

	signalLowSpace
		ifTrue: [signalLowSpace := false. "reset flag"
			sema := self splObj: TheLowSpaceSemaphore.
			sema = nilObj ifFalse: [self synchronousSignal: sema]].

	now < lastTick
		ifTrue: ["millisecond clock wrapped so correct the nextPollTick"
			nextPollTick := nextPollTick - MillisecondClockMask - 1].
	now >= nextPollTick
		ifTrue: [statIOProcessEvents := statIOProcessEvents + 1.
		 	self ioProcessEvents.
			"sets interruptPending if interrupt key pressed"
			nextPollTick := now + 200
			"msecs to wait before next call to ioProcessEvents.  
			Note that strictly speaking we might need to update  
			'now' at this point since ioProcessEvents could take a  
			very long time on some platforms"].
	interruptPending
		ifTrue: [interruptPending := false.
			"reset interrupt flag"
			sema := self splObj: TheInterruptSemaphore.
			sema = nilObj
				ifFalse: [self synchronousSignal: sema]].

	nextWakeupTick ~= 0
		ifTrue: [now < lastTick
				ifTrue: ["the clock has wrapped. Subtract the wrap  
					interval from nextWakeupTick - this might just  
					possibly result in 0. Since this is used as a flag  
					value for 'no timer' we do the 0 check above"
					nextWakeupTick := nextWakeupTick - MillisecondClockMask - 1].
			now >= nextWakeupTick
				ifTrue: [nextWakeupTick := 0.
					"set timer interrupt to 0 for 'no timer'"
					sema := self splObj: TheTimerSemaphore.
					sema = nilObj ifFalse: [self synchronousSignal: sema]]].

	"signal any pending finalizations"
	pendingFinalizationSignals > 0
		ifTrue: [sema := self splObj: TheFinalizationSemaphore.
			(self fetchClassOf: sema) = (self splObj: ClassSemaphore)
				ifTrue: [self synchronousSignal: sema].
			pendingFinalizationSignals := 0].

	"signal all semaphores in semaphoresToSignal"
	(semaphoresToSignalCountA > 0 or: [semaphoresToSignalCountB > 0])
		ifTrue: [self signalExternalSemaphores].

	"update the tracking value"
	lastTick := now