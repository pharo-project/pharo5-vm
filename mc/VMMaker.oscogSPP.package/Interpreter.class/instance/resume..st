process primitive support
resume: aProcess 
	| activeProc activePriority newPriority |
	<inline: false>
	activeProc := self fetchPointer: ActiveProcessIndex ofObject: self schedulerPointer.
	activePriority := self quickFetchInteger: PriorityIndex ofObject: activeProc.
	newPriority := self quickFetchInteger: PriorityIndex ofObject: aProcess.
	newPriority > activePriority
		ifTrue: [self putToSleep: activeProc.
			self transferTo: aProcess]
		ifFalse: [self putToSleep: aProcess]