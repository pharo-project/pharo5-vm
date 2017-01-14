debug support
dumpTraceLog
	<api>
	"The trace log is a circular buffer of pairs of entries. If there is
	 an entry at traceLogIndex - 3 \\ TraceBufferSize it has entries.
	 If there is something at traceLogIndex it has wrapped."
	<inline: false>
	(traceLog at: (self safe: traceLogIndex - 3 mod: TraceBufferSize)) = 0 ifTrue: [^self].
	(traceLog at: traceLogIndex) ~= 0 ifTrue:
		[traceLogIndex to: TraceBufferSize - 3 by: 3 do:
			[:i| self printLogEntryAt: i]].

	0 to: traceLogIndex - 3 by: 3 do:
		[:i| self printLogEntryAt: i]