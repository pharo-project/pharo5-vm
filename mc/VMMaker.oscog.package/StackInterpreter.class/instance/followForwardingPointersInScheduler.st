object memory support
followForwardingPointersInScheduler
	| schedAssoc sched procLists |
	schedAssoc := objectMemory splObj: SchedulerAssociation.
	"the GC follows pointers in the special objects array for us."
	self assert: (objectMemory isForwarded: schedAssoc) not.

	sched := objectMemory followNonImmediateField: ValueIndex ofObject: schedAssoc.

	procLists := objectMemory followNonImmediateField: ProcessListsIndex ofObject: sched.

	0 to: (objectMemory numSlotsOf: procLists) - 1 do:
		[:i| | list first last next |
		list := objectMemory followNonImmediateField: i ofObject: procLists.
		first := objectMemory followNonImmediateField: FirstLinkIndex ofObject: list.
		last := objectMemory followNonImmediateField: LastLinkIndex ofObject: list.
		[first ~= last] whileTrue:
			[next := objectMemory followNonImmediateField: NextLinkIndex ofObject: first.
			 first := next]]
