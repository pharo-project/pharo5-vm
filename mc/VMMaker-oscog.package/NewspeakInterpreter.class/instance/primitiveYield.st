process primitives
primitiveYield
"primitively do the equivalent of Process>yield"
	| activeProc priority processLists processList |
	activeProc := self activeProcess.
	priority := self quickFetchInteger: PriorityIndex ofObject: activeProc.
	processLists := self fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	processList := self fetchPointer: priority - 1 ofObject: processLists.

	(self isEmptyList: processList) ifFalse:[
		self addLastLink: activeProc toList: processList.
		self transferTo: self wakeHighestPriority]