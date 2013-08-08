reporting
reportForMacOS: lines
	| thread dateAndTime cStackTop cstIdx |

	thread := Integer readFrom: ((lines detect: [:l| l beginsWith: 'Crashed Thread: ']) allButFirst: 15) readStream skipSeparators.
	thread := 'Thread ', thread printString, ' Crashed'.
	lines withIndexDo:
		[:l :i|
		(l beginsWith: 'Date/Time:') ifTrue:
			[dateAndTime := l allButFirst: 11].
		((l beginsWith: thread)
		and: [i < lines size]) ifTrue:
			[cStackTop := lines at: (cstIdx := i + 1)]].
	[cstIdx <= lines size
	 and: [(lines at: cstIdx) notEmpty]] whileTrue:
		[(((lines at: cstIdx) includesSubString: ' _sigtramp ')
		 and: [((lines at: cstIdx + 1) includesSubString: ' ??? ')
		 and: [((lines at: cstIdx + 1) includesSubString: '0xffffffff 0 + 4294967295')]]) ifTrue:
			[cStackTop := lines at: cstIdx + 2.
			 cstIdx := lines size].
		 cstIdx := cstIdx + 1].
	dateAndTime := self macOSDateFor: dateAndTime.
	(dateAndTime between: startDate and: endDate) ifFalse:
		[^nil].
	^'Mac:', (cStackTop allButFirst: (cStackTop indexOf: Character space))