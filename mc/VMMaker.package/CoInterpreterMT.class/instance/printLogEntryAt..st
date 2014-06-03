debug support
printLogEntryAt: i
	<inline: false>
	| intOrClass selectorOrMethod source |
	intOrClass := traceLog at: i.
	selectorOrMethod := traceLog at: i + 1.
	self printNum: ((traceLog at: i + 2) bitShift: -16); space.
	source := (traceLog at: i + 2) bitAnd: 16rFFFF.
	source <= TraceIsFromInterpreter ifTrue:
		[self print: (traceSources at: source); space].
	(objectMemory isIntegerObject: intOrClass)
		ifTrue:
			[| value |
			value := objectMemory integerValueOf: selectorOrMethod.
			intOrClass = TraceContextSwitch ifTrue:
				[self print: 'context switch'].
			 intOrClass = TraceBlockActivation ifTrue:
				[self print: ' [] in '; printHex: selectorOrMethod].
			 intOrClass = TraceBlockCreation ifTrue:
				[self print: 'create [] '; printHex: selectorOrMethod].
			 intOrClass = TraceIncrementalGC ifTrue:
				[self print: 'incrementalGC'].
			 intOrClass = TraceFullGC ifTrue:
				[self print: 'fullGC'].
			 intOrClass = TraceCodeCompaction ifTrue:
				[self print: 'compactCode'].
			 intOrClass = TraceVMCallback ifTrue:
				[self print: 'callback'].
			 intOrClass = TraceVMCallbackReturn ifTrue:
				[self print: 'return from callback'].
			 intOrClass = TraceThreadSwitch ifTrue:
				[self print: 'thread switch '; printNum: (value bitAnd: 16rFFFF); print: '->'; printNum: (value >> 16)].
			 intOrClass = TracePreemptDisowningThread ifTrue:
				[self print: 'preempt thread '; printNum: value].
			 intOrClass = TraceOwnVM ifTrue:
				[self print: 'ownVM '; printNum: value].
			 intOrClass = TraceDisownVM ifTrue:
				[self print: 'disownVM '; printHex: value]]
		ifFalse:
			[self space; printNameOfClass: intOrClass count: 5; print: '>>'; printStringOf: selectorOrMethod].
	source > TraceIsFromInterpreter ifTrue:
		[self space; print: (traceSources at: source)].
	self cr