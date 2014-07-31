debug printing
printAllStacks
	"Print all the stacks of all running processes, including those that are currently suspended."
	<api>
	| proc semaphoreClass mutexClass schedLists p processList |
	<inline: false>
	proc := self activeProcess.
	self printNameOfClass: (objectMemory fetchClassOf: proc) count: 5; space; printHex: proc.
	self print: ' priority '; printNum: (self quickFetchInteger: PriorityIndex ofObject: proc); cr.
	self printCallStackFP: framePointer. "first the current activation"
	schedLists := objectMemory fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	"then the runnable processes"
	p := highestRunnableProcessPriority = 0
			ifTrue: [objectMemory numSlotsOf: schedLists]
			ifFalse: [highestRunnableProcessPriority].
	p - 1 to: 0 by: -1 do:
		[:pri|
		processList := objectMemory fetchPointer: pri ofObject: schedLists.
		(self isEmptyList: processList) ifFalse:
			[self cr; print: 'processes at priority '; printNum: pri + 1.
			 self printProcsOnList: processList]].
	self cr; print: 'suspended processes'.
	semaphoreClass := objectMemory classSemaphore.
	mutexClass := objectMemory classMutex.
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[semaphoreClass := objectMemory compactIndexOfClass: semaphoreClass.
			 mutexClass := objectMemory compactIndexOfClass: mutexClass.
			 objectMemory allHeapEntitiesDo:
				[:obj| | classIdx |
				 classIdx := objectMemory classIndexOf: obj.
				 (classIdx = semaphoreClass
				  or: [classIdx = mutexClass]) ifTrue:
					[self printProcsOnList: obj]]]
		ifFalse:
			[objectMemory allObjectsDoSafely:
				[:obj| | classObj |
				 classObj := objectMemory fetchClassOfNonImm: obj.
				 (classObj = semaphoreClass
				  or: [classObj = mutexClass]) ifTrue:
					[self printProcsOnList: obj]]]