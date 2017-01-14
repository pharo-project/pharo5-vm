debug support
maybeTraceStackOverflow
	cogit recordOverflowTrace ifTrue:
		[self recordTrace: TraceStackOverflow
			thing: TraceStackOverflow
			source: ((self isMachineCodeFrame: framePointer)
						ifTrue: [TraceIsFromMachineCode]
						ifFalse: [TraceIsFromInterpreter])].
	cogit recordPrimTrace ifTrue:
		[self fastLogPrim: TraceStackOverflow]