debug support
fastLogPrim: aSelectorOrImmediate
	"Fast tracing of named primitives.  primTraceLogIndex is a byte variable.
	 aSelectorOrImmediate is a selector oop or one of TraceCodeCompaction et al.
	 primTraceLog has 256 entries.  In C the + 1 below is hence implicitly modulo 256."
	<inline: true>
	primTraceLog at: primTraceLogIndex put: aSelectorOrImmediate.
	self primTraceLogIndex: primTraceLogIndex + 1