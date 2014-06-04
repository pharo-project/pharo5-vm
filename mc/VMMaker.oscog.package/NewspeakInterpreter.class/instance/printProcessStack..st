debug printing
printProcessStack: aProcess
	<api>
	<inline: false>
	| ctx |
	self cr; printNameOfClass: (self fetchClassOf: aProcess) count: 5; space; printHex: aProcess.
	self print: ' priority '; printNum: (self quickFetchInteger: PriorityIndex ofObject: aProcess); cr.
	ctx := self fetchPointer: SuspendedContextIndex ofObject: aProcess.
	ctx = nilObj ifFalse:
		[self printContextCallStackOf: ctx]