debug support
fastLogPrim: aSelector
	"Fast tracing of named primitives.  primTraceLogIndex is a byte variable.
	 primTraceLog has 256 entries.  In C the + 1 below is hence implicitly modulo 256."
	<inline: true>
	RecordPrimTrace ifTrue:
		[primTraceLog at: primTraceLogIndex put: aSelector.
		 self primTraceLogIndex: primTraceLogIndex + 1]