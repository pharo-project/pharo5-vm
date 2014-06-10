debug printing
printAllStacks
	"Print all the stacks of all running processes, including those that are currently suspended."
	<api>
	| oop classObj proc semaphoreClass schedLists processList |
	<inline: false>
	proc := self activeProcess.
	self printNameOfClass: (self fetchClassOf: proc) count: 5; space; printHex: proc.
	self print: ' priority '; printNum: (self quickFetchInteger: PriorityIndex ofObject: proc); cr.
	self printContextCallStackOf: activeContext.
	semaphoreClass := self classSemaphore.
	oop := self firstObject.
	[self oop: oop isLessThan: freeBlock] whileTrue:
		[classObj := self fetchClassOfNonImm: oop.
		 (classObj = semaphoreClass) ifTrue:
			[self printProcsOnList: oop].
		 oop := self objectAfter: oop].
	schedLists := self fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	(self fetchWordLengthOf: schedLists) - 1 to: 0 by: -1 do:
		[:pri|
		processList := self fetchPointer: pri ofObject: schedLists.
		(self isEmptyList: processList) ifFalse:
			[self cr; print: 'processes at priority '; printNum: pri + 1.
			 self printProcsOnList: processList]]