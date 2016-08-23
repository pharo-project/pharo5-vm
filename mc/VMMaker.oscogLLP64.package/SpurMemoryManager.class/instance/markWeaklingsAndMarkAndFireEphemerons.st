gc - global
markWeaklingsAndMarkAndFireEphemerons
	"After the initial scan-mark is complete ephemerons can be processed.
	 Weaklings have accumulated on the weaklingStack, but more may be
	 uncovered during ephemeron processing.  So trace the strong slots
	 of the weaklings, and as ephemerons are processed ensure any newly
	 reached weaklings are also traced."
	| numTracedWeaklings |
	<inline: false>
	numTracedWeaklings := 0.
	[coInterpreter markAndTraceUntracedReachableStackPages.
	 coInterpreter markAndTraceMachineCodeOfMarkedMethods.
	 "Make sure all reached weaklings have their string slots traced before firing ephemerons..."
	 [numTracedWeaklings := self markAndTraceWeaklingsFrom: numTracedWeaklings.
	  (self sizeOfObjStack: weaklingStack) > numTracedWeaklings] whileTrue.
	 self noUnscannedEphemerons ifTrue:
		[coInterpreter
			markAndTraceUntracedReachableStackPages;
	 		markAndTraceMachineCodeOfMarkedMethods;
			freeUntracedStackPages;
			freeUnmarkedMachineCode.
		 ^self].
	 self markInactiveEphemerons ifFalse:
		[self fireAllUnscannedEphemerons].
	 self markAllUnscannedEphemerons]
		repeat