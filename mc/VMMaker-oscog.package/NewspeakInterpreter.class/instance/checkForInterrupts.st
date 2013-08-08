processes
checkForInterrupts
	"Check for possible interrupts and handle one if necessary."
	| sema now thisLastTick |
	<inline: false>

	"Mask so same wrapping as primitiveMillisecondClock"
	now := self ioMSecs bitAnd: MillisecondClockMask.
	thisLastTick := lastTick.

	self interruptCheckForced ifFalse: [
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

	"inIOProcessEvents prevents reentrancy into ioProcessEvents and allows disabling
	 ioProcessEvents e.g. for native GUIs.  We would like to manage that here but can't
	 since the platform code may choose to call ioProcessEvents itself in various places."
	false
		ifTrue:
			[(now >= nextPollTick
			  and: [inIOProcessEvents = 0]) ifTrue:
				[inIOProcessEvents := inIOProcessEvents + 1.
				 self ioProcessEvents. "sets interruptPending if interrupt key pressed; may callback"
				 inIOProcessEvents > 0 ifTrue:
					[inIOProcessEvents := inIOProcessEvents - 1].
				nextPollTick := now + 200
				"msecs to wait before next call to ioProcessEvents.  
				Note that strictly speaking we might need to update  
				'now' at this point since ioProcessEvents could take a  
				very long time on some platforms"]]
		ifFalse:
			[now >= nextPollTick ifTrue:
				[self ioProcessEvents.
				 "sets interruptPending if interrupt key pressed"
				 nextPollTick := now + 200
				 "msecs to wait before next call to ioProcessEvents.  
				 Note that strictly speaking we might need to update  
				 'now' at this point since ioProcessEvents could take a  
				 very long time on some platforms"]].
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
	self signalExternalSemaphores.

	"update the tracking value (unless e.g. updated in a callback via ioProcessEvents)."
	lastTick = thisLastTick ifTrue:
		[lastTick := now]