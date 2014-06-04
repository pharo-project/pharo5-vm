debug support
printPrimLogEntryAt: i
	<inline: false>
	| intOrSelector |
	intOrSelector := primTraceLog at: i.
	(objectMemory isImmediate: intOrSelector)
		ifTrue:
			[intOrSelector = TraceIncrementalGC ifTrue:
				[self print: '**IncrementalGC**'. ^nil].
			 intOrSelector = TraceFullGC ifTrue:
				[self print: '**FullGC**'. ^nil].
			 intOrSelector = TraceCodeCompaction ifTrue:
				[self print: '**CompactCode**'. ^nil].
			 self print: '???']
		ifFalse:
			[intOrSelector = 0
				ifTrue: [self printNum: i; print: '!!!']
				ifFalse: [objectMemory safePrintStringOf: intOrSelector]]