debug printing
printProcessStack: aProcess
	<api>
	<inline: false>
	| ctx |
	self cr; printNameOfClass: (objectMemory fetchClassOf: aProcess) count: 5; space; printHex: aProcess.
	self print: ' priority '; printNum: (self quickFetchInteger: PriorityIndex ofObject: aProcess); cr.
	ctx := objectMemory followField: SuspendedContextIndex ofObject: aProcess.
	ctx = objectMemory nilObject ifFalse:
		[self printCallStackOf: ctx currentFP: framePointer]