debug support
dumpPrimTraceLog
	"The prim trace log is a circular buffer of entries. If there is
	 an entry at primTraceLogIndex \\ PrimTraceLogSize it has entries.
	 If there is something at primTraceLogIndex it has wrapped."

	<api>
	<inline: false>
	(primTraceLog at: (self safe: primTraceLogIndex - 1 mod: TraceLogSize)) = 0 ifTrue: [^self].
	(primTraceLog at: primTraceLogIndex) ~= 0 ifTrue:
		[primTraceLogIndex to: TraceLogSize - 1 do:
			[:i | self safePrintStringOf: (primTraceLog at: i); cr]].
	0 to: primTraceLogIndex - 1 do:
		[:i | self safePrintStringOf: (primTraceLog at: i); cr]