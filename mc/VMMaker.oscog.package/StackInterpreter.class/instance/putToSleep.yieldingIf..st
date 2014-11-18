process primitive support
putToSleep: aProcess yieldingIf: yieldImplicitly
	"Save the given process on the scheduler process list for its priority,
	 adding to the back if yieldImplicitly or to the front if not yieldImplicitly."

	| priority processLists processList |
	self assert: (framePointer - stackPointer) < (LargeContextSlots * objectMemory bytesPerOop).
	priority := self quickFetchInteger: PriorityIndex ofObject: aProcess.
	(highestRunnableProcessPriority ~= 0
	 and: [priority > highestRunnableProcessPriority]) ifTrue:
		[highestRunnableProcessPriority := priority].
	processLists := objectMemory fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	processList := objectMemory fetchPointer: priority - 1 ofObject: processLists.
	yieldImplicitly
		ifTrue: [self addLastLink: aProcess toList: processList]
		ifFalse: [self addFirstLink: aProcess toList: processList]