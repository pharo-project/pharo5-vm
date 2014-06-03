process primitive support
transferTo: aProc 
	"Record a process to be awoken on the next interpreter cycle. 
	ikp 11/24/1999 06:07 -- added hook for external runtime compiler.
	eem 8/17/2009 16:37 -- stored nil into myList of new activeProcess"
	| sched oldProc newProc |
	statProcessSwitch := statProcessSwitch + 1.
	newProc := aProc.
	sched := self schedulerPointer.
	oldProc := self fetchPointer: ActiveProcessIndex ofObject: sched.
	self storePointer: ActiveProcessIndex ofObject: sched withValue: newProc.
	self storePointerUnchecked: MyListIndex ofObject: newProc withValue: nilObj.
	compilerInitialized
		ifTrue: [self compilerProcessChange: oldProc to: newProc]
		ifFalse: [self storePointer: SuspendedContextIndex ofObject: oldProc withValue: activeContext.
			self newActiveContext: (self fetchPointer: SuspendedContextIndex ofObject: newProc).
			self storePointer: SuspendedContextIndex ofObject: newProc withValue: nilObj].
	reclaimableContextCount := 0