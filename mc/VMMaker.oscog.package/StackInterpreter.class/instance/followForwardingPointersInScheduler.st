object memory support
followForwardingPointersInScheduler
	| schedAssoc sched procLists |
	schedAssoc := objectMemory splObj: SchedulerAssociation.
	"the GC follows pointers in the special objects array for us."
	self assert: (objectMemory isForwarded: schedAssoc) not.

	sched := objectMemory followObjField: ValueIndex ofObject: schedAssoc.

	procLists := objectMemory followObjField: ProcessListsIndex ofObject: sched.

	0 to: (objectMemory numSlotsOf: procLists) - 1 do:
		[:i| | list first last next |
		list := objectMemory followObjField: i ofObject: procLists.
		first := objectMemory followObjField: FirstLinkIndex ofObject: list.
		last := objectMemory followObjField: LastLinkIndex ofObject: list.
		[first ~= last] whileTrue:
			[next := objectMemory followObjField: NextLinkIndex ofObject: first.
			 first := next]]
