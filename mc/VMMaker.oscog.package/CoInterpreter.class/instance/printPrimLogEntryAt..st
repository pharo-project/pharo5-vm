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
			 intOrSelector = TraceStackOverflow ifTrue:
				[self print: '**StackOverflow**'. ^nil].
			 intOrSelector = TracePrimitiveFailure ifTrue:
				[self print: '**PrimitiveFailure**'. ^nil].
			 intOrSelector = TracePrimitiveRetry ifTrue:
				[self print: '**PrimitiveRetry**'. ^nil].
			 self print: '???']
		ifFalse:
			[intOrSelector = 0
				ifTrue: [self printNum: i; print: '!!!']
				ifFalse: [objectMemory safePrintStringOf: intOrSelector]]