initialization
loadInitialContext

	| sched proc |
	sched := self fetchPointer: ValueIndex ofObject: (self splObj: SchedulerAssociation).
	proc := self fetchPointer: ActiveProcessIndex ofObject: sched.
	activeContext := self fetchPointer: SuspendedContextIndex ofObject: proc.
	(self oop: activeContext isLessThan: youngStart) ifTrue: [ self beRootIfOld: activeContext ].
	self fetchContextRegisters: activeContext.
	reclaimableContextCount := 0.