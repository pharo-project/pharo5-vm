debug support
printLogEntryAt: i
	<inline: false>
	| intOrClass selectorMethodOrProcess source |
	intOrClass := traceLog at: i.
	selectorMethodOrProcess := traceLog at: i + 1.
	source := traceLog at: i + 2.
	source <= TraceIsFromInterpreter ifTrue:
		[self print: (traceSources at: source); space].
	(objectMemory isIntegerObject: intOrClass)
		ifTrue:
			[intOrClass = TraceStackOverflow ifTrue:
				[self print: 'stack overflow'].
			 intOrClass = TraceContextSwitch ifTrue:
				[self print: 'context switch from '; printHex: selectorMethodOrProcess].
			 intOrClass = TraceBlockActivation ifTrue:
				[self print: ' [] in '; printHex: selectorMethodOrProcess].
			 intOrClass = TraceBlockCreation ifTrue:
				[self print: 'create [] '; printHex: selectorMethodOrProcess].
			 intOrClass = TraceIncrementalGC ifTrue:
				[self print: 'incrementalGC'].
			 intOrClass = TraceFullGC ifTrue:
				[self print: 'fullGC'].
			 intOrClass = TraceCodeCompaction ifTrue:
				[self print: 'compactCode'].
			 intOrClass = TraceVMCallback ifTrue:
				[self print: 'callback'].
			 intOrClass = TraceVMCallbackReturn ifTrue:
				[self print: 'return from callback']]
		ifFalse:
			[self space; printNameOfClass: intOrClass count: 5; print: '>>'; printStringOf: selectorMethodOrProcess].
	source > TraceIsFromInterpreter ifTrue:
		[self space; print: (traceSources at: source)].
	self cr