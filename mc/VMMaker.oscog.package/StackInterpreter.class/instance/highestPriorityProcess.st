process primitive support
highestPriorityProcess
	"Answer the highest priority process that is ready to run, but
	 unlike wakeHighestPriority do not remove it from the list.
	 To save time looking at many empty lists before finding a
	 runnable process the VM maintains a variable holding the
	 highest priority runnable process.  If this variable is 0 then the
	 VM does not know the highest priority and must search all lists.
	 Note: It is a fatal VM error if there is no runnable process."
	| schedLists p processList processOrNil |
	<inline: false>
	schedLists := objectMemory fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	p := highestRunnableProcessPriority = 0
			ifTrue: [objectMemory numSlotsOf: schedLists]
			ifFalse: [highestRunnableProcessPriority].
	p := p - 1.
	"index of last indexable field"
	[processList := objectMemory fetchPointer: p ofObject: schedLists.
	 processOrNil := objectMemory fetchPointer: FirstLinkIndex ofObject: processList.
	 processOrNil = objectMemory nilObject] whileTrue:
		[(p := p - 1) < 0 ifTrue:
			[^nil]].
	highestRunnableProcessPriority := p + 1.
	^processOrNil