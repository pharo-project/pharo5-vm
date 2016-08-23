process primitives
primitiveYield
	"Primitively do the equivalent of Process>yield, avoiding the overhead of a fork and a wait in the standard implementation."
	| scheduler activeProc priority processLists processList |
	scheduler := self schedulerPointer.
	activeProc := objectMemory fetchPointer: ActiveProcessIndex ofObject: scheduler.
	priority := self quickFetchInteger: PriorityIndex ofObject: activeProc.
	processLists := objectMemory fetchPointer: ProcessListsIndex ofObject: scheduler.
	processList := objectMemory fetchPointer: priority - 1 ofObject: processLists.

	(self isEmptyList: processList) ifFalse:
		[self addLastLink: activeProc toList: processList.
		 self transferTo: self wakeHighestPriority]