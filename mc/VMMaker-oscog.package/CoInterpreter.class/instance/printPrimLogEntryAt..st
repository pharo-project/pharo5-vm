debug support
printPrimLogEntryAt: i
	<inline: false>
	| intOrSelector |
	intOrSelector := primTraceLog at: i.
	(objectMemory isIntegerObject: intOrSelector)
		ifTrue:
			[ intOrSelector = TraceIncrementalGC ifTrue:
				[self print: '**IncrementalGC**'. ^nil].
			 intOrSelector = TraceFullGC ifTrue:
				[self print: '**FullGC**'. ^nil].
			 intOrSelector = TraceCodeCompaction ifTrue:
				[self print: '**CompactCode**'. ^nil].
			 self print: '???']
		ifFalse:
			[objectMemory safePrintStringOf: intOrSelector]