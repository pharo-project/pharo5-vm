process primitive support
transferTo: aProc 
	"Record a process to be awoken on the next interpreter cycle."
	| sched oldProc newProc |
	newProc := aProc.
	sched := self schedulerPointer.
	oldProc := self fetchPointer: ActiveProcessIndex ofObject: sched.
	self storePointer: ActiveProcessIndex ofObject: sched withValue: newProc.
	self storePointer: SuspendedContextIndex ofObject: oldProc withValue: activeContext.
	self newActiveContext: (self fetchPointer: SuspendedContextIndex ofObject: newProc).
	self storePointer: SuspendedContextIndex ofObject: newProc withValue: nilObj.
	reclaimableContextCount := 0