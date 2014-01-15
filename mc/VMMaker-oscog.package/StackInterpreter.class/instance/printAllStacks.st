debug printing
printAllStacks
	"Print all the stacks of all running processes, including those that are currently suspended."
	<api>
	| oop classObj proc semaphoreClass mutexClass schedLists p processList |
	<inline: false>
	proc := self activeProcess.
	self printNameOfClass: (objectMemory fetchClassOf: proc) count: 5; space; printHex: proc.
	self print: ' priority '; printNum: (self quickFetchInteger: PriorityIndex ofObject: proc); cr.
	self printCallStackFP: framePointer. "first the current activation"
	semaphoreClass := objectMemory classSemaphore.
	mutexClass := objectMemory classMutex.
	oop := objectMemory firstObject.
	[self oop: oop isLessThan: objectMemory freeStart] whileTrue:
		[classObj := objectMemory fetchClassOfNonInt: oop.
		 (classObj = semaphoreClass
		  or: [classObj = mutexClass]) ifTrue:
			[self printProcsOnList: oop].
		 oop := objectMemory objectAfter: oop].
	schedLists := objectMemory fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	p := highestRunnableProcessPriority = 0
			ifTrue: [objectMemory fetchWordLengthOf: schedLists]
			ifFalse: [highestRunnableProcessPriority].
	p - 1 to: 0 by: -1 do:
		[:pri|
		processList := objectMemory fetchPointer: pri ofObject: schedLists.
		(self isEmptyList: processList) ifFalse:
			[self cr; print: 'processes at priority '; printNum: pri + 1.
			 self printProcsOnList: processList]]